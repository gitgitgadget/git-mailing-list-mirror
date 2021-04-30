Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47A1C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CE761462
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhD3OBG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 10:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhD3OBF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 10:01:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233C0C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 07:00:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x2so4330586lff.10
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=h/KxwLc5XZELhsDHNuuYguMxLWe90gwPRvlGDQ/wTdE=;
        b=EBBJcQM+K9pyX412FO7v8xp1Kutg9on2PkgDChlSdRFXYAz+JIWLj+RBMw31fI9NhL
         kSaZH/ygGADOLZ3qucFjZNU35N/kg6qYFsFWezdZacPKDk4z/ITtk6tfiks72JKXO+Qu
         vQi2uiu2d80drGiKrDa0J2b0l7NI3XPxeAE4mX38zMpEaAUgY9Y0dQAWcjW9aOn0DEPQ
         ZGTqib1mU7iDWKXNfgsb+zz3xqChgCH+DAbL3ACEbIQX5yHSWqadVpe0RGRzYLC6YbJB
         WZ+Usmnyoo5Fl9R3ZcJ5KTY8zQ1E6IGYYGZgHDhAHwrYBJB1LKTUYexQEsAHELgPVqDo
         beCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=h/KxwLc5XZELhsDHNuuYguMxLWe90gwPRvlGDQ/wTdE=;
        b=Hx1Bxlz34+MI+Lf5PiSkBE8U6YmGeun3uR+PPwgWrOSKUyChewuOktM2TdQUQpeicT
         tQlQYLKT8nLBkG7CSoQxZ/MsgFajTl89YZ4IzlKmdx5yBnh6gdIaIBX7I2FrggcdhAZo
         JjsfnUKUl42Y4n1w2ZaKLPIhSSXRZxPhXPZ0R7tPxE2Il+mg7dTXX0sujyufDfV9yl7l
         VPiFQ6uIcERMtxUj9AAuu62vc8FRAQ/caH/yL3e0EVHTV+9gBm84+fVGfm2kR4UVs9E8
         ucD4Wk4jb84tvCVFveVYClf3CnBtO3KLISqgXFaxRGGA7246HA2tSrUB+Xx/PwOQcfaN
         VUDQ==
X-Gm-Message-State: AOAM533GyFjeUqW/qyzO7ncM8g6CDlkpQQtFC13BKQWSlu+sNRLS6+cZ
        4nvFMKkNBT2AFsTEbc2FeJLDiLL6Fek=
X-Google-Smtp-Source: ABdhPJwR61VOa3+ejriplkr1KCndKrAsH9By2TepFBZAUEYjyK8LqOra0lkWKrdU/4vYcDuocrcBJg==
X-Received: by 2002:a05:6512:48c:: with SMTP id v12mr3379372lfq.132.1619791215274;
        Fri, 30 Apr 2021 07:00:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y20sm244175ljd.106.2021.04.30.07.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:00:14 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g> <xmqqy2d0cr5l.fsf@gitster.g>
Date:   Fri, 30 Apr 2021 17:00:13 +0300
In-Reply-To: <xmqqy2d0cr5l.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        30 Apr 2021 13:50:14 +0900")
Message-ID: <87v9837tzm.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Yep, but --diff-merges=m doesn't imply -p either, though it does produce
>>> diff output without -p, for merge commits only.
>>
>> I misspoke without thinking it through.  It is absolutely wrong for
>> the "-m" option (or "--diff-merges=m" for that matter) to imply
>> "-p".
>>
>> $ git log --stat --summary
>>
>> would show "diff", but the kind of "diff" requested is not a textual
>> patch but just diffstat and the summary of new/removed files, and
>> the "diff" is shown only for single-parent commits, and it omits
>> "diff" for merge commits.  Adding "-m" to this command line is *not*
>> a request to show the textual patch.  It is to ask "diff" to be
>> shown pairwise with each of the parent.
>>
>> $ git log -m --stat --summary
>>
>> It is probably OK to special case "-m" given alone without any other
>> option [*1*] that specifies what kind of "diff" is requested and
>> make it imply "-p".  But unconditionally flipping "-p" on only
>> because you saw "-m" (or "--diff-merges=m" for that matter) is just
>> wrong.
>
> Luckily,
>
>     $ git log [--stat] --diff-merges=first-parent master..seen
>
> seems to do almost the right thing, with respect to the "It is
> probably OK to special case" I gave above.

I believe any special-casing is to be a last resort, and definitely is
not the right thing to do in this particular case.

>
> It only "enables diff" for merge commits, which does not quite feel
> right and we may want to do the same "enable diff" for single parent
> commits, but the good part is that it does not blindly imply "-p".
>
> It seems to do the "enable diff" the right way by honoring other
> command line options that specify the format of the diff, so with
> "--stat" included in the sample command line above, we get the
> diffstat for single parent commits (because we ask for "--stat" from
> the command line to show it throughout the history) and also for
> merge commits (because --diff-merges=first-parent does *not* blindly
> turn the textual patch '-p' on).

Good to know! I must admit I did nothing special in this regard, just
paid attention to avoid breaking any existing logic, at least knowingly.

>
>> [Footnote]
>>
>> *1* They are not limited to "-p", "--stat" and "--summary", but
>> you'd need to also pay attention to "--raw", "--name-only", etc.)
>
> I've merged the so/log-diff-merge topic to 'master', with this
> (possibly) known breakage that it does not do anything for single
> parent commits.  We may want to fix this last mile before the
> release that is scheduled to happen around early June.

I have no idea what the breakage is or could be. Do we have any relevant
tests in place already, or can somebody suggest some to check for
possible breakage?

> Note that I didn't check if you are doing the right thing for all
> formats, or if I was lucky and --stat was only one of them you paid
> attention to, when you needed to notice all others that you don't.
> But if you used the same logic that allows "git show" to by default
> give "-p/--cc" output while "git show --stat" to squelch the patch
> output, you should be OK.

In fact I didn't do anything specific to --stat, nor to other options
you mention (--raw, --name-only, --summary), so I'd expect all of them
still work the same way they were before my --diff-merges series. Need
to be checked anyway, sure thing, and that gets us back to the questions
of tests. I personally don't know what expectations are, so it's hard
for me to implement needed tests.

Thanks,
-- Sergey Organov

