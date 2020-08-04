Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6180C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD34C22B45
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5D4mH6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgHDVox (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgHDVox (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 17:44:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F2DC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 14:44:52 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s16so30076675ljc.8
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jvqpCLaDqHNNJ2tiU9rYMBF8cd6/Cq4nDwCrZ8AjILg=;
        b=p5D4mH6UZnmroO1fUqjTwl8XUsMvWFvFIoB+TY5K2wTBNzlxz+G7kQpHXmUvmNwSCX
         h2h4vHBELL/++pj1Qap+B6VMLcm7LoGSOF7ik7U+zSzqTXHXceJd9A5v6ZLhrYPh+C2A
         w6xDdQLXhtJaulKpYbrRQgrCOY+qIUAHKj09qef9m6elaBnfqCUfECvk9pYMGF5tKq1f
         Bfj13RSQW5nZisTxzg0cFpckaU2sTC8DxEePKe97EIo8vCvmtrCtn3fU78Fc7hGym1v6
         2Aah5m9EJDunT40RGagSphz9w8GbN0ZUmG6svDNTaN7ngJBLAmXiwodhKO7YKIUEo3Ta
         BzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=jvqpCLaDqHNNJ2tiU9rYMBF8cd6/Cq4nDwCrZ8AjILg=;
        b=Pj+QPEHRnn3kKRpEp8e5y+9FokVWsil9QRtTq0On2JCas6KQGBIn3SMr6LL17lHN9f
         CzT9q9n+G+dYxmngGad64l7BvLrVKr83+cAIJfZX6hVGD4Wzz57HsRCRrDrc0UaEssZc
         NMc6SgvbF3ZW6nEjAYy6LUe3UGiWk39bEZTkMEyUjyQwMKoBL87JbOmFmMP3rlk/4EZd
         BYZw6EtJZRma5ov/2GjvECj0dGqSKYsoWUYcUcmlMW6ykrsWTrak0SzsrMC+h5P+g6rW
         en1oHddls+6vav2eX5Hv5wvEivWrN/MLCBrrq28vADqRxvjxFLbfEds0eIQeLG9N7Y0v
         VG9Q==
X-Gm-Message-State: AOAM5303KkRnMLXOcOXQY4s8gqUeHjGHfQU23xm+evxtKWzIq8zT/C1J
        RKAHSAmXlh64++AYMibjrus=
X-Google-Smtp-Source: ABdhPJyqg1DB8DJVmmqHbCdzMEBouGqinHyvLF/AMPnrvMpu3eu436pIzFa62K4Rv5N7Qi5FgH993A==
X-Received: by 2002:a2e:9284:: with SMTP id d4mr1595377ljh.64.1596577491145;
        Tue, 04 Aug 2020 14:44:51 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j17sm104464lfr.32.2020.08.04.14.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 14:44:50 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
        <873652166e.fsf@osv.gnss.ru> <xmqq7duerti9.fsf@gitster.c.googlers.com>
Date:   Wed, 05 Aug 2020 00:44:49 +0300
In-Reply-To: <xmqq7duerti9.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 04 Aug 2020 14:27:58 -0700")
Message-ID: <87tuxixezy.fsf@osv.gnss.ru>
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
>> Jeff King <peff@peff.net> writes:
>>
>>>> +	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
>>>>  		revs->ignore_merges = 0;
>>>> +		if (!strcmp(optarg, "off")) {
>>>> +			revs->ignore_merges = 1;
>>>> +		} else if (!strcmp(optarg, "all")) {
>>>> +			revs->diff = 0;
>>>
>>> Should this be revs->ignore_merges = 0?
>>
>> It's 4 lines above, as it's in fact common for all the cases but the
>> first one.
>
> I may be mistaken, but I thought Peff was asking about turning
> revs->diff off.

No, but this one was in his follow-up that I already answered a few
minutes ago.

> I somehow thought that the equivalence planned for
> the short term is:
>
>             (new)               (peff's)         (master)
> 	diff-merges=none == --no-diff-merges == ! -m
> 	diff-merges=all  == --diff-merges    == -m

The second one is somewhat problematic, so I excluded it for now (see
aforementioned answer for more discussion).

Thanks,
-- Sergey
