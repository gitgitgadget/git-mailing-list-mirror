Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1D1C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiGSUrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbiGSUrj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFF3599D4
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n12so10493238wrc.8
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/BPDMnzr5BYpKRXEsCp1hJw6pSuR1amBlfB3Pl4izB4=;
        b=XsEeiVQVi4EQ2QxBjNY9BCyQdsVK49tVfvzpgjmcHEMq0ZjKcjwBm1BhPXYsmdR7Fq
         yQZ/4B9/AjlTBnE26XDnu8g2WT+TgEcqSLG3WoehItUOWb2PObFXaEq8VcHXdxWizQyj
         t8PiuIM8B24k77FtIfONaAoveToIrIPeV2RAeQJ+sLG6R90QyesFBXS3Kw1/xsZcWpr3
         OGNCfYWp4WaE8VC0gbHH7/mJyrfsbIum3tW6kRiRuqdinTEXiKBMn+YGbGTM0Qq/Abjw
         mQLCGRLMA40pYzfF9lLvmkV3UhUgy1Q2vJJTWFzIJsOXcuGToAo02GMivdX2InwqRE5S
         8A3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BPDMnzr5BYpKRXEsCp1hJw6pSuR1amBlfB3Pl4izB4=;
        b=hJfTgd2ssyg8xpCoFhfYNaDGjX8kyzpBGR3NKDnCO04mWGjQc5dXqom/w1UgiwpplB
         FtlnR9KDTyXQXO8F9jepa2B4KO0MLrJcgQJbILFH+CAv5XQ/NbHVTtSCQvIDEziZrhSC
         uGvWhShLMCAizyOlacTRP5+iYV25Df5p3vyuucc8tUZQN3zUm6q3Wj6NPCmBQcu334DK
         zFZYIycOgwsI3JOwXu6GbwVzHczYKnrvOpbVLoMFg2uvh4T+sfFM5m2gfNVXYULGlRG/
         KamPubwcqJjLMdjLqrRyj6xSCmWLbF5WFcDp5ZD80AEp7VQz6O1tzyUqzD4794/q4v00
         Qy2A==
X-Gm-Message-State: AJIora9kF5LZmg0CZRwrEYJdeicYennbUZ3GMSU8YHRaz7ajQAHcql7e
        +tq6sXM29Hi8tB+k9QBxNf1fUey5ErRDFg==
X-Google-Smtp-Source: AGRyM1vcy7JPLAvN8YsOXM4cJD8LgyeswFHukj/egEaAmx6aZ5vcX2ChevvtiWj3HIjAkI5GcEbFjA==
X-Received: by 2002:a05:6000:1a8b:b0:21d:9ae8:f8d9 with SMTP id f11-20020a0560001a8b00b0021d9ae8f8d9mr26589572wry.686.1658263655501;
        Tue, 19 Jul 2022 13:47:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/24] submodule--helper: fix "sm_path" and other "module_cb_list" leaks
Date:   Tue, 19 Jul 2022 22:47:02 +0200
Message-Id: <patch-v2-11.24-c25b55c9528-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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
index e51640d020c..a95231b1698 100644
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
@@ -1181,6 +1198,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 cleanup:
 	strvec_clear(&diff_args);
 	release_revisions(&rev);
+	module_cb_list_release(&list);
 	return ret;
 }
 
-- 
2.37.1.1062.g385eac7fccf

