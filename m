Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3922CCCA487
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiGUTOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiGUTNx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:13:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E538CEB7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d16so3598277wrv.10
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NG1uYFlSfij5PvvjFbSdYUDXQRes6sRhg7jrwV/nj1c=;
        b=MH7Dr3JAK4aLKiseY4P5F4eAgbl3f5sQ37QHlBEWc/RR/G++MfwIeQQ3Myd5Id/Z0i
         oraNkurAUiRl++ojLNE5nOKUhbttuJD0vlRMTSsajBMtu49SIPDJwnkqAx5JaVa5HOMS
         acoC5JN43ym7+oXpF+Wd7iFJs2uzxYzK2i4CGbVMjKnJ31kX99gT9hI+FEMJZn8ikqMV
         GaITNuKATPgOg4+lil5bxEWsETrw6XP9Dd3DfQB/rqNfYly5KRhRNd5iQxk7KMQi6RJg
         DYx/vTZ2IzM4//xflwZ8UED08f+gAm9ncSobAW9/pcd8E2LJywZ2wvpG73cFVwoITube
         rmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NG1uYFlSfij5PvvjFbSdYUDXQRes6sRhg7jrwV/nj1c=;
        b=qKjd/gLTmVdlG+WhYxDB81HKjplr1XUSeVeF6tMBbrPLbAPUJ2PEGPaK16CGis1+50
         FYSOoi/CYfvkSUbSg1cJRPPhzPk1QOsZHZmuB2QUNEhE8VAoF413IjEZd9ZxztN3WfFc
         RcYV7lt/OqElriuIZ8bcK/4M+K7lkXL/wzL15tHJNZoc94oKzMQUw1Xca1lvuDrPoxsA
         euDvhFH5s3pVR0pUCWCeu0Zm0BhBsVVcbiqLs/ka4NgX1DNwF7Q2v9wcPXetSc6yo5u/
         1pgZAt5cMAJgb7UQCcc4IMHHfCuxh7zBlfrVOQooQ31xb7b3AKqiwFwbcUApxaj1FXTW
         xv0A==
X-Gm-Message-State: AJIora9jOaNhhYvRNJdTrOpVEW61FCC1M/WTBkJpfCQH9LuvCELfxGFO
        4LCazmxKvkQu5arZDL94BMNIgDml17jcxQ==
X-Google-Smtp-Source: AGRyM1vefyTvFjM98PQpY9ZgiLUloQGaIYsWMXLaLt3TuAFU7cUTiUS+aEKcfLYWmum14FDMQPMyqw==
X-Received: by 2002:a05:6000:184f:b0:21d:a1fb:4581 with SMTP id c15-20020a056000184f00b0021da1fb4581mr36669805wri.651.1658430829111;
        Thu, 21 Jul 2022 12:13:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/26] submodule--helper: add "const" to copy of "update_data"
Date:   Thu, 21 Jul 2022 21:13:05 +0200
Message-Id: <patch-v3-09.26-abf5c4754a4-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Add a "const" to the copy of "struct update_data" that's tracked by
the "struct submodule_update_clone", as it neither owns nor modifies
it.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fb3102f024f..3223c93f91a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1889,7 +1889,7 @@ struct submodule_update_clone {
 	int current;
 
 	/* configuration parameters which are passed on to the children */
-	struct update_data *update_data;
+	const struct update_data *update_data;
 
 	/* to be consumed by update_submodule() */
 	struct update_clone_data *update_clone;
@@ -1974,7 +1974,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	const char *update_string;
 	enum submodule_update_type update_type;
 	char *key;
-	struct update_data *ud = suc->update_data;
+	const struct update_data *ud = suc->update_data;
 	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix);
 	struct strbuf sb = STRBUF_INIT;
 	int needs_cloning = 0;
-- 
2.37.1.1095.g0bd6f54ba8a

