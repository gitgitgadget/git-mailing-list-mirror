Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C706AC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CD920658
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ia3T67Rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgEEBNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727995AbgEEBNx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:13:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AE3C061A10
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:13:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h12so518018pjz.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5S/9u2/3DE3w+vJ+ZYwegIJwhPJg8PsBxFjVeDOImrI=;
        b=ia3T67Rz72TpFSgb4vnElRtFji3JdoAQfeVTs4Z0h0Zx/NueDItkz2LTEP41DEnJpK
         C9EIitRdfK2+FkCmLIJJ4OV6mjX3xTMSVoLsMCLPqPiU3zpPm0y5MVY2IPK8A4O5x4B9
         ap3MCh6g6J5ABHh4vm/3xBwQpCPDsauwLvDJiLGzSvi4OrFf88NsDrao+53uHMUiQw9K
         J/9iBjMJ9s8GrPDrF/WoHbos3BBVetO17gT/afnvCpZXq5VKVDmbVHjkE0KCo3dSgw+F
         U7GVY04QPhuCl+4e5UjMALW2UR590Znay6gkGJL5xVzBmb7vCacWY2lbbllVoaTQDfrK
         y4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5S/9u2/3DE3w+vJ+ZYwegIJwhPJg8PsBxFjVeDOImrI=;
        b=SCa4rH40aXlQPk+3bTkqWYMPhU5TU5IR+HJCnQoVbc2k+vicQ2M1ZI6fbL9ogsOp2e
         inKAcUIEXNnEe3zRtSNPMhhJNaDyasdljEBkweV2tyHuiUS6iTJgyEmPePrzQCRF1K0Y
         HXQ6nDnbtVMT0Jzknsi/Yk/nx57UKL1l/8Vmg3FzkYrbqalplNw2rlGwCW8Od+sxofAG
         pBIu50vBXxPdXDv9iBpobkN3dRT+Ar5yYvxn6iP77N9KSKm02e4MBeOg68Bi3rDeEH0E
         q9l1EUy1FaLycLcHdUwYmAb8vNRS5Mx39zAe5uU3S+1gMGCrMA/lm8vmh/nZ73Eeq9Y0
         NNXQ==
X-Gm-Message-State: AGi0PuY8/CT0LvVw7aNyqVYaAJ2G19XjDVAnAL+mYBAmbZOHPnvwkFyd
        +OxnC+iEG4/uHo0CuMY9HpAkXE+Ys/NZmA==
X-Google-Smtp-Source: APiQypJuVlTRXk+b1sJ7yG/HvddNrPdiMoG+eBZlObMSmddJy5SiJVEfaYC/WR/dE3QYYzfv95Bnuw==
X-Received: by 2002:a17:90a:3781:: with SMTP id v1mr86287pjb.83.1588641231537;
        Mon, 04 May 2020 18:13:51 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id o11sm236041pgd.58.2020.05.04.18.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 18:13:50 -0700 (PDT)
Date:   Mon, 4 May 2020 19:13:49 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 5/8] builtin/commit-graph.c: dereference tags in builtin
Message-ID: <513a634f14e90ec0c2e80a6aaf8cb66bbedf8966.1588641176.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588641176.git.me@ttaylorr.com>
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
 builtin/commit-graph.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f550d8489a..9eec68572f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -6,6 +6,7 @@
 #include "repository.h"
 #include "commit-graph.h"
 #include "object-store.h"
+#include "progress.h"
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
@@ -138,8 +139,10 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static int read_one_commit(struct oidset *commits, char *hash)
+static int read_one_commit(struct oidset *commits, struct progress *progress,
+			   char *hash)
 {
+	struct commit *result;
 	struct object_id oid;
 	const char *end;
 
@@ -148,7 +151,15 @@ static int read_one_commit(struct oidset *commits, char *hash)
 		return 1;
 	}
 
-	oidset_insert(commits, &oid);
+	display_progress(progress, oidset_size(commits) + 1);
+
+	result = lookup_commit_reference_gently(the_repository, &oid, 1);
+	if (result)
+		oidset_insert(commits, &result->object.oid);
+	else {
+		error(_("invalid commit object id: %s"), hash);
+		return 1;
+	}
 	return 0;
 }
 
@@ -159,6 +170,7 @@ static int graph_write(int argc, const char **argv)
 	struct object_directory *odb = NULL;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
+	struct progress *progress = NULL;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -228,18 +240,25 @@ static int graph_write(int argc, const char **argv)
 		if (opts.stdin_commits) {
 			oidset_init(&commits, 0);
 			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
+			if (opts.progress)
+				progress = start_delayed_progress(
+					_("Analyzing commits from stdin"), 0);
 		}
 
 		while (strbuf_getline(&buf, stdin) != EOF) {
 			char *line = strbuf_detach(&buf, NULL);
 			if (opts.stdin_commits) {
-				int result = read_one_commit(&commits, line);
+				int result = read_one_commit(&commits, progress,
+							     line);
 				if (result)
 					return result;
 			} else
 				string_list_append(&pack_indexes, line);
 		}
 
+		if (progress)
+			stop_progress(&progress);
+
 		UNLEAK(buf);
 	}
 
-- 
2.26.0.113.ge9739cdccc

