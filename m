Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E8C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E7D60F58
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbhHTKZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbhHTKZY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 06:25:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E39EC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 03:24:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i9so19517403lfg.10
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 03:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5JXVz+euiz2X+0bykNrZnSzQNFuwr10j13ZS0cTisRY=;
        b=VlsuDQuwoXVQggPfCzuItj6SmE/gGA3cRTQgu+j3ou5YOLcEEwABcQHs88gIXjzurb
         CsYVZWoXg6oNCG/NMn1TDEa+nPtQ8i3giGmr2sBHGB2889VFgiAZhxB5aekxBWQWYd6j
         XZYtdz5ANT6kHv7rPpOujPXDIgFWyeIx7mbSTBMrynwZeDmonmdjBZo7suMUZvWiXPBN
         JNF0C7l78j3Jrk2TZU2rAdjf4Rv05H1tKaM81zPAwhcC/PEbFlg/8FYXDA1riGIlwzkE
         aVhHM8b5GgrZxBDgnBJJZQd69GcMjy9heXquCv8HDnnEvfOgO9y88TOBczQDLSBBoD8O
         /CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=5JXVz+euiz2X+0bykNrZnSzQNFuwr10j13ZS0cTisRY=;
        b=H2jMix6k5TN1jcUk1S0EES7A1jHg9yR8P0PM1l+RmPQE7CZqlqBApV1n6tUuKAeadl
         ffZcOEmGkLu4eoNxajWFkI9QoISrZ4+YDzuuhdFtAawPkZxrwbsLId7YMSRIztBfUsyM
         6O19YJASae1a9kev7WwD4TKvjWZG1YFCwJu477FM6zJHWeUgRuikF0dqc4W2TbVgu8rZ
         F9MaovSdioZ+ZTRVw8AICN9BLG2NDn0jAxFyA7NXHNx7RWLRdqM3YNMTjMcMevExYlDL
         D0zYfCWKfukdX9s4/PH/Z3doPsGJIMPsxTewtiwrMnpTB7NDw7mvkT/xPOhZDFe8jbWq
         UPcQ==
X-Gm-Message-State: AOAM532KuAaqbDoTUnbb1+e/pj0fMnIv1ED3j6qlJ8OUafu1qplYstf6
        dM8Q4b7kVVwwraUtEs3Pry4=
X-Google-Smtp-Source: ABdhPJwcAgYjKbdQQAKkSM6D66qZpYj64lhUoEhJi8fz/eISvssHu1riMa5raXKDmdZ9c4UyEEtOVg==
X-Received: by 2002:ac2:4e12:: with SMTP id e18mr14147645lfr.251.1629455084684;
        Fri, 20 Aug 2021 03:24:44 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d6sm588888lfi.57.2021.08.20.03.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:24:43 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210520214703.27323-1-sorganov@gmail.com>
        <20210520214703.27323-11-sorganov@gmail.com>
        <YQtYEftByY8cNMml@google.com> <YQyUM2uZdFBX8G0r@google.com>
        <xmqqh7g2ij5q.fsf@gitster.g> <xmqqczqqihkk.fsf@gitster.g>
        <YQ2UFmCxRKNMOtrD@google.com> <xmqqeeb3hlcq.fsf@gitster.g>
        <87a6lgl9gq.fsf@osv.gnss.ru> <xmqqczqb7mds.fsf@gitster.g>
        <87fsv7f7wx.fsf@osv.gnss.ru> <xmqqim011d6m.fsf@gitster.g>
Date:   Fri, 20 Aug 2021 13:24:42 +0300
In-Reply-To: <xmqqim011d6m.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        19 Aug 2021 11:50:41 -0700")
Message-ID: <87y28wct1x.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> We need to note that the "-m" implied by "--first-parent" is "if we
>>> were to show some comparison, do so also for merge commits", not the
>>> "if the user says '-m', it must mean that the user wants to see
>>> comparison, period, so make it imply '-p'".  The latter is what was
>>> reverted.
>>
>> Yes, there is minor backward incompatibility indeed, and that was
>> expected. This could be seen from the patch in the same series that
>> fixes "git stash" by removing unneeded -m.
>>
>> The fix for the scripts is as simple as removing -m from "--first-parent
>> -m". It's a one-time change.
>> ...
>>> I agree that we both (and if there were other reviewers, they too)
>>> mistakenly thought that the change in behaviour was innocuous enough
>>> when we queued the patch, but our mistakes were caught while the
>>> topic was still cooking in 'next', and I have Jonathan to thank for
>>> being extra careful.
>>
>> So, what would be the procedure to get this change back, as this minor
>> backward incompatibility shouldn't be the show-stopper for the change
>> that otherwise is an improvement?
>
> Your repeating "minor" does not make it minor.  Anything you force
> existing users and scripts to change is "fixing the scripts", but
> "working around the breakage you brought to them", which is closer
> to being a show-stopper.

Backward compatibility is important, no questions, but later on you
start to say that this change is a *design* mistake, so discussing
backward compatibility issues gets rather useless.

That said, scripts that still have "log --first-parent -m" are remnants
of former sub-optimal design that was improved by "--first-parent imply
-m" change about a year ago, and with current Git these scripts are
confusing anyway, so fixing them by removing the work around they
historically have would be a good idea no matter if the change in
question is accepted or not.

I mean your "working around the breakage you brought to them" is simply
wrong. These changes to the scripts in question are not work-arounds
they are rather improvements. It's "log --first-parent -m" in the
scripts that is a work-around, and getting rid of -m there is getting
rid of work-around that is not needed anymore (for about a year
already.)

> I understand that you like this feature a lot, but you'd need to be a
> bit more considerate to your users and other people.

First, I believe I *am* considerate, and second, I don't either "like"
or "dislike" the feature, personally. It's a matter of consistency of
UI, and the fact that such requests appear on the list (not from me)
only supports this view. There are other people here who do think this
is an improvement.

> I think it is a design mistake to make a plain vanilla "-m" to imply
> "-p" (or any "output of result of comparison"), simply because the
> implication goes in the other direction, so there will never be "get
> this change back", period, but see below.

Well, I thought we've already discussed this to death and agreed this is
an improvement, before I even started to implement the patches, and now
what? I'm confused.

I still believe it's reasonable for "git log -m" to output diffs without
need to explicitly specify -p, and I still see no design mistake here,
especially if it were implemented this way from the beginning,
especially given that "git log --cc" and and "git log -c" already behave
exactly this way.

>
> "git log" when showing a commit and asked to "output result of
> comparison" like patch, combined diff, raw diff, etc. would:
>
>  - show the comparison for non-merge commits and when
>    "--first-parent" is specified (the latter is natural since it
>    makes us consistently pretend that the merges were squash
>    merges).
>
>  - shows the comparison for merge commits when -m is given.
>
> but because "--cc" and "-c" (which are used to specify how the
> result of comparison is shown; they are not about specifying if
> "normally we show only non-merges" is disabled) do not make sense in
> the context of non-merge commits (in other words, the user is better
> off giving "-p" if merges are not to be shown), they are made to
> imply "-m". And that is a sensible design choice.  

No, sorry, they are made to imply -p, not -m.

> On the other
> hand, "--raw" (which is used to specify how the result of comparison
> is shown; it not about specifying if "normally we show only
> non-merges" is disabled) does make sense in the context of non-merge
> commits, so unlike "--cc"/"-c", it does not imply "-m".  And that
> also is a sensible design choice.  "-p" falls into the same bucket
> as "--raw", so it should not imply "-m".

Yes, but this has nothing to do with the patch in question, as -p still
doesn't imply -m with this patch. It's another way around: the patch
makes -m imply -p, the same way -c/--cc imply -p.

>
> But some folks may not like "log -p" to be silent about comparison
> for merge commits (like you are).

No, not me, and I didn't see anybody who insisted on it yet. It's fine
with me it's silent by default.

> To accomodate them, it might make sense to have a configuration that
> says "I like -m, so when -p or --raw or any 'how to show comparison
> result' option is given, please make it imply '-m'", but it should not
> be the default.

This has nothing to do with the patch in question, and I actually don't
like the idea, sorry.

Overall, my opinion is still that there is nothing wrong with "-m
implies -p", as implemented by the patch, as if user asks to output
diffs even for merge commits, it's likely they need diffs for *all* of
them. This is again consistent with how -c/--cc work.

Now, only provided we *again* and *finally* agree that -m should better
imply -p, we can get back to discussing backward incompatibility this
change does introduce, and how to get transition smoother if it needs to
be.

Thanks,
-- Sergey Organov
