Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB9EC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbiGSUsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240251AbiGSUr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFAE5B07D
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z12so23362137wrq.7
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yvr/pSH5za1VIP92OEcjUjTowdIceVIdhRhfF0b/l5c=;
        b=UfhnEw/nWhKIBKilOnBFlml0OJmg2i4z/cQFuagghEzPbRABJy8XGPrxplOI9p7CQj
         2mbn6DRvUCcVzzfVVAswXwl/dgjMevBP7U+E6/FI7HHrKsdcFojh341+tL1Ea5qbyxyK
         r1+3JOTi8iXT8r5f1HKlK6cN6eVJ2Xu692DQQGoRpzhl5FoRCmyptdqb+UvN1SuM/0HJ
         g0pW6atrAsCvOwPr41AcCDp4GexJoDvXcszXzBQPcb6Ljag3ODbEcRK+9FXnSlm7QgE3
         omeBBrBIabFb1w1xlSUd95sFmfMf0o0/q+f3UPXUQCW0aJpCwjbLj1AB5Pfzfp3Dm1VU
         lgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yvr/pSH5za1VIP92OEcjUjTowdIceVIdhRhfF0b/l5c=;
        b=e5AQdP5ahlx+fBJNMGkmkMK6D/zQb8mAs71JJFHTk8AIcNrpEtR/2jIRQWOPdwsp0F
         AggWidoicD3FISMFEij7JSbNPVGT7Xp5VzYQOe7JfFoS6taFNW9XpPmEKsH2XbJrtCXR
         uR7RQnLqG5jrmxv7Ku9ELn78WYn/tOYeNh+9+dpS5SPu+EyAmL6C1FKFAsIrwkfxC0zf
         U14h+2iZ2EMrz28xW9VaCsItbSoSjfJkaLoK0hw8cuF6XtXS0X8vzdWtT2ITgCoavP8L
         ATOVeBoSqv62q86Dr8GEcgJazpAXtk488fZRDhRgI7RFN/An51n6eBCP0z2XrWjmHVtB
         ucWA==
X-Gm-Message-State: AJIora8Zlk/TCfYWG3PLF3ixojpVv7xb4drhQrjMV3787Hhdbx0bzcjN
        B8Cvs6s9SywPTsMdETWlu2DWbbu5PQmlFw==
X-Google-Smtp-Source: AGRyM1tkdYJfShb8VD2CJUIUwCjPWP4wGPPQpo42ckkRLqkzrUll7NecOFo2aMm6HtmoWJBfFjRmxQ==
X-Received: by 2002:a05:6000:702:b0:21d:7f65:f1b5 with SMTP id bs2-20020a056000070200b0021d7f65f1b5mr28035856wrb.555.1658263666237;
        Tue, 19 Jul 2022 13:47:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 21/24] submodule--helper: don't exit() on failure, return
Date:   Tue, 19 Jul 2022 22:47:12 +0200
Message-Id: <patch-v2-21.24-31395a2b4f8-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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
call these routines as a library in the future, and to avoid leaking
memory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3b0f46ad3f6..707c5027961 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2282,7 +2282,8 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 	return run_command(&cp);
 }
 
-static int run_update_command(struct update_data *ud, int subforce)
+static int run_update_command(struct update_data *ud, int subforce,
+			      int *must_die_on_failurep)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
@@ -2344,8 +2345,10 @@ static int run_update_command(struct update_data *ud, int subforce)
 			BUG("unexpected update strategy type: %s",
 			    submodule_strategy_to_string(&ud->update_strategy));
 		}
-		if (must_die_on_failure)
-			exit(128);
+		if (must_die_on_failure) {
+			*must_die_on_failurep = 1;
+			return 128;
+		}
 
 		/* the command failed, but update must continue */
 		return 1;
@@ -2379,7 +2382,8 @@ static int run_update_command(struct update_data *ud, int subforce)
 	return 0;
 }
 
-static int run_update_procedure(struct update_data *ud)
+static int run_update_procedure(struct update_data *ud,
+				int *must_die_on_failure)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2406,7 +2410,7 @@ static int run_update_procedure(struct update_data *ud)
 			    ud->displaypath, oid_to_hex(&ud->oid));
 	}
 
-	return run_update_command(ud, subforce);
+	return run_update_command(ud, subforce, must_die_on_failure);
 }
 
 static const char *remote_submodule_branch(const char *path)
@@ -2542,7 +2546,8 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 				    "--no-single-branch");
 }
 
-static int update_submodule(struct update_data *update_data)
+static int update_submodule(struct update_data *update_data,
+			    int *must_die_on_failure)
 {
 	int ret;
 
@@ -2583,8 +2588,10 @@ static int update_submodule(struct update_data *update_data)
 	}
 
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
-		ret = run_update_procedure(update_data);
-		if (ret) {
+		ret = run_update_procedure(update_data, must_die_on_failure);
+		if (ret && *must_die_on_failure) {
+			goto cleanup;
+		} else if (ret) {
 			ret = 1;
 			goto cleanup;
 		}
@@ -2610,7 +2617,8 @@ static int update_submodule(struct update_data *update_data)
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
 		if (ret == 128) {
-			exit(ret);
+			*must_die_on_failure = 1;
+			goto cleanup;
 		} else if (ret) {
 			ret = 1;
 			goto cleanup;
@@ -2648,13 +2656,18 @@ static int update_submodules(struct update_data *update_data)
 
 	for (i = 0; i < suc.update_clone_nr; i++) {
 		struct update_clone_data ucd = suc.update_clone[i];
+		int code;
+		int must_die_on_failure = 0;
 
 		oidcpy(&update_data->oid, &ucd.oid);
 		update_data->just_cloned = ucd.just_cloned;
 		update_data->sm_path = ucd.sub->path;
 
-		if (update_submodule(update_data))
-			res = 1;
+		code = update_submodule(update_data, &must_die_on_failure);
+		if (code)
+			res = code;
+		if (must_die_on_failure)
+			goto cleanup;
 	}
 
 cleanup:
-- 
2.37.1.1062.g385eac7fccf

