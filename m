Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABDDC2D0CF
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF19206B7
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="pjXhIjBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfLXLce (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:32:34 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:46635 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLXLce (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:32:34 -0500
Received: by mail-pf1-f171.google.com with SMTP id n9so2772715pff.13
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=D+BUtS4EFIhepmEm7AponDg2q26v2INZttuLWWhsHXo=;
        b=pjXhIjBVvxzMHBtLt0RhR1NpQzXqfBKrGAfNHa1PXvi2/PzRsvesMU6d5iDf1/l6bI
         ZMshGKcTfGBE3FGmbl7i4EP0nJvrwlePAayFSHYn/sOEurU/tPkWlulUSh0VpkeoEtK9
         LTcnD0k91gd2W/VEkP9JZVqqXAuIzRVjJJbDkcNPH52tmY3BYm33mYa81v9EBIQDAhN4
         ruSd17ih8yfrwfWexgA8/PBE9HnuNDHk7MJIOg/cqR2v+47UhaM6xztkFtIW57B5ongM
         IXqRzSlPVX8KC6F5rRNU4CUgpcfOA9InbSbon2cXpWCIpKMhok/xKt8JLJ/Tp181KbAi
         +q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=D+BUtS4EFIhepmEm7AponDg2q26v2INZttuLWWhsHXo=;
        b=OThHO4Mw4U+Ymq8gdTq0YLToqnDOF1UF3KRu3SPTaFUr3kU4K8mBagi62mvSbkaRUV
         XG7sdoeYG2aSIOJaRHggFcusiI9yyj2nXZ/BAjpkAhTeoreiX1F5D9HsJhmQEhlPf+BN
         da34wJG8gKRHfcLlS3nKx3rq7wWjhbsNJ37N8o+2da/vuE01vzjOwAzv+9K2PXC01nQW
         JGvwlEyirhockK2E4/aEhb7xKmoFK2sbmpF6bYOXfz4rUZl3X8JLyY4I6KNp6C5sS0xh
         IOcYL7BUYF2B6YK1qgNBKu6PlX58zTgNNb+BeADFCxa3O1aOtbTX2AG0UWEHUDt50/Io
         nvYQ==
X-Gm-Message-State: APjAAAUvEh6naRLT3t7igsvrAhlCHSaIhsli0TLCXuctA5THzXszRZ3n
        fOkItNbsidehHVpjpEmLIWb48g==
X-Google-Smtp-Source: APXvYqw8OgPGFmR9F5+HGBD0jog383/zSklA3DB9aSIFGn9nzneAnFjVZBx4VOZ3y2ZWQsPfVBxSaw==
X-Received: by 2002:a63:141b:: with SMTP id u27mr24654108pgl.314.1577187153472;
        Tue, 24 Dec 2019 03:32:33 -0800 (PST)
Received: from localhost ([202.129.236.211])
        by smtp.gmail.com with ESMTPSA id d24sm29760168pfq.75.2019.12.24.03.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:32:33 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor'?= 
        <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: RE: [PATCH 1/1] gpg-interface: add minTrustLevel as a configuration option
In-Reply-To: <011401d5b9a0$58604df0$0920e9d0$@nexbridge.com>
References: <20191216153204.8906-1-hji@dyntopia.com> <20191216153204.8906-2-hji@dyntopia.com> <20191220225746.GF8609@szeder.dev> <87y2v54i9v.hji@dyntopia.com> <011401d5b9a0$58604df0$0920e9d0$@nexbridge.com>
Date:   Tue, 24 Dec 2019 11:30:58 +0000
Message-ID: <877e2mq7t9.hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 23 2019, Randall S. Becker wrote:
> Side question: are there any tests running with alternate GPG
> packages? I have a platform where the official GPG itself is not
> available, so am looking for alternatives for that community.

Do you mean non-standard builds or forks of GnuPG, or alternative
implementations of PGP?

As it stands, the test suite is hardcoded to use gpg and gpgsm (see e.g.
t/lib-gpg.sh).  For normal use, the gpg.program and gpg.<format>.program
config options can be used to override the programs to use.  However,
any alternative implementation would have to mimic the behavior of GnuPG
(see gpg-interface.c -- a number of hardcoded arguments are passed in
verify_signed_buffer() and sign_buffer(), and the output from various
operations are GnuPG-specific.)

-- 
hji
