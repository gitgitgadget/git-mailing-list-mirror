Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31098202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 19:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753825AbdCHTU6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 14:20:58 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34994 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753254AbdCHTU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 14:20:56 -0500
Received: by mail-pf0-f182.google.com with SMTP id j5so18417077pfb.2
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 11:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kWQtiwTKFCNfq9HJvJkh2E3iSl4ep2TLKEv3lRxjbw4=;
        b=rvbUSPEi/yz01pbZbVCmcOSXUfOxDZY5QFIQZZjlbL1ZuOzTlgvlAtEgGfTMKhGg6M
         PAMvd+nRkGINNTTBrP52GrcjxIM1TWbYGHVwsB+5GNEIkX1kAaWd32EX1AMuNN72jR1K
         tzOWH7j+5+n0e1UKgfuqo2dAUpKXBcMRGV1trJFjKV1brkfHv5bhIIO3+j8IWPcXY+fs
         MEaVYcXHsMd06yMS4kKMw8OPCv9r4914Zqm8MeqVhQyzrX7iOvThBvP/IAeN8YH8AUPH
         0ImjwBPS71pt2AVflCeSgFh4eQL7x5xa57HlgEHn7kdEtkS+zAGyl/JTACipdlejTmd3
         CWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kWQtiwTKFCNfq9HJvJkh2E3iSl4ep2TLKEv3lRxjbw4=;
        b=f2YXXs279ai8PJtHUFEdvYalWD3mmgN6Uj1CRO5xehY6Lm6yhsnmnbuQQ2Xdct3ccQ
         YMQuMcpkYaQNEuhZwr/Fl3vvAEFAxZwqQgT+B7DscazWCXhvdDmfc4cqrVlqqWwiuUfQ
         1kdktuTHGeRSEG0e3clXGDG9o457yoKMjcaj8rz8gmv0LuDpZH9rk6CKTWLC/E1f5beC
         29xAuztpRhrcWUym9Whe/trHCsZLR+WQDVEyA48ElEhRLxoC10Sl8yEzJWKT5spoUxNu
         aXFnOzezJUIrIi2hfh5/7Hc1dRdNuGgtPKgqJglDlfNKCdcNU3iN/ZgiCY8PW0lpERPI
         /1VQ==
X-Gm-Message-State: AMke39lPmwhkXoI6kXVu7V4PPAJ/3lsS6VvFMB74mHG+TkCyV7bmZZhub5ZIsJwItRFl/+xm
X-Received: by 10.98.87.27 with SMTP id l27mr8974828pfb.169.1489000840469;
        Wed, 08 Mar 2017 11:20:40 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:35da:deef:74a3:8cee])
        by smtp.gmail.com with ESMTPSA id g78sm7744763pfe.5.2017.03.08.11.20.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 11:20:39 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     szeder.dev@gmail.com, email@benjaminfuchs.de, git@vger.kernel.org,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCHv3] rev-parse: add --show-superproject-working-tree
Date:   Wed,  8 Mar 2017 11:20:37 -0800
Message-Id: <20170308192037.21847-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.190.g6e60aba09d.dirty
In-Reply-To: <xmqq60jk488v.fsf@gitster.mtv.corp.google.com>
References: <xmqq60jk488v.fsf@gitster.mtv.corp.google.com>
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
> Looks more or less right but invoke "ls-files -z" and reading the \0
> delimited output would be easier;

done

> otherwise you would have to worry
> about c-unquoting the pathname when the submodule is bound at a path
> with funny character (like a double-quote) in it.
 
paths from "rev-parse" (like "--git-dir", "--show-toplevel", etc.) already
are excempt from quoting rules, apparently.

  $ git rev-parse --show-toplevel
/usr/local/google/home/sbeller/OSS/git/t/trash directory.t1500-rev-parse


interdiff to v2:
  #diff --git a/submodule.c b/submodule.c
  #index 06473d3646..bb405653fd 100644
  #--- a/submodule.c
  #+++ b/submodule.c
  #@@ -1543,7 +1543,8 @@ const char *get_superproject_working_tree(void)
  # 	argv_array_pop(&cp.env_array);
  # 
  # 	argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
  #-			"ls-files", "--stage", "--full-name", "--", subpath, NULL);
  #+			"ls-files", "-z", "--stage", "--full-name", "--",
  #+			subpath, NULL);
  # 	strbuf_reset(&sb);
  # 
  # 	cp.no_stdin = 1;
  #@@ -1564,13 +1565,12 @@ const char *get_superproject_working_tree(void)
  # 
  # 		/*
  # 		 * There is a superproject having this repo as a submodule.
  #-		 * The format is <mode> SP <hash> SP <stage> TAB <full name> LF,
  #-		 * First remove LF, then skip up to \t.
  #+		 * The format is <mode> SP <hash> SP <stage> TAB <full name> \0,
  #+		 * We're only interested in the name after the tab.
  # 		 */
  #-		strbuf_rtrim(&sb);
  # 		super_sub = strchr(sb.buf, '\t') + 1;
  #+		super_sub_len = sb.buf + sb.len - super_sub - 1;
  # 
  #-		super_sub_len = sb.buf + sb.len - super_sub;
  # 		if (super_sub_len > cwd_len ||
  # 		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
  # 			die (_("BUG: returned path string doesn't match cwd?"));
  #@@ -1579,7 +1579,6 @@ const char *get_superproject_working_tree(void)
  # 		super_wt[cwd_len - super_sub_len] = '\0';
  # 
  # 		ret = real_path(super_wt);
  #-
  # 		free(super_wt);
  # 	}
  # 	strbuf_release(&sb);
  
  Thanks,
  Stefan
  

 Documentation/git-rev-parse.txt |  5 +++
 builtin/rev-parse.c             |  7 ++++
 submodule.c                     | 82 +++++++++++++++++++++++++++++++++++++++++
 submodule.h                     |  8 ++++
 t/t1500-rev-parse.sh            | 14 +++++++
 5 files changed, 116 insertions(+)

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
index 3b98766a6b..bb405653fd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1514,3 +1514,85 @@ void absorb_git_dir_into_superproject(const char *prefix,
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
+			"ls-files", "-z", "--stage", "--full-name", "--",
+			subpath, NULL);
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
+		 * The format is <mode> SP <hash> SP <stage> TAB <full name> \0,
+		 * We're only interested in the name after the tab.
+		 */
+		super_sub = strchr(sb.buf, '\t') + 1;
+		super_sub_len = sb.buf + sb.len - super_sub - 1;
+
+		if (super_sub_len > cwd_len ||
+		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
+			die (_("BUG: returned path string doesn't match cwd?"));
+
+		super_wt = xstrdup(cwd);
+		super_wt[cwd_len - super_sub_len] = '\0';
+
+		ret = real_path(super_wt);
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
2.12.0.190.g6e60aba09d.dirty

