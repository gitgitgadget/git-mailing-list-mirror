Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165B0C2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3568206D5
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WsH7/9Z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405067AbgDNEEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 00:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgDNEEN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 00:04:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D575BC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id z9so4684180pjd.2
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pnmstrq41vvkwasQvJo9GppKN9vte6zAsQ24x/vm4nQ=;
        b=WsH7/9Z4i1vVES0OsDVOmvJ3FpYioR0Ji/nt2PKMKqYQdyWIImkpq9AaoIeBhY2j61
         JS8RIBKiJmM66a45gdCWwxtGxZZ9i+JSEb2m4fd+/Q1D/yjjIxDjo4pBVLc62MmKKPGb
         UBVq0IsL/HoLFnN1v1SdPo0NHkXjgxdENIuU/RLIZaieNGr5jF79p4efQSjsL8xI5d6j
         bMvSKzmxjhZy6hImT6e8y8CCSJUy9SVU2SGrLUuVPJdrqPy+kHOHrG7UUXnz0tkhZDib
         TSFxxk2I1Gn5bSQJlHOLfE3QIGDs32FzhRNGU7hQHWnwMwTMoMBJIJPnUNmw11hLnXYL
         WgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pnmstrq41vvkwasQvJo9GppKN9vte6zAsQ24x/vm4nQ=;
        b=GSiQIMCcX9N2mgJlSBRMQ59ZMizhPQ7nX+ekRBpMJu7ddNmYXwKTbAvQ5L8H0ufKTC
         pESQ8XlMC55bo96pZe0vWGqspSXpnX7X8HpFviHhQLwnWuZZ2HRtNBgUI7uGDD/+Nl5X
         /B2y6gCcj+nqBfW7+3vCLNhW9Y4LC3+/z4pGZ3GqbXuWoAftR3MS3Qcn0GLU/Gm+9wxC
         YIo2GxaFr816RjWv6TPbKJLOhG8nfGpo4UfghWI1qk0ZuekmV3aHrsRgXSzO1MfmDGh8
         gda2Yo1fN6cqdBg+xzjQMse8g6JYJ6xmxFl4zgdaDASBGvGjJv/3E2be1DIQY+A/vJ4w
         nZqA==
X-Gm-Message-State: AGi0PuauAbLehkQNQmSafzgvFIq1eg6Io5lM9Q2zBkQOKeIHw5Q37DB8
        c/x2twXdEY+kYT6YpNs/tXMhHOiV88eD0Cuf
X-Google-Smtp-Source: APiQypL9rZUrm5DCWIT/4pF3rZFUboK16xSZClu2S1WwwGziqMQvuS9Tj5bxeIQjENE07PpTH7xr0w==
X-Received: by 2002:a17:90a:30e7:: with SMTP id h94mr23583661pjb.186.1586837050487;
        Mon, 13 Apr 2020 21:04:10 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x4sm9971526pfa.191.2020.04.13.21.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:04:09 -0700 (PDT)
Date:   Mon, 13 Apr 2020 22:04:08 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: [PATCH 2/7] builtin/commit-graph.c: support for
 '--split[=<strategy>]'
Message-ID: <e70c66be882e004a527df3da4d130a26356883e0.1586836700.git.me@ttaylorr.com>
References: <cover.1586836700.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1586836700.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With '--split', the commit-graph machinery writes new commits in another
incremental commit-graph which is part of the existing chain, and
optionally decides to condense the chain into a single commit-graph.
This is done to ensure that the asymptotic behavior of looking up a
commit in an incremental chain is not dominated by the number of
incrementals in that chain. It can be controlled by the '--max-commits'
and '--size-multiple' options.

In the next two commits, we will introduce additional splitting
strategies that can exert additional control over:

  - when a split commit-graph is and isn't written, and

  - when the existing commit-graph chain is discarded completely and
    replaced with another graph

To prepare for this, make '--split' take an optional strategy (as in
'--split[=<strategy>]'), and add a new enum to describe which strategy
is being used. For now, no strategies are given, and the only enumerated
value is 'COMMIT_GRAPH_SPLIT_UNSPECIFIED', indicating the absence of a
strategy.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt | 11 ++++++-----
 builtin/commit-graph.c             | 26 ++++++++++++++++++++++----
 commit-graph.h                     |  5 +++++
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 28d1fee505..10d757c5cc 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -57,11 +57,12 @@ or `--stdin-packs`.)
 With the `--append` option, include all commits that are present in the
 existing commit-graph file.
 +
-With the `--split` option, write the commit-graph as a chain of multiple
-commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
-not already in the commit-graph are added in a new "tip" file. This file
-is merged with the existing file if the following merge conditions are
-met:
+With the `--split[=<strategy>]` option, write the commit-graph as a
+chain of multiple commit-graph files stored in
+`<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
+strategy and other splitting options. The new commits not already in the
+commit-graph are added in a new "tip" file. This file is merged with the
+existing file if the following merge conditions are met:
 +
 * If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
 tip file would have `N` commits and the previous tip has `M` commits and
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index d1ab6625f6..342094fc77 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,7 +9,9 @@
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] "
+	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
+	   "[--[no-]progress] <split options>"),
 	NULL
 };
 
@@ -19,7 +21,9 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] "
+	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
+	   "[--[no-]progress] <split options>"),
 	NULL
 };
 
@@ -114,6 +118,18 @@ static int graph_verify(int argc, const char **argv)
 extern int read_replace_refs;
 static struct split_commit_graph_opts split_opts;
 
+static int write_option_parse_split(const struct option *opt, const char *arg,
+				    int unset)
+{
+	opts.split = 1;
+	if (!arg)
+		return 0;
+
+	die(_("unrecognized --split argument, %s"), arg);
+
+	return 0;
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	struct string_list *pack_indexes = NULL;
@@ -136,8 +152,10 @@ static int graph_write(int argc, const char **argv)
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
-		OPT_BOOL(0, "split", &opts.split,
-			N_("allow writing an incremental commit-graph file")),
+		OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
+			N_("allow writing an incremental commit-graph file"),
+			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
+			write_option_parse_split),
 		OPT_INTEGER(0, "max-commits", &split_opts.max_commits,
 			N_("maximum number of commits in a non-base split commit-graph")),
 		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
diff --git a/commit-graph.h b/commit-graph.h
index e87a6f6360..e799008ff4 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -82,10 +82,15 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
 };
 
+enum commit_graph_split_flags {
+	COMMIT_GRAPH_SPLIT_UNSPECIFIED = 0
+};
+
 struct split_commit_graph_opts {
 	int size_multiple;
 	int max_commits;
 	timestamp_t expire_time;
+	enum commit_graph_split_flags flags;
 };
 
 /*
-- 
2.26.0.106.g9fadedd637

