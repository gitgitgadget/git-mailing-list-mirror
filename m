Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC217C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbhK3OtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbhK3OtN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:49:13 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA49FC061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:45:53 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r25so22379778edq.7
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OA0aX2vaCr6+RV9gM6HGxp1fgXeLWGibIXDLbOU47AQ=;
        b=G6XqejlLj8Yl6s+SyEYvjLjLHQCU4/CIHrIElBfSfR2w0+yKye9iWZKAokK+2BOVYE
         Mt3otYUzgkcPIv5f/xc8fFCleuW4eFQ6lTwnBPEASLwSvDGS768AMlyYqk4GpwpJoy4+
         QFdD+sS4Js3GdXxrIgjGFNRy5bEdOG71fNuOSCv9MJzBMCZY3RmEwr9g+FFxHg8qUhRL
         XKLfTrlcoPg9r4rLQmJ7H2EGlhrPGk+HVeEcfExX91lhgur38jA3zgE/AqEFPzdnJ2Kh
         0BQde0KDoG5W2PBi0Kb/5ZX9ITYzInh1GKydav1iox1z5OjJe7kZPPxM8QD8g+/eb4U1
         9NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OA0aX2vaCr6+RV9gM6HGxp1fgXeLWGibIXDLbOU47AQ=;
        b=O5RO2h1Naj+QMTfvrjz4bZH70E6vlECDp3s/v/e8KrFNd7GDW5bwBDkY8cqA/EFX3x
         fjITuHPK2JkahDtTPCbMnI/OEoXN6+HRSWVRWg4Um5c9YqEPfccbGVX+QqVdHHZowhdS
         nNSmN4SiV/M+osdBGcEhKOaGmhE2olH+XaWj9TZIej9bDq813HxslInmAQBFrk3RPnBC
         x9KS+0YOa2elgSdsnWIzPoVGSPuFNw/iC6VSXwBiwAX+joUWaIwHzg3hg6vsC2I9vOWC
         m4ea+N3NjZBHvihPbIt2yUX1WFiX9CmXKsy7elLA3C5QpbkY8iMLUujpAVn/RJQEbMDL
         1GNw==
X-Gm-Message-State: AOAM530AV3eGRCVwi9VXIABIpKLIB2rGXnofDmawumSpbjX9oSNVZ5Dc
        1EcBNv1ig2UCQje/ypHaFEM=
X-Google-Smtp-Source: ABdhPJwse2tZIWmjvk7cMZzXGc7fVdMhrF9QlEJ1lSeAI0SkilZXwJGNJc6mZp/11BM7CHg6S8pUlQ==
X-Received: by 2002:a17:907:9723:: with SMTP id jg35mr71767689ejc.329.1638283552023;
        Tue, 30 Nov 2021 06:45:52 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s16sm11248191edt.30.2021.11.30.06.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:45:51 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ms4OE-0011ug-Ni;
        Tue, 30 Nov 2021 15:45:50 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Nikita Bobko <nikitabobko@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [BUG REPORT] `git rebase --exec` shouldn't run the exec command
 when there is nothing to rebase
Date:   Tue, 30 Nov 2021 15:03:57 +0100
References: <CAMJzOtyw78-8gt3oGscN7KUzpzRRWtAQuGfcJ+R_Fjoom9Lexw@mail.gmail.com>
        <211129.868rx7gnd5.gmgdl@evledraar.gmail.com>
        <CABPp-BFRE2=Owf15WzkacNfdNKbkd2n4GZh7HqDokKzeviBWRw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <pull.1149.git.git.1638244719381.gitgitgadget@gmail.com>
Message-ID: <211130.865ys9em75.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Elijah Newren wrote:

[Moving this between threads, from
https://lore.kernel.org/git/CABPp-BFRE2=3DOwf15WzkacNfdNKbkd2n4GZh7HqDokKze=
viBWRw@mail.gmail.com/
to the patch]

> On Mon, Nov 29, 2021 at 2:25 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Fri, Nov 26 2021, Nikita Bobko wrote:
>>
>> > Steps:
>> > git rebase HEAD --exec "echo foo"
>> >
>> > EXPECTED: since 0 commits are going to be rebased then I expect "foo"
>> > NOT to be printed
>> > ACTUAL:   "foo" is printed
>>
>> I don't think this is a bug, but explicitly desired behavior.
>
> My reading of the docs are such that I'd expect the same as Nikita here:
>
>         Append "exec <cmd>" after each line creating a commit in the final
>         history.
>         ...
>         If --autosquash is used, "exec" lines will not be appended for the
>         intermediate commits, and will only appear at the end of each
>         squash/fixup series.
>
> There is no line creating a commit in the final history when you do a
> git rebase -i --exec "echo foo" HEAD (there is only a noop line), so
> there should be no exec line.

Maybe you're right & we can just change it. Keep in mind that those docs
were added by a non-native speaker (or rather, I'm assuming so based on
the name / E-Mail address).

See c214538416e (rebase -i: teach "--exec <cmd>", 2012-06-12). I agree
that the reading you've got of it is the more obvious one.

The reason I thought it wasn't a bug (some of which I dug more into
afterwards):

 1. I read that "commit in the final history" as referring to the range of
    commits to be rebased. Having only one commit or zero is perfectly OK,
    since...

 2. ... with "exec" we don't know if the "commit in the final history" isn't
   affected with an argument of HEAD. I.e. yes you can also provide "HEAD~"=
, but
   that's the difference between having a "pick" line or not. I don't think=
 the
   sequencer cares, but maybe third party scripting via the sequence editor=
 does?

   We already have an explicit facility to early abort the rebasing. See
   ff74126c03a (rebase -i: do not fail when there is no commit to cherry-pi=
ck,
   2008-10-10)

   So the feature that Nikita wants is already possible via GIT_SEQUENCE_ED=
ITOR.
   Now, that's a painful UI, but perhaps if this patch is implemented as a =
1=3D1
   mapping to that we'll discover some new edge case that wasn't considered?

 3. This isn't just a theoretical concern. It's *interactive* rebase, e.g. a
    perfectly fine use for it (which I've occasionally used is):

        # no local commits
        git checkout master
        # opens my editor with just a "noop" line
        git rebase -i

    And then adding/copying around *new* commits in the buffer and saving
    it, i.e. using it as an interactive text-based cherry-pick (this is
    particularly nice with Emacs's magit mode).

For #3 we can just say "well use HEAD~ then and ignore the one 'pick'"
line. Sure, I've probably only used this once or twice.

I just worry that we'll break thinsg for other users because we're
narrowly focusing on --exec as a way to follow-up interactive rebase
commands that we insert, and forgetting that this is a generic
templating language that others are intercepting and modifying.

So e.g. if you want to cherry-pick new commits and always use the same
10 "exec" lines to build and test those you can just rebase to HEAD with
those --exec, then copy/paste them for each new thing you insert.

You can also do that with HEAD~ and carry forward any "pick" line, but
that's *different*. I.e. we're forcing whoever relies on the current
semantics to change their GIT_SEQUENCE_EDITOR script from (pseudocode):

    if grep ^noop git-rebase-todo
    then
        for c in commits
        do
            echo "pick $c"
            # get the exec lines for each one, if any
            cat git-rebase-todo
        done
    fi

To something that'll have to handle a single "pick" line.

>> When you do:
>>
>>     git rebase -x 'make test' BASE
>>
>> You expect to run 'make test' for all of BASE..HEAD inclusive of
>> "base". E.g. for HEAD~1 we'll run 'make test' twice, and you know both
>> your HEAD~ and HEAD passed tests.
>
> This is not true.  Try `git rebase -i --exec HEAD~$N` for various
> values of N>0.  base is not included.

Sorry, I meant "inclusive of HEAD". I.e. we'll run "make test" for HEAD,
not just HEAD~. Likewise with any "exec" commands.

>> So why wouldn't doing the same for HEAD make sense?
>
> Indeed; HEAD is weirdly inconsistent and should be brought in line
> with the others.

I mean why shouldn't we run "make test" on HEAD, sorry. I agree that
running "make test" on "base" would make no sense. You can rebase to
BASE~ if you want that.

But yes, the result is the same as a rebase to HEAD~, so maybe it's fine
to change it...

>> That being said perhaps some users would think an option or
>> configuration to skip the injection of "exec" after "noop" would make
>> sense in that case.
>>
>> But does this really have anything per-se to do with --exec? Wouldn't
>> such an option/configuration be the same as rebase in general dying if
>> there's no work to do?
>>
>> And wouldn't such a thing be more useful than a narrow change to make
>> --exec a NOOP in these cases?
>>
>> E.g. if I've got a "topic" that has commit "A", that's since been
>> integrated into my upstream and I have a script to "make test" on my
>> topics, won't simply dying (and thus indicating that the topic is
>> dead/integrated) be better than noop-ing?
>
> Why do you suggest "dying" rather than early completion with success?

If you do:

    git rebase -i HEAD

Comment out the "noop" line, and save you'll get:

    error: nothing to do

And an exit code of 1.

Maybe we should silently return 0 there, but it seems to me like this
behavior needs to be consistent with whatever "noop" is trying to
accomplish in general (see ff74126c03a above).

That's why I said "does this really have anything per-se to do with
--exec?". I.e. we already observe this behavior without --exec, we just
get a noop line, and if we had no line at all we'd error with nothing to
do.

If we're going to make "git rebase -i HEAD" do nothing, why would it
have behavior different from a TODO list of just a "noop" line (which is
not the same thing as "nothing to do").

That's partially a matter of consistency, but mostly the general
paranoia that if we're going to subtly change what's *probably* an
obscure feature hopefully many aren't relying on, then at least having
it die instead of silently "succeed" would be better. I.e. we'll now
silently ignore the "--exec" commands, but didn't before.

