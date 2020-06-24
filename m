Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5322C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 11:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20C320706
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 11:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErGDTGT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbgFXLnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388360AbgFXLnU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 07:43:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552A9C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 04:43:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so1943347wrr.10
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9Di5cSJFS4bvKBa92EdlrdzHkC2XQI/qoNEGVbO87VY=;
        b=ErGDTGT2C9J1QwiPScZFLQbHd4WEoukkDul46mWCSjxPt0Ay3OwgPa3ifn1pMtCarL
         PIe60pfy0egWLnmKMeVBaHTS4AKdXDQTuKBGqt3JFmqwwQjU8NDR7SNZ/kmtL0wUriLF
         Mz/n+arIINJ81byymaKSzcJ7xZUg6Bd+snb5aVS4l5qZDC3HqBVWoC3XAw1bRvsnmvye
         OkPZBfgZcCJFrONLZM0e348vx43gnnKHJZdM3CKI1gtPTDK5vIduNMfEklw8fTgtZqsV
         OKwQ2ZVxIxUu7HT7zBJrmpy+4ldvkGQWxsFeX75EMsP9qHbRR1x7vwZ+3IawJtzACYzp
         qIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9Di5cSJFS4bvKBa92EdlrdzHkC2XQI/qoNEGVbO87VY=;
        b=ENq7FmDJi0Lqh9Plu8Pr0GsG68jgtcFbCLwqJwnwiJ4c1GN6QfJE/UMQ12p9FPo3aG
         6RAjbc/RpmCx/OeGnqv/yikXx1n1REXEwnlWJFY2ij3kMq4Dw6NvLn1ptUVRdcWDdWKH
         Qo6ZiIGbhr21gTYSs98RERYgfclbRPypayiiCn1REN5BP3LWBKFY7kR/X9hF2s+pLxbk
         27mqzaYiZKP+lVCsNUvE11IIMU5dnab+J1WSZqGeABeJv1MZFoX2eK2E60gidTwfFZxo
         GYyO5dmehliVX6ILqnvp9fEuBdEZ25/8y1um295+dhV72viLqDHq3c4p3nHSEdO53BDU
         EmRA==
X-Gm-Message-State: AOAM5328jWh7R95jOs6y9Pzk89HpX31LGZejcXusS3RoHdXMgFHDK5jn
        mc083fgnFR4FExYoBKks3+Cna0q0
X-Google-Smtp-Source: ABdhPJywFtcTTHAUyS/nVli46aMRxmE+wU5hzKaz00z/b4dzDgrUdr3W44hmCdrP1eyb84XzoRssKA==
X-Received: by 2002:adf:f608:: with SMTP id t8mr15736048wrp.308.1592998996915;
        Wed, 24 Jun 2020 04:43:16 -0700 (PDT)
Received: from szeder.dev (92-249-246-85.pool.digikabel.hu. [92.249.246.85])
        by smtp.gmail.com with ESMTPSA id r1sm26284207wrn.29.2020.06.24.04.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2020 04:43:16 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:43:13 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/10] fast-export: store anonymized oids as hex strings
Message-ID: <20200624114313.GJ2898@szeder.dev>
References: <20200623152436.GA50925@coredump.intra.peff.net>
 <20200623152451.GC1435482@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200623152451.GC1435482@coredump.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 11:24:51AM -0400, Jeff King wrote:

> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 289395a131..4a3a4c933e 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -387,16 +387,19 @@ static void *generate_fake_oid(const void *old, size_t *len)
>  {
>  	static uint32_t counter = 1; /* avoid null oid */
>  	const unsigned hashsz = the_hash_algo->rawsz;
> -	unsigned char *out = xcalloc(hashsz, 1);
> -	put_be32(out + hashsz - 4, counter++);
> -	return out;
> +	struct object_id oid;
> +	char *hex = xmallocz(GIT_MAX_HEXSZ);
> +
> +	oidclr(&oid);
> +	put_be32(oid.hash + hashsz - 4, counter++);
> +	return oid_to_hex_r(hex, &oid);
>  }

GCC 4.8 complains about this change in our CI job:

  $ make CC=gcc-4.8 builtin/fast-export.o
      CC builtin/fast-export.o
  builtin/fast-export.c: In function ‘generate_fake_oid’:
  builtin/fast-export.c:394:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
    put_be32(oid.hash + hashsz - 4, counter++);
    ^
  cc1: all warnings being treated as errors


