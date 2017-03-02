Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18872023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753765AbdCBAzJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:55:09 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34036 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbdCBAzI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:55:08 -0500
Received: by mail-pf0-f181.google.com with SMTP id b5so9002550pfa.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FtDn0V7Sfsv5oCR0qQZPCiqF41A3KnWc9E8IwKGlx9Q=;
        b=LRS6UioW/yYYPV14xxkS5Jio0nl5k96eIjMSBXtlnJ/ETAqjVepix60KxcAZUUupvn
         9wy0uXt93EYHDR0x01tjeMzly4dlhLHSvZrX6tnzZv8JaIey7RhmNZLej6VOF+VGNPcO
         6FWNINbMmf84pvepjfagqXvG76DBbj2UnTTMJIV8gQQ2dBwIKUlHwoD2jGdHFS+dnfzS
         ouZ363WkATnC/8fN7dLOoxuRpgD4EeYMZ8VLNQmKwvhsbxlm4miNF/kor2I5fiXnidt+
         BTFLoRcC5CcJcJtur8mXLyZm4dYfijIJR4QZHFI9LuVwSLrFIkDe7VRUx8ZdSsvCWRzD
         sdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FtDn0V7Sfsv5oCR0qQZPCiqF41A3KnWc9E8IwKGlx9Q=;
        b=TK2NRbatFXZZniGDtBffM1pVpwMUQWHGP1i4Pe0y8kmlRlkulSahRAE/kqzl9BliRL
         /CbfKSJt2byNvCGjgQFRDeCOv2e6J09mRVWH1hbx7PmFEJXm5/SzAJTMpNXjmSwedJs8
         JtvrDjWJ7RfgfHM+v51X3raVIlkicmSdDC2li/ooKmLqiwG9c6LdsGOUxWPWFyb/OdeJ
         a6W4Rf20kgifsYqkMJDWcpG4mIDMtv86PRhy5q3WLTkaGgp/6GCSy5/PJ2yw6xM+E8gn
         id4YiAP00+9fdvyAIVSyFgrRegESSn+71HCuoEgWDPBpmKDulYzMeFBQ1bbmvEcYJN8j
         zAgw==
X-Gm-Message-State: AMke39nidNZuV6JBQEg5UuMDNBEQA+cQ1aP+kbTkNbCvdX3sAO3cZEvAZ3fm1Zr9l9qn/fOi
X-Received: by 10.99.245.21 with SMTP id w21mr12114244pgh.117.1488415699184;
        Wed, 01 Mar 2017 16:48:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id y187sm12725497pfy.123.2017.03.01.16.48.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:18 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 12/18] update submodules: add submodule_move_head
Date:   Wed,  1 Mar 2017 16:47:53 -0800
Message-Id: <20170302004759.27852-13-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later patches we introduce the options and flag for commands
that modify the working directory, e.g. git-checkout.

This piece of code will be used universally for
all these working tree modifications as it
* supports dry run to answer the question:
  "Is it safe to change the submodule to this new state?"
  e.g. is it overwriting untracked files or are there local
  changes that would be overwritten?
* supports a force flag that can be used for resetting
  the tree.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h |   7 ++++
 2 files changed, 142 insertions(+)

diff --git a/submodule.c b/submodule.c
index 0b2596e88a..bc5fecf8c5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1239,6 +1239,141 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	return ret;
 }
 
+static int submodule_has_dirty_index(const struct submodule *sub)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "diff-index", "--quiet", \
+					"--cached", "HEAD", NULL);
+	cp.no_stdin = 1;
+	cp.no_stdout = 1;
+	cp.dir = sub->path;
+	if (start_command(&cp))
+		die("could not recurse into submodule '%s'", sub->path);
+
+	return finish_command(&cp);
+}
+
+static void submodule_reset_index(const char *path)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+
+	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
+	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
+
+	argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
+
+	if (run_command(&cp))
+		die("could not reset submodule index");
+}
+
+/**
+ * Moves a submodule at a given path from a given head to another new head.
+ * For edge cases (a submodule coming into existence or removing a submodule)
+ * pass NULL for old or new respectively.
+ */
+int submodule_move_head(const char *path,
+			 const char *old,
+			 const char *new,
+			 unsigned flags)
+{
+	int ret = 0;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const struct submodule *sub;
+
+	sub = submodule_from_path(null_sha1, path);
+
+	if (!sub)
+		die("BUG: could not get submodule information for '%s'", path);
+
+	if (old && !(flags & SUBMODULE_MOVE_HEAD_FORCE)) {
+		/* Check if the submodule has a dirty index. */
+		if (submodule_has_dirty_index(sub))
+			return error(_("submodule '%s' has dirty index"), path);
+	}
+
+	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
+		if (old) {
+			if (!submodule_uses_gitfile(path))
+				absorb_git_dir_into_superproject("", path,
+					ABSORB_GITDIR_RECURSE_SUBMODULES);
+		} else {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addf(&sb, "%s/modules/%s",
+				    get_git_common_dir(), sub->name);
+			connect_work_tree_and_git_dir(path, sb.buf);
+			strbuf_release(&sb);
+
+			/* make sure the index is clean as well */
+			submodule_reset_index(path);
+		}
+	}
+
+	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+
+	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
+	argv_array_pushl(&cp.args, "read-tree", NULL);
+
+	if (flags & SUBMODULE_MOVE_HEAD_DRY_RUN)
+		argv_array_push(&cp.args, "-n");
+	else
+		argv_array_push(&cp.args, "-u");
+
+	if (flags & SUBMODULE_MOVE_HEAD_FORCE)
+		argv_array_push(&cp.args, "--reset");
+	else
+		argv_array_push(&cp.args, "-m");
+
+	argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
+	argv_array_push(&cp.args, new ? new : EMPTY_TREE_SHA1_HEX);
+
+	if (run_command(&cp)) {
+		ret = -1;
+		goto out;
+	}
+
+	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
+		if (new) {
+			struct child_process cp1 = CHILD_PROCESS_INIT;
+			/* also set the HEAD accordingly */
+			cp1.git_cmd = 1;
+			cp1.no_stdin = 1;
+			cp1.dir = path;
+
+			argv_array_pushl(&cp1.args, "update-ref", "HEAD",
+					 new ? new : EMPTY_TREE_SHA1_HEX, NULL);
+
+			if (run_command(&cp1)) {
+				ret = -1;
+				goto out;
+			}
+		} else {
+			struct strbuf sb = STRBUF_INIT;
+
+			strbuf_addf(&sb, "%s/.git", path);
+			unlink_or_warn(sb.buf);
+			strbuf_release(&sb);
+
+			if (is_empty_dir(path))
+				rmdir_or_warn(path);
+		}
+	}
+out:
+	return ret;
+}
+
 static int find_first_merges(struct object_array *result, const char *path,
 		struct commit *a, struct commit *b)
 {
diff --git a/submodule.h b/submodule.h
index 6f3fe85c7c..4cdf6445f7 100644
--- a/submodule.h
+++ b/submodule.h
@@ -96,6 +96,13 @@ extern int push_unpushed_submodules(struct sha1_array *commits,
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 extern int parallel_submodules(void);
 
+#define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
+#define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
+extern int submodule_move_head(const char *path,
+			       const char *old,
+			       const char *new,
+			       unsigned flags);
+
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific envirionment variables, but
-- 
2.12.0.rc1.52.ge239d7e709.dirty

