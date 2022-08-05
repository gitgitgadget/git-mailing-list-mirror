Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484DDC19F2A
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 03:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbiHEDG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 23:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiHEDGc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 23:06:32 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C812B101F7
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 20:06:04 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bh13so1577421pgb.4
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 20:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWf9s3Lm8yrbGwwBbzyZN+RdRUj7ojNrhg84WfEReR4=;
        b=dPitKpd8XBCHXvhV5yerWoR4PYFTnq8AAFJn9T/7rV7K3Yirbfeq5ePh4uITtRseC8
         zXncaFDMGOpL+QwKXB4g098vet+y4vfZpXnPl2+f+VHpqEb2IN9lotCCCkHZKfKPd5sg
         zGtXJrbAeedWMya4GPRZU/9uzcXOZGmSPZ/MNgyWBVswUeVeRYeXb5q27qtdscigo/n2
         By+iOPmgv8PYfMyjVwL130S/MHybmb9loKGQpWwSpM89J4Jf01ZK9E7urYwjACBkltFq
         oHFi7JrR7ykMhXuJMuIQAmEPgg94By0LTojm93cbQCdFGlAi4kojm/uw3OlKmbX71BLM
         RPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWf9s3Lm8yrbGwwBbzyZN+RdRUj7ojNrhg84WfEReR4=;
        b=GBf3vhcMfhNEljUbDPg2eXD/gA6M5w1+mrgNb3fhHix2yxJkAxVR1ZJDtblWnuVpsX
         YSWtjmQdUom74OgVVfjyRDhE8/3vkHC6/IvZ3SlUUreWl86kCUXRhja/yO9ll5CL5kkc
         iMTOi5nfynhapOf48Pdmq7EkV9yr9Suf4tU28G9OYsvKCv4+KypGr4Y78bJo73ydq0pb
         me76Rz6cfHAK51dvQEwMafT9UfQI6B9wKZ8EWsG6LFwAjtoTwELoDKrT55dpmTcz2Vxi
         yaa5p5HQ4y5FO43xKehqqpvKvNHIGdCR1G4YmMCaHclVFzY74/K3dDewqtDhgU6I7Ds7
         VLoA==
X-Gm-Message-State: ACgBeo1NPVOux7jPklhCxBVkEx3iQbONa/qGOLSGd+YhjUk+CmVfCloj
        56AB1hCQg3fF4k4ved/xSrG15ybwRBnsYSOo
X-Google-Smtp-Source: AA6agR4T2WA6LfZLEQLwzQcv1NUasHV7/UmFE4IiSZXi5zJumbhvyzN0MqJd8STJnU3lZFPqHjQCDg==
X-Received: by 2002:a65:6d1b:0:b0:41d:431:eaff with SMTP id bf27-20020a656d1b000000b0041d0431eaffmr1021021pgb.592.1659668764142;
        Thu, 04 Aug 2022 20:06:04 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.229.239])
        by smtp.gmail.com with ESMTPSA id i6-20020a654d06000000b0040df0c9a1aasm570234pgt.14.2022.08.04.20.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:06:03 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 9/9] mv: check overwrite for in-to-out move
Date:   Fri,  5 Aug 2022 11:05:28 +0800
Message-Id: <20220805030528.1535376-10-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add checking logic for overwriting when moving from in-cone to
out-of-cone. It is the index version of the original overwrite logic.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 12 ++++++++++++
 t/t7002-mv-sparse-checkout.sh |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 765a1e8eb5..70996d582f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -367,6 +367,18 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			goto act_on_entry;
 		}
 
+		if (ignore_sparse &&
+		    (dst_mode & SKIP_WORKTREE_DIR) &&
+		    index_entry_exists(&the_index, dst, strlen(dst))) {
+			bad = _("destination exists in the index");
+			if (force) {
+				if (verbose)
+					warning(_("overwriting '%s'"), dst);
+				bad = NULL;
+			} else {
+				goto act_on_entry;
+			}
+		}
 		/*
 		 * We check if the paths are in the sparse-checkout
 		 * definition as a very final check, since that
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index f0b32a2f70..50bcca583c 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -323,7 +323,7 @@ test_expect_success 'move clean path from in-cone to out-of-cone' '
 	grep "S folder1/d" actual
 '
 
-test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
+test_expect_success 'move clean path from in-cone to out-of-cone overwrite' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 	echo "sub/file1 overwrite" >sub/file1 &&
-- 
2.37.0

