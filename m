Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6C11F597
	for <e@80x24.org>; Tue, 17 Jul 2018 06:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeGQHZX (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 03:25:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35817 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeGQHZX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 03:25:23 -0400
Received: by mail-pf0-f193.google.com with SMTP id q7-v6so30978pff.2
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 23:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J52GZ9oFsbuH6sooHSbdTeZuvxYkeUlowN4zUqlab9w=;
        b=QHOVl7hcyc+Md20tIpjZDr1Sih7fVMck8wfeUmybQVMMVkqBa/BN0b7WbgKDvIMHaD
         o8KxwHBtoYMJGv9024Hy2k+48y0TbwAKryOBfyP2LgjZPm3cSs+7057j7R920V8HFGsZ
         OCE/6Y0HGTKcnOTvYzHb3Zs0SY7fJHHBYt0CxGO6kI0tkRZ1w+VoaSkHe9IuQd9mhZnp
         a+KKXtl5Cw0T3JF7LZm3CUnho/LsFBbH4Jv1fzRB4dnLLEHsLjgxKIUvrvMMrXgZvA46
         RbI+cUMf9g1YTYhAnOwDDHu2qUn0CGS5AIMDMCibyi3muF9iLyt+Gfct+18OKmS8PUy+
         3F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J52GZ9oFsbuH6sooHSbdTeZuvxYkeUlowN4zUqlab9w=;
        b=KcxEU3phe/tuonIIOz6v/Ssc94sdonarlp2OAq9G7/Gt785ZOamVluf/LGRTR+PFo2
         /vUAc+XOJycE1Y/1bmI9g7ryvovcNVsdTg3ZsUBHgdUaaj+6c96N3nv13Bjl2GJXbehL
         AB/zsCqM81VQwoack0tB0UUoIIFZYCe9LdkxW92dA+OghbaierYzo/0xunL3tVTzVPjL
         92a2cMokwDnMLZ29HFOCJfPXDPsWztaKZ/ByK1QA9p51upjutggBF/qYypc+aGd5Gm27
         0GkVQfk5KzAnz9sYoZH7Hiewqk/5Eg4TIBe3xZxdGL03PxeVk3INNV7khI4zeqknjUrw
         gDnw==
X-Gm-Message-State: AOUpUlHzTyzS9boAqqFdEOzheXRVoIFr0a9+o6Oi3NuHdJ3Q3aDwr3rC
        IaUEa67Jk+JSKrA2H2eYYR8=
X-Google-Smtp-Source: AAOMgpehom+LiL4KNsFnYRmqrRmagsbnl/u+6ZTtzvriuReyUdh9INXQeozvrewJZTODxjG+lscUbw==
X-Received: by 2002:a62:6698:: with SMTP id s24-v6mr404894pfj.243.1531810458567;
        Mon, 16 Jul 2018 23:54:18 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id w72-v6sm1371694pfa.26.2018.07.16.23.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 23:54:18 -0700 (PDT)
Date:   Mon, 16 Jul 2018 23:54:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 2/3] gc: exit with status 128 on failure
Message-ID: <20180717065416.GC177907@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180717065151.GA177907@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717065151.GA177907@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A value of -1 returned from cmd_gc gets propagated to exit(),
resulting in an exit status of 255.  Use die instead for a clearer
error message and a controlled exit.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As in
https://public-inbox.org/git/20180716225639.GK11513@aiede.svl.corp.google.com/.
The only change is splitting out patch 1/3.

 builtin/gc.c  | 35 ++++++++++++++---------------------
 t/t6500-gc.sh |  2 +-
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d69fc4c0b0..95c8afd07b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -438,10 +438,9 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	return NULL;
 }
 
-static int report_last_gc_error(void)
+static void report_last_gc_error(void)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret = 0;
 	ssize_t len;
 	struct stat st;
 	char *gc_log_path = git_pathdup("gc.log");
@@ -450,8 +449,7 @@ static int report_last_gc_error(void)
 		if (errno == ENOENT)
 			goto done;
 
-		ret = error_errno(_("cannot stat '%s'"), gc_log_path);
-		goto done;
+		die_errno(_("cannot stat '%s'"), gc_log_path);
 	}
 
 	if (st.st_mtime < gc_log_expire_time)
@@ -459,9 +457,9 @@ static int report_last_gc_error(void)
 
 	len = strbuf_read_file(&sb, gc_log_path, 0);
 	if (len < 0)
-		ret = error_errno(_("cannot read '%s'"), gc_log_path);
+		die_errno(_("cannot read '%s'"), gc_log_path);
 	else if (len > 0)
-		ret = error(_("The last gc run reported the following. "
+		die(_("The last gc run reported the following. "
 			       "Please correct the root cause\n"
 			       "and remove %s.\n"
 			       "Automatic cleanup will not be performed "
@@ -471,20 +469,18 @@ static int report_last_gc_error(void)
 	strbuf_release(&sb);
 done:
 	free(gc_log_path);
-	return ret;
 }
 
-static int gc_before_repack(void)
+static void gc_before_repack(void)
 {
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
-		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
+		die(FAILED_RUN, pack_refs_cmd.argv[0]);
 
 	if (prune_reflogs && run_command_v_opt(reflog.argv, RUN_GIT_CMD))
-		return error(FAILED_RUN, reflog.argv[0]);
+		die(FAILED_RUN, reflog.argv[0]);
 
 	pack_refs = 0;
 	prune_reflogs = 0;
-	return 0;
 }
 
 int cmd_gc(int argc, const char **argv, const char *prefix)
@@ -565,13 +561,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
 		if (detach_auto) {
-			if (report_last_gc_error())
-				return -1;
+			report_last_gc_error(); /* dies on error */
 
 			if (lock_repo_for_gc(force, &pid))
 				return 0;
-			if (gc_before_repack())
-				return -1;
+			gc_before_repack(); /* dies on failure */
 			delete_tempfile(&pidfile);
 
 			/*
@@ -611,12 +605,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		atexit(process_log_file_at_exit);
 	}
 
-	if (gc_before_repack())
-		return -1;
+	gc_before_repack();
 
 	if (!repository_format_precious_objects) {
 		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
-			return error(FAILED_RUN, repack.argv[0]);
+			die(FAILED_RUN, repack.argv[0]);
 
 		if (prune_expire) {
 			argv_array_push(&prune, prune_expire);
@@ -626,18 +619,18 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 				argv_array_push(&prune,
 						"--exclude-promisor-objects");
 			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
-				return error(FAILED_RUN, prune.argv[0]);
+				die(FAILED_RUN, prune.argv[0]);
 		}
 	}
 
 	if (prune_worktrees_expire) {
 		argv_array_push(&prune_worktrees, prune_worktrees_expire);
 		if (run_command_v_opt(prune_worktrees.argv, RUN_GIT_CMD))
-			return error(FAILED_RUN, prune_worktrees.argv[0]);
+			die(FAILED_RUN, prune_worktrees.argv[0]);
 	}
 
 	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
-		return error(FAILED_RUN, rerere.argv[0]);
+		die(FAILED_RUN, rerere.argv[0]);
 
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 818435f04e..c474a94a9f 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -117,7 +117,7 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
 	test_config gc.autodetach true &&
 	echo fleem >.git/gc.log &&
 	test_must_fail git gc --auto 2>err &&
-	test_i18ngrep "^error:" err &&
+	test_i18ngrep "^fatal:" err &&
 	test_config gc.logexpiry 5.days &&
 	test-tool chmtime =-345600 .git/gc.log &&
 	test_must_fail git gc --auto &&
-- 
2.18.0.233.g985f88cf7e

