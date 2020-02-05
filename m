Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A55C3524D
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD0B21582
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="AQDoxdVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgBEA2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:28:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39114 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgBEA2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 19:28:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id j15so41978pgm.6
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 16:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cEK3toLRGG4Pm3wRr4c2eJnHWc6nvg+JXU0FQGSnUuc=;
        b=AQDoxdVSSB5+9cD/GBF0rRvmNvgKuG6djGu7jHxQBHQR3gIXloqMgd33VxQj0FOxb7
         1AZlfyld5lenokQ9Vz7zh3bU7h4lLF0wBDgedCrukFNGfDdpCMvQPDZrPnB3SUY9b654
         qlmYZpjN2Zy9Q7y/wYWSjtQBpXV6IQLCHfUgvLiwQA4LHAAY6eHp1Cp/XKRYbG5r4xjI
         a16fTPdjZmMxjxISjPL4KEhPxP1HrGw7018duywRQjP5RnGCxEgLbubd98OUD07WhVlt
         7VeGV3Ush9esyVyjeb9yMvvV64jfdwyfb97GHE+CR8zHwxeKqEM43l4ii8wdn0YoF5ag
         BIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cEK3toLRGG4Pm3wRr4c2eJnHWc6nvg+JXU0FQGSnUuc=;
        b=Skxh2R6ntRHFn1Gq6+JvTLK22wMeeTlr74Hhw3c6HWtLeXuwPkeyVhKMlP+9Vrgpq6
         TYuflTdGIH2HUDIX7lC4h+6FVPHXvtBMgtEchK6+4T9sYR5yMeLEyyUfYmEaSJZYOnxy
         Xsjb3jVJy4K6AEstdHFhNviMp7MIeK+LkQu4L8J5VFICTPjOPzuKpZ5m1bpUJKh28erx
         ZBONZgSGxLEP/DF/Elj/RXprXZBgVEfCylR/J/os3nJerzAAmjgkGAxzJ9/XM67/WMay
         y6f2b4o6GfSy7FodAc6067LO9AA568ENxOht8kE/5U77poFbGk3d3loHr34x2qy3cHkl
         M1LQ==
X-Gm-Message-State: APjAAAW1ekjfZ8csZ6YKCcuWc8Q12xXpFH/r9zAl58fCxxAInQSKn3ia
        ZU49NuYHGNLZfGFeIuYHoG2Pat9GwMaNtQ==
X-Google-Smtp-Source: APXvYqxVsX28MbSr76SlPEsa/mVBXpXq6WByNH1YmxlhBbR9xoWw15LPvL5U8lyHbMqMbtfI9poXcQ==
X-Received: by 2002:a65:621a:: with SMTP id d26mr33258206pgv.151.1580862517891;
        Tue, 04 Feb 2020 16:28:37 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:fd92:b4b9:d992:34e6])
        by smtp.gmail.com with ESMTPSA id w14sm3498755pgi.22.2020.02.04.16.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:28:37 -0800 (PST)
Date:   Tue, 4 Feb 2020 16:28:36 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [PATCH v2 3/3] builtin/commit-graph.c: support '--input=none'
Message-ID: <4c6425f0da9a6e5ae86530a12f18959ada07404b.1580862307.git.me@ttaylorr.com>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1580862307.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580862307.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit, we introduced '--split=<no-merge|merge-all>',
and alluded to the fact that '--split=merge-all' would be useful for
callers who wish to always trigger a merge of an incremental chain.

There is a problem with the above approach, which is that there is no
way to specify to the commit-graph builtin that a caller only wants to
include commits already in the graph. One can specify '--input=append'
to include all commits in the existing graphs, but the absence of
'--input=stdin-{commits,packs}' causes the builtin to call
'fill_oids_from_all_packs()'.

Passing '--input=reachable' (as in 'git commit-graph write
--split=merge-all --input=reachable --input=append') works around this
issue by making '--input=reachable' effectively a no-op, but this can be
prohibitively expensive in large repositories, making it an undesirable
choice for some users.

Teach '--input=none' as an option to behave as if '--input=append' were
given, but to consider no other sources in addition.

This, in conjunction with the option introduced in the previous patch
offers the convenient way to force the commit-graph machinery to
condense a chain of incrementals without requiring any new commits:

  $ git commit-graph write --split=merge-all --input=none

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt |  8 +++++++-
 builtin/commit-graph.c             | 11 ++++++++---
 commit-graph.c                     |  6 ++++--
 commit-graph.h                     |  3 ++-
 t/t5324-split-commit-graph.sh      | 26 ++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 2ae9de679a..633cfbe023 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -39,7 +39,7 @@ COMMANDS
 --------
 'write'::
 
-Write a commit-graph file based on the commits found in packfiles.
+Write a commit-graph file based on the specified sources of input:
 +
 With the `--input=stdin-packs` option, generate the new commit graph by
 walking objects only in the specified pack-indexes. (Cannot be combined
@@ -57,6 +57,12 @@ walking commits starting at all refs. (Cannot be combined with
 With the `--input=append` option, include all commits that are present
 in the existing commit-graph file.
 +
+With the `--input=none` option, behave as if `--input=append` were
+given, but do not walk other packs to find additional commits.
+
+If none of the above options are given, then generate the new
+commit-graph by walking over all pack-indexes.
++
 With the `--split[=<strategy>]` option, write the commit-graph as a
 chain of multiple commit-graph files stored in
 `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 0ff25896d0..a71af88815 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -11,7 +11,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
 	N_("git commit-graph write [--object-dir <objdir>] "
 	   "[--split[=<strategy>]] "
-	   "[--input=<reachable|stdin-packs|stdin-commits|append>] "
+	   "[--input=<reachable|stdin-packs|stdin-commits|append|none>] "
 	   "[--[no-]progress] <split options>"),
 	NULL
 };
@@ -24,7 +24,7 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 static const char * const builtin_commit_graph_write_usage[] = {
 	N_("git commit-graph write [--object-dir <objdir>] "
 	   "[--split[=<strategy>]] "
-	   "[--input=<reachable|stdin-packs|stdin-commits|append>] "
+	   "[--input=<reachable|stdin-packs|stdin-commits|append|none>] "
 	   "[--[no-]progress] <split options>"),
 	NULL
 };
@@ -33,7 +33,8 @@ enum commit_graph_input {
 	COMMIT_GRAPH_INPUT_REACHABLE     = (1 << 1),
 	COMMIT_GRAPH_INPUT_STDIN_PACKS   = (1 << 2),
 	COMMIT_GRAPH_INPUT_STDIN_COMMITS = (1 << 3),
-	COMMIT_GRAPH_INPUT_APPEND        = (1 << 4)
+	COMMIT_GRAPH_INPUT_APPEND        = (1 << 4),
+	COMMIT_GRAPH_INPUT_NONE          = (1 << 5)
 };
 
 static struct opts_commit_graph {
@@ -80,6 +81,8 @@ static int option_parse_input(const struct option *opt, const char *arg,
 		*to |= COMMIT_GRAPH_INPUT_STDIN_COMMITS;
 	else if (!strcmp(arg, "append"))
 		*to |= COMMIT_GRAPH_INPUT_APPEND;
+	else if (!strcmp(arg, "none"))
+		*to |= (COMMIT_GRAPH_INPUT_APPEND | COMMIT_GRAPH_INPUT_NONE);
 	else
 		die(_("unrecognized --input source, %s"), arg);
 	return 0;
@@ -225,6 +228,8 @@ static int graph_write(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 	if (opts.input & COMMIT_GRAPH_INPUT_APPEND)
 		flags |= COMMIT_GRAPH_WRITE_APPEND;
+	if (opts.input & COMMIT_GRAPH_INPUT_NONE)
+		flags |= COMMIT_GRAPH_WRITE_NO_INPUT;
 	if (opts.split)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
diff --git a/commit-graph.c b/commit-graph.c
index 3a5cb23cd7..417b7eac9c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -788,7 +788,8 @@ struct write_commit_graph_context {
 	unsigned append:1,
 		 report_progress:1,
 		 split:1,
-		 check_oids:1;
+		 check_oids:1,
+		 no_input:1;
 
 	const struct split_commit_graph_opts *split_opts;
 };
@@ -1785,6 +1786,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
+	ctx->no_input = flags & COMMIT_GRAPH_WRITE_NO_INPUT ? 1 : 0;
 
 	if (ctx->split) {
 		struct commit_graph *g;
@@ -1843,7 +1845,7 @@ int write_commit_graph(struct object_directory *odb,
 			goto cleanup;
 	}
 
-	if (!pack_indexes && !commit_hex)
+	if (!ctx->no_input && !pack_indexes && !commit_hex)
 		fill_oids_from_all_packs(ctx);
 
 	close_reachable(ctx);
diff --git a/commit-graph.h b/commit-graph.h
index 65a7d2edae..df7f3f5961 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -79,7 +79,8 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
 	/* Make sure that each OID in the input is a valid commit OID. */
-	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
+	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
+	COMMIT_GRAPH_WRITE_NO_INPUT   = (1 << 4)
 };
 
 enum commit_graph_split_flags {
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 353523eca4..e3f317a1f4 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -369,4 +369,30 @@ test_expect_success '--split=no-merge always writes an incremental' '
 	test_line_count = 2 $graphdir/commit-graph-chain
 '
 
+test_expect_success '--split=no-merge, --input=none writes nothing' '
+	test_when_finished rm -rf a graphs.before graphs.after &&
+	rm -rf $graphdir &&
+	git reset --hard commits/2 &&
+	git rev-list -1 HEAD~1 >a &&
+	git commit-graph write --split=no-merge --input=stdin-commits <a &&
+	ls $graphdir/graph-*.graph >graphs.before &&
+	test_line_count = 1 $graphdir/commit-graph-chain &&
+	git commit-graph write --split --input=none &&
+	ls $graphdir/graph-*.graph >graphs.after &&
+	test_cmp graphs.before graphs.after
+'
+
+test_expect_success '--split=merge-all, --input=none merges the chain' '
+	test_when_finished rm -rf a b &&
+	rm -rf $graphdir &&
+	git reset --hard commits/2 &&
+	git rev-list -1 HEAD~1 >a &&
+	git rev-list -1 HEAD >b &&
+	git commit-graph write --split=no-merge --input=stdin-commits <a &&
+	git commit-graph write --split=no-merge --input=stdin-commits <b &&
+	test_line_count = 2 $graphdir/commit-graph-chain &&
+	git commit-graph write --split=merge-all --input=none &&
+	test_line_count = 1 $graphdir/commit-graph-chain
+'
+
 test_done
-- 
2.25.0.119.gaa12b7378b
