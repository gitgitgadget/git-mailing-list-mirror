Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E435C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F98205CB
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFozosnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHKV0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgHKV0W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 17:26:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E33C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:26:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i19so30928lfj.8
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yhCoZ8hyoPfwqje5nbNq6Qbf9O1ZPMk7KQCZcP0k4J0=;
        b=TFozosnNwta3QymymWkU8gEZrfEN6jQkW/ajsgWKncgHQSgi3HbUUSAQ+txS6GThZD
         oyJlgNk/hUPxp/s/IZkHFa0X+75sXaZH04BNDIiABhPp1+tReJh9FTSayB+ISGN90tsV
         61pqKfnOuNEoy7RCDVTsYUMaCYbkfEMD7NZNe4ndGgKADZe/kfV62XcHlvrbJbIIdPLr
         qrATdElBV9oclIPPM1+AB8K68d2DJMxnYteOn4X/6VuT/YpW2DF1J4WALLzqTHF9EWyA
         vU2PbR9m/r7XuJe1Jx3g9rYWjaptCvTk23bbKVVdeTqvwaNARJutuq4BfJesE9Rxe38Y
         MPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=yhCoZ8hyoPfwqje5nbNq6Qbf9O1ZPMk7KQCZcP0k4J0=;
        b=FWUn/9AJRazNTl+Cex7Xsuwu1z/YbXk91oC0ug5769lcSNPBPSaCJxrPl5tsM/2mDp
         MzWmrbZAwh+KjDW6O4lObdyeJe+rBagHlyjjxfwI1TvUwn9EKTbs4mhivtJq1eEQrRxk
         FvbLs4O97liyQP7Jwg1Dup9vcOzj0CiIw5y37P/q8MmIaKH2D4YIvJeMbB9JajM5+yBN
         /YOuBqy0F5bqVuyCLjaXpMafNfSMDQ+MKYK/xuv2YgvHyleSPhrrhTfWRPnuvWPkun/7
         cXBoq3YfXky9SZvJUFR8B8AnR7pGuNMHaiHwoy9qR3WN0s3JymKkXwjRSFC9Ys5lE/cC
         wnAQ==
X-Gm-Message-State: AOAM530tFoE0WQS7025vjp/kxYlPTcoOHQIxAO32YsrPtpvGsoBFZmdy
        CcKk64xj/9+L4A1osXyN6gf5Zapj
X-Google-Smtp-Source: ABdhPJyuOr3giYAvFH5q2ernSs/fkq5H4vuWPPdB8nSmKflfrJxMVLRdNfYlJ7n8lxeIgiRgLYbkoA==
X-Received: by 2002:a19:be87:: with SMTP id o129mr4067474lff.180.1597181180011;
        Tue, 11 Aug 2020 14:26:20 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t16sm3977713ljo.27.2020.08.11.14.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:26:18 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
        <874kp9biho.fsf@osv.gnss.ru> <xmqq7du59eb4.fsf@gitster.c.googlers.com>
        <87364t563r.fsf@osv.gnss.ru> <xmqqy2ml7wrd.fsf@gitster.c.googlers.com>
Date:   Wed, 12 Aug 2020 00:26:17 +0300
In-Reply-To: <xmqqy2ml7wrd.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 11 Aug 2020 13:28:22 -0700")
Message-ID: <87lfik50xy.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> And I asked you to postpone that in <875z9v7b0k.fsf@osv.gnss.ru> for
>> which I got no answer. I repeat it here for convenience:
>>
>> "
>> For now, can we leave these patches as-is and then add additional tests
>> on top, please? I'm afraid that adding them now will force me to rewrite
>> current descriptions, as the result won't be minimal anymore, and I
>> feel uneasy about writing commit messages for these permuted tests
>> anyway.
>> "
>
> I was expecting just one case I mentioned in the first message and
> nothing else, which is crucial to highlight how --first-parent's
> "implication" works with explicit --diff-merges.
>
> Full "permutated tests" was what you brought up in the discussion,
> but I already said it was overkill to your response before you said
> the above.  The "minimal" would be the posted patch plus a missing
> "first-parent comes before --diff-merges=off" test filled in.

I've sent the patch before I saw this, please see
<87tux93pku.fsf@osv.gnss.ru>.

Is it OK with you?

Thanks,
-- Sergey
