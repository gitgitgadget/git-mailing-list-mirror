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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E347EC433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915A464DA3
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhBETV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 14:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbhBETTD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 14:19:03 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB1EC06178C
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 12:49:01 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id f7so6187887qtd.9
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 12:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3qA5U0eSO7FYCrtpzziYgWTqVrrAMC33eQ3CKXTU2eo=;
        b=uigkytn5QxavvSVlSZlS/v8QfhtRPN90AlUpIxTX2AdWXmTMoDUpltM7/fRLQ8H+HW
         jHb8Uyzsq44RGC/yMHdrAvexcMmA3Ia3QEAzd7Bz4IlDEdmeAGTRz5znpUHNlm0DGmD2
         K4mZdW58Rz2VtWIXy8VAfN5sVnFUJQ2JS3Du2WLjcV64fBkkA3iv5vDY2PCer0yHkheq
         g3zKq3ZBMvGkIL5lJCBtx4c9Jj3eEZSssQNA8Gquoezb0nOaFwBC9kgAZu2Lcmz9E2PR
         1dIbUj3PmUxXJTweiw1qPDbf8RgdXF5DTbaJPU+Sy7B57XwLMPKtK8By78fGYN2ZCEJq
         ltvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3qA5U0eSO7FYCrtpzziYgWTqVrrAMC33eQ3CKXTU2eo=;
        b=jTSg1s6uD+zTLOnRoEanb3nyMuV9S64+GY7MFovU7kusC72Vpg/XW3rsug51uchuUJ
         6fHACmKZcP6waq6DRI/6zGAjNuYDSyJsQMQL8a0Fcwr9bpVc79tHK0YpwaIG2OawfNUz
         Y89RXfpTYGyKYJ1Sw8sp5bHFciWV0T4UQAvvqF23fV0bj0n+X6+fZskA/wtzsAXnaKbi
         pHOk+BP8+i0jPgPsegeiCbiZsVeLTIqbo6j4mBPW6akqsuoItnADUbVL5OLWFKAY1hgR
         6F7QahqjnZ7a9i/LJXE6UquZVTtxY//xuAPKs/1NSG1AvRRBYTIKBN2l6i2ENlGQM+/e
         dRWg==
X-Gm-Message-State: AOAM531PNPfJr7f8d+nA2MNi4eEULpRP2F2zMMrgTCfXOGAb1rOG1a4z
        Is9MgqBrSplkeSPVTFq+AVa3dx4dTM/FsEFezUhjrhjEVs21fmcxVWqrZKHa609izKjeDsO9Wv6
        11sYsZr8IOIvBGkiQnln7CDaVUu3Ju6g9MFoLTi4y4kQBBK4a7uFPEXIMoPj/ICKtwHMCX1xxFd
        V0
X-Google-Smtp-Source: ABdhPJzB1doasSdaxlYtzlePeJh8PRrbXhGnoz4Sb51sixEpvUl5phKnGH/NYKsTNpZoEI7mV+TUANnODPdVYQ/TRCsC
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:d6d:: with SMTP id
 13mr6198474qvs.60.1612558140264; Fri, 05 Feb 2021 12:49:00 -0800 (PST)
Date:   Fri,  5 Feb 2021 12:48:49 -0800
In-Reply-To: <cover.1612557937.git.jonathantanmy@google.com>
Message-Id: <a5495a42f186ab5acc4214e892d7becd03cfa67f.1612557937.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201208013121.677494-1-jonathantanmy@google.com> <cover.1612557937.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v8 3/3] clone: respect remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/init.txt |  2 +-
 builtin/clone.c               | 16 ++++++++++++++--
 connect.c                     | 28 ++++++++++++++++++++++++++--
 t/t5606-clone-options.sh      |  8 +++++---
 t/t5702-protocol-v2.sh        | 25 +++++++++++++++++++++++++
 transport.h                   |  8 ++++++++
 6 files changed, 79 insertions(+), 8 deletions(-)

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
index 211d4f54b0..09dcd97a2e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1330,8 +1330,19 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = NULL;
 		option_no_checkout = 1;
 		if (!option_bare) {
-			const char *branch = git_default_branch_name();
-			char *ref = xstrfmt("refs/heads/%s", branch);
+			const char *branch;
+			char *ref;
+
+			if (transport_ls_refs_options.unborn_head_target &&
+			    skip_prefix(transport_ls_refs_options.unborn_head_target,
+					"refs/heads/", &branch)) {
+				ref = transport_ls_refs_options.unborn_head_target;
+				transport_ls_refs_options.unborn_head_target = NULL;
+				create_symref("HEAD", ref, reflog_msg.buf);
+			} else {
+				branch = git_default_branch_name();
+				ref = xstrfmt("refs/heads/%s", branch);
+			}
 
 			install_branch_config(0, branch, remote_name, ref);
 			free(ref);
@@ -1385,5 +1396,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_mode = JUNK_LEAVE_ALL;
 
 	strvec_clear(&transport_ls_refs_options.ref_prefixes);
+	free(transport_ls_refs_options.unborn_head_target);
 	return err;
 }
diff --git a/connect.c b/connect.c
index 328c279250..879669df93 100644
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
@@ -461,6 +481,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	const char *hash_name;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
+	char **unborn_head_target = transport_options ?
+		&transport_options->unborn_head_target : NULL;
 	*list = NULL;
 
 	if (server_supports_v2("ls-refs", 1))
@@ -490,6 +512,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	if (!for_push)
 		packet_write_fmt(fd_out, "peel\n");
 	packet_write_fmt(fd_out, "symrefs\n");
+	if (server_supports_feature("ls-refs", "unborn", 0))
+		packet_write_fmt(fd_out, "unborn\n");
 	for (i = 0; ref_prefixes && i < ref_prefixes->nr; i++) {
 		packet_write_fmt(fd_out, "ref-prefix %s\n",
 				 ref_prefixes->v[i]);
@@ -498,7 +522,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 
 	/* Process response from server */
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
-		if (!process_ref_v2(reader, &list))
+		if (!process_ref_v2(reader, &list, unborn_head_target))
 			die(_("invalid ls-refs response: %s"), reader->line);
 	}
 
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 7f082fb23b..ca6339a5fb 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -102,11 +102,13 @@ test_expect_success 'redirected clone -v does show progress' '
 '
 
 test_expect_success 'chooses correct default initial branch name' '
-	git init --bare empty &&
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=foo init --bare empty &&
+	test_config -C empty lsrefs.unborn advertise &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
 	git -c init.defaultBranch=up clone empty whats-up &&
-	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
-	test refs/heads/up = $(git -C whats-up config branch.up.merge)
+	test refs/heads/foo = $(git -C whats-up symbolic-ref HEAD) &&
+	test refs/heads/foo = $(git -C whats-up config branch.foo.merge)
 '
 
 test_expect_success 'guesses initial branch name correctly' '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7d5b17909b..b2ead93af9 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -209,6 +209,31 @@ test_expect_success 'clone with file:// using protocol v2' '
 	grep "ref-prefix refs/tags/" log
 '
 
+test_expect_success 'clone of empty repo propagates name of default branch' '
+	test_when_finished "rm -rf file_empty_parent file_empty_child" &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=main -c protocol.version=2 \
+		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
+	grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
+'
+
+test_expect_success '...but not if explicitly forbidden by config' '
+	test_when_finished "rm -rf file_empty_parent file_empty_child" &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&
+	test_config -C file_empty_parent lsrefs.unborn ignore &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+	git -c init.defaultBranch=main -c protocol.version=2 \
+		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
+	! grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
+'
+
 test_expect_success 'fetch with file:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
diff --git a/transport.h b/transport.h
index 1f5b60e4d3..24e15799e7 100644
--- a/transport.h
+++ b/transport.h
@@ -243,6 +243,14 @@ struct transport_ls_refs_options {
 	 * provided ref_prefixes.
 	 */
 	struct strvec ref_prefixes;
+
+	/*
+	 * If unborn_head_target is not NULL, and the remote reports HEAD as
+	 * pointing to an unborn branch, transport_get_remote_refs() stores the
+	 * unborn branch in unborn_head_target. It should be freed by the
+	 * caller.
+	 */
+	char *unborn_head_target;
 };
 #define TRANSPORT_LS_REFS_OPTIONS_INIT { STRVEC_INIT }
 
-- 
2.30.0.365.g02bc693789-goog

