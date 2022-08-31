Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EFBECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiHaXTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiHaXSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B84D9F1B8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u17so866099wrp.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=l4jyzwIcTiQTBNvs3QkL5KkVdT3b+LabYwWg/+7J91Q=;
        b=lpsf39/1y8lbMlBzDO+MMt8QuTqzWFfaQCX7YAn7YhEfPbF3pznTa+Jjs8CISQJcaO
         VY2bTVC5jQTYAuqcyBRS9doHc9Yd9B5T/Os3Yv0wZ/cY/Kx6wVHxeJqAufOChflkuyXc
         XcHbzqWDEBuwzXfssOEZx6Fon4ppKaShqsdjIjCOCEscJbapW8rMk3YoZhyH8s/fVOhH
         Gk9u3FLKfkMl1jjihwmpjY0C3FHIyu3ni6q5m40USGSFN0KmFUSwlQ3AQE9dpBqGrVNU
         PzOxXvu7HPEket8raF0OsxG8yhaJVOFNnVDNTRGXxFJgh2wV/ANdb8HqP7OYqjoNYsgN
         OiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=l4jyzwIcTiQTBNvs3QkL5KkVdT3b+LabYwWg/+7J91Q=;
        b=swKWVXUGw62KMu2jnzk37ewYjJBpRQS+VBhagBtwOWF3/SOcjGl4MY2j6edgagpzrR
         HUGSWHEqbvxq+c7+ZiooiP8Ko6Q0Y0iPL1+p+P8SVTgt6rxUWBrR58CeT8Hhalaqh9t+
         //u0ScbQGFbVcNjoNg+B9dcizeFYYy3FefkhLwRARaL0iMKnQqEopI6RIpptSbifoBDt
         Dwq3UmcvMT1JCYKfMCHOcgKhK/juffJmw6rUYiZq614UtjHPYVTbVku/Lsc0pGoFTv9D
         ztIeVUb/k1ecsk95DQ21dYVwKZdhY6dzFeKmfkSPZvQqpiT4b7Cy/6a9byIVl6ZKMWtV
         Ptfw==
X-Gm-Message-State: ACgBeo0iI5retNGuNkHbtwtUo+7sR2sp9OQk/c+96ajCUqlzNnXRrKQl
        w+wk3rMYrqMzsw7CRMsIJWM7K+mZ5Hykmw==
X-Google-Smtp-Source: AA6agR6MLhspA+HZDKg8dQLVyebS8g27IBQWLceJ6G3bH9RAwZpdsr9nht1GVZbp3BVNmDW3ZY4peg==
X-Received: by 2002:a05:6000:813:b0:226:da5a:84a9 with SMTP id bt19-20020a056000081300b00226da5a84a9mr9544492wrb.309.1661987915488;
        Wed, 31 Aug 2022 16:18:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 19/33] submodule--helper: rename "int res" to "int ret"
Date:   Thu,  1 Sep 2022 01:18:01 +0200
Message-Id: <patch-v4-19.33-bc7d401bfb3-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "res" variable added in b3c5f5cb048 (submodule: move core
cmd_update() logic to C, 2022-03-15) to "ret", which is the convention
in the rest of this file.

Eventual follow-up commits will change the code in update_submodule()
to a "goto cleanup" pattern, let's have the post image look consistent
with the rest. For update_submodules() let's also use a "ret" for
consistency, that use was also added in b3c5f5cb048. We'll be
modifying that codepath in subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 93ab49defb1..4fbbffb4637 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2429,7 +2429,7 @@ static int update_submodule(struct update_data *update_data)
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct update_data next = *update_data;
-		int res;
+		int ret;
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
@@ -2441,13 +2441,13 @@ static int update_submodule(struct update_data *update_data)
 		update_data_to_args(&next, &cp.args);
 
 		/* die() if child process die()'d */
-		res = run_command(&cp);
-		if (!res)
+		ret = run_command(&cp);
+		if (!ret)
 			return 0;
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
-		if (res == 128)
-			exit(res);
+		if (ret == 128)
+			exit(ret);
 		return 1;
 	}
 
@@ -2456,7 +2456,7 @@ static int update_submodule(struct update_data *update_data)
 
 static int update_submodules(struct update_data *update_data)
 {
-	int i, res = 0;
+	int i, ret = 0;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
 
 	suc.update_data = update_data;
@@ -2474,7 +2474,7 @@ static int update_submodules(struct update_data *update_data)
 	 * - the listener can avoid doing any work if fetching failed.
 	 */
 	if (suc.quickstop) {
-		res = 1;
+		ret = 1;
 		goto cleanup;
 	}
 
@@ -2486,12 +2486,12 @@ static int update_submodules(struct update_data *update_data)
 		update_data->sm_path = ucd.sub->path;
 
 		if (update_submodule(update_data))
-			res = 1;
+			ret = 1;
 	}
 
 cleanup:
 	string_list_clear(&update_data->references, 0);
-	return res;
+	return ret;
 }
 
 static int module_update(int argc, const char **argv, const char *prefix)
-- 
2.37.3.1420.g76f8a3d556c

