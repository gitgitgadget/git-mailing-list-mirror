Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF30BC433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77AA20659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="pHE2g7kF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgEMV7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730305AbgEMV7o (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 17:59:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0808C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so350657pfa.1
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Xnh57gtXU6qWJCRXSH0eKqYk+pRXQDAd/dMfhHrjLI=;
        b=pHE2g7kF+VqxvxWkZANeJAWOZnPvLbSfSOzNk3uOE9K/jxR5gLyaYhf1lnEIlvguz2
         KuvJdJS4kb07FxiPUjZsV+N986aQn4Lxco7+b1dRXOLvlDoLE/rMVRETvDc0jD8BeluF
         bU2wW4ZEXiYJgvd68owl3JrbAxGIwhyGzfugACEQH0He1s5w+CPaHvBStcYWGZ7QvCkq
         bVrrdou8h2HdL0gdFiKdGuGkoSEEql3KAuCBhVh5l+KPWqMuJG5vzFFgqoNA5Lo+y2P2
         XeuhVesam/SbPTkgF8iRhFdhQKT0kX4uE1kwd9mB/dBtjzldb/+bauJJaEn0nZyrOObe
         gotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Xnh57gtXU6qWJCRXSH0eKqYk+pRXQDAd/dMfhHrjLI=;
        b=I93xvY0tNmwJGF8veYo9kvZWi0R8Y5wu+nc29m7tVuNBpULNI+hbUN1qXOZ0q/3OUw
         l5fC2rDSRecxTcF6W+vjB3499AY7Zr+C5sPdk6brVDmVKPmK6SDUgpesBjFuQU7Lz39c
         ep/erEfDX2U7ltjUNrND/smK7aNuuI9tlEnUdfOUWS5gLLKaXdE5NXaQs/2wW5QMik5L
         17GJIvp9cPAq2i6y/N1K3SgYe8TPwFCH2BkLxSWWdSAJ5sINxUGudQyrvabvDe4PiArx
         ad8PxDGZqJyW3+7es7FmQFUIVZv81R9sjw+w+btRBcr66GOlHjtB8NCgJF3Rnc8fKbGj
         QLLQ==
X-Gm-Message-State: AOAM530r4wIbttYJkbc9q1NXnbHbBgcwsDTpGN0Dy/a0AGSs7VoBJh6M
        YsmaREiPgaig60aGlj+d+PJQlaZr6o4=
X-Google-Smtp-Source: ABdhPJx9zZOOjka5caJ0ZSYB2GQtNFt5YeNrNbvTl1Lxybe6N4pyyDmmJWVUAF2tY/dCpxxH2X+8EQ==
X-Received: by 2002:aa7:95b2:: with SMTP id a18mr1362709pfk.91.1589407182986;
        Wed, 13 May 2020 14:59:42 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z66sm449640pfz.141.2020.05.13.14.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:59:42 -0700 (PDT)
Date:   Wed, 13 May 2020 15:59:41 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 4/8] builtin/commit-graph.c: extract 'read_one_commit()'
Message-ID: <c37e94907b140f3d2e5a44293f2c1faa6d473712.1589407014.git.me@ttaylorr.com>
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

With either '--stdin-commits' or '--stdin-packs', the commit-graph
builtin will read line-delimited input, and interpret it either as a
series of commit OIDs, or pack names.

In a subsequent commit, we will begin handling '--stdin-commits'
differently by processing each line as it comes in, instead of in one
shot at the end. To make adequate room for this additional logic, split
the '--stdin-commits' case from '--stdin-packs' by only storing the
input when '--stdin-packs' is given.

In the case of '--stdin-commits', feed each line to a new
'read_one_commit' helper, which (for now) will merely call
'parse_oid_hex'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c | 56 ++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 15fe60317c..f6647449ed 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -138,12 +138,23 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int read_one_commit(struct oidset *commits, const char *hash)
+{
+	struct object_id oid;
+	const char *end;
+
+	if (parse_oid_hex(hash, &oid, &end))
+		return error(_("unexpected non-hex object ID: %s"), hash);
+
+	oidset_insert(commits, &oid);
+	return 0;
+}
+
 static int graph_write(int argc, const char **argv)
 {
-	struct string_list *pack_indexes = NULL;
+	struct string_list pack_indexes;
 	struct oidset commits = OIDSET_INIT;
 	struct object_directory *odb = NULL;
-	struct string_list lines;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
 
@@ -209,44 +220,35 @@ static int graph_write(int argc, const char **argv)
 		return 0;
 	}
 
-	string_list_init(&lines, 0);
-	if (opts.stdin_packs || opts.stdin_commits) {
-		struct strbuf buf = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	if (opts.stdin_packs) {
+		string_list_init(&pack_indexes, 0);
 
 		while (strbuf_getline(&buf, stdin) != EOF)
-			string_list_append(&lines, strbuf_detach(&buf, NULL));
+			string_list_append(&pack_indexes,
+					   strbuf_detach(&buf, NULL));
+	} else if (opts.stdin_commits) {
+		oidset_init(&commits, 0);
+		flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
 
-		if (opts.stdin_packs)
-			pack_indexes = &lines;
-		if (opts.stdin_commits) {
-			struct string_list_item *item;
-			oidset_init(&commits, lines.nr);
-			for_each_string_list_item(item, &lines) {
-				struct object_id oid;
-				const char *end;
-
-				if (parse_oid_hex(item->string, &oid, &end)) {
-					error(_("unexpected non-hex object ID: "
-						"%s"), item->string);
-					return 1;
-				}
-
-				oidset_insert(&commits, &oid);
+		while (strbuf_getline(&buf, stdin) != EOF) {
+			if (read_one_commit(&commits, buf.buf)) {
+				result = 1;
+				goto cleanup;
 			}
-			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
 		}
-
-		UNLEAK(buf);
 	}
 
 	if (write_commit_graph(odb,
-			       pack_indexes,
+			       opts.stdin_packs ? &pack_indexes : NULL,
 			       opts.stdin_commits ? &commits : NULL,
 			       flags,
 			       &split_opts))
 		result = 1;
 
-	UNLEAK(lines);
+cleanup:
+	UNLEAK(pack_indexes);
+	strbuf_release(&buf);
 	return result;
 }
 
-- 
2.26.0.113.ge9739cdccc

