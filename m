Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1E8C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 02:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343755AbiBUCbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 21:31:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343749AbiBUCbU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 21:31:20 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EC0443DA
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 18:30:58 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 195so4174828iou.0
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 18:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HWkh4QxHRYBm83oVsBf0ZIsP3nia9mh5h4BysNGPsUE=;
        b=ONdFv+05AeJDt2TkNVGDx896mVsB4QCqpR4y6nUz6OFM7jx7Ze5VKg8PCNB93EpBlX
         c9frEci9j8qMqT3EvthYvxg2QNVtH7g9XoujF10bJ39j4jcd+MHlBmDbuU88UaTP8Yok
         MXDgFY6WK6/AnEnRjOT0Kx+xBRJxFOF+rpIGKjz9LgU/SEEpIh3egs73dI0gpzGF9jVb
         FEaXueLcts5ibeY/AsncXBcdO0jrPUACKtHJdwxRgItfe4fw2pSPZX3ya1dZGB20V5Rk
         eI8bn7bb18m2LCtpToWcP3i4eFWxx/rChHNXE7Yjr0tJusIDSr2BHyAMNEMV+GLFPjt0
         26VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HWkh4QxHRYBm83oVsBf0ZIsP3nia9mh5h4BysNGPsUE=;
        b=V9VXAfUb/x2gpXV7PeKxbPusoKORk0R23Chkv1AeJ6OiudZ4ML+lW3X87XhsoGz5pw
         XVCedca0lYdlxrESGZXvPcpHSeSFZck8SZToabpfZ7qlp2qKIr1HmAkgz9uLYMQroHop
         4SsFksSVOi/y4lPLqAFmYD4Vr/N1CcTQQD0SkDi5ipBhlYBshWEDkzVfKDTnDO0LF1SO
         dherCRKNB+pze1wQeLjZtaR/LhLXPlx7710lb4McZ27B4XuMeniEbKyBHWWRCfruywPw
         FN75Hj/w7kYwG6iodA7dLyj0vCHdAdz2BClm5R0jS7Slv951tNJLPiRSNvy2aOEJCcw4
         QC8g==
X-Gm-Message-State: AOAM533c8wkYpg2Dr/602BTEenpYqsXSA8w+gm0bu7tkSkFWoZf2kghx
        FR/cMWVS2hw0J1jMbkBVBg5GkXtA8cASzKJa
X-Google-Smtp-Source: ABdhPJx9MEE2BF+TMc1GKMihBkrqk43/bL47GEpf9Y2dK5o7uw0rF0Xaa+hR+2MTvf33uHzukyuBUQ==
X-Received: by 2002:a02:a80b:0:b0:314:c59d:364d with SMTP id f11-20020a02a80b000000b00314c59d364dmr6435480jaj.77.1645410658129;
        Sun, 20 Feb 2022 18:30:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o22sm8796720iow.37.2022.02.20.18.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:30:57 -0800 (PST)
Date:   Sun, 20 Feb 2022 21:30:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] test-lib: improve LSAN + ASAN stack traces
Message-ID: <YhL5YTrbcWXv2PBo@nand.local>
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 19, 2022 at 12:29:39PM +0100, Ævar Arnfjörð Bjarmason wrote:
> I think this v2 should address all the comments on the v1, thanks
> Taylor & Junio!

Thanks; this version looks good to me, though I agree with Junio's
feedback on the first patch. TBH, I do not feel strongly at all about
"GIT_XSAN_OPTIONS" versus "GIT_SAN_OPTIONS", either seems fine to (with
a slight bias towards the first, since it makes it clear that it targets
both ASan and LSan).

But either way, this looks like it's almost there.

Thanks,
Taylor
