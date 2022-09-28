Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAB4C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiI1IlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiI1IkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203E6804B8
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m4so4293216wrr.5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=y5P/SySPrrYrCDcjKcb8fK9DDb5wI4+qyfqOIaUXUNQ=;
        b=kL7aflbIOjwQNE1Dpv71cyBC1ON00F2A69yQQQsO9GnoSNpftboKVX9S52aLFvqlQw
         0f7Ioy9oN2gBgYxYLUm1zxhDQgInJi+RuoDsVbCq2w5UiHVG6rAZ+QVLWb8ZyeZQUME3
         xGz9mbZiQ2OeiIBOT/vOlwn7uA+ColjJjxD8BPn2Nrur4WQVegvaHYtHEzacFPhfIcfp
         ZSdmUfTwhyF7+5U0OOMDEFeeH4pDYntB0hR3hEqXEtnrTINU7uqTcE7ZsGkdwnACAErS
         VhaFe0DIJHtzTrMu7+N9TPeX98j7cA1dvhmi4C6wsNuogsh3snDZ1p1+gTkTwkts/RwL
         SaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=y5P/SySPrrYrCDcjKcb8fK9DDb5wI4+qyfqOIaUXUNQ=;
        b=Ikxt/fEGVh7n7yHHwCO5IWt7X7gRYfaJCZwxXbJnX0e3B2GYYFZ84ZPcLlQaCsM3Ty
         y9mV1UZJyIUyjJSO13MuiiwGBIHLD3l2zwzDxgnXQruM6H+Ae8EVKhreMFJTF/ZKeBhF
         QJoU5yPMF5JF+KDHYOlasfdeg2DyOEwLHgU08p1gSTxCdY3qzLr646Ahy+dU+JgnCBth
         ziG12f6N574UzEYsSG/p+H0r4gfsSzL2j8qkZ0O0lPnh2asFDYT9QO4exkBVzQXgNZOU
         YLm8rf3sVRa8oK2iQbbjvZXqzcRt6iaKyv2mJ1qsaSLd1FO2aJbMK45TfsCOkMpb53Bp
         opDA==
X-Gm-Message-State: ACrzQf2qJGYhhyuSM6G/5JStIQk5/szvSPnU194rIf3C6ItNzXkmNl0l
        W+2jbrU6QnyipAcIistqYWLwtt07Kmn99Q==
X-Google-Smtp-Source: AMsMyM5mh7/DL8+kZ3RcVwlGZhl2hhQe3CRWiq6h6L7qIBc4nXDruNk1MFrxoySSGupGu7J749T14g==
X-Received: by 2002:a05:6000:178a:b0:22b:87b:c995 with SMTP id e10-20020a056000178a00b0022b087bc995mr20362482wrg.715.1664354400365;
        Wed, 28 Sep 2022 01:40:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 23/35] doc txt & -h consistency: make "bundle" consistent
Date:   Wed, 28 Sep 2022 10:39:18 +0200
Message-Id: <patch-v2-23.35-a6a43d0b3fd-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the -h output to match that of the *.txt output, the differences
were fairly small. In the case of "[<options>]" we only have a few of
them, so let's exhaustively list them as in the *.txt.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 1b08700bf9e..544c78a5f3a 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -12,13 +12,14 @@
  */
 
 #define BUILTIN_BUNDLE_CREATE_USAGE \
-	N_("git bundle create [<options>] <file> <git-rev-list args>")
+	N_("git bundle create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]\n" \
+	   "                  [--version=<version>] <file> <git-rev-list-args>")
 #define BUILTIN_BUNDLE_VERIFY_USAGE \
-	N_("git bundle verify [<options>] <file>")
+	N_("git bundle verify [-q | --quiet] <file>")
 #define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
 	N_("git bundle list-heads <file> [<refname>...]")
 #define BUILTIN_BUNDLE_UNBUNDLE_USAGE \
-	N_("git bundle unbundle <file> [<refname>...]")
+	N_("git bundle unbundle [--progress] <file> [<refname>...]")
 
 static char const * const builtin_bundle_usage[] = {
 	BUILTIN_BUNDLE_CREATE_USAGE,
-- 
2.38.0.rc1.925.gb61c5ccd7da

