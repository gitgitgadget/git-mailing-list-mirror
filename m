Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8737EC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiDMQq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbiDMQqj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:46:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9726A03A
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:44:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bg10so5161884ejb.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MboPv96yLeLupVQfj9+xdHuPfQRvs6S+ipiA5kuyODg=;
        b=fqmCQcIvD5cF0DOHlHbmXXvMe7A3nvXNSDzIzHOrhCaFbV0igiQEyv8VILPzHP8Zy0
         OxmN4QaTXoFiro22A98B/sg3kZkBwhQ/c+G4uFtkWZESPmyNK8tYUZQTMPF+oBfHvJ9v
         izGseVVEGtuP1FwHYqNeFzR+7S2ZZW42iHB1mvWyz9UFENyucL/R2gOyoNX4Mt3PXFYW
         AxU3gYv5BrzkHJiCzLmwZ6fKauhZFeNI3C8ZAhC5sdAxlkNv1cRDHM03CDbcpFE2jl+7
         HR29R9HifT/zm4alhCan9SWgwqdeUhUmNq1agvHuh/ngZ4Zs/Dd8s9inDumIACiqtLd9
         UhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MboPv96yLeLupVQfj9+xdHuPfQRvs6S+ipiA5kuyODg=;
        b=HqCkGcj1jFxF+Dxr6r/YUcBC7l9PP9PMtmLfszp3RZSE56FmZ0MtbiHAMtAN9LjlQ3
         5Nb1YcztW+RC+RX/ZNvujNPIek5RCQQJdrYyoUx7bE04ZWPcB5NDZc3eG3cH5tEOAkQA
         nzPLBwzYxlAnS0LN7kW5XxiqfDr14qlqN5Q/YeI0NYNLM4KfarFLQYtNbqX8DIIZPzbh
         BUOf8l18SSmcc8NkaSIiSg8DgNU91Qo8z4FxSD/SARYi5jwU2oi/ecZNdxUW6cXKfMdG
         yKnWTg0xG+wxwvWCjonxwFEkrkJdHE2mpONpILzjhYOAQDq3NfTI1ImEYsmhQTkVptls
         ZZOg==
X-Gm-Message-State: AOAM533rhGZRbhl6PmdTwKPXSZaq/nJl2fOiSQx/4LLVtkvujC3u5gd5
        0CGYVsue7aHm0/fzT8ef63XkCW4Q1mkC2UNL
X-Google-Smtp-Source: ABdhPJz24HFG9hDE+D5+Qab/8EMKMORfrTpVuYzoX9Oryzsy17Kc+ZFCrI4e+LUOnVm0IMgw66D8hQ==
X-Received: by 2002:a17:906:9611:b0:6e8:9b4e:5aaa with SMTP id s17-20020a170906961100b006e89b4e5aaamr12317613ejx.455.1649868239385;
        Wed, 13 Apr 2022 09:43:59 -0700 (PDT)
Received: from linuxerio.localdomain (j109098.upc-j.chello.nl. [24.132.109.98])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402105300b004162d0b4cbbsm1408911edu.93.2022.04.13.09.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:43:58 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [RFC] introducing git replay
Date:   Wed, 13 Apr 2022 18:43:35 +0200
Message-Id: <20220413164336.101390-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let me explain with an easy-to-follow example:

$ git checkout v2.35.0
.
.
.
HEAD is now at 89bece5c8c Git 2.35
$ git commit --amend --no-edit
[detached HEAD c58a5e5621] Git 2.35
 Author: Junio C Hamano <someone@somewhere>
 Date: Mon Jan 24 09:25:25 2022 -0800
 2 files changed, 11 insertions(+), 1 deletion(-)
$ git rebase --rebase-merges --onto HEAD v2.35.0 v2.36.0-rc1
Auto-merging GIT-VERSION-GEN
CONFLICT (content): Merge conflict in GIT-VERSION-GEN
CONFLICT (content): Merge conflict in RelNotes
error: could not apply 4c53a8c20f... Git 2.35.1
hint: Resolve all conflicts manually, mark them as resolved with
hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
hint: You can instead skip this commit: run "git rebase --skip".
hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
Could not apply 4c53a8c20f... Git 2.35.1

If HEAD and v2.35.0 share the same tree, it _should_ be possible
to recreate the commits that make up the range v2.35.0..v2.36.0-rc1
on top of HEAD without requiring any real "rebasing". Just creating
new revisions with the same information except for different parents
(and possibly a committer?).

This is what git replay does. To achieve the same in this example:

$ git checkout v2.35.0
.
.
.
HEAD is now at 89bece5c8c Git 2.35
$ git commit --amend --no-edit
[detached HEAD c682d8a22e] Git 2.35
 Author: Junio C Hamano <someone@somewhere>
 Date: Mon Jan 24 09:25:25 2022 -0800
 2 files changed, 11 insertions(+), 1 deletion(-)
$ git replay HEAD v2.35.0 v2.36.0-rc1
8312ecf6404ab1bacd5521a2d8681a2410d13ede

The ID that is printed out is the equivalent
of V2.36.0-rc1 after replaying.

This is a RFC because:
- Perhaps it is already possible to do it with git rebase
  to achieve the same? But I haven't seen a recipe that
  gets it done in stackoverflow, at least.
- If it is not possible, I think getting this logic in rebase
  (with a flag, for example --replay) makes sense.

Let me know what you think.
Interesting? Not?
Keep it as a builtin (polishing it, it's just a rough cut
at the time) or get it into rebase?
---
 Makefile         |   1 +
 builtin.h        |   1 +
 builtin/replay.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++
 git.c            |   1 +
 4 files changed, 151 insertions(+)
 create mode 100644 builtin/replay.c

diff --git a/Makefile b/Makefile
index f8bccfab5e..71924d0c43 100644
--- a/Makefile
+++ b/Makefile
@@ -1194,6 +1194,7 @@ BUILTIN_OBJS += builtin/remote-fd.o
 BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/repack.o
 BUILTIN_OBJS += builtin/replace.o
+BUILTIN_OBJS += builtin/replay.o
 BUILTIN_OBJS += builtin/rerere.o
 BUILTIN_OBJS += builtin/reset.o
 BUILTIN_OBJS += builtin/rev-list.o
diff --git a/builtin.h b/builtin.h
index 40e9ecc848..0c1915c4c9 100644
--- a/builtin.h
+++ b/builtin.h
@@ -207,6 +207,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix);
 int cmd_remote_ext(int argc, const char **argv, const char *prefix);
 int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 int cmd_repack(int argc, const char **argv, const char *prefix);
+int cmd_replay(int argc, const char **argv, const char *prefix);
 int cmd_rerere(int argc, const char **argv, const char *prefix);
 int cmd_reset(int argc, const char **argv, const char *prefix);
 int cmd_restore(int argc, const char **argv, const char *prefix);
diff --git a/builtin/replay.c b/builtin/replay.c
new file mode 100644
index 0000000000..ed970fa057
--- /dev/null
+++ b/builtin/replay.c
@@ -0,0 +1,148 @@
+/*
+ * "git replay" builtin command
+ *
+ * Copyright (c) 2022 Edmundo Carmona Antoranz
+ * Released under the terms of GPLv2
+ */
+
+#include "builtin.h"
+#include "revision.h"
+#include "commit.h"
+#include "cache.h"
+
+static struct commit **new_commits;
+static unsigned long mappings_size = 0;
+static struct commit_list *old_commits = NULL;
+
+static unsigned int replay_indexof(struct commit *commit,
+				   struct commit_list *list)
+{
+	int res;
+	if (list == NULL)
+		return -1;
+	if (!oidcmp(&list->item->object.oid,
+		    &commit->object.oid))
+		return 0;
+	res = replay_indexof(commit, list->next);
+	return res < 0 ? res : res + 1;
+}
+
+static struct commit *replay_find_commit(const char *name)
+{
+	struct commit *commit = lookup_commit_reference_by_name(name);
+	if (!commit)
+		die(_("no such branch/commit '%s'"), name);
+	return commit;
+}
+
+static struct commit* replay_commit(struct commit * orig_commit)
+{
+	struct pretty_print_context ctx = {0};
+	struct strbuf body = STRBUF_INIT;
+	struct strbuf author = STRBUF_INIT;
+	struct strbuf committer = STRBUF_INIT;
+	struct object_id new_commit_oid;
+	struct commit *new_commit;
+
+	struct commit_list *new_parents_head = NULL;
+	struct commit_list **new_parents = &new_parents_head;
+	struct commit_list *parents = orig_commit->parents;
+	while (parents) {
+		struct commit *parent = parents->item;
+		int commit_index;
+		struct commit *new_parent;
+
+		commit_index = replay_indexof(parent, old_commits);
+
+		if (commit_index < 0)
+			 // won't be replayed, use the original parent
+			new_parent = parent;
+		else {
+			// it might have been translated already
+			if (!new_commits[commit_index])
+				new_commits[commit_index] = replay_commit(parent);
+			new_parent = new_commits[commit_index];
+		}
+		new_parents = commit_list_append(new_parent, new_parents);
+		parents = parents->next;
+	}
+
+	format_commit_message(orig_commit, "%B", &body, &ctx);
+	// TODO timezones
+	format_commit_message(orig_commit, "%an <%ae> %at +0000", &author, &ctx);
+	// TODO consider committer (control with an option)
+	format_commit_message(orig_commit, "%cn <%ce> %ct +0000", &committer, &ctx);
+
+	commit_tree_extended(body.buf,
+			     body.len,
+			     get_commit_tree_oid(orig_commit),
+			     new_parents_head,
+			     &new_commit_oid,
+			     author.buf,
+			     committer.buf,
+			     NULL, NULL);
+
+	new_commit = lookup_commit_or_die(&new_commit_oid,
+					  "new commit");
+
+	strbuf_release(&author);
+	strbuf_release(&body);
+	strbuf_release(&committer);
+
+	return new_commit;
+}
+
+static struct commit* replay(struct commit *new_base, struct commit *old_base,
+		      struct commit *tip)
+{
+	struct rev_info revs;
+	struct commit *commit;
+
+	init_revisions(&revs, NULL);
+
+	old_base->object.flags |= UNINTERESTING;
+	add_pending_object(&revs, &old_base->object, "old-base");
+	add_pending_object(&revs, &tip->object, "tip");
+
+	if (prepare_revision_walk(&revs))
+		die("Could not get revisions to replay");
+
+	while ((commit = get_revision(&revs)) != NULL)
+		commit_list_insert(commit, &old_commits);
+
+	// save the mapping between the new and the old base
+	commit_list_insert(old_base, &old_commits);
+	mappings_size = commit_list_count(old_commits);
+	new_commits = calloc(mappings_size, sizeof(struct commit));
+	new_commits[replay_indexof(old_base, old_commits)] = new_base;
+
+	return replay_commit(tip);
+}
+
+
+int cmd_replay(int argc, const char **argv, const char *prefix)
+{
+	struct commit *new_base;
+	struct commit *old_base;
+	struct commit *tip;
+	struct commit *new_tip;
+
+	if (argc < 4) {
+		die("Not enough parameters");
+	}
+
+	new_base = replay_find_commit(argv[1]);
+	old_base = replay_find_commit(argv[2]);
+	tip = replay_find_commit(argv[3]);
+
+	if (oidcmp(get_commit_tree_oid(new_base),
+		   get_commit_tree_oid(old_base)))
+		die("The old and the new base do not have the same tree");
+
+	// get the list of revisions between old_base and tip
+	new_tip = replay(new_base, old_base, tip);
+
+	printf("%s\n", oid_to_hex(&new_tip->object.oid));
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 3d8e48cf55..14de8d666f 100644
--- a/git.c
+++ b/git.c
@@ -590,6 +590,7 @@ static struct cmd_struct commands[] = {
 	{ "remote-fd", cmd_remote_fd, NO_PARSEOPT },
 	{ "repack", cmd_repack, RUN_SETUP },
 	{ "replace", cmd_replace, RUN_SETUP },
+	{ "replay", cmd_replay, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
 	{ "restore", cmd_restore, RUN_SETUP | NEED_WORK_TREE },
-- 
2.35.1

