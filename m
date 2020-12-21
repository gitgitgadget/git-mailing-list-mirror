Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B457C433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD95E225AC
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 22:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgLUWbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 17:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLUWbw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 17:31:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC051C061282
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 14:31:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b131so15476235ybc.3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 14:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1r6tK2x1UJYknjjX486ofalbchD/VfnhEpu1buRlBcc=;
        b=F5f9R6SF4kUZ61UIHTfERProOdMShorhNbGfTIZ3US3myvr30GJY4+tv/zLbv13jNz
         Jj6/hER/9DN5hrdTg26dqB/9N16FArJryjmEw9KtOim8tQExCeH8MDlO9fqVt/XjNlxF
         jtGTaW8+EtzkqQRbST2EU1vL0RmMZ157+Lbp6c3RHokxV+T4w8Ff31EuhIQoIY+Za4TN
         IVDKFBw3xR7yjTSH6zx31FjDq4O7DXldRXKpzRV9TCkj3nb0khqZdXl1N7sVZe1EADVj
         FpMem8AKWrLmwIVyDIXVQ9GvVpz3ifNRRCe7t7ePrXsPaevcOsHcSSSH/1E91ipoU4Bt
         hNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1r6tK2x1UJYknjjX486ofalbchD/VfnhEpu1buRlBcc=;
        b=LLe7yDOtvfesW2QTJwGcrD7I+AnhVmcoRi1LmyJFBL0JgXqDXTGJi8nFFklOMFRhOb
         lGFeum61vRPkJaIzwZX6XfDP3u5A9QtbVy7OqtrxekLBqH5RJiUFKuC0ujAnfzqzXLA8
         Vv8uKkyM3LuXCZ+aJQRVhZe0PeZ/HxLffGX52rvvU8d7kR0XjlR2HsLk1afOhzoqh7il
         7ESZTjxjSmTCqusPna3nWANmZa9vqmFaO0BHRLGLOTU4jHyIw8gLZEztvefSlyk+PItQ
         9z0EVU5fW7pHSd72zOT3n/1pPr3nHyCIn4wz7uZOgikWzy7/8ZL3VSiuCvuQ7EYiNhq1
         L/0Q==
X-Gm-Message-State: AOAM5313NgozMSvEyWszQ3wNI674zRzJDWLrluMnmkTKCS6dt7yR0dc2
        Y+ygx/iouaSWzh6IbXUQJM8lXEbS/zwp5SsRbbza71noMCclu34rtl+2wiFfVc6+VmMLYzyNx0T
        lzbpWeiqfGVB/xlQMSput3nIVhIcbPtHG9IDPAnUgZXcHinnQDBF7EE3Tn89DHknxECWP/MQnUg
        vV
X-Google-Smtp-Source: ABdhPJweVgEcpLlKXGFldCh69PSlKDcutANH6XHfDh80xOJNK1+zEx6zTFetaVutTQGISG2Dc7TkINgHS3dYtYGtulhP
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ab30:: with SMTP id
 u45mr25191692ybi.516.1608589870876; Mon, 21 Dec 2020 14:31:10 -0800 (PST)
Date:   Mon, 21 Dec 2020 14:31:01 -0800
In-Reply-To: <cover.1608587839.git.jonathantanmy@google.com>
Message-Id: <c2303dc9761493decd7a21a7f1e89d6dd9c646e4.1608587839.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201211210508.2337494-1-jonathantanmy@google.com> <cover.1608587839.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 3/3] clone: respect remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to use the "unborn" feature introduced in a previous patch as
follows: Git will always send the "unborn" argument if it is supported
by the server. During "git clone", if cloning an empty repository, Git
will use the new information to determine the local branch to create. In
all other cases, Git will ignore it.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config/init.txt |  2 +-
 builtin/clone.c               | 19 ++++++++++++++++---
 connect.c                     | 28 ++++++++++++++++++++++++----
 t/t5606-clone-options.sh      |  7 ++++---
 t/t5702-protocol-v2.sh        |  9 +++++++++
 5 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
index dc77f8c844..79c79d6617 100644
--- a/Documentation/config/init.txt
+++ b/Documentation/config/init.txt
@@ -4,4 +4,4 @@ init.templateDir::
 
 init.defaultBranch::
 	Allows overriding the default branch name e.g. when initializing
-	a new repository or when cloning an empty repository.
+	a new repository.
diff --git a/builtin/clone.c b/builtin/clone.c
index 70f9450db4..217c87fddf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -980,6 +980,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int submodule_progress;
 
 	struct strvec ref_prefixes = STRVEC_INIT;
+	char *unborn_head_target = NULL;
 
 	packet_trace_identity("clone");
 
@@ -1264,7 +1265,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (!option_no_tags)
 		strvec_push(&ref_prefixes, "refs/tags/");
 
-	refs = transport_get_remote_refs(transport, &ref_prefixes, NULL);
+	refs = transport_get_remote_refs(transport, &ref_prefixes,
+					 &unborn_head_target);
 
 	if (refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
@@ -1323,10 +1325,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = NULL;
 		option_no_checkout = 1;
 		if (!option_bare) {
-			const char *branch = git_default_branch_name();
-			char *ref = xstrfmt("refs/heads/%s", branch);
+			const char *branch;
+			char *ref;
+
+			if (unborn_head_target &&
+			    skip_prefix(unborn_head_target, "refs/heads/", &branch)) {
+				ref = unborn_head_target;
+				unborn_head_target = NULL;
+			} else {
+				branch = git_default_branch_name();
+				ref = xstrfmt("refs/heads/%s", branch);
+			}
 
 			install_branch_config(0, branch, remote_name, ref);
+			create_symref("HEAD", ref, "");
 			free(ref);
 		}
 	}
@@ -1373,6 +1385,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&key);
 	junk_mode = JUNK_LEAVE_ALL;
 
+	free(unborn_head_target);
 	strvec_clear(&ref_prefixes);
 	return err;
 }
diff --git a/connect.c b/connect.c
index 99d9052365..3c35324b4c 100644
--- a/connect.c
+++ b/connect.c
@@ -376,7 +376,8 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 }
 
 /* Returns 1 when a valid ref has been added to `list`, 0 otherwise */
-static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
+static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
+			  char **unborn_head_target)
 {
 	int ret = 1;
 	int i = 0;
@@ -397,6 +398,25 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 		goto out;
 	}
 
+	if (!strcmp("unborn", line_sections.items[i].string)) {
+		i++;
+		if (unborn_head_target &&
+		    !strcmp("HEAD", line_sections.items[i++].string)) {
+			/*
+			 * Look for the symref target (if any). If found,
+			 * return it to the caller.
+			 */
+			for (; i < line_sections.nr; i++) {
+				const char *arg = line_sections.items[i].string;
+
+				if (skip_prefix(arg, "symref-target:", &arg)) {
+					*unborn_head_target = xstrdup(arg);
+					break;
+				}
+			}
+		}
+		goto out;
+	}
 	if (parse_oid_hex_algop(line_sections.items[i++].string, &old_oid, &end, reader->hash_algo) ||
 	    *end) {
 		ret = 0;
@@ -489,6 +509,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	if (!for_push)
 		packet_write_fmt(fd_out, "peel\n");
 	packet_write_fmt(fd_out, "symrefs\n");
+	if (server_supports_feature("ls-refs", "unborn", 0))
+		packet_write_fmt(fd_out, "unborn\n");
 	for (i = 0; ref_prefixes && i < ref_prefixes->nr; i++) {
 		packet_write_fmt(fd_out, "ref-prefix %s\n",
 				 ref_prefixes->v[i]);
@@ -497,9 +519,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 
 	/* Process response from server */
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
-		if (unborn_head_target)
-			BUG("NEEDSWORK: provide unborn HEAD target to caller while reading refs");
-		if (!process_ref_v2(reader, &list))
+		if (!process_ref_v2(reader, &list, unborn_head_target))
 			die(_("invalid ls-refs response: %s"), reader->line);
 	}
 
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 7f082fb23b..67a4c6d05b 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -102,11 +102,12 @@ test_expect_success 'redirected clone -v does show progress' '
 '
 
 test_expect_success 'chooses correct default initial branch name' '
-	git init --bare empty &&
+	git -c init.defaultBranch=foo init --bare empty &&
+	test_config -C empty lsrefs.allowUnborn true &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
 	git -c init.defaultBranch=up clone empty whats-up &&
-	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
-	test refs/heads/up = $(git -C whats-up config branch.up.merge)
+	test refs/heads/foo = $(git -C whats-up symbolic-ref HEAD) &&
+	test refs/heads/foo = $(git -C whats-up config branch.foo.merge)
 '
 
 test_expect_success 'guesses initial branch name correctly' '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7d5b17909b..4fbbe5aff5 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -209,6 +209,15 @@ test_expect_success 'clone with file:// using protocol v2' '
 	grep "ref-prefix refs/tags/" log
 '
 
+test_expect_success 'clone of empty repo propagates name of default branch' '
+	git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&
+	test_config -C file_empty_parent lsrefs.allowUnborn true &&
+
+	git -c init.defaultBranch=main -c protocol.version=2 \
+		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
+	grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
+'
+
 test_expect_success 'fetch with file:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
-- 
2.29.2.729.g45daf8777d-goog

