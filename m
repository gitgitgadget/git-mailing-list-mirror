Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F41DECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiHaXPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiHaXO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:14:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D65EDF40
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so424957wms.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SgC20aquWKdv3k3UUBSIC+olHZ/FWNAKia64zB/F3fo=;
        b=ilXfMS/8Zg4rNfyzKGD7bs6DGFVpbm89VpjjZfI60QS+9O7Aj/3AF0PozvbzOw4GRM
         j49R7DaHIwpOCplSJrZ38yadAb5Pqw8iooRsd24I8UwBcj/3ocDUeTJL7EQmXem8YG7Y
         Ee9fy0sBD4jZwkD6SwAZeNwTe64GTJ4Pb1a0Y3ugbyndhGXB02hH/4dcuJ2mpN6SYc22
         04koubveqYVLCwFG+EfwBHSN5Fg6eYPGdx2nzdwvh/bmcI6kHyI79ev7dkX4YwosJMrC
         /7DrgOQj++SuMCHJwIDVfeo50c4UZm5cULRo3fmbBDcxnfNVSdI86Jre54lVA3RMBA+R
         N22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SgC20aquWKdv3k3UUBSIC+olHZ/FWNAKia64zB/F3fo=;
        b=j12Ue2TvttlsqUblRbwqPWHBEAyigNcQY7Lsubo9rp63Y24SGigznoUbfrenuP3MVs
         HKEQBrTLdA1lBjQKGZgIYbkBKzduRhUYdztyu9wEK2hz9oc85Z/JWu5/xLZ8rRW/Pyh9
         HqkTmwr2JcVr+E2p5RAHZroGgi8wFVX6qPE7cxtUjMh7AVpI7znpOMu+46lEyQsXV1c0
         hat7QI3U6Ttptpf/+zjEqyXkfd+FAvZXdaJQwIHJTAqiHJtvAZM/HlXd9XtKrevTz558
         ywP1/nTBSCyfLKQlRlir+aqH0qNRdvVt0ADeYQ+HLj8xFo0agVPo9M4Rw656oCKPgzO2
         ornA==
X-Gm-Message-State: ACgBeo18BfcPBT352i+l/AINtck8jN/Sw0eqWXt7/Ta8Hc0xf+ZUBO8n
        duUX/b8wYMmJ5Y9atDmCm8q/Y4PLnW1R9g==
X-Google-Smtp-Source: AA6agR5UpIhlzAq04xZgRr4uJ2I0tuZrAN5Rv8Wd3tGUH2hyuiPSNpzxB3yVFL3vzYKoQ0U3ILZHBA==
X-Received: by 2002:a05:600c:3c96:b0:3a6:59b1:5eb5 with SMTP id bg22-20020a05600c3c9600b003a659b15eb5mr3328859wmb.187.1661987691434;
        Wed, 31 Aug 2022 16:14:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 08/17] submodule--helper: fix "sm_path" and other "module_cb_list" leaks
Date:   Thu,  1 Sep 2022 01:14:15 +0200
Message-Id: <patch-v7-08.17-2c5db495189-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix leaks in "struct module_cb_list" and the "struct module_cb" which
it contains, these fix leaks in e83e3333b57 (submodule: port submodule
subcommand 'summary' from shell to C, 2020-08-13).

The "sm_path" should always have been a "char *", not a "const
char *", we always create it with xstrdup().

We can't mark any tests passing passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true" as a result of this change, but
"t7401-submodule-summary.sh" gets closer to passing as a result of
this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c  | 21 ++++++++++++++++++++-
 t/t7401-submodule-summary.sh |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 75a5d9d47fd..162e92c033e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -748,16 +748,34 @@ struct module_cb {
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
+
 struct module_cb_list {
 	struct module_cb **entries;
 	int alloc, nr;
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
@@ -1104,6 +1122,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 cleanup:
 	strvec_clear(&diff_args);
 	release_revisions(&rev);
+	module_cb_list_release(&list);
 	return ret;
 }
 
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 9c3cc4cf404..542b3331a78 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -17,6 +17,7 @@ This test script tries to verify the sanity of summary subcommand of git submodu
 # various reasons, one of them being that there are lots of commands taking place
 # outside of 'test_expect_success' block, which is no longer in good-style.
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 add_file () {
-- 
2.37.3.1420.g76f8a3d556c

