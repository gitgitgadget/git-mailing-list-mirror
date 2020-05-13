Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310EFC433E1
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FC420675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mBqGooPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgEMV7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730305AbgEMV7s (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 17:59:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4298EC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b12so340881plz.13
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=noEV4gExGCZv1UnBn7qT3MkHqACRdSElwEVLyO9xSTU=;
        b=mBqGooPBc1dGdol9HbXVTJolsEcNRdiAdWlaK0ufXzjcOHTsdyw+O20qLoqGwI2IWT
         ysTWbKk3/Wx3xscLTPpQchay+hU73NDf73/yTjUXDmPBda6zpWcjnex5qUwM3UTtDUXI
         qkY7L8prNhEMjiebHSfS0rkMaGtc1kJwIHOW9qyYIwTRpC0LvKcZ53aCkM7cF4E++EoW
         /v2J9y9a4LV0JnQ6jVPljVmYgOBJpzyckeNIa8cBVaN+MtmuZybsh3+ix8WgnW0UBrPL
         pS1uozdxWBp1lDg0HgSojVO9SlpHLZFDyVCPivcn5AY8L9JWxtTdU5a5FNOJJQ1Epk6L
         40KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=noEV4gExGCZv1UnBn7qT3MkHqACRdSElwEVLyO9xSTU=;
        b=YVFkAr9o67lzXphoKDn8/ArhZzVk5p7AZSiPqWTYVZNHXEcDM4cCg9jAUnWphLIKex
         WF/XDdtF9deB9ttzgQBbWrzNWlRjuZj0wXBicEYikCbaXTQuGUMYd8BZWB2FjlnUy/h4
         rBhXwrvv8aa9SzGRqnDZHxDkza6gDMd/7vyz914OtUHNQon6J3DUp05Xgu5iZ9UVQrPj
         DSR/X1GfTwu/kbVz1dX6L9YVjDCgMqi4oNCYY3RIP4zebAznSdM4bVfcCrxZtWn40Dgd
         B6hVA4XGdxxAx+DEGG/Aok68o+/BQ1g5Fr/ZY6n9vEjtSFLQZZnp9J0amSqC2zpe104Y
         AAKA==
X-Gm-Message-State: AOAM532bhj539q47DOXzd8HiCPB/6vSsq8LDnTr0g3Bq/V4C4lE6G7bw
        tnyNa2hzKs9/yZbGQ/P71QxpYDwgmrc=
X-Google-Smtp-Source: ABdhPJx/Ga5esO5zErfve3xZQp9C4z8zJNzOqFdLuKJzEC5kI0zluLHFwBcQEjxi9PNlMynF5zX2ag==
X-Received: by 2002:a17:902:bc8c:: with SMTP id bb12mr1123073plb.142.1589407186310;
        Wed, 13 May 2020 14:59:46 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id h64sm463862pfe.42.2020.05.13.14.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:59:45 -0700 (PDT)
Date:   Wed, 13 May 2020 15:59:44 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 5/8] builtin/commit-graph.c: dereference tags in builtin
Message-ID: <56403dd377b996d21a4da1e01ffd6e691ac120bd.1589407014.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1589407014.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When given a list of commits, the commit-graph machinery calls
'lookup_commit_reference_gently()' on each element in the set and treats
the resulting set of OIDs as the base over which to close for
reachability.

In an earlier collection of commits, the 'git commit-graph write
--reachable' case made the inner-most call to
'lookup_commit_reference_gently()' by peeling references before they
were passed over to the commit-graph internals.

Do the analog for 'git commit-graph write --stdin-commits' by calling
'lookup_commit_reference_gently()' outside of the commit-graph
machinery, making the inner-most call a noop.

Since this may incur additional processing time, surround
'read_one_commit' with a progress meter to provide output to the caller.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f6647449ed..83c55d9227 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -6,6 +6,7 @@
 #include "repository.h"
 #include "commit-graph.h"
 #include "object-store.h"
+#include "progress.h"
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
@@ -138,15 +139,24 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static int read_one_commit(struct oidset *commits, const char *hash)
+static int read_one_commit(struct oidset *commits, struct progress *progress,
+			   const char *hash)
 {
+	struct commit *result;
 	struct object_id oid;
 	const char *end;
 
 	if (parse_oid_hex(hash, &oid, &end))
 		return error(_("unexpected non-hex object ID: %s"), hash);
 
-	oidset_insert(commits, &oid);
+	result = lookup_commit_reference_gently(the_repository, &oid, 1);
+	if (result)
+		oidset_insert(commits, &result->object.oid);
+	else
+		return error(_("invalid commit object id: %s"), hash);
+
+	display_progress(progress, oidset_size(commits));
+
 	return 0;
 }
 
@@ -157,6 +167,7 @@ static int graph_write(int argc, const char **argv)
 	struct object_directory *odb = NULL;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
+	struct progress *progress = NULL;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -230,13 +241,18 @@ static int graph_write(int argc, const char **argv)
 	} else if (opts.stdin_commits) {
 		oidset_init(&commits, 0);
 		flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
+		if (opts.progress)
+			progress = start_delayed_progress(
+				_("Collecting commits from input"), 0);
 
 		while (strbuf_getline(&buf, stdin) != EOF) {
-			if (read_one_commit(&commits, buf.buf)) {
+			if (read_one_commit(&commits, progress, buf.buf)) {
 				result = 1;
 				goto cleanup;
 			}
 		}
+
+
 	}
 
 	if (write_commit_graph(odb,
@@ -249,6 +265,8 @@ static int graph_write(int argc, const char **argv)
 cleanup:
 	UNLEAK(pack_indexes);
 	strbuf_release(&buf);
+	if (progress)
+		stop_progress(&progress);
 	return result;
 }
 
-- 
2.26.0.113.ge9739cdccc

