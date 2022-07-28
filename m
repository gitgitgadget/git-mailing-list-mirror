Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C16C19F29
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiG1QTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiG1QSj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:18:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB82973923
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:18:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso1286255wmq.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MDuxaca6R08UPfn+MoxLjVmu6tELZK5ij7EtBgR8ub0=;
        b=VQNPljIhZ4ck0aON2hlegVy5Bzf7HnfIT3NAT75EZ5OZMiGKTPdQFGTH+guVbvELFV
         b/ahAubaWjEtZht64rDiSXXtApSdflF9kp/d1ZlAuhypK38YEyv6LsBbzLBmSSI0tFs7
         UFFrFx1rWbTWYdjXQOOfBuMGB4fc/Vm/g1HnAp1PZVxv098NlDHSHHEXlvF1PHaJBdHH
         3sYB3tFtpBadA4Azxw8Xj0N985TGiUYsyaA80Y9EjjjRO6TsMjCQuk8FDRvQMr2OHIPa
         nHhbyoTWksca1PTSykdxSySrSohx4L+cDL+JiKf56NF2kqwsEL5DfGpOfx/Tzj7JW/WW
         Z/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MDuxaca6R08UPfn+MoxLjVmu6tELZK5ij7EtBgR8ub0=;
        b=fQzS7HBPyJGHLy/nwGy2LUsGmYGWZRr4V/fHlBF7bfYAqvOi1YviE9MrVm0mmsIuv9
         PyHskBPdXB8GVv/tZt3qrscdGMB+WRzq0Yc6RwHnbUA+qP0b4raQ2qk7kneLAwFI9kKI
         5/CJRbz1MGkiPWSHfKxwTgeHG5q3WDiwxYiLOrhjX2FiPRg/F4Cveb8IjrQ6uLaanq3G
         RTnfsvX57+GQ8vHGB1lGVs62Q3nPQ0uyUBFRmEusqHKJNhxnFtXMcrLafbl3DsVgxcH5
         xE6b4UnMedb4UdBdM/boZEYF8+00P7o4lFeykQ7gMPcWwVyUuxcGdsB/Cfs8y/TLpJ+2
         hAlg==
X-Gm-Message-State: AJIora/ZI6/04WdT2wYImCU3RswVzC1Z6oEkHAV1aoHPTeskwJ/Xp31Y
        SyQYMqxuR9Ez2c6h2IXx2ZYjj4bPLof2rQ==
X-Google-Smtp-Source: AGRyM1t8RqIyWVKoSujHvW+0lj5w9YhIZKmzDqfOAvSTeFo47Mubsx3A20qlDUf9tlyrr9cnPnz90w==
X-Received: by 2002:a7b:ca57:0:b0:3a3:205d:2533 with SMTP id m23-20020a7bca57000000b003a3205d2533mr103085wml.67.1659025085876;
        Thu, 28 Jul 2022 09:18:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:18:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 19/20] submodule--helper: don't exit() on failure, return
Date:   Thu, 28 Jul 2022 18:17:04 +0200
Message-Id: <patch-19.20-5a26c9428be-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
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
 builtin/submodule--helper.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 68aa10a26cd..d3f22f03766 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2121,7 +2121,8 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 	return run_command(&cp);
 }
 
-static int run_update_command(struct update_data *ud, int subforce)
+static int run_update_command(struct update_data *ud, int subforce,
+			      int *must_die_on_failurep)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
@@ -2183,8 +2184,10 @@ static int run_update_command(struct update_data *ud, int subforce)
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
@@ -2218,7 +2221,8 @@ static int run_update_command(struct update_data *ud, int subforce)
 	return 0;
 }
 
-static int run_update_procedure(struct update_data *ud)
+static int run_update_procedure(struct update_data *ud,
+				int *must_die_on_failure)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2245,7 +2249,7 @@ static int run_update_procedure(struct update_data *ud)
 			    ud->displaypath, oid_to_hex(&ud->oid));
 	}
 
-	return run_update_command(ud, subforce);
+	return run_update_command(ud, subforce, must_die_on_failure);
 }
 
 static const char *remote_submodule_branch(const char *path)
@@ -2381,7 +2385,8 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 				    "--no-single-branch");
 }
 
-static int update_submodule(struct update_data *update_data)
+static int update_submodule(struct update_data *update_data,
+			    int *must_die_on_failure)
 {
 	int ret = 1;
 
@@ -2420,8 +2425,13 @@ static int update_submodule(struct update_data *update_data)
 	}
 
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
-		if (run_update_procedure(update_data))
+		ret = run_update_procedure(update_data, must_die_on_failure);
+		if (ret && *must_die_on_failure) {
+			goto cleanup;
+		} else if (ret) {
+			ret = 1;
 			goto cleanup;
+		}
 	}
 
 	if (update_data->recursive) {
@@ -2444,7 +2454,8 @@ static int update_submodule(struct update_data *update_data)
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
 		if (ret == 128) {
-			exit(ret);
+			*must_die_on_failure = 1;
+			goto cleanup;
 		} else if (ret) {
 			ret = 1;
 			goto cleanup;
@@ -2482,13 +2493,18 @@ static int update_submodules(struct update_data *update_data)
 
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
2.37.1.1167.g38fda70d8c4

