Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C65C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 22:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352272AbiCOWjP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 15 Mar 2022 18:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348559AbiCOWjO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 18:39:14 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E13D19280
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 15:38:00 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22FMbupq077951
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Mar 2022 18:37:57 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Emily Shaffer'" <emilyshaffer@google.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     "'Git List'" <git@vger.kernel.org>
References: <028301d837b1$173aacd0$45b00670$@nexbridge.com> <220315.86lexbdm4d.gmgdl@evledraar.gmail.com> <CAJoAoZmBdgFez5Mrx9_GMaNtcTrTixEOjE+Gshs0umTbbXAOPw@mail.gmail.com>
In-Reply-To: <CAJoAoZmBdgFez5Mrx9_GMaNtcTrTixEOjE+Gshs0umTbbXAOPw@mail.gmail.com>
Subject: RE: Follow-up on hooks series
Date:   Tue, 15 Mar 2022 18:37:51 -0400
Organization: Nexbridge Inc.
Message-ID: <032501d838bd$5174c090$f45e41b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGv1KEyMRx7mJL9nCu45rrN5avRFAKhIPoFAkBq2e6s6sGpgA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 15, 2022 4:25 PM, Emily Shaffer wrote:
>As threatened in IRC yesterday, adding Git list as well ;)

CC'ing the Git list as agreed 😊

>On Tue, Mar 15, 2022 at 12:57 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>wrote:
>> On Mon, Mar 14 2022, rsbecker@nexbridge.com wrote:
>>
>> > 1 I am not sure of the usefulness of the git hook list <hook> form.
>> > If you know the name of the hook, then you don’t need it listed. I get that it
>seems like a whereis style command. How  about this:
>> >  git hook list [ <hook-pattern> … ]
>> >  that displays all hooks if none specified or those matching a
>> > pattern. The current message of hooks in hookdir is not particularly meaningful
>to me. hook bob found in .git/hooks explicitly  would be more useful and better if
>you have patterns.
>>
>> That might be a good idea, I honestly haven't re-paged this into my brain.
>>
>> In any case this isn't in master/next or in-flight, there's just "git
>> hook run" there, so let's discuss it when those patches are submitted
>> (I'll CC you).
>
>
>I'm a little unsure about what the semantics of this looks like, actually.
>
>The way it works as implemented is like so:
>
>$ git list pre-commit
># Because pre-commit can run more than one script, they all appear in the output:
>/usr/share/some-package/very-cool-pre-commit-hook
>~/my-repo/hooks/project-specific-hook
>~/src/script-i-wrote-to-watch-for-debug-printfs

I think my issue may be that I do not have a complete set of patches. The tests I ran did not produce output like that. This also may be something to clarify in the documentation - can you post the latest bit?

>That is, I know that I'm about to make a commit, but I don't remember if I
>configured very-cool-pre-commit-hook and I need it for this commit, so I want to
>list all my pre-commit hooks as a sanity check.
>
>So I'm a little bit confused why it would be useful to grep with a pattern. Are you
>expecting instead for something like:
>$ git hook list '.*project-specific'
>pre-commit: ~/my-repo/hooks/project-specific-hook
>prepare-commit-msg: ~/my-repo/hooks/project-specific-check-commit-msg-
>hook
>
>Or maybe even, given a config:
>[hook "very-cool"]
>  command = /usr/share/some-package/very-cool-pre-commit-hook
>  event = pre-commit
>[hook "very-cool-other-hook"]
>  command = /usr/share/some-package/very-cool-pre-push-hook
>  event = pre-push
>
>to run something like
>$ git hook list 'very-co*'
>hook."very-cool".command=/usr/share/some-package/very-cool-pre-commit-
>hook
>hook."very-cool".event=pre-commit
>hook."very-cool-other-hook".command=/usr/share/some-package/very-cool-
>pre-push-hook
>hook."very-cool-other-hook".event=pre-push
>
>Both these examples I see a little less usefulness, but especially the last one
>(which is essentially a thinly veiled 'git config
>--get-regexp') doesn't seem useful to me. The "hook name" ("very-cool"
>and "very-cool-other-hook" in this example) is pretty much an implementation
>detail local to the config parse, and user will never refer to it by that name after
>the config setup, right?

As a user of this, what I was looking for was some way to query the inventory of relevant hooks. Assuming the user knows where all the possible hooks are, I guess this is ok.

>> > 2 I may have missed something, but I thought that this series might
>> > allow execution of hooks if not in a repository – that was my hope
>> > anyway. To do this, maybe add a --repository=<path> argument so that
>> > git will know where to find the ./git/hooks directory, and then run
>> > it.
>>
>> Yeah, some version of those patches does that, not sure which offhand...
>
>Hrm. Well, I have a bit of a personal grudge against .git/hooks/ hooks in general :)
>so I would say, if you will go through the pain of wanting to reuse some hook in
>some specific repo all over your machine, why not just set it up in your ~/.gitconfig
>instead, so you don't have to pass this argument?

I think the useful case is more sharing hooks between copies of the repo, not sharing hooks between repos of different origins. So ~/.gitconfig is not the place I am likely to put hooks. It's not like I have 50-100 different projects on the fly at once 😉

>Better yet, if this argument is targeted for scripting, I think you could achieve the
>same thing with 'git -c core.hooksPath=~/myproject/.git/hooks/ hook run
>sendemail-validate', and we wouldn't have to implement anything new at all.

Isn't that in Ævar series? I don't see it in 2.35.1? I don't think the goal is scripting around git, it is more scripting inside git. The users with whom I work seem to want the least amount of external scripting as possible, mostly because of how they are running git. The model I am working work, which is multi-platform (and not shell-invoked), is to set up a façade that runs git to perform whatever needs to be done, and the hooks offer some good value because we are inside a shell by that point, but not when git gets launched. I know it's funky, but that's why I find the whole series "interesting".

-Randall

