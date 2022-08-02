Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD1BC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbiHBPrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbiHBPrM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:47:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722CC3190B
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z16so18345691wrh.12
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=EcDTY4yw+3c2nTVXJecF6TldvH8mwoAj39muhZLKQZM=;
        b=THsqfcApgoJwl2S/YXg9c/cNiGO3jkH7arfPSAa6db7i/GwSQcmRlLmcTHIDxehWuY
         3x5Sdqjt9dbh3/mDh30MT3M2YljOczBy6h9BiJLiYkhYjelgSuIqgVx1Uas8Sj+/By+N
         SocjJOTnPQs0TT6ci2PuPMKWaAguXoJZhJzIqwvEem5QkcMXvsKXX1q186q98v8mq3FB
         ealPkJrRHytWqyxl+xVNuDlRvwMgdK1bwbJJZNeUmLkL5qJB9V/s0dk5pXyPby5zkWP1
         UjvYQqOcpQT7e2QqZg3Fj2Fn12Wr6o2z9AW+1n4H9qFf0H1Cx0aCOHwDolFnys1ZhfCg
         Q2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EcDTY4yw+3c2nTVXJecF6TldvH8mwoAj39muhZLKQZM=;
        b=0ITqrB1vk/tlGAiRIvDRqt10G376k/KtfZwqo3U4p8H+F9umQbaz+gGC+ab54Eka53
         uPNuRmrqC3NgJMVaWHc5QXIT5SMRwOKeePJlYGHS+8MWvpL1W9s4UBVzqgzFCIE0sN8U
         Cp6BtM+QPKOIhSc3350ChZNc5Hf6JisWjZWWMsrvCKXy0aJTGgjlWxfOyhPE7/vAeHla
         zEBqrk0qAGMKFqNn5ZRZ2rzRLiCnLTy/Bf71BR45VGRRSVZmgVBYdHmFwQe9ScY+r/kR
         OONdulh9BbGW+UIA9Mh+9la3d61i6Xe48CncIfaE0sWuRFCC8bvGlsw64W5THkYbOzdl
         4bog==
X-Gm-Message-State: ACgBeo0ylPpxDT2pjb1Us8Ornzj8ZmGp9Vhw9vMx0AAjN0l8jA5issYP
        M1YYwbDO2CZOMQeh0vgjeWZ/FC0UtCLnCQ==
X-Google-Smtp-Source: AA6agR4AcePheyQnIMTwr54SsrGtOB3vsWcgrhu7OEbMvIiKg3w4fQRE2DrFQtuoJC8v4wG7YPEiKA==
X-Received: by 2002:a5d:64ec:0:b0:21e:9396:b0ff with SMTP id g12-20020a5d64ec000000b0021e9396b0ffmr13911137wri.411.1659455200644;
        Tue, 02 Aug 2022 08:46:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 24/28] submodule--helper: don't exit() on failure, return
Date:   Tue,  2 Aug 2022 17:46:08 +0200
Message-Id: <patch-v2-24.28-d33260487bd-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code downstream of module_update() to short-circuit and return
to the top-level on failure, rather than calling exit().

To do so we need to diligently check whether we "must_die_on_failure",
which is a pattern started in c51f8f94e5b (submodule--helper: run
update procedures from C, 2021-08-24), but which hadn't been completed
to the point where we could avoid calling exit() here.

This introduces no functional changes, but makes it easier to both
call these routines as a library in the future, and to eventually
avoid leaking memory.

This and similar control flow in submodule--helper.c could be made
simpler by properly "libifying" it, i.e. to have it consistently
return -1 on failures, and to early return on any non-success.

But let's leave that larger project for now, and (mostly) emulate what
were doing with the "exit(128)" before this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bac45e2bab7..8d83f1f99d2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2141,7 +2141,8 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 	return run_command(&cp);
 }
 
-static int run_update_command(struct update_data *ud, int subforce)
+static int run_update_command(struct update_data *ud, int subforce,
+			      int *must_die_on_failure)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
@@ -2205,7 +2206,7 @@ static int run_update_command(struct update_data *ud, int subforce)
 		}
 
 		if (ret == 128)
-			exit(ret);
+			*must_die_on_failure = 1;
 		return ret;
 	}
 
@@ -2237,7 +2238,8 @@ static int run_update_command(struct update_data *ud, int subforce)
 	return 0;
 }
 
-static int run_update_procedure(struct update_data *ud)
+static int run_update_procedure(struct update_data *ud,
+				int *must_die_on_failure)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2264,7 +2266,7 @@ static int run_update_procedure(struct update_data *ud)
 			    ud->displaypath, oid_to_hex(&ud->oid));
 	}
 
-	return run_update_command(ud, subforce);
+	return run_update_command(ud, subforce, must_die_on_failure);
 }
 
 static const char *remote_submodule_branch(const char *path)
@@ -2400,7 +2402,8 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 				    "--no-single-branch");
 }
 
-static int update_submodule(struct update_data *update_data)
+static int update_submodule(struct update_data *update_data,
+			    int *must_die_on_failure)
 {
 	ensure_core_worktree(update_data->sm_path);
 
@@ -2436,9 +2439,15 @@ static int update_submodule(struct update_data *update_data)
 		free(remote_ref);
 	}
 
-	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
-		if (run_update_procedure(update_data))
+	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
+		int ret;
+
+		ret = run_update_procedure(update_data, must_die_on_failure);
+		if (*must_die_on_failure)
+			return ret;
+		if (ret)
 			return 1;
+	}
 
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -2461,7 +2470,7 @@ static int update_submodule(struct update_data *update_data)
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
 		if (ret == 128)
-			exit(ret);
+			*must_die_on_failure = 1;
 		return ret;
 	}
 
@@ -2494,12 +2503,19 @@ static int update_submodules(struct update_data *update_data)
 
 	for (i = 0; i < suc.update_clone_nr; i++) {
 		struct update_clone_data ucd = suc.update_clone[i];
+		int must_die_on_failure = 0;
+		int code;
 
 		oidcpy(&update_data->oid, &ucd.oid);
 		update_data->just_cloned = ucd.just_cloned;
 		update_data->sm_path = ucd.sub->path;
 
-		if (update_submodule(update_data))
+		code = update_submodule(update_data, &must_die_on_failure);
+		if (code)
+			ret = code;
+		if (must_die_on_failure)
+			goto cleanup;
+		else if (code)
 			ret = 1;
 	}
 
-- 
2.37.1.1233.ge8b09efaedc

