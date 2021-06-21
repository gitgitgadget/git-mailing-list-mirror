Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97440C49EA2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800AE610C7
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFUPMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUPMi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 11:12:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A263C06175F
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:10:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y7so20002125wrh.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Q7VLdxc4OiclmKLG4qbM6BYrtuFsAv+ExVZqsD8I3Y=;
        b=PVrkqjPFvrcquQ1SyIGCmjESWy6zwjKjw/gvbRdhr3BcLGlRJYAhdvSxl2XfR7z82l
         EcWrHjrfPDcgE7jwdkiqP9cQ5PrZDr8yO2H+D5ZLX656mMP8poQaO8FMwIiqn8eY41MC
         65MVZx3f/NDzoOJeAp1KLoXdOqZzLTNFz7L2EePoYBvGYin4oQgZs9YNEJiG6guk23wi
         cjXNPLpC9CFiE9V5gUPU1iWUG6Kse4pjbpUmvBqlLxWMuUs1YlikpTa1t5yD2v2ukiSl
         KHRtYTh/VrGJPfe5kBkFCvaJXJI7Kw7x2KlX+oqIrEKwvQc0uMSQ3iyQbKUgX4lIhBKs
         BvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Q7VLdxc4OiclmKLG4qbM6BYrtuFsAv+ExVZqsD8I3Y=;
        b=O0HIbJVlGnmQzeI3AAuzHFFI0fRjZZkZJntTv3ab6Xd2Ad0u7W4Wdw4pWufRQ4nsmR
         86fou3ZTCpADwEL06G2cCsaMjR/O1YVTPa4JcIRCQMT3E/ga40daq7dXlaDPYmKpWULQ
         yRUJfVsEsay3Vo/LnesMOvD1BZPFx0mr2kES7+GTd5aFHUd1Drw5We+N3P6T40vQ606+
         Xnxjo35tEzmDhu8kjgLJBDV33Iw3avhhArIQMoGMmOpNQAc3AiDlZKG0Xn+qMaCNPKxH
         r/rtIk4xgcmUBVp5SxhBsMXX8PJqoR2Rer+WM6cv9oCwS26Or+AD8+3kCgJL0ivhn86Q
         0pIQ==
X-Gm-Message-State: AOAM5328/CI3qf8IBXgEccJRP6WV25b1cp4gP+XHtJpZYPVG+yWiyQnT
        KccubLlhHsjfsCaWp9ijJTFtJ0Ia9GQ9+w==
X-Google-Smtp-Source: ABdhPJwS/rGlRyPqMQj/MD7SG+DPBhEb9XWIoWOGuCs+/lHkvrpeSvnEekX7hvI2BSjRfxtDK5aF1Q==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr26192766wrp.220.1624288222463;
        Mon, 21 Jun 2021 08:10:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t17sm16676383wmi.47.2021.06.21.08.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:10:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/4] pack-objects.c: do stdin parsing via revision.c's API
Date:   Mon, 21 Jun 2021 17:10:15 +0200
Message-Id: <patch-3.4-943b1b4c12a-20210621T150651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com> <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the rev_info stdin parsing API to support hooking into its
read_revisions_from_stdin() function, and change the custom stdin
parsing in pack-objects.c to use it.

The pack-objects.c code being refactored away here was first added in
Linus's c323ac7d9c5 (git-pack-objects: create a packed object
representation., 2005-06-25).

Later on rev-list started doing similar parsing in 42cabc341c4 (Teach
rev-list an option to read revs from the standard input., 2006-09-05).
That code was promoted to a more general API in 1fc561d169a (Move
read_revisions_from_stdin from builtin-rev-list.c to revision.c,
2008-07-05).

Since then the API in revision.c has received improvements that have
been missed here. E.g. the arbitrary limit of 1000 bytes was removed
in 63d564b3002 (read_revision_from_stdin(): use strbuf, 2009-11-20),
and it moved to a more simpler strbuf API in 6e8d46f9d4b (revision:
read --stdin with strbuf_getline(), 2015-10-28).

Let's do the same here, as in 6e8d46f9d4b we can remove the "if (len
&& line[len - 1] == '\n')" check, it's now redundant to using
strbuf_getline(), and we get to skip the whole
"warn_on_object_refname_ambiguity" dance. The
read_revisions_from_stdin() function in revision.c we're now using
does it for us.

For now there isn't all that much point in this whole exercises. We
just end up calling setup_revisions() to loop over stdin for us, but
the callback we define makes no use of REV_INFO_STDIN_LINE_PROCESS, we
still need to call handle_revision_arg() ourselves because we'd like
to call it with different flags.

This very light use of the API will be further refined in a subsequent
commit, for now we're just doing the bare minimum to move this
existing code over to the new callback pattern without any functional
changes, and making it as friendly to "git show -w" and "the
--color-moved-ws=allow-indentation-change" mode as possible.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 63 ++++++++++++++++++++----------------------
 revision.c             | 22 +++++++++++++++
 revision.h             | 30 ++++++++++++++++++++
 3 files changed, 82 insertions(+), 33 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a4e2ae059c0..f8cae6c305a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3755,15 +3755,40 @@ static void mark_bitmap_preferred_tips(void)
 	}
 }
 
+static enum rev_info_stdin_line get_object_list_handle_stdin_line(
+	struct rev_info *revs, struct strbuf *line_sb, void *stdin_line_priv)
+{
+	int *flags = stdin_line_priv;
+	char *line = line_sb->buf;
+
+	if (*line == '-') {
+		if (!strcmp(line, "--not")) {
+			*flags ^= UNINTERESTING;
+			write_bitmap_index = 0;
+			return REV_INFO_STDIN_LINE_CONTINUE;
+		}
+		if (starts_with(line, "--shallow ")) {
+			struct object_id oid;
+			if (get_oid_hex(line + 10, &oid))
+				die("not an object name '%s'", line + 10);
+			register_shallow(the_repository, &oid);
+			use_bitmap_index = 0;
+			return REV_INFO_STDIN_LINE_CONTINUE;
+		}
+		die(_("not a rev '%s'"), line);
+	}
+	if (handle_revision_arg(line, revs, *flags, REVARG_CANNOT_BE_FILENAME))
+			die(_("bad revision '%s'"), line);
+	return REV_INFO_STDIN_LINE_CONTINUE;
+}
+
 static void get_object_list(int ac, const char **av)
 {
 	struct rev_info revs;
 	struct setup_revision_opt s_r_opt = {
 		.allow_exclude_promisor_objects = 1,
 	};
-	char line[1000];
 	int flags = 0;
-	int save_warning;
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
@@ -3771,39 +3796,11 @@ static void get_object_list(int ac, const char **av)
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
+	revs.stdin_handling = REV_INFO_STDIN_ALWAYS_READ;
+	revs.handle_stdin_line = get_object_list_handle_stdin_line;
+	revs.stdin_line_priv = &flags;
 	setup_revisions(ac, av, &revs, &s_r_opt);
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
-
-	while (fgets(line, sizeof(line), stdin) != NULL) {
-		int len = strlen(line);
-		if (len && line[len - 1] == '\n')
-			line[--len] = 0;
-		if (!len)
-			break;
-		if (*line == '-') {
-			if (!strcmp(line, "--not")) {
-				flags ^= UNINTERESTING;
-				write_bitmap_index = 0;
-				continue;
-			}
-			if (starts_with(line, "--shallow ")) {
-				struct object_id oid;
-				if (get_oid_hex(line + 10, &oid))
-					die("not an object name '%s'", line + 10);
-				register_shallow(the_repository, &oid);
-				use_bitmap_index = 0;
-				continue;
-			}
-			die(_("not a rev '%s'"), line);
-		}
-		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILENAME))
-			die(_("bad revision '%s'"), line);
-	}
-
-	warn_on_object_refname_ambiguity = save_warning;
-
 	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
 		return;
 
diff --git a/revision.c b/revision.c
index a65f9b89e99..f55b3a1caf4 100644
--- a/revision.c
+++ b/revision.c
@@ -2119,6 +2119,19 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 		int len = sb.len;
 		if (!len)
 			break;
+
+		if (revs->handle_stdin_line) {
+			enum rev_info_stdin_line ret = revs->handle_stdin_line(
+				revs, &sb, revs->stdin_line_priv);
+
+			switch (ret) {
+			case REV_INFO_STDIN_LINE_PROCESS:
+				break;
+			case REV_INFO_STDIN_LINE_CONTINUE:
+				continue;
+			}
+		}
+
 		if (sb.buf[0] == '-') {
 			if (len == 2 && sb.buf[1] == '-') {
 				seen_dashdash = 1;
@@ -2742,6 +2755,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 			if (!strcmp(arg, "--stdin")) {
 				switch (revs->stdin_handling) {
+				case REV_INFO_STDIN_ALWAYS_READ:
 				case REV_INFO_STDIN_IGNORE:
 					argv[left++] = arg;
 					continue;
@@ -2789,6 +2803,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		}
 	}
 
+	/*
+	 * We're asked to ALWAYS_READ from stdin, but no --stdin
+	 * option (or "consumed_stdin" would be set).
+	 */
+	if (!revs->consumed_stdin &&
+	    revs->stdin_handling == REV_INFO_STDIN_ALWAYS_READ)
+		read_revisions_from_stdin(revs, &prune_data);
+
 	if (prune_data.nr) {
 		/*
 		 * If we need to introduce the magic "a lone ':' means no
diff --git a/revision.h b/revision.h
index 79a3421cd1f..ff7994bb13d 100644
--- a/revision.h
+++ b/revision.h
@@ -89,8 +89,17 @@ struct topo_walk_info;
 enum rev_info_stdin {
 	REV_INFO_STDIN_CONSUME_ON_OPTION = 0,
 	REV_INFO_STDIN_IGNORE,
+	REV_INFO_STDIN_ALWAYS_READ,
 };
 
+enum rev_info_stdin_line {
+	REV_INFO_STDIN_LINE_PROCESS,
+	REV_INFO_STDIN_LINE_CONTINUE,
+};
+
+typedef enum rev_info_stdin_line (*rev_info_stdin_line_func)(
+	struct rev_info *revs, struct strbuf *line, void *stdin_line_priv);
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -126,6 +135,9 @@ struct rev_info {
 	 *
 	 * Can be set to REV_INFO_STDIN_IGNORE to ignore the --stdin
 	 * option.
+	 *
+	 * Set it to REV_INFO_STDIN_ALWAYS_READ if there's always data
+	 * on stdin to be read, even if no --stdin option is provided.
 	 */
 	enum rev_info_stdin stdin_handling;
 
@@ -136,6 +148,24 @@ struct rev_info {
 	 */
 	int consumed_stdin;
 
+	/*
+	 * When reading from stdin (see "stdin_handling" above) define
+	 * a handle_stdin_line function to consume the lines.
+	 *
+	 * - Return REV_INFO_STDIN_LINE_PROCESS to continue
+	 *   revision.c's normal processing of the line (after
+	 *   possibly munging the provided strbuf).
+	 *
+	 * - Return REV_INFO_STDIN_LINE_CONTINUE to indicate that the
+	 *   line is fully processed, moving onto the next line (if
+	 *   any)
+	 *
+	 * Use the "stdin_line_priv" to optionally pass your own data
+	 * around.
+	 */
+	rev_info_stdin_line_func handle_stdin_line;
+	void *stdin_line_priv;
+
 	/* topo-sort */
 	enum rev_sort_order sort_order;
 
-- 
2.32.0.599.g3967b4fa4ac

