Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8279C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 01:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiITBCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 21:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiITBCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 21:02:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C814A805
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:02:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n12so1759474wrx.9
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=iFmQqGQKNVF0bzcNTmPd8rJJFzdOjMfd6c8ZbXB5L7U=;
        b=BYogqDrAklpnLdRdpFpzfzUf6V0lisUr7jDS2bn6d9X+OgZmOVwNahoFxFngQwAhmu
         X4LuTT6fU8nnF9oyMzcKx7hvRyyiTkH3kCJghQgUdTQ6aXS6lJUEWsQP5hCzEwu8lYIY
         eg1rM8YQ2+Vf/Ham3zgkKyreCg7FzN+VMOj/8cKbuDOI7fHwfZVF0jHNFW/hdZ9cHGFO
         E0r4F5NY12AMmkU11ceqcllBsqNqJC8M4lsLdPts5KmpdUm46lQJc2/hAhOkQM3hvqa4
         rv4CEvOqKnQVz8ska1I3P4TXfsy/OoNAJJrnIRcHYp/xdaz/BeGqXkZBStUQWGe4t/Yd
         NpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=iFmQqGQKNVF0bzcNTmPd8rJJFzdOjMfd6c8ZbXB5L7U=;
        b=Lwh3v6NGH4WVEPZpQjlhe/dmxv+xrbsWFglmMifFHK63ezrBvGNNTA3XWMLMPlyb2m
         /J2FwpkUsOOBBcLfodQssY/JJSBWmUqMV+PDKCSlXBMm/DMAPglx94i1aAvcUHmAiS65
         BO9tSG63oTJYfrxwjK9zQCh2zBX5nJy8nafZjBL/CdfDXO9IvMN8tHEEFQIeXEMCjkwA
         tvp++H3KNWlK3J63r0VYZM1blGBCDRg/ZS7Ev2t4bbhiWft3gGW2mTcKxI/3Vbfd0GrO
         M/jx9vz4Z4TMP9fhQ+NKsn0X0Z4xZWL8MZgcIcPs/FvoMo8F/5zlA5fZgsPl/vd6Zh8f
         mm8A==
X-Gm-Message-State: ACrzQf0CnH/JR4UB3+eveD8oyYEQvCD1YugWFacjot9mxgAxUFS5zkLn
        1gho7LjtJzCMFVLEV5lI0DdyceFxnyY=
X-Google-Smtp-Source: AMsMyM57GCU0lQ3mpPvfkDwAyJATKtn4jrDxyO1yCwsBvSkb9x/jgjXyssZUJnE/RYKsQgtPu/04Zw==
X-Received: by 2002:a5d:5988:0:b0:22a:f8cc:386a with SMTP id n8-20020a5d5988000000b0022af8cc386amr5810246wri.365.1663635733415;
        Mon, 19 Sep 2022 18:02:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d4e4d000000b0022ae4f8395dsm10388210wrt.96.2022.09.19.18.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 18:02:12 -0700 (PDT)
Message-Id: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 01:02:11 +0000
Subject: [PATCH] maintenance: make unregister idempotent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'git maintenance unregister' subcommand has a step that removes the
current repository from the multi-valued maitenance.repo config key.
This fails if the repository is not listed in that key. This makes
running 'git maintenance unregister' twice result in a failure in the
second instance.

Make this task idempotent, since the end result is the same in both
cases: maintenance will no longer run on this repository.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    maintenance: make unregister idempotent
    
    I noticed this while we were updating the microsoft/git fork to include
    v2.38.0-rc0. I don't think 'git maintenance unregister' was idempotent
    before, but instead some change in 'scalar unregister' led to it relying
    on the return code of 'git maintenance unregister'. Our functional tests
    expect 'scalar unregister' to be idempotent, and I think that's a good
    pattern for 'git maintenance unregister', so I'm fixing it at that
    layer.
    
    Despite finding this during the 2.38.0-rc0 integration, this isn't
    critical to the release.
    
    Perhaps an argument could be made that "failure means it wasn't
    registered before", but I think that isn't terribly helpful.
    
    Our functional tests are running the unregister subcommand to disable
    maintenance in order to run tests on the object store (such as running
    maintenance commands in the foreground and checking the object store
    afterwards). This is a form of automation using 'unregister' as a check
    that maintenance will not run at the same time, and it doesn't care if
    maintenance was already disabled. I can imagine other scripting
    scenarios wanting that kind of guarantee.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1358%2Fderrickstolee%2Fmaintenance-unregister-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1358/derrickstolee/maintenance-unregister-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1358

 builtin/gc.c           | 24 +++++++++++++++++++-----
 t/t7900-maintenance.sh |  5 ++++-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 0accc024067..787e9c702b2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1528,9 +1528,13 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 	struct option options[] = {
 		OPT_END(),
 	};
-	int rc;
+	const char *key = "maintenance.repo";
+	int rc = 0;
 	struct child_process config_unset = CHILD_PROCESS_INIT;
 	char *maintpath = get_maintpath();
+	int found = 0;
+	struct string_list_item *item;
+	const struct string_list *list = git_config_get_value_multi(key);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_maintenance_unregister_usage, 0);
@@ -1538,11 +1542,21 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	config_unset.git_cmd = 1;
-	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
-		     "--fixed-value", "maintenance.repo", maintpath, NULL);
+	for_each_string_list_item(item, list) {
+		if (!strcmp(maintpath, item->string)) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (found) {
+		config_unset.git_cmd = 1;
+		strvec_pushl(&config_unset.args, "config", "--global", "--unset",
+			     "--fixed-value", key, maintpath, NULL);
+
+		rc = run_command(&config_unset);
+	}
 
-	rc = run_command(&config_unset);
 	free(maintpath);
 	return rc;
 }
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2724a44fe3e..3747e4a14f8 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -493,7 +493,10 @@ test_expect_success 'register and unregister' '
 
 	git maintenance unregister &&
 	git config --global --get-all maintenance.repo >actual &&
-	test_cmp before actual
+	test_cmp before actual &&
+
+	# Expect unregister to be idempotent.
+	git maintenance unregister
 '
 
 test_expect_success !MINGW 'register and unregister with regex metacharacters' '

base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
-- 
gitgitgadget
