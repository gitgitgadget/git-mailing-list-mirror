Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82047C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiBPK4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:56:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiBPK4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:56:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2EE6542
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:56:37 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q7so2734309wrc.13
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XWJub6jVv6m/FvLCssoxdSc79o256o9sU6uccjTo6uk=;
        b=Iw7WjYtPGcGFlZfjVlTOh0tw7eCeWCeKQqrvGcv8b5j1ZjnBFPMZJhGGrm4d974QSn
         yg0zVSWOUy6FCmIa66sjugqvpHv6kJr0fvCLlCds8ZCRu6/SbAtPxtTWtobXMj7mTy5V
         7soq9CR1jSw3yaJXjB0+D1NG3TqeKJTA8byL8gHRDXMQSEWhMOkO1RAs6rrgiaCfIvfd
         waM2f60zw6pYL5Jpz8s0X1pzjDrrDmVvJvpGibQE4mIZqcNVKeO1sH35/GI8TA6vwB2k
         N4lo/7QZsB6xD7h2CsyfHuulICdx7Qmujldj6BCGFVznpUOq7WuUMLS6A/qOnTotdVLS
         kyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWJub6jVv6m/FvLCssoxdSc79o256o9sU6uccjTo6uk=;
        b=ag/hrX18N/jPLIWNwOSM5oBaTQac3nSSuJtJtBAC7fi5z635bjilfXiAcZqTKOQXOu
         Uz8eggvAH8yrGTs4mWG3exg96ljo3GEBp4v3VPesU5cNrm2y9MgFMsvLMCAOYgG1dUUt
         RRTTtxLVKnU2nQzXsVLZSo2thSBS8KWxiLtd7tts7df7AF7IEhtBYrSK/99NXnMhvkcF
         3HSV2mIY2OwLvUvYfnVBk5v5luswoZknhqnx70m2FjKmJbeD9fb97lCBP0G7lSR8zk+F
         dj4SJEB3ygmO4wr9X7vgltqKBMfv6QUxmbXEY4VkY51x6ap5jBcAL9svsy6jNnAhY+9F
         dATg==
X-Gm-Message-State: AOAM532GxTe8ZWpqpuhg2odO59yV2jqThPY9Bfd/taxNjoZc/JtEaUsM
        9Hgj4X46sOnFS7J1jTqx56mzRDj3YOq04w==
X-Google-Smtp-Source: ABdhPJw6JrDjMfJgMFiTAdU5eL0NJ4VerrpOubyZ4dt5HPDgF4JxKoEm29ECnp49M8kLYcErl0rRiA==
X-Received: by 2002:a05:6000:186d:b0:1e8:49fc:69ce with SMTP id d13-20020a056000186d00b001e849fc69cemr1352901wri.80.1645008995551;
        Wed, 16 Feb 2022 02:56:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u7sm27185370wrq.112.2022.02.16.02.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:56:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] diff.[ch]: have diff_free() free options->parseopts
Date:   Wed, 16 Feb 2022 11:56:29 +0100
Message-Id: <patch-2.2-7f320062419-20220216T105250Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g2d2d4be19de
In-Reply-To: <cover-0.2-00000000000-20220216T105250Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220216T105250Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "struct option" added in 4a288478394 (diff.c: prepare to use
parse_options() for parsing, 2019-01-27) would be free'd in the case
of diff_setup_done() being called.

But not all codepaths that allocate it reach that,
e.g. "t6427-diff3-conflict-markers.sh" will now free memory that it
didn't free before. By using FREE_AND_NULL() here (which
diff_setup_done() also does) we ensure that we free the memory, and
that we won't have double-free's.

Before this running:

    ./t6427-diff3-conflict-markers.sh -vixd --run=7

Would report:

    SUMMARY: LeakSanitizer: 7823 byte(s) leaked in 6 allocation(s).

But now we'll report:

    SUMMARY: LeakSanitizer: 703 byte(s) leaked in 5 allocation(s).

I.e. the largest leak in that particular test has now been addressed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diff.c b/diff.c
index 0aef3db6e10..fb8bc8aadbf 100644
--- a/diff.c
+++ b/diff.c
@@ -6346,6 +6346,7 @@ void diff_free(struct diff_options *options)
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
+	FREE_AND_NULL(options->parseopts);
 }
 
 void diff_flush(struct diff_options *options)
-- 
2.35.1.1028.g2d2d4be19de

