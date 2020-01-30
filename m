Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46811C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2802063A
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="aHYHLHU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgA3XA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:00:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38864 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgA3XA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 18:00:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so2260724pfc.5
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 15:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iCiY0lDE2y7kIK/mcEsUBELJibebaw3Wond40rF8buk=;
        b=aHYHLHU8ajM3QoqDs/t8xH6x6UsriokwM0QRtm8tpyhdyda51tU+0IUYz7PJmS09Hi
         JsNGc5yoUJchnkwUaVzO/4av3qc/nv/cc9juvNnFeTQWAM3sD/I2c0dQ6Fdp8A0rWWjB
         6lXE1D7YLGpNY5wtB927/oHf5wCR3oXkVoRRqRQ32uqJF+g+hVMhYo2QLNfm22Xg14OF
         Lr+nBEIpm7fycw3WPdoJB0Yzd9UxyYJkwfxiXzx/J8Thrwwe8/SZAwzwQjow7nF7VQih
         iHlUbsXPx4XWNGj+O322vM6mqNGYKPKhMbbtMH3Zqd+pb9yGDbHG7gDKkTjEccCLu9cZ
         u/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iCiY0lDE2y7kIK/mcEsUBELJibebaw3Wond40rF8buk=;
        b=pGiEDaPMEbrsSTXeYyZR38Xd0P9d8c1qbVj8SMYDycYdgU8bcsmL3UdO8kRDMP/FTy
         e1Qp3//ISxh1e3azXjst0SbJx02OE+x9RAinR1BcEFzcpk+FiSRLapSITeGIWTQpo7sL
         zEHPxkgoJRL3TNvn8w85bbbKIHn+v0ItV6uDE/qbd+id/hWJxPtQTSE0m+dVCgJZvZSO
         LC5nhLkUp22JKO4uqI67DmitiNo9jMWWW0dHwBm6sWV14QDGRBj/+nLl7/VI9eZ7TtUj
         KDkdVpaXZcC5FiE7Cy1yXdcDc53i3Jk8wYsuDLN7/TYQoztVUP4Q1fP0el5gReiJv5tV
         T/Rw==
X-Gm-Message-State: APjAAAX1Xl7q7FsiZkCegH4wera+ZugGLNkkN4gpzhPkE8TOX+iJneoD
        Y4MvRRwft8kubxcElWbJrSIiRgLTMsAHcw==
X-Google-Smtp-Source: APXvYqzwKU70HzjZABck/rkzv+tzYkm/ZhwgHyyVkaYTGJXnRah47UX0OBn+gQpAr4D7gjXhSCm7SQ==
X-Received: by 2002:a63:1f0c:: with SMTP id f12mr7276657pgf.247.1580425255888;
        Thu, 30 Jan 2020 15:00:55 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5c8f:7dac:47b8:95ff])
        by smtp.gmail.com with ESMTPSA id v25sm7554420pfe.147.2020.01.30.15.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 15:00:55 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:00:54 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH 3/6] builtin/commit-graph.c: die() with unknown '--object-dir'
Message-ID: <bff635973073f4c496213e0416483985d7a4d12e.1580424766.git.me@ttaylorr.com>
References: <cover.1580424766.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580424766.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph sub-commands 'write', 'verify' both take an
'--object-dir' argument, which is used to specify the location of an
object directory containing commit-graphs.

However, there was no verification that the '--object-dir' argument
was an object directory. In the case of an '--object-dir' argument that
either (1) doesn't exist, or (2) isn't an object directory, 'git
commit-graph ...' would exit silently with status zero.

This can clearly lead to unintended behavior, such as verifying
commit-graphs that aren't in a repository's own object store (or one of
its alternates), or causing a typo to mask a legitimate commit-graph
verification failure.

To remedy this, let's wrap 'find_odb()' with 'find_odb_or_die()' and
cause the above such errors to produce an error and non-zero exit code.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt |  5 ++++-
 builtin/commit-graph.c             | 13 +++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index bcd85c1976..28d1fee505 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -26,7 +26,10 @@ OPTIONS
 	file. This parameter exists to specify the location of an alternate
 	that only has the objects directory, not a full `.git` directory. The
 	commit-graph file is expected to be in the `<dir>/info` directory and
-	the packfiles are expected to be in `<dir>/pack`.
+	the packfiles are expected to be in `<dir>/pack`. If the directory
+	could not be made into an absolute path, or does not match any known
+	object directory, `git commit-graph ...` will exit with non-zero
+	status.
 
 --[no-]progress::
 	Turn progress on/off explicitly. If neither is specified, progress is
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 3edac318e8..93ff90d73b 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -34,6 +34,15 @@ static struct opts_commit_graph {
 	int progress;
 } opts;
 
+static struct object_directory *find_odb_or_die(struct repository *r,
+						const char *obj_dir)
+{
+	struct object_directory *odb = find_odb(r, obj_dir);
+	if (!odb)
+		die(_("could not find object directory matching %s"), obj_dir);
+	return odb;
+}
+
 static int graph_verify(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
@@ -78,7 +87,7 @@ static int graph_verify(int argc, const char **argv)
 		graph = load_commit_graph_one_fd_st(fd, &st);
 	else {
 		struct object_directory *odb;
-		if ((odb = find_odb(the_repository, opts.obj_dir)))
+		if ((odb = find_odb_or_die(the_repository, opts.obj_dir)))
 			graph = read_commit_graph_one(the_repository, odb);
 	}
 
@@ -149,7 +158,7 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 	read_replace_refs = 0;
-	odb = find_odb(the_repository, opts.obj_dir);
+	odb = find_odb_or_die(the_repository, opts.obj_dir);
 
 	if (opts.reachable) {
 		if (write_commit_graph_reachable(odb->path, flags, &split_opts))
-- 
2.25.0.dirty

