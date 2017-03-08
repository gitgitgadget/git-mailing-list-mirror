Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804C01FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 01:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756621AbdCHBFj (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 20:05:39 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:32938 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756438AbdCHBFi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 20:05:38 -0500
Received: by mail-pg0-f41.google.com with SMTP id 25so6710375pgy.0
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 17:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/QNZScfpUlyUlv8Y35Rwcqw/pcFpoLZLahqCD3vdLoI=;
        b=vuK3aJLHaXrM43+IthEPR9BCAk9td3ofMZ1KdS0X0WqtmHaTdVYTaLeRWKLsUwF01r
         cbZehjOYFIO8C4ineJgiG6mxVfellSKknW9+Z4E7HZuDQn4uG/eZdJVG7veMo9Xv21jL
         WJ8JG0SyJXn2ukhltPsL+xMXWeYXsXJ/YVx4yityPwW4UDPH8Nx+S7+frmGYz6iw7M+n
         QV8JBEGymz6KWujqKHBWiRlub39zuCz9flqhtd/gP2blFl8/8vZNAdhZ+bVipvg3Jwek
         n4l3K4pJpspudm3YTH0XCwhcvsMl5ofPb8nqgLiE+WOjs04We/V5Rnvj8Bv/b7Q/lnxp
         tiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/QNZScfpUlyUlv8Y35Rwcqw/pcFpoLZLahqCD3vdLoI=;
        b=CQOxEc6XQBETYbqrFEkBwlPoaUuPr46fXWJspswGTQcovrCcgIUex4cNyy2oCiaiXx
         wPANr5XdoStx6FC+dYOa/rBsA1AcdwNvZVhOT9m8vzOsRJk3G5foZUN1jF8j5X3jleNz
         f1ROVmHuPme9CquuhgeQjjrpKxOhgIkr8LegsdLrO1QHEIsiu8OvTRgwifDtz2Tp+WFN
         Bf/ot9VqOH0hl5nULajCh8t+NM148+ZJZRE1Lt3Xq4f5T/R9XDr8b4GU+qXJpBXUTjYr
         gTrdhlLZ9+aYDIEA/Sk/KVTBqOkBnG5kVor2x+c5B9I/JvHIUJN33Dxgj7K8BebazgVp
         y7/Q==
X-Gm-Message-State: AMke39kqr62zcw9D7z278fldMz1iV2LDQbpXpV5M5LI9MnXQfsCFCcT+y//QW+ymqtxB9Nzu
X-Received: by 10.99.7.206 with SMTP id 197mr3625431pgh.95.1488934585999;
        Tue, 07 Mar 2017 16:56:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:5c89:fa68:bdb9:83f0])
        by smtp.gmail.com with ESMTPSA id 194sm1916149pfx.134.2017.03.07.16.56.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Mar 2017 16:56:25 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     szeder.dev@gmail.com, email@benjaminfuchs.de, git@vger.kernel.org,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] rev-parse: add --show-superproject-working-tree
Date:   Tue,  7 Mar 2017 16:56:15 -0800
Message-Id: <20170308005615.20321-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.190.g6a12a61b77.dirty
In-Reply-To: <xmqq7f4066t9.fsf@gitster.mtv.corp.google.com>
References: <xmqq7f4066t9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some situations it is useful to know if the given repository
is a submodule of another repository.

Add the flag --show-superproject-working-tree to git-rev-parse
to make it easy to find out if there is a superproject.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

* not RFC anymore, but for real this time; including a test and docs :)

* Following Junios advice: there is only one function
  (superproject_exists was dropped) using ls-files.
  (the test actually tests for a staged submodule) 
  
Thanks,
Stefan


 Documentation/git-rev-parse.txt |  5 +++
 builtin/rev-parse.c             |  7 ++++
 submodule.c                     | 83 +++++++++++++++++++++++++++++++++++++++++
 submodule.h                     |  8 ++++
 t/t1500-rev-parse.sh            | 14 +++++++
 5 files changed, 117 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 91c02b8c85..b841bad7c7 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -261,6 +261,11 @@ print a message to stderr and exit with nonzero status.
 --show-toplevel::
 	Show the absolute path of the top-level directory.
 
+--show-superproject-working-tree
+	Show the absolute path of the top-level directory of
+	the superproject. A superproject is a repository that records
+	this repository as a submodule.
+
 --shared-index-path::
 	Show the path to the shared index file in split index mode, or
 	empty if not in split-index mode.
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index e08677e559..2549643267 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -12,6 +12,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "split-index.h"
+#include "submodule.h"
 
 #define DO_REVS		1
 #define DO_NOREV	2
@@ -779,6 +780,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					puts(work_tree);
 				continue;
 			}
+			if (!strcmp(arg, "--show-superproject-working-tree")) {
+				const char *superproject = get_superproject_working_tree();
+				if (superproject)
+					puts(superproject);
+				continue;
+			}
 			if (!strcmp(arg, "--show-prefix")) {
 				if (prefix)
 					puts(prefix);
diff --git a/submodule.c b/submodule.c
index 3b98766a6b..06473d3646 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1514,3 +1514,86 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		strbuf_release(&sb);
 	}
 }
+
+const char *get_superproject_working_tree(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	const char *one_up = real_path_if_valid("../");
+	const char *cwd = xgetcwd();
+	const char *ret = NULL;
+	const char *subpath;
+	int code;
+	ssize_t len;
+
+	if (!is_inside_work_tree())
+		/*
+		 * FIXME:
+		 * We might have a superproject, but it is harder
+		 * to determine.
+		 */
+		return NULL;
+
+	if (!one_up)
+		return NULL;
+
+	subpath = relative_path(cwd, one_up, &sb);
+
+	prepare_submodule_repo_env(&cp.env_array);
+	argv_array_pop(&cp.env_array);
+
+	argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
+			"ls-files", "--stage", "--full-name", "--", subpath, NULL);
+	strbuf_reset(&sb);
+
+	cp.no_stdin = 1;
+	cp.no_stderr = 1;
+	cp.out = -1;
+	cp.git_cmd = 1;
+
+	if (start_command(&cp))
+		die(_("could not start ls-files in .."));
+
+	len = strbuf_read(&sb, cp.out, PATH_MAX);
+	close(cp.out);
+
+	if (starts_with(sb.buf, "160000")) {
+		int super_sub_len;
+		int cwd_len = strlen(cwd);
+		char *super_sub, *super_wt;
+
+		/*
+		 * There is a superproject having this repo as a submodule.
+		 * The format is <mode> SP <hash> SP <stage> TAB <full name> LF,
+		 * First remove LF, then skip up to \t.
+		 */
+		strbuf_rtrim(&sb);
+		super_sub = strchr(sb.buf, '\t') + 1;
+
+		super_sub_len = sb.buf + sb.len - super_sub;
+		if (super_sub_len > cwd_len ||
+		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
+			die (_("BUG: returned path string doesn't match cwd?"));
+
+		super_wt = xstrdup(cwd);
+		super_wt[cwd_len - super_sub_len] = '\0';
+
+		ret = real_path(super_wt);
+
+		free(super_wt);
+	}
+	strbuf_release(&sb);
+
+	code = finish_command(&cp);
+
+	if (code == 128)
+		/* '../' is not a git repository */
+		return NULL;
+	if (code == 0 && len == 0)
+		/* There is an unrelated git repository at '../' */
+		return NULL;
+	if (code)
+		die(_("ls-tree returned unexpected return code %d"), code);
+
+	return ret;
+}
diff --git a/submodule.h b/submodule.h
index 05ab674f06..c8a0c9cb29 100644
--- a/submodule.h
+++ b/submodule.h
@@ -93,4 +93,12 @@ extern void prepare_submodule_repo_env(struct argv_array *out);
 extern void absorb_git_dir_into_superproject(const char *prefix,
 					     const char *path,
 					     unsigned flags);
+
+/*
+ * Return the absolute path of the working tree of the superproject, which this
+ * project is a submodule of. If this repository is not a submodule of
+ * another repository, return NULL.
+ */
+extern const char *get_superproject_working_tree(void);
+
 #endif
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 9ed8b8ccba..03d3c7f6d6 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -116,4 +116,18 @@ test_expect_success 'git-path inside sub-dir' '
 	test_cmp expect actual
 '
 
+test_expect_success 'showing the superproject correctly' '
+	git rev-parse --show-superproject-working-tree >out &&
+	test_must_be_empty out &&
+
+	test_create_repo super &&
+	test_commit -C super test_commit &&
+	test_create_repo sub &&
+	test_commit -C sub test_commit &&
+	git -C super submodule add ../sub dir/sub &&
+	echo $(pwd)/super >expect  &&
+	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
+	test_cmp expect out
+'
+
 test_done
-- 
2.12.0.190.g6a12a61b77.dirty

