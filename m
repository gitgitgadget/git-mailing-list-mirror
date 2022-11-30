Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45973C4332F
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 13:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiK3NDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 08:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiK3NDG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 08:03:06 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E03B769EC
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 05:02:09 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s8so26840800lfc.8
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 05:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JtS5vs7KiHJ6qrBZuKtLzxSYc1Pts5Eiuca3kXtdySM=;
        b=amaHdn6KVWstQzwKdEICGY2o4ol0fgNzhGAPNF2pqQGMCWY32HFu/2F2DNGc5KsaMK
         Vg/JuVuZRtlg4Ah65fIDA5vVGh1bgoYnVc7noaPUJmb0DUWaAvbfmwA/5mADcniYV1yM
         g30txQpNP5c/HPPTD6GB3m8eODglVL05qzboo5iSEQ2Qem7Y6wiGe6NDGGEj3TkdRUqV
         lMzeInUtJ4B9mBYg49UGiuVDiMLimqiPo6SILxQBoywAc2fAZTFgQ0UkihATZvTSERen
         ffWE2vjDFEwKKzK7syX8umZXrK/y6PxbTLowuaGBOcJWQRZzY21p7MUDZjDMX7adB9aW
         tduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtS5vs7KiHJ6qrBZuKtLzxSYc1Pts5Eiuca3kXtdySM=;
        b=qlU0VQKt17NwAPinl39nHNmaZ30GnOW4igzaDpiXSAufbzyXvwxNY2/SAqBqYHx0b8
         QOKeTQG6M/DCOUvag5+WZU8cyqQVgXY/YJNeR7Z2sDGuDuIYvxet8MVuojOPgkZQiuFc
         K5NjHtkGDmhQwuR8EQJ4h/LAr0wGhHczQ6i8QeZEd675rYtZSPNDEQdKCxz8/ToCuqsz
         cn9MkBTKtB3DYFAdsXIWULoRk369vgmqj+JAU22XpkOrmafo1JKKmy5jfjjIfNeTRaZI
         w6/ZKfoGsMRrZppiEMfFiJqqsiGjbGg8EFRmihrSbSGi+VXYK7yLT6keext7SMoYr5mg
         4FJg==
X-Gm-Message-State: ANoB5pnzUy/0EbGdRwQNsp1fVLtqwxJD8y5+EPs5Wb7N8Kh6x3eCLWOv
        i0oZYtxATaLmMAQdnYPPchMsJKRTaQ4=
X-Google-Smtp-Source: AA0mqf7Hdl2RsB4Auq6F5g2YxyFqTprmLiVpJWmcqBEyjz48t2tjqms44FfnM8KCuHl9iW1LrilzcA==
X-Received: by 2002:a05:6512:32b2:b0:4b5:2dc:8107 with SMTP id q18-20020a05651232b200b004b502dc8107mr8302184lfe.209.1669813326903;
        Wed, 30 Nov 2022 05:02:06 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i11-20020a196d0b000000b004a03d5c2140sm250535lfc.136.2022.11.30.05.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:02:06 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] diff-merges: implement log.diffMergesForce config
References: <20221127093721.31012-1-sorganov@gmail.com>
        <20221127093721.31012-4-sorganov@gmail.com>
        <xmqqedtn957j.fsf@gitster.g> <8735a3gmuq.fsf@osv.gnss.ru>
        <Y4ZUAsT7UKguvXiz@coredump.intra.peff.net>
Date:   Wed, 30 Nov 2022 16:02:05 +0300
In-Reply-To: <Y4ZUAsT7UKguvXiz@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 29 Nov 2022 13:48:34 -0500")
Message-ID: <87r0xktx2q.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 28, 2022 at 05:44:29PM +0300, Sergey Organov wrote:
>
>> >> +	if (set_func != NULL) {
>> >
>> > Please write it like so:
>> >
>> > 	if (set_func) {
>>[...]
>> Thanks! Do we now have tool for auto-check for these issues? I still use
>> one from Linux kernel, and it didn't object to this form.
>
> Running "make coccicheck" will find this, but of course you need to have
> coccinelle installed. Note that if it finds anything, "make" won't
> report an error. You have to check for non-empty files in
> contrib/coccinelle/*.patch.

Thank you! I'll give it a try.

-- Sergey Organov
