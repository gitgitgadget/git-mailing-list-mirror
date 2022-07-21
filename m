Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78346C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiGUTOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiGUTOD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91728D5F2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bu1so3603147wrb.9
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkN7AXbY6pW5NTyz6u4UEUk39JBJrh4jAt8oUngcabA=;
        b=kmFVIC/X5Hf/Rioiw+3dJDwQCrjVoaMgXHIpsH9nDoTHOFyavRhoFC+v992ftcWDCx
         KUgefEK0s2NLqYu6QiAkpPgeFTNhvMnFoFzeA+uMIkFz8bsgphpgH9RsFbnXoVIvA6s+
         RI/2QPGgHadaZAbH05ErzehWYWTayJJOA2p6yZwreADD6Lkccdrko1gFewG1eeXO6ial
         RQzpInVFTYKLjKosQlu0pQQEDAqALcS+bqEyjU5Z/p51jthqTlaUIQtH5f5KrmIOcl+i
         exRCR3TXKgxRUF9Bn0RoZ1tdNVbvugMSvhkpzn+h8CTLEShJbkTv1PVTp8iyOb50BQ74
         HaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkN7AXbY6pW5NTyz6u4UEUk39JBJrh4jAt8oUngcabA=;
        b=DmPPfDA2q9I9xe/KqI0RY33YQaILDF1q3Dc1rMUzWdmQHiM778ujCOiDEirs9lZYHM
         LFkfBCViAwfT7/pzppYXl/d/kdIYbt9K1solblJXb74PGvmX6ss8sPaIyORwgCSu4LUJ
         rRujCdFnM63BOqkpM14UAexETsL0dEFm5068KFo90ah1bX++e8+8XCh0INhTAXpgYoOt
         sYtr28PKdh/+5T/o6wFi7XXe9FuNx4tFPcHsboHSgwCks5YzR0F3UD9WTdJemDL+0Kmp
         LYC6EXPrSwaib2uCfrGncNaxq9plOAc7EpunonOEyouvXYMi4zEc0hRXQLsdf+2pKx6k
         vvYg==
X-Gm-Message-State: AJIora/76mTAV7Zu3lZxQ+GKzGss7oKYRjz3npEqJ4sJa0QoHODJUXT3
        PvH0EMQQZEUMtIDeGUZ2Mx/7ZO8QpTawRA==
X-Google-Smtp-Source: AGRyM1vAvTWAQ8sZWvp/VXhFGWnbY4W6KHQD9eJHUKlRG8sS0SrZ3H5r4dWFZG+RBPa1JSaxKA1dqw==
X-Received: by 2002:adf:e708:0:b0:21e:59c8:d2ea with SMTP id c8-20020adfe708000000b0021e59c8d2eamr2406462wrm.499.1658430834735;
        Thu, 21 Jul 2022 12:13:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/26] submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
Date:   Thu, 21 Jul 2022 21:13:07 +0200
Message-Id: <patch-v3-11.26-feec1f20bf9-20220721T191249Z-avarab@gmail.com>
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

Refactor code added in e83e3333b57 (submodule: port submodule
subcommand 'summary' from shell to C, 2020-08-13) so that "errmsg" and
"errmsg_str" are folded into one. The distinction between the empty
string and NULL is something that's tested for by
e.g. "t/t7401-submodule-summary.sh".

This is in preparation for fixing a memory leak the "struct strbuf" in
the pre-image.

Let's also pass a "const char *" to print_submodule_summary(), as it
should not be modifying the "errmsg".

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 21b3abb7b40..f794d2b588b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -866,7 +866,7 @@ static char *verify_submodule_committish(const char *sm_path,
 	return strbuf_detach(&result, NULL);
 }
 
-static void print_submodule_summary(struct summary_cb *info, char *errmsg,
+static void print_submodule_summary(struct summary_cb *info, const char *errmsg,
 				    int total_commits, const char *displaypath,
 				    const char *src_abbrev, const char *dst_abbrev,
 				    struct module_cb *p)
@@ -924,7 +924,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 {
 	char *displaypath, *src_abbrev = NULL, *dst_abbrev;
 	int missing_src = 0, missing_dst = 0;
-	char *errmsg = NULL;
+	struct strbuf errmsg = STRBUF_INIT;
 	int total_commits = -1;
 
 	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
@@ -1024,23 +1024,21 @@ static void generate_submodule_summary(struct summary_cb *info,
 		 * submodule, i.e., deleted or changed to blob
 		 */
 		if (S_ISGITLINK(p->mod_dst)) {
-			struct strbuf errmsg_str = STRBUF_INIT;
 			if (missing_src && missing_dst) {
-				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commits %s and %s\n",
+				strbuf_addf(&errmsg, "  Warn: %s doesn't contain commits %s and %s\n",
 					    displaypath, oid_to_hex(&p->oid_src),
 					    oid_to_hex(&p->oid_dst));
 			} else {
-				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commit %s\n",
+				strbuf_addf(&errmsg, "  Warn: %s doesn't contain commit %s\n",
 					    displaypath, missing_src ?
 					    oid_to_hex(&p->oid_src) :
 					    oid_to_hex(&p->oid_dst));
 			}
-			errmsg = strbuf_detach(&errmsg_str, NULL);
 		}
 	}
 
-	print_submodule_summary(info, errmsg, total_commits,
-				displaypath, src_abbrev,
+	print_submodule_summary(info, errmsg.len ? errmsg.buf : NULL,
+				total_commits, displaypath, src_abbrev,
 				dst_abbrev, p);
 
 	free(displaypath);
-- 
2.37.1.1095.g0bd6f54ba8a

