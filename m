Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA791C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D77861106
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346087AbhIGTy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhIGTy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:54:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2738C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 12:53:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y34so27740lfa.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IE202KpPDEPRxEWltwLplN1HY8L4BrfFOX0UzUQNByA=;
        b=IpCr/RknBL1EvYBqlBEcuJZyJA4vDiTYZcJEyksZdW0X+sX4bVxoMd6SafUMtlZ0tM
         QOlbpRoxMtnTGByAdaw1F9S7hmQoNBxpx9LkpWxEU3BrqB19ud/BIUuGKFAgtdJjjQqq
         uX/u4yDJWpqNtxFmgHGmTJNtbfPrxR3tcFWrhJ+rs3mbUgx/kVM0xlKNPlMGGSoK4xsV
         QX7P7x2LXHCOKYtaU384LITXzTo5NI92wkDQdG+wgXEK1ridh5WdCvVFKlgwKXXlJaFe
         jaB4a/xJ7pb8bkAWZwHawdJvdmuVps78NkiIdDvjyr2GSjYppQnN5LJ5uIznWnqLgUm9
         exxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=IE202KpPDEPRxEWltwLplN1HY8L4BrfFOX0UzUQNByA=;
        b=T6hPdK5UpRybjRgyX+5UZDylLxrmcB6B20xrE14V+VrbcFMhrY9+nGf/2y5KFitSUC
         aupztK+2roZDmU8P89RxQ6UtRORVXrSH8iXQPlsaXGkf7qOs+npreASx1mIJfldjxLHM
         5jP1S2lRIJEaCR3GCZdy5mntud2fICo3v/+2+TRnqG7YKR+3Gfsl6nMaVPqhwoVbnepj
         LA2gAU+5ekL4XgtWm7ChZQaTmDnPQBsSwzSbqgKCoYEJ9db031pbH8G90FGFtv8g5db6
         JfgUlsoSsPOq+4AYGJ+GGn33SXPv4o/bd5uxgJY2EyP/MnhGa0e+mguZ1WV59MJ7v2Wh
         tsaQ==
X-Gm-Message-State: AOAM5335GK/1t/hPvoLwZX0KgHkLhXq6jCaMxHpPnZGv/xM5s7MhmDCG
        E2QenHBHNRrWSgmeAyseLCjy1gh56g4=
X-Google-Smtp-Source: ABdhPJyO38JT+N3vYe0hYux9ynu7lnwv6uRt/EW3UL7Q+EYz16/5sG4Sim/y2wSbrMBlt3x1NidHaA==
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr79140lfr.362.1631044427988;
        Tue, 07 Sep 2021 12:53:47 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u20sm1169604lff.240.2021.09.07.12.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:53:47 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
Date:   Tue, 07 Sep 2021 22:53:46 +0300
In-Reply-To: <xmqqy288b64q.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        07 Sep 2021 11:19:33 -0700")
Message-ID: <878s089n79.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Here is a patch that fixes diff-index to accept --cc again:
>
> Sorry for the delay; I did not notice there was a patch buried in a
> discussion thread.

Sorry from my side as well. I was already about to re-submit the patch
properly, but you happened to be faster with this )

>
> We might later need to do this suppression in more codepaths if we
> find more regressions, but let's have one fix at a time.  
>
> Will queue.
>
>>  builtin/diff-index.c |  6 +++---
>>  diff-merges.c        | 14 ++++----------
>>  diff-merges.h        |  2 +-
>
> This would deserve new tests that cover the existing use cases,
> given that both of us (and other reviewers in the original thread)
> did not notice how big a regression we are causing.

Yep, it's too easy to break undocumented and untested behavior.

> We care about --cc naturally falling back to -p when there is only
> one other thing to compare with, and also we care about --cc that
> allows us to compare during conflict resolution, at least, I think.

I'm all for more tests, but I'm afraid I'm not in a good position to
write them, especially for an undocumented behavior. I think somebody
should first document what --cc/-c does in diff-index, and only then
it makes sense to write some tests.

> It can and should come as a separate step, of course.  Unbreaking
> gitk for an already known breakage would be more urgent than hunting
> for other breakages, even though the latter might result in a more
> thorough fix in the end.

Makes sense.

Thanks,
-- Sergey Organov
