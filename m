Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BAFECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiHaXTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiHaXSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6198A4C636
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso413051wmc.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=T3dQ9gtllFdH3QqagR16AV/Xyjdoeb9qS+iUt+ZUg0Y=;
        b=oTuhr5dzRg9sbX27DCigSqXCJXZejYVBoOw2yXbLmp9uKaAc8qxCiFthMcRTvtKWia
         Ib1ZElT1FysK79uq/s+CFRbIewEbhC9AZFDlJ9bmpVNAJ+le7oDvvNlkwIWwInlihTmP
         g7mwYxtxqQscZ9YRkNLhPed5HUTFF+/bO1t0WkcpVkJylvQED8fOB3bwrq0YdOf2985o
         H9iuIxsnufiHTkUi7ugxn1CZ7bqAYAIeUqGyNlUxCaLyYM+8Yl9i7WyOtKdkoToOfekG
         fy3zBa/YeDuTffeLCiwSEJBm5667ObBMa3MSBORh92/C+J0ROErqmoj5O5xfn+cs66AI
         SiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=T3dQ9gtllFdH3QqagR16AV/Xyjdoeb9qS+iUt+ZUg0Y=;
        b=JDjezXM1DTdY8/sQBTYeyCaQW6YcLElY7DR/Lx8C0xOFFulyO1AYktUa0K50bJbG4W
         MK43ntKd8lbMIwN29mwtMoOrVkEcEAEU/8tV89r1kmcUC4Shp2M/TIoRzujGyQ1RbGkZ
         tKRK/IDbjY7IdqKIOdebLn8M2SuiTUj43Q5nVx0Ii//P9p2giEAhthhTL/1mDd/sE2s1
         nG9U/MFAOcjVwi4Akz8RWyA56BTCyemQC88nprp7hpC9gleK3DZ8Lk6443BiV5o28HRe
         xWSRuzbilhkggMFPS7kw8MNRFt4h3NwvZvWdNI+vMi1GtYuGpDGmSPFhbxc80GZuhT60
         zm1A==
X-Gm-Message-State: ACgBeo1mcygrDUevIXXnJPuUaFXHFz3pLUL0pKFQnCW2U+/10difADNH
        vgr4e2f7hClq9lZhhLXNwXjtqdBTzQKGYA==
X-Google-Smtp-Source: AA6agR6jvH4jseuV8wauGbGjSP+9wep3ZA9xu+kRlqYGleerQhEQdONdKHqIYmUqyehDki/MOzMdIg==
X-Received: by 2002:a05:600c:1c19:b0:3a5:51aa:d041 with SMTP id j25-20020a05600c1c1900b003a551aad041mr3286118wms.172.1661987913815;
        Wed, 31 Aug 2022 16:18:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 17/33] submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
Date:   Thu,  1 Sep 2022 01:17:59 +0200
Message-Id: <patch-v4-17.33-52da0d60b47-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
index 4e3bb54afa2..07a918f7373 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -761,7 +761,7 @@ static char *verify_submodule_committish(const char *sm_path,
 	return strbuf_detach(&result, NULL);
 }
 
-static void print_submodule_summary(struct summary_cb *info, char *errmsg,
+static void print_submodule_summary(struct summary_cb *info, const char *errmsg,
 				    int total_commits, const char *displaypath,
 				    const char *src_abbrev, const char *dst_abbrev,
 				    struct module_cb *p)
@@ -819,7 +819,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 {
 	char *displaypath, *src_abbrev = NULL, *dst_abbrev;
 	int missing_src = 0, missing_dst = 0;
-	char *errmsg = NULL;
+	struct strbuf errmsg = STRBUF_INIT;
 	int total_commits = -1;
 
 	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
@@ -920,23 +920,21 @@ static void generate_submodule_summary(struct summary_cb *info,
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
2.37.3.1420.g76f8a3d556c

