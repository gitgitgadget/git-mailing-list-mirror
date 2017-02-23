Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85172022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbdBWXHC (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:07:02 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33359 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdBWXHB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:07:01 -0500
Received: by mail-pg0-f46.google.com with SMTP id z128so2353228pgb.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EFqeP6CvyLrBFzaUcyuol/EqtNsLkEYGxz7hYQCK2Ks=;
        b=XFZabdQWwDdOKV3ouc2NTlkUbvRMbaPgJu2EJt+x8UT8+DbfgQ8vprqYFcCZ8EKBA3
         OHGNMCal2VViM6CwY+0daix2sU3t2DKVA3Qbk1F3XNha3UtPf30A295BjKXYDVeQ3OPW
         TGouZvSwSY8Hmvb/7uMMIIFjJR640ziZoCkV5y2B5m71kR6tKG2zl0WerTrdcDCmaoMB
         20pgzpOUitXUpBIp/LsoTltfB4njp2ouCYzzrHwgFplu5he1KztXTwx6UgSZYv6cHKuu
         FwRME0XL3uOFfzFI/CvyeadZewfXalavNRdZWvn7kJQa2nODJfb2AjPbfNt1RFZ7fJdR
         LwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EFqeP6CvyLrBFzaUcyuol/EqtNsLkEYGxz7hYQCK2Ks=;
        b=QIxeeXPuDgkTpJw6rhWd6zFbL+Vcb71RFtnUaCWa5nPX0rkaZwPvBcohITcx+9zTLa
         +T5htkxoGSc2sOMrq+um4XDzFlx7tyvxg8/ViXMJF9xAykYRBWyWTGhQVFLamh2FpGS/
         FLL08TLwrrqiuKh0gc/ivqiYFf4z4yalzQqPkNOsDN2q5Sn9ycaZab0GGhcUUMjwFH6O
         PiXoYEQAi2JBQu2f/Mn07JaXVsGeAkVhye0UfXi7O6DV79bc++ND+Ygp6gvHQGi4qv4M
         FxSKWE4yjyAB3UI9P0/Ctf9+V1iKtSXF596s64C5qn5rmPtltTPFruLcHSxxOLlj6oBP
         qPFg==
X-Gm-Message-State: AMke39nNbuUQ34+K3QVXp3zxuZnf4KMl2IH1GbtMhn8XQlIwsMdFH20oZlpdq/Kxpd07xHNo
X-Received: by 10.99.39.71 with SMTP id n68mr50411628pgn.85.1487890684169;
        Thu, 23 Feb 2017 14:58:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id w28sm172115pge.27.2017.02.23.14.58.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:58:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
Subject: [PATCH 10/15] update submodules: add submodule_move_head
Date:   Thu, 23 Feb 2017 14:57:30 -0800
Message-Id: <20170223225735.10994-11-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170223225735.10994-1-sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
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
index 0b2596e88a..a2cf8c9376 100644
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
+void submodule_reset_index(const char *path)
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
2.12.0.rc1.16.ge4278d41a0.dirty

