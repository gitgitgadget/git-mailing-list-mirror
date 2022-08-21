Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A732BC32772
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiHUOAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiHUN7X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3FD237F6
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h5so9485075wru.7
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QJOF0encA2eLRU0Gls9kTtVCQlugyvnfBFgeH1Zh2k0=;
        b=pBjalC9K6w2j9IuwnKDUOgPNxaIrsMIrAUjYsX0bNMvjIA2UfZ4k3RWuriImDkyckx
         6FXvAYmy0QpTrt+0H5NeAX4+471S0vnZCp8opF1EmJzynjv68l54VOIqYtUTWvrjopQQ
         9bdj5AyeRRBxJF4bab8Ztgi36HLQ75mQ15OR3eqx02KJJV1c4Ly/TBhhFze0d1mBoLAx
         cqJ5b75Z9oLtldm8p48B2NpQQFX60Zo+GqAJ/uwfiKIMCYQy3+b/LRirXc8+hG5+vHqL
         DxbgntMlYIaJ8G2FNlOmOeF994+xLMd24EJn9L71/390kNf/moVPLDdUtjOPNeoa7xMg
         +m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QJOF0encA2eLRU0Gls9kTtVCQlugyvnfBFgeH1Zh2k0=;
        b=LynkH7l4QirXrKWLgYj//mnL+NNS8RcD+NadbX1mGtNqUZvJyFOvkXdgnFxW8CnCgX
         KBHEMFQ7F96V8Frys0ozH18s7nLMzaWt07PG+NdAHETHRkZUY1Q7SDYQp/MBOa67D5Hj
         4kk+NQBD/69kYhpDbXWKKhfGMqzRyofe2WzUw7aC2kLQDXS9vi2tlmwK8hZElAmGeZOh
         AzmRVo/5p2xckf+Onbt+H9pqxPR+6ev6oKjHWZGWMsXRLHh4rnZnQb2huXuW5I/AbaTr
         yWjUkFqGTzvVdmZrvD4ebxYCBwHae7yfXpCaqtXr6z2eMkVR2+Uy7XyRx4Ur5gKk0c7k
         697g==
X-Gm-Message-State: ACgBeo2En7G/9njhI54tx7NmoLxD+X1jTBejAns+wMgc4J3ni5xksWYY
        A+8qEDyOhpHlbATXu5nAjAik8X5g4sevBC5H
X-Google-Smtp-Source: AA6agR6uJMYIvyKF/npLlj9SndB+U6Jh6Jhosg+1pX1At3OM+qd7J3eDefwi0nWffKZ6IcfKhHfScg==
X-Received: by 2002:adf:c803:0:b0:225:3d30:27db with SMTP id d3-20020adfc803000000b002253d3027dbmr5701108wrh.454.1661090332648;
        Sun, 21 Aug 2022 06:58:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 26/32] submodule--helper: libify "must_die_on_failure" code paths
Date:   Sun, 21 Aug 2022 15:57:35 +0200
Message-Id: <patch-v3-26.32-da1a07afd25-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits the codepaths around update_submodules() were
changed from using exit() or die() to ferrying up a
"must_die_on_failure" in the cases where we'd exit(), and in most
cases where we'd die().

We needed to do this this to ensure that we'd early exit or otherwise
abort the update_submodules() processing before it was completed.

Now that those preceding changes have shown that we've converted those
paths, we can remove the remaining "ret == 128" special-cases, leaving
the only such special-case in update_submodules(). I.e. we now know
after having gone through the various codepaths that we were only
returning 128 if we meant to early abort.

In update_submodules() we'll for now set any non-zero non-128 exit
codes to "1", but will start ferrying up the exit code as-is in a
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 45 +++++++++++++------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4d102f2b32e..9e9d4fe0261 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2131,8 +2131,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 	return run_command(&cp);
 }
 
-static int run_update_command(struct update_data *ud, int subforce,
-			      int *must_die_on_failure)
+static int run_update_command(struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
@@ -2195,8 +2194,6 @@ static int run_update_command(struct update_data *ud, int subforce,
 			    ud->update_strategy.type);
 		}
 
-		if (ret == 128)
-			*must_die_on_failure = 1;
 		return ret;
 	}
 
@@ -2228,8 +2225,7 @@ static int run_update_command(struct update_data *ud, int subforce,
 	return 0;
 }
 
-static int run_update_procedure(struct update_data *ud,
-				int *must_die_on_failure)
+static int run_update_procedure(struct update_data *ud)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2256,7 +2252,7 @@ static int run_update_procedure(struct update_data *ud,
 			    ud->displaypath, oid_to_hex(&ud->oid));
 	}
 
-	return run_update_command(ud, subforce, must_die_on_failure);
+	return run_update_command(ud, subforce);
 }
 
 static const char *remote_submodule_branch(const char *path)
@@ -2392,8 +2388,7 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 				    "--no-single-branch");
 }
 
-static int update_submodule(struct update_data *update_data,
-			    int *must_die_on_failure)
+static int update_submodule(struct update_data *update_data)
 {
 	int ret;
 
@@ -2407,10 +2402,8 @@ static int update_submodule(struct update_data *update_data,
 						  update_data->sm_path,
 						  update_data->update_default,
 						  &update_data->update_strategy);
-	if (ret) {
-		*must_die_on_failure = 1;
+	if (ret)
 		return ret;
-	}
 
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
@@ -2438,11 +2431,9 @@ static int update_submodule(struct update_data *update_data,
 	}
 
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
-		ret = run_update_procedure(update_data, must_die_on_failure);
-		if (*must_die_on_failure)
-			return ret;
+		ret = run_update_procedure(update_data);
 		if (ret)
-			return 1;
+			return ret;
 	}
 
 	if (update_data->recursive) {
@@ -2459,12 +2450,9 @@ static int update_submodule(struct update_data *update_data,
 		update_data_to_args(&next, &cp.args);
 
 		ret = run_command(&cp);
-		if (!ret)
-			return 0;
-		die_message(_("Failed to recurse into submodule path '%s'"),
-			    update_data->displaypath);
-		if (ret == 128)
-			*must_die_on_failure = 1;
+		if (ret)
+			die_message(_("Failed to recurse into submodule path '%s'"),
+				    update_data->displaypath);
 		return ret;
 	}
 
@@ -2497,20 +2485,19 @@ static int update_submodules(struct update_data *update_data)
 
 	for (i = 0; i < suc.update_clone_nr; i++) {
 		struct update_clone_data ucd = suc.update_clone[i];
-		int must_die_on_failure = 0;
 		int code;
 
 		oidcpy(&update_data->oid, &ucd.oid);
 		update_data->just_cloned = ucd.just_cloned;
 		update_data->sm_path = ucd.sub->path;
 
-		code = update_submodule(update_data, &must_die_on_failure);
-		if (code)
-			ret = code;
-		if (must_die_on_failure)
+		code = update_submodule(update_data);
+		if (!code)
+			continue;
+		ret = code;
+		if (ret == 128)
 			goto cleanup;
-		else if (code)
-			ret = 1;
+		ret = 1;
 	}
 
 cleanup:
-- 
2.37.2.1279.g64dec4e13cf

