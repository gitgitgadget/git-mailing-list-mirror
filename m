Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253E52018D
	for <e@80x24.org>; Thu, 11 May 2017 17:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbdEKRYn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:24:43 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33947 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932418AbdEKRYm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:24:42 -0400
Received: by mail-pg0-f48.google.com with SMTP id u28so17804707pgn.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wzG6J4EMEEBy19GDQpl67ROLdnUjqJ6+6AewtOa7PBY=;
        b=YVJ/rF85B23B8mOX2sIniR4EXUUCQte9GC8vrgpj2RJXK/Ljbc1r6/mjYRkgTQBwvI
         kRtUfSqSgrnXQgs8gAbSslYsZUYHu95fiLZ5EdMGAZnVzALI6HjyOaN1O0bk/zmR44w1
         O+TwQIsvtybm821OHLBlr53fDASJ8o0YHP+Edrjb7EA7T2rofMLmPWW67dHrjG8xDE7N
         jPATlhGTmlbSPkdiCPk7IvLsOnVag87lfM+37IxmngdrK3iufF4ubUne+S2+5pLjL3qW
         /roX8ZC3d8vG085cu4TSVuGrVMQB3v/xXHbjjQao4nE9CUP34OgfcI9FXYASPDZB7gY7
         n+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wzG6J4EMEEBy19GDQpl67ROLdnUjqJ6+6AewtOa7PBY=;
        b=QEBYPxMlHHwLk7lzBJOhjbw/DjEfZmQpQbO6s/vk5zat/AgWOSj2eLsQM7rNAFzhAW
         JHL1CE97pz+1/xXC3V90Hq6qLAcSjFQ/ACIqdt+GUdRtk/PL/aD7RElHIX9wxNXK8TbR
         /1JkmyNqqNbNZPtXR2Q2vUUwseJ+uX9gff8R5YBQeMDBuxJPVyT3P3V2IXDn+gwa8ERC
         4TY/YLvTyzDF9Hl6WqcKx68nhLMgvTZFFLvI1mPnKCRf4L76mtlWlBncBds+fuEEzgHi
         N6YMIEJPIyilJKykupNiq/fnc6qEPKDU6L67wiPnUcePBmnw/W98gD9gOtRJJ/HEMjW5
         t12A==
X-Gm-Message-State: AODbwcA8Jcbx9DVipNhD8ijGW+Y5S1Bdk0PB2z9/ZX0IlLuTs0ugpH3a
        jCMLv7LryiFJSNmR
X-Received: by 10.84.135.129 with SMTP id 1mr264931plj.57.1494523481219;
        Thu, 11 May 2017 10:24:41 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm1394720pfb.24.2017.05.11.10.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 10:24:40 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH] pull: optionally rebase submodules
Date:   Thu, 11 May 2017 10:24:37 -0700
Message-Id: <20170511172437.96878-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach pull to optionally update submodules when '--recurse-submodules'
is provided.  This will teach pull to run 'submodule update --rebase'
when the '--recurse-submodules' and '--rebase' flags are given.

Signed-off-by: Brandon Williams <bmwill@google.com>
---

Pull is already a shortcut for running fetch followed by a merge/rebase, so why
not have it be a shortcut for running 'submodule update --rebase' when the
recurse flag is given!

 builtin/pull.c            | 30 ++++++++++++++-
 t/t5572-pull-submodule.sh | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index dd1a4a94e..d73d654e6 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -77,6 +77,7 @@ static const char * const pull_usage[] = {
 /* Shared options */
 static int opt_verbosity;
 static char *opt_progress;
+static int recurse_submodules;
 
 /* Options passed to git-merge or git-rebase */
 static enum rebase_type opt_rebase = -1;
@@ -532,6 +533,17 @@ static int pull_into_void(const struct object_id *merge_head,
 	return 0;
 }
 
+static int  update_submodules(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	cp.git_cmd = 1;
+
+	argv_array_pushl(&cp.args, "submodule", "update", "--recursive", NULL);
+	argv_array_push(&cp.args, "--rebase");
+
+	return run_command(&cp);
+}
+
 /**
  * Runs git-merge, returning its exit status.
  */
@@ -816,6 +828,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			oidclr(&rebase_fork_point);
 	}
 
+	if (opt_recurse_submodules &&
+	    !strcmp(opt_recurse_submodules, "--recurse-submodules")) {
+		recurse_submodules = 1;
+
+		if (!opt_rebase)
+			die(_("--recurse-submodules is only valid with --rebase"));
+	}
+
 	if (run_fetch(repo, refspecs))
 		return 1;
 
@@ -862,6 +882,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		die(_("Cannot rebase onto multiple branches."));
 
 	if (opt_rebase) {
+		int ret = 0;
 		struct commit_list *list = NULL;
 		struct commit *merge_head, *head;
 
@@ -871,9 +892,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (is_descendant_of(merge_head, list)) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
-			return run_merge();
+			ret = run_merge();
 		}
-		return run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
+		ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
+
+		if (!ret && recurse_submodules)
+			ret = update_submodules();
+
+		return ret;
 	} else {
 		return run_merge();
 	}
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index accfa5cc0..234a22315 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -42,4 +42,101 @@ KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
 test_submodule_switch "git_pull_noff"
 
+test_expect_success 'pull --recurse-submodule setup' '
+	git init child &&
+	(
+		cd child &&
+		echo "bar" >file &&
+		git add file &&
+		git commit -m "initial commit"
+	) &&
+	git init parent &&
+	(
+		cd parent &&
+		echo "foo" >file &&
+		git add file &&
+		git commit -m "Initial commit" &&
+		git submodule add ../child sub &&
+		git commit -m "add submodule"
+	) &&
+	git clone --recurse-submodule parent super &&
+	git -C super/sub checkout master
+'
+
+test_expect_success 'pull recursive fails without --rebase' '
+	test_must_fail git -C super pull --recurse-submodules 2>actual &&
+	test_i18ngrep "recurse-submodules is only valid with --rebase" actual
+'
+
+test_expect_success 'pull basic recurse' '
+	(
+		cd child &&
+		echo "foobar" >>file &&
+		git add file &&
+		git commit -m "update file"
+	) &&
+	(
+		cd parent &&
+		git -C sub pull &&
+		git add sub &&
+		git commit -m "update submodule"
+	) &&
+
+	git -C parent rev-parse master >expect_super &&
+	git -C child rev-parse master >expect_sub &&
+
+	git -C super pull --rebase --recurse-submodules &&
+	git -C super rev-parse master >actual_super &&
+	git -C super/sub rev-parse master >actual_sub &&
+	test_cmp expect_super actual_super &&
+	test_cmp expect_sub actual_sub
+'
+
+test_expect_success 'pull basic rebase recurse' '
+	(
+		cd child &&
+		echo "a" >file &&
+		git add file &&
+		git commit -m "update file"
+	) &&
+	(
+		cd parent &&
+		git -C sub pull &&
+		git add sub &&
+		git commit -m "update submodule"
+	) &&
+	(
+		cd super/sub &&
+		echo "b" >file2 &&
+		git add file2 &&
+		git commit -m "add file2"
+	) &&
+
+	git -C parent rev-parse master >expect_super &&
+	git -C child rev-parse master >expect_sub &&
+
+	git -C super pull --rebase --recurse-submodules &&
+	git -C super rev-parse master >actual_super &&
+	git -C super/sub rev-parse master^ >actual_sub &&
+	test_cmp expect_super actual_super &&
+	test_cmp expect_sub actual_sub &&
+
+	echo "a" >expect &&
+	test_cmp expect super/sub/file &&
+	echo "b" >expect &&
+	test_cmp expect super/sub/file2
+'
+
+test_expect_success 'pull rebase recursing fails with conflicts' '
+	git -C super/sub reset --hard HEAD^^ &&
+	git -C super reset --hard HEAD^ &&
+	(
+		cd super/sub &&
+		echo "b" >file &&
+		git add file &&
+		git commit -m "update file"
+	) &&
+	test_must_fail git -C super pull --rebase --recurse-submodules
+'
+
 test_done
-- 
2.13.0.rc2.291.g57267f2277-goog

