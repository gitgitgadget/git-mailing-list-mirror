Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCB5C433E2
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 19:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3B3208B3
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 19:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="F4CWijHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgIFTCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgIFTCl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 15:02:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E017EC061573
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 12:02:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f142so11040605qke.13
        for <git@vger.kernel.org>; Sun, 06 Sep 2020 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4yXQYty7JwYORBjnliHPAcUgEbFvUgcKt7vRj6pbgmA=;
        b=F4CWijHHiCLgtaAAW6O4J8FKFHfXmQCXPUJqzw6NKQ8/cejnewKYkPkoA9njwBI2yy
         cVu10Bdf5LD3NDR14/jT64RDlti6Q6CHHctl7upkwikrEQW/3/pz7b7miDDmAjWldzUB
         upJYM63RsOcQLfJWXnVE2cvIL1iDLVJiwy1tl5PMAVA8MeH7kg8CTQDt0tT2Gj2uM4QC
         F1JPXB1VyABgP3pPduu0Vc8sb96OxEWg6p6ddNVEnbCs2BCXiXSiFELtRl4a4wr9P1m7
         Ipr/+U8F8x94aKgancmxO3HR+6aVIe2JiGUZNoDUp5Xv8Tkau5RM0vp3PEP41/neKh5d
         YAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4yXQYty7JwYORBjnliHPAcUgEbFvUgcKt7vRj6pbgmA=;
        b=SzE3yswBKKalUY9HljHePJipFW3wvB9Med4v/wxgO9gdUiuIC3HbTCJzkFm+dIQS/0
         YPsOkJILnnI0X5llI7SK0anQg/o0j4PQYo/EWNqPHb8TQ53Q0/TTlRfsLzZyE8SCTrku
         /dGNiB9MXK8vfcFblISbSlj3nfyEW9OVgVF3K3/OqfX/QQ9sMOVjeN4Pv4oxH8DxzrhL
         dry6JycH6AfCPauW07WwirWaQw63OrnDXWV/pRQVMvFK8+L8CKaTyF0n4xz03mE+FvgX
         v4jXTDzEz2E4cLE6mzn5g0FxF2mV2NoTvTzRNsOieHpb0d0z8gt8PgV8Hnjh82/jNXQI
         +SRA==
X-Gm-Message-State: AOAM53352YVNIjE0j4NwPvMO63tSoHpioIBSxs+mBanYXQo33nDnRuJ1
        Y+yZtJnX1B8g21NzIW6lSk4QNw==
X-Google-Smtp-Source: ABdhPJzMF3ZHoLuafBuPelrb+36eX68pRkNEQNK9earhuyS5+nk/34TGnqLPi3fozC2aayJ76d9EGA==
X-Received: by 2002:a05:620a:661:: with SMTP id a1mr2931871qkh.92.1599418959491;
        Sun, 06 Sep 2020 12:02:39 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2928:8cf2:b0f6:adfd])
        by smtp.gmail.com with ESMTPSA id x197sm8961478qkb.17.2020.09.06.12.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 12:02:38 -0700 (PDT)
Date:   Sun, 6 Sep 2020 15:02:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-bitmap-write: use hashwrite_be32() in
 write_hash_cache()
Message-ID: <20200906190235.GA6146@nand.local>
References: <1143b9e0-3adf-095f-78cf-2f8d8c2bd368@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1143b9e0-3adf-095f-78cf-2f8d8c2bd368@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

On Sun, Sep 06, 2020 at 10:59:06AM +0200, René Scharfe wrote:
> -		uint32_t hash_value = htonl(entry->hash);
> -		hashwrite(f, &hash_value, sizeof(hash_value));
> +		hashwrite_be32(f, entry->hash);

This is an obviously correct translation of what's already written, and
indeed it is shorter and easier to read.

Unfortunately, I think there is some more subtlety here since the hash
cache isn't guarenteed to be aligned, and so blindly calling htonl()
(either directly in write_hash_cache(), or indirectly in
hashwrite_be32()) might cause tools like ASan to complain when loading
data on architectures that don't support fast unaligned reads.

So, I think that we could do one of three things, depending on how much
you care about improving this case ;-).

  - leave your patch alone, accepting that this case which was broken
    before will remain broken, and leave it as #leftoverbits

  - discard your patch as-is, and replace the 'htonl' with 'get_be32()'
    before handing it off to 'hashwrite()', or

  - change the 'hashwrite_beXX()' implementations to use the correct
    'get_beXX' wrappers which behave like htonl() on architectures with
    fast unaligned loads, and fall back to byte reads and shifts on
    architectures that don't.

Credit goes to Peff for finding this issue in GitHub's fork. For what
it's worth, we were planning on sending those patches to the list soon,
but they are tied up with a longer series in the meantime.

For what it's worth, I think doing any of the above would be fine.

Thanks,
Taylor
