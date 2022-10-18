Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94374C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 18:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJRSg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJRSg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 14:36:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF49D535
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 11:36:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so14788765pjl.3
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 11:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=CtZXNFJWhKofJJfKu4Xwu1qKWChP9WwTb73pthAQ39M=;
        b=6FZ2DP+/Y4CQBqIluATGqT2HHqxIOy1PlhJOMYkQiagmV6Mj/ehqdKAUCHnN3xn0ST
         F2agVK4Ywo7B8PI+aAdC1s4BBEUlToAzdP8Bhy86g1QRrETXlvwfSyrx5Mq9f4wunUYR
         eQznwrUf17cg3VrWfj4gURDo+SbLVDy1WcsqndSiudVuRwUYAVww+9d+6O2G0+7m6cHg
         iS6M22AJmwZaZ+v+hNLdX3chgOzltYXH+aag1g5tSu9xjeiWEkfoUPbNLpI4BS3DiZc6
         lEQGJLlAUIF5bEqhV4ghFrvO271zMFzHcsYmZcy6fNPmd6kmTPqOPrEyl1FmTM0EE6lV
         GOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtZXNFJWhKofJJfKu4Xwu1qKWChP9WwTb73pthAQ39M=;
        b=abAqWQBRPRqkstImDkSTYlF5Cxf93A58fCDzR6W5zFcemrYnmXyhQQbMuxgaDY8B7D
         k0qbcZXloRuf0UzjEdjmcdfzIMFQK2gQ2Oyx4VOIp9ET28FtbbnNDosdCxSQSW+X46Rt
         6BkTPNhIw1tSxoEhR8687u/NiHcScthWJpQ8UtB27nl7tnsuUEZVBtYM3HtSsTzp2c5R
         IzmnwtGVOXyYvYR1mQEZi3ouhwvt9nwDfmLTsTMOeAd880m3P9rxrOgDAsGCXmnh3kt7
         olDdhkYvB6Jy3dywDNpc4luUSeXF5YdwEGF2xOoDapb2pQSIYk1ukRtRe7B28fAOLzBJ
         UDgQ==
X-Gm-Message-State: ACrzQf01CO83lAiZVyFqRurB+y19uWUTHsQGn+tpPAlWJ72ehcEC1C6i
        6go4bM/gNuZZPhpLNE6PUHBmUoE0TpE82A==
X-Google-Smtp-Source: AMsMyM5mx9CQ4oiGaiSUiZlDQfM9HqABgoQDCmZ0g2GvTmAIasDs9uqcoUe1bExUQHFwaZc0aKooTg==
X-Received: by 2002:a17:903:50e:b0:182:631b:df6f with SMTP id jn14-20020a170903050e00b00182631bdf6fmr4560866plb.66.1666118215188;
        Tue, 18 Oct 2022 11:36:55 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p189-20020a625bc6000000b00562e9f636e0sm9956689pfb.10.2022.10.18.11.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:36:54 -0700 (PDT)
Subject: [PATCH] {merge,fmt-merge-msg}: Add the --from-name argument
Date:   Tue, 18 Oct 2022 11:36:56 -0700
Message-Id: <20221018183656.32185-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a "--into-name" to fake one side of the merge message, but
there's no way to fake the from branch that's being merged.  The
specific case I'm running into is "b4 shazam -M" with shortlogs enabled,
which ends up putting a "/tmp/tmp.XXXXXX" as the from branch in the
shortlog (the title is already overriden by b4).

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

I saw tests were required by the patch submission docs, but I haven't
written any.  That's both because I don't know how to do so (I haven't
done much hacking on git), and because I'm not sure this is useful
enough for other people to warrant taking upstream.  Happy to do so, but
figured I'd send this along this as-is to start.
---
 Documentation/git-fmt-merge-msg.txt |  4 ++
 Documentation/git-merge.txt         |  5 ++
 builtin/fmt-merge-msg.c             |  4 ++
 builtin/merge.c                     |  4 ++
 fmt-merge-msg.c                     | 89 ++++++++++++++++-------------
 fmt-merge-msg.h                     |  1 +
 6 files changed, 66 insertions(+), 41 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 6f28812f38..1d8ea40216 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -48,6 +48,10 @@ OPTIONS
 	Prepare the merge message as if merging to the branch `<branch>`,
 	instead of the name of the real branch to which the merge is made.
 
+--from-name <branch>::
+	Prepare the merge message as if merging from the branch `<branch>`,
+	instead of the name of the real branch from which the merge is made.
+
 -F <file>::
 --file <file>::
 	Take the list of merged objects from <file> instead of
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 2d6a1391c8..e9d02b8a6f 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -82,6 +82,11 @@ invocations. The automated message can include the branch description.
 	`<branch>`, instead of the name of the real branch to which
 	the merge is made.
 
+--from-name <branch>::
+	Prepare the default merge message as if merging from the branch
+	`<branch>`, instead of the name of the real branch from which
+	the merge is made.
+
 -F <file>::
 --file=<file>::
 	Read the commit message to be used for the merge commit (in
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 8d8fd393f8..f0ea815162 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -13,6 +13,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	const char *inpath = NULL;
 	const char *message = NULL;
 	char *into_name = NULL;
+	char *from_name = NULL;
 	int shortlog_len = -1;
 	struct option options[] = {
 		{ OPTION_INTEGER, 0, "log", &shortlog_len, N_("n"),
@@ -26,6 +27,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 			N_("use <text> as start of message")),
 		OPT_STRING(0, "into-name", &into_name, N_("name"),
 			   N_("use <name> instead of the real target branch")),
+		OPT_STRING(0, "from-name", &from_name, N_("name"),
+			   N_("use <name> instead of the real source branch")),
 		OPT_FILENAME('F', "file", &inpath, N_("file to read from")),
 		OPT_END()
 	};
@@ -60,6 +63,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	opts.credit_people = 1;
 	opts.shortlog_len = shortlog_len;
 	opts.into_name = into_name;
+	opts.from_name = from_name;
 
 	ret = fmt_merge_msg(&input, &output, &opts);
 	if (ret)
diff --git a/builtin/merge.c b/builtin/merge.c
index 5900b81729..921aa39c50 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -88,6 +88,7 @@ static const char *sign_commit;
 static int autostash;
 static int no_verify;
 static char *into_name;
+static char *from_name;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  NO_TRIVIAL },
@@ -289,6 +290,8 @@ static struct option builtin_merge_options[] = {
 		NULL, 0, option_read_message },
 	OPT_STRING(0, "into-name", &into_name, N_("name"),
 		   N_("use <name> instead of the real target")),
+	OPT_STRING(0, "from-name", &from_name, N_("name"),
+		   N_("use <name> instead of the real source")),
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
@@ -1144,6 +1147,7 @@ static void prepare_merge_message(struct strbuf *merge_names, struct strbuf *mer
 	opts.shortlog_len = shortlog_len;
 	opts.credit_people = (0 < option_edit);
 	opts.into_name = into_name;
+	opts.from_name = from_name;
 
 	fmt_merge_msg(merge_names, merge_msg, &opts);
 	if (merge_msg->len)
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index f48f44f9cd..5d94ce9214 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -353,6 +353,7 @@ static void shortlog(const char *name,
 	struct strbuf sb = STRBUF_INIT;
 	const struct object_id *oid = &origin_data->oid;
 	int limit = opts->shortlog_len;
+	const char *from_name = opts->from_name ? opts->from_name : name;
 
 	branch = deref_tag(the_repository, parse_object(the_repository, oid),
 			   oid_to_hex(oid),
@@ -398,12 +399,12 @@ static void shortlog(const char *name,
 	if (opts->credit_people)
 		add_people_info(out, &authors, &committers);
 	if (count > limit)
-		strbuf_addf(out, "\n* %s: (%d commits)\n", name, count);
+		strbuf_addf(out, "\n* %s: (%d commits)\n", from_name, count);
 	else
-		strbuf_addf(out, "\n* %s:\n", name);
+		strbuf_addf(out, "\n* %s:\n", from_name);
 
 	if (origin_data->is_local_branch && use_branch_desc)
-		add_branch_desc(out, name);
+		add_branch_desc(out, from_name);
 
 	for (i = 0; i < subjects.nr; i++)
 		if (i >= limit)
@@ -441,51 +442,57 @@ static int dest_suppressed(const char *dest_branch)
 }
 
 static void fmt_merge_msg_title(struct strbuf *out,
-				const char *current_branch)
+				const char *current_branch,
+				const char *into_branch)
 {
 	int i = 0;
 	char *sep = "";
 
 	strbuf_addstr(out, "Merge ");
-	for (i = 0; i < srcs.nr; i++) {
-		struct src_data *src_data = srcs.items[i].util;
-		const char *subsep = "";
 
-		strbuf_addstr(out, sep);
-		sep = "; ";
+	if (into_branch) {
+		strbuf_addstr(out, into_branch);
+	} else {
+		for (i = 0; i < srcs.nr; i++) {
+			struct src_data *src_data = srcs.items[i].util;
+			const char *subsep = "";
 
-		if (src_data->head_status == 1) {
-			strbuf_addstr(out, srcs.items[i].string);
-			continue;
-		}
-		if (src_data->head_status == 3) {
-			subsep = ", ";
-			strbuf_addstr(out, "HEAD");
-		}
-		if (src_data->branch.nr) {
-			strbuf_addstr(out, subsep);
-			subsep = ", ";
-			print_joined("branch ", "branches ", &src_data->branch,
-					out);
-		}
-		if (src_data->r_branch.nr) {
-			strbuf_addstr(out, subsep);
-			subsep = ", ";
-			print_joined("remote-tracking branch ", "remote-tracking branches ",
-					&src_data->r_branch, out);
-		}
-		if (src_data->tag.nr) {
-			strbuf_addstr(out, subsep);
-			subsep = ", ";
-			print_joined("tag ", "tags ", &src_data->tag, out);
-		}
-		if (src_data->generic.nr) {
-			strbuf_addstr(out, subsep);
-			print_joined("commit ", "commits ", &src_data->generic,
-					out);
+			strbuf_addstr(out, sep);
+			sep = "; ";
+
+			if (src_data->head_status == 1) {
+				strbuf_addstr(out, srcs.items[i].string);
+				continue;
+			}
+			if (src_data->head_status == 3) {
+				subsep = ", ";
+				strbuf_addstr(out, "HEAD");
+			}
+			if (src_data->branch.nr) {
+				strbuf_addstr(out, subsep);
+				subsep = ", ";
+				print_joined("branch ", "branches ", &src_data->branch,
+						out);
+			}
+			if (src_data->r_branch.nr) {
+				strbuf_addstr(out, subsep);
+				subsep = ", ";
+				print_joined("remote-tracking branch ", "remote-tracking branches ",
+						&src_data->r_branch, out);
+			}
+			if (src_data->tag.nr) {
+				strbuf_addstr(out, subsep);
+				subsep = ", ";
+				print_joined("tag ", "tags ", &src_data->tag, out);
+			}
+			if (src_data->generic.nr) {
+				strbuf_addstr(out, subsep);
+				print_joined("commit ", "commits ", &src_data->generic,
+						out);
+			}
+			if (strcmp(".", srcs.items[i].string))
+				strbuf_addf(out, " of %s", srcs.items[i].string);
 		}
-		if (strcmp(".", srcs.items[i].string))
-			strbuf_addf(out, " of %s", srcs.items[i].string);
 	}
 
 	if (!dest_suppressed(current_branch))
@@ -678,7 +685,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 	}
 
 	if (opts->add_title && srcs.nr)
-		fmt_merge_msg_title(out, current_branch);
+		fmt_merge_msg_title(out, current_branch, opts->from_name);
 
 	if (origins.nr)
 		fmt_merge_msg_sigs(out);
diff --git a/fmt-merge-msg.h b/fmt-merge-msg.h
index 99054042dc..fb3d93a317 100644
--- a/fmt-merge-msg.h
+++ b/fmt-merge-msg.h
@@ -10,6 +10,7 @@ struct fmt_merge_msg_opts {
 		credit_people:1;
 	int shortlog_len;
 	const char *into_name;
+	const char *from_name;
 };
 
 extern int merge_log_config;
-- 
2.38.0

