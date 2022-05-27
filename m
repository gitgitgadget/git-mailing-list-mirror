Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38820C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 10:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350815AbiE0KI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242503AbiE0KIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 06:08:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD46C127194
        for <git@vger.kernel.org>; Fri, 27 May 2022 03:08:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x2-20020a17090a1f8200b001e07a64c461so6692494pja.4
        for <git@vger.kernel.org>; Fri, 27 May 2022 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waEf3kcPtVmHJBBXtXcwF3Q2qcjSd/Hs48+sBWBfbI0=;
        b=BFTXf/pjl8msYS3lSOKe4cu8uPnbV0Eml2PdWSwgFzEe4j+k6tjPKr2vkZSzSo15nb
         oVQPUOWrk3UNBiYthST8++mcmDvSDUuCHIb3Mu/v6ZIqR8WEsIF0A5H2UrjeFP7TUBNY
         8/8NDUu/Ibout1QAcAFptQXnVU2tMtE1UluA2p0iNNIK5nJ6i3iVTE3IzZH14eqQqRlK
         P/p0P8b0ltNRXf1XJUN8PsGo4XUsHY6KAEq2xJpZFBwF9xb0nI8IICZVf+g8dXdm4kmo
         FmaL0jRTse/SrJ2qvyTCf/p3fC1Ubp1W0UGqObNnTgIIRRg/t8pXHkQQpTCxGnDuG08r
         8YOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waEf3kcPtVmHJBBXtXcwF3Q2qcjSd/Hs48+sBWBfbI0=;
        b=EQhPnAXMKa/oxze4nMlaqcnpRVCS70kNqIOOmeR0P7NcXAjgCMo6745SDJyHJzyMv2
         BQXeSR7I8ME+xtWp1oeFPMNisqfXNZXAaikyjCpmuf3ZVMm1frEPSa7Z/E078uxkKmBK
         iubA9S8QSJCUMhor1qIfdWrIxvpQPwX83R4ArljhSiOwdhDEBTgU1VjXSbsbAND2Loxp
         qKASEmOYKCsuI3cc4SEhW0ng0M7U6zXNrSf6ysWqUu+hb+VLmpRZFiM72S13UpoRQbxx
         FLsNT8iqq+Q7Dcqx1wr8MP91xYd4C2cjl95yVjcnkdcBuZs2eXY4WrcuRlv0k0kaLOie
         xbAA==
X-Gm-Message-State: AOAM530lou4UiWullXgwayqtC3Y+plgjI7kuTuPvtI5DFibdulNIpaas
        vWOWhQp6tSgUMaQQGoJ3q6inVnOqLeG52A==
X-Google-Smtp-Source: ABdhPJxqiVTLK8R8HCNcvX4PtBs6JMFTO36rF7dwZ2XUP6L6xfACdtv0Uj100d2fiLm/HnaV2DzpqA==
X-Received: by 2002:a17:903:1249:b0:15e:8b15:b7d2 with SMTP id u9-20020a170903124900b0015e8b15b7d2mr43832630plh.150.1653646103579;
        Fri, 27 May 2022 03:08:23 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.142.42])
        by smtp.gmail.com with ESMTPSA id p26-20020a056a0026da00b005184640c939sm2994262pfw.207.2022.05.27.03.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:08:23 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        newren@gmail.com, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [WIP v2 3/5] mv: check if <destination> exists in index to handle overwriting
Date:   Fri, 27 May 2022 18:08:02 +0800
Message-Id: <20220527100804.209890-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving a sparse file into cone can result in unwarned
overwrite of existing entry. The expected behavior is that if the
<destination> exists in the entry, user should be prompted to supply
a [-f|--force] to carry out the operation, or the operation should
fail.

Add a check mechanism to do that.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 23 +++++++++++------------
 t/t7002-mv-sparse-checkout.sh |  2 +-
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 32ad4d5682..62284e3f86 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -185,16 +185,6 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		length = strlen(src);
 		if (lstat(src, &st) < 0) {
-			/*
-			 * TODO: for now, when you try to overwrite a <destination>
-			 * with your <source> as a sparse file, if you supply a "--sparse"
-			 * flag, then the action will be done without providing "--force"
-			 * and no warning.
-			 *
-			 * This is mainly because the sparse <source>
-			 * is not on-disk, and this if-else chain will be cut off early in
-			 * this check, thus the "--force" check is ignored. Need fix.
-			 */
 
 			int pos = cache_name_pos(src, length);
 			if (pos >= 0) {
@@ -203,8 +193,17 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				if (ce_skip_worktree(ce)) {
 					if (!ignore_sparse)
 						string_list_append(&only_match_skip_worktree, src);
-					else
-						modes[i] = SPARSE;
+					else {
+						/* Check if dst exists in index */
+						if (cache_name_pos(dst, strlen(dst)) >= 0) {
+							if (force)
+								modes[i] = SPARSE;
+							else
+								bad = _("destination exists");
+						}
+						else
+							modes[i] = SPARSE;
+					}
 				}
 				else
 					bad = _("bad source");
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 581ef4c0f6..2c9008573a 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -272,7 +272,7 @@ test_expect_success 'can move out-of-cone file with --sparse' '
 	test_path_is_file sub/file1
 '
 
-test_expect_failure 'refuse to move sparse file to existing destination' '
+test_expect_success 'refuse to move sparse file to existing destination' '
 	git sparse-checkout disable &&
 	git reset --hard &&
 	mkdir folder1 &&
-- 
2.35.1

