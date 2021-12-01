Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6751C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 11:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbhLALsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 06:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLALse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 06:48:34 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63B9C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 03:45:13 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso22011063wmr.4
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 03:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jsKnT+bWNfy0xbz5Mn4CRAuCuqmsQi8XzmEnib0aSAk=;
        b=ZhnrgWxEMJTQb5V518x4LX/8t4et/1xNsHIEnvOB+aLEAop6HvNZsjg/O1+cpVRhZe
         No8BKIybSE3gesV5MnnCrE+yVqlz7Q06gijd2AxeiZCENyoqhN9qu3moQGNs0QXEvX6H
         trqwsZiHBmrOaZ6+6FZ+/xFrU+EkCufY3O2S20QhulPp+GaHffpkv6iZXR+80e5o1PEc
         HIW+lV1DZFd4xQygKEpTb9NZG+f0Olc62mtCyIcJkLhQrouXYA1h0udpd7NO2DCHueE2
         DSeuARAXIft7ZkykJRNs0AuxDHbqK+jIuGpoClouLjQnQoB23dvbl2MmGSfJAOyHjNi3
         jySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jsKnT+bWNfy0xbz5Mn4CRAuCuqmsQi8XzmEnib0aSAk=;
        b=FFDgz6aRk1pNx/7ku7aFrlk9uqQgto/WNZyEsiL9e5DfhL/eN+5pFtxh0Ox4WSPHH2
         Dj4Z5mTXyaJh2OELMjutl2lRkzFP/Yle2i6Fk95LRKDQ3FpR8MC1iHdOTP1FzzqNYwLe
         gw0ivgwal7086Ghg8nuPq97ILXyZqiG29h4/S3vdLg1hTNTPsiRFHll3RIK/m8xeVqGj
         9Oal/3KIYIvd38x4HK4GbYsc/enAzgsRFBjx3rTW1ZQL6rWpCq6COkFJWM1OzQh48QU7
         hUTPEDCp/XyfvusdvKwXP3aBcZcw2R9NsqkOINF9jHXNAnqxRMyCCvtKSUUq8Fw9GUeG
         tkCw==
X-Gm-Message-State: AOAM532nb/hO636LH7KCHR9fuduGd5IYm7j5/vVSqoE9B8Lu0w7DDh/v
        v0zndk35GIdwCVqJu8l5xJE=
X-Google-Smtp-Source: ABdhPJwmFXDmJll/xqxFhUn/I0jKPEUjUll7Ox8dncw7Pf/eOUE/FCkkxafAABfykhzD7sVQMw+jqg==
X-Received: by 2002:a1c:a301:: with SMTP id m1mr6457701wme.118.1638359112343;
        Wed, 01 Dec 2021 03:45:12 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id 4sm25126239wrz.90.2021.12.01.03.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 03:45:11 -0800 (PST)
Message-ID: <4a6387a9-ade0-3690-0003-df28081f76a3@gmail.com>
Date:   Wed, 1 Dec 2021 11:45:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG REPORT] `git rebase --exec` shouldn't run the exec command
 when there is nothing to rebase
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Nikita Bobko <nikitabobko@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <CAMJzOtyw78-8gt3oGscN7KUzpzRRWtAQuGfcJ+R_Fjoom9Lexw@mail.gmail.com>
 <211129.868rx7gnd5.gmgdl@evledraar.gmail.com>
 <CABPp-BFRE2=Owf15WzkacNfdNKbkd2n4GZh7HqDokKzeviBWRw@mail.gmail.com>
 <211130.865ys9em75.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <211130.865ys9em75.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/11/2021 14:03, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Nov 29 2021, Elijah Newren wrote:
> 
> [Moving this between threads, from
> https://lore.kernel.org/git/CABPp-BFRE2=Owf15WzkacNfdNKbkd2n4GZh7HqDokKzeviBWRw@mail.gmail.com/
> to the patch]
> 
>> On Mon, Nov 29, 2021 at 2:25 PM Ævar Arnfjörð Bjarmason
>> <avarab@gmail.com> wrote:
>>>
>>> On Fri, Nov 26 2021, Nikita Bobko wrote:
>>>
>>>> Steps:
>>>> git rebase HEAD --exec "echo foo"
>>>>
>>>> EXPECTED: since 0 commits are going to be rebased then I expect "foo"
>>>> NOT to be printed
>>>> ACTUAL:   "foo" is printed
>>>
>>> I don't think this is a bug, but explicitly desired behavior.
>>
>> My reading of the docs are such that I'd expect the same as Nikita here:
>>
>>          Append "exec <cmd>" after each line creating a commit in the final
>>          history.
>>          ...
>>          If --autosquash is used, "exec" lines will not be appended for the
>>          intermediate commits, and will only appear at the end of each
>>          squash/fixup series.
>>
>> There is no line creating a commit in the final history when you do a
>> git rebase -i --exec "echo foo" HEAD (there is only a noop line), so
>> there should be no exec line.
> 
> Maybe you're right & we can just change it. Keep in mind that those docs
> were added by a non-native speaker (or rather, I'm assuming so based on
> the name / E-Mail address).
> 
> See c214538416e (rebase -i: teach "--exec <cmd>", 2012-06-12). I agree
> that the reading you've got of it is the more obvious one.
> 
> The reason I thought it wasn't a bug (some of which I dug more into
> afterwards):
> 
>   1. I read that "commit in the final history" as referring to the range of
>      commits to be rebased. Having only one commit or zero is perfectly OK,
>      since...
> 
>   2. ... with "exec" we don't know if the "commit in the final history" isn't
>     affected with an argument of HEAD. I.e. yes you can also provide "HEAD~", but
>     that's the difference between having a "pick" line or not. I don't think the
>     sequencer cares, but maybe third party scripting via the sequence editor does?
> 
>     We already have an explicit facility to early abort the rebasing. See
>     ff74126c03a (rebase -i: do not fail when there is no commit to cherry-pick,
>     2008-10-10)
> 
>     So the feature that Nikita wants is already possible via GIT_SEQUENCE_EDITOR.
>     Now, that's a painful UI, but perhaps if this patch is implemented as a 1=1
>     mapping to that we'll discover some new edge case that wasn't considered?
> 
>   3. This isn't just a theoretical concern. It's *interactive* rebase, e.g. a
>      perfectly fine use for it (which I've occasionally used is):
> 
>          # no local commits
>          git checkout master
>          # opens my editor with just a "noop" line
>          git rebase -i
> 
>      And then adding/copying around *new* commits in the buffer and saving
>      it, i.e. using it as an interactive text-based cherry-pick (this is
>      particularly nice with Emacs's magit mode).
> 
> For #3 we can just say "well use HEAD~ then and ignore the one 'pick'"
> line. Sure, I've probably only used this once or twice.

I'm not sure I really follow. For #3 you can just type the exec command 
into the editor rather than passing it on the command line. You already 
have to manually add exec commands after any new pick lines anyway.

> I just worry that we'll break thinsg for other users because we're
> narrowly focusing on --exec as a way to follow-up interactive rebase
> commands that we insert, and forgetting that this is a generic
> templating language that others are intercepting and modifying.

I see what you're getting at but I think this is a small enough corner 
case that we shouldn't worry too much. I think it is simpler to say if 
we don't pick any commits we don't add any exec commands.

 >[...]
>>> When you do:
>>>
>>>      git rebase -x 'make test' BASE
>>>
>>> You expect to run 'make test' for all of BASE..HEAD inclusive of
>>> "base". E.g. for HEAD~1 we'll run 'make test' twice, and you know both
>>> your HEAD~ and HEAD passed tests.
>>
>> This is not true.  Try `git rebase -i --exec HEAD~$N` for various
>> values of N>0.  base is not included.
> 
> Sorry, I meant "inclusive of HEAD". I.e. we'll run "make test" for HEAD,
> not just HEAD~. Likewise with any "exec" commands.

We do not run "make test" for HEAD~ when executing "git rebase -x 'make 
test' HEAD~1".

>>> So why wouldn't doing the same for HEAD make sense?
>>
>> Indeed; HEAD is weirdly inconsistent and should be brought in line
>> with the others.
> 
> I mean why shouldn't we run "make test" on HEAD, sorry. I agree that
> running "make test" on "base" would make no sense. You can rebase to
> BASE~ if you want that.
> 
> But yes, the result is the same as a rebase to HEAD~, so maybe it's fine
> to change it...
> 
>>> That being said perhaps some users would think an option or
>>> configuration to skip the injection of "exec" after "noop" would make
>>> sense in that case.
>>>
>>> But does this really have anything per-se to do with --exec? Wouldn't
>>> such an option/configuration be the same as rebase in general dying if
>>> there's no work to do?
>>>
>>> And wouldn't such a thing be more useful than a narrow change to make
>>> --exec a NOOP in these cases?
>>>
>>> E.g. if I've got a "topic" that has commit "A", that's since been
>>> integrated into my upstream and I have a script to "make test" on my
>>> topics, won't simply dying (and thus indicating that the topic is
>>> dead/integrated) be better than noop-ing?
>>
>> Why do you suggest "dying" rather than early completion with success?
> 
> If you do:
> 
>      git rebase -i HEAD
> 
> Comment out the "noop" line, and save you'll get:
> 
>      error: nothing to do
> 
> And an exit code of 1.
> 
> Maybe we should silently return 0 there, but it seems to me like this
> behavior needs to be consistent with whatever "noop" is trying to
> accomplish in general (see ff74126c03a above).
> 
> That's why I said "does this really have anything per-se to do with
> --exec?". I.e. we already observe this behavior without --exec, we just
> get a noop line, and if we had no line at all we'd error with nothing to
> do.
> 
> If we're going to make "git rebase -i HEAD" do nothing, why would it
> have behavior different from a TODO list of just a "noop" line (which is
> not the same thing as "nothing to do").
> 
> That's partially a matter of consistency, but mostly the general
> paranoia that if we're going to subtly change what's *probably* an
> obscure feature hopefully many aren't relying on, then at least having
> it die instead of silently "succeed" would be better. I.e. we'll now
> silently ignore the "--exec" commands, but didn't before.

I wonder if we could print a warning if the exec command gets ignored. I 
haven't looked how hard it would be to do in general but certainly for 
'rebase -x cmd HEAD' it should be simple(ish?) to do that. We also pick 
nothing if we're already up to date. If HEAD is an ancestor of 
<upstream> then I think we avoid fast-forwarding when there is an exec 
command so we will pick commits in that case.

Best Wishes

Phillip

