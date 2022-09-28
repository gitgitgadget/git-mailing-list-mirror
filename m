Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8B3C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiI1Ikx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiI1Iju (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4789E4F6B1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l18so6626800wrw.9
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vZnN4Fog68v7wx1RpmswA593GVc9mFcYVqAQxkqyVow=;
        b=IbQhHVdnNFzMnSmUZXAI2T2axmoGhypTbGP1wOefjD/5BP58mAlXCRvemdbCTF7L4U
         Ktn4RGw7pSfdzima6Xh7Y129FyRjQvlyN7lwSiEYZCpKCRnecbGyrVICT7VZ7fBFCw5q
         DddqQePsnNuSoKaK79s4vMrmpTxERKuaG/4cPW/oyFpg6zkIByQ1W22tYN0wFLuAV9Uf
         2/4bC60FzqOX2tKN2K5gAmniKLrn70lWccSHSX4MCDrqTgzw0bYQBJDN3LigdBjAy9zW
         OBG2iJUEg9u7or73KVH/YvAvfeqYMYOjTMPnSvMBXcPrbRTW1Rk/DQ8qhFjviaHyuR7t
         UVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vZnN4Fog68v7wx1RpmswA593GVc9mFcYVqAQxkqyVow=;
        b=QB58J40LDDcK92KGLE/VwUgASi8VOnPUo3sFdoSbMXwAfQT3wHOJctbHem7LYojlz8
         JRPNnQkqf0PZRwAeZrIc8kgPZg2s9XrItMSyyQuquvKAZysT21lrzvV9dNfoepq2H4QL
         6qqLyr8MTYHHFsR86t2E4pDFOvfL5cEpAHAq3cWj3jYJ//9087qhPrF9hsiW2Mt99Sz8
         dqrA/k5jGRkKUwUMt5Mlig4sfzP5nTjK926gBvG/bzd2B/whNYzHG12ONi9skglRuF+l
         h05e+1jpKHaMy12zdnZAY+NCiLxZxChnH1xjSI6JPyiEKAB7eGPWYE77F37/f3FI60S4
         8mkg==
X-Gm-Message-State: ACrzQf1Sfso8zZYm17EWBM7pO1nSuAbY3XG4PS7nowv1vckMg3rtjiXF
        qKGarujwvZQzMmMG8Z4Fw9oUoU62T+jfhA==
X-Google-Smtp-Source: AMsMyM6vdP6e1D3q24g94hvaC/RTe75XWFU95yKoS7ccViUTR26XqvY/j8rbqfK4ljiHieyZICn9dg==
X-Received: by 2002:a05:6000:178a:b0:22b:87b:c995 with SMTP id e10-20020a056000178a00b0022b087bc995mr20361966wrg.715.1664354388318;
        Wed, 28 Sep 2022 01:39:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:47 -0700 (PDT)
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
Subject: [PATCH v2 12/35] doc txt & -h consistency: add missing "]" to bugreport "-h"
Date:   Wed, 28 Sep 2022 10:39:07 +0200
Message-Id: <patch-v2-12.35-6501b9d1ecc-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a "-h" output syntax issue introduced when "--diagnose" was added
in aac0e8ffeee (builtin/bugreport.c: create '--diagnose' option,
2022-08-12): We need to close the "[" we opened. The
corresponding *.txt change did not have the same issue.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 23170113cc8..bb138161943 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -61,7 +61,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <format>]\n"
-	   "              [--diagnose[=<mode>]"),
+	   "              [--diagnose[=<mode>]]"),
 	NULL
 };
 
-- 
2.38.0.rc1.925.gb61c5ccd7da

