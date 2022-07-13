Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C472C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbiGMNQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiGMNQh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:16:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BD0E4F
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z12so15472516wrq.7
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKY6NYDDq6NtOQXjMPNnhM2DPgBkcOaPOKNh9JVbgHw=;
        b=OVgszPq1KAZrHfyTHvl3mFp377w4OoLzNqDI9B+QBd2e4hy3oeZIpzlM/6Qei8kJOH
         aekd4w5SA2odEVb6VhYkb1cVuINPX7USp8JP6IUPmyc0In8EZ2yI+osDGSEI7BEVchrJ
         PbmAL9SqkPy+zcOHpyONEuRFldNtsQ+QUg5X5P8mnbOSU3SQqLqaH+5cqn1MFqe7fiSu
         SL6QSG47pob4Zljl4C+MDInVdmIMQanc8nk+trp92yA3OkfKdqvWqJ720JdgLtkDxsFM
         9s+D7c7XAAIZqlsYkHAIaZrNFpjBhKH+ADojuXNqfZTRIQO+wJLjtsZRISlOAONxyqya
         cMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKY6NYDDq6NtOQXjMPNnhM2DPgBkcOaPOKNh9JVbgHw=;
        b=aQQrqee+OHmcILZuAdV9mSJj/2Cjfzucjcbb98/ifgsOFdw9vFipPhm2k82E5Hs93P
         ialJtirVByE6R1WgLOX9w0y8Ho58E6CsDw58G5aaJvPae7nOJyMQCZhpwAIOzU+5pUdG
         ZP4Cm/dFMtAFCTDX1xaVWPp3LmU1GBeuy5N2Hw5hty8j5YiKAjg9cEYjmLzom/0RBRQp
         7AE0epiSNDOGXhP+dntjQh0n3qkTQHvmecNfPdcCm+P73BipNXBSnoEq74m1Hki+A5AN
         XboDtzs0P7VfyRZtTH2rB9qPnHnTZNoEtdQMYzCT+IIu7n2M1z8z3mSRjHZu7stWNIbm
         DFXg==
X-Gm-Message-State: AJIora/kcb9rp7hYoJIJgMGRxigs9Tfejq020eV5z44NfXusYPYbYek7
        5/sh1FV797H5z5A2b8tUNS14usUCICkHNA==
X-Google-Smtp-Source: AGRyM1ty5B2BxkF4l8b78kCjrh6t/F9IhsCaprDn/C8IQVdluWEBx6L4mHtRXNdg3TrxgiyqzdYN+g==
X-Received: by 2002:adf:d1e8:0:b0:21d:ac9c:983d with SMTP id g8-20020adfd1e8000000b0021dac9c983dmr3137382wrd.629.1657718193291;
        Wed, 13 Jul 2022 06:16:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a2e05a81b3sm2216352wma.8.2022.07.13.06.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:16:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/11] submodule--helper: fix "sm_path" and other "module_cb_list" leaks
Date:   Wed, 13 Jul 2022 15:16:13 +0200
Message-Id: <patch-08.11-c8bb7bb7bb3-20220713T131601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix leaks in "struct module_cb_list" and the "struct module_cb" which
it contains, these fixes leaks in e83e3333b57 (submodule: port
submodule subcommand 'summary' from shell to C, 2020-08-13).

The "sm_path" should always have been a "char *", not a "const
char *", we always create it with xstrdup().

We can't mark any tests passing passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true" as a result of this change, but
"t7401-submodule-summary.sh" gets closer to passing as a result of
this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a05578a7382..2b44f391f15 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -828,9 +828,13 @@ struct module_cb {
 	struct object_id oid_src;
 	struct object_id oid_dst;
 	char status;
-	const char *sm_path;
+	char *sm_path;
 };
 #define MODULE_CB_INIT { 0 }
+static void module_cb_release(struct module_cb *mcb)
+{
+	free(mcb->sm_path);
+}
 
 struct module_cb_list {
 	struct module_cb **entries;
@@ -838,6 +842,19 @@ struct module_cb_list {
 };
 #define MODULE_CB_LIST_INIT { 0 }
 
+static void module_cb_list_release(struct module_cb_list *mcbl)
+{
+	int i;
+
+	for (i = 0; i < mcbl->nr; i++) {
+		struct module_cb *mcb = mcbl->entries[i];
+
+		module_cb_release(mcb);
+		free(mcb);
+	}
+	free(mcbl->entries);
+}
+
 struct summary_cb {
 	int argc;
 	const char **argv;
@@ -1183,6 +1200,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 cleanup:
 	strvec_clear(&diff_args);
 	release_revisions(&rev);
+	module_cb_list_release(&list);
 	return ret;
 }
 
-- 
2.37.0.932.g7b7031e73bc

