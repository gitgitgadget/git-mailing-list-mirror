Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3464F20705
	for <e@80x24.org>; Mon,  5 Sep 2016 20:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964926AbcIEUJw (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 16:09:52 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:43008 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964902AbcIEUIa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 16:08:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A1623280A7;
        Mon,  5 Sep 2016 20:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473106109;
        bh=RtJCn2NFBzs7ZHk2sb9S7fFqyvJNmIRdKJrOl7pmm/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yrcONvvkbrDVBJCL7NbXytBvGLmdaUbAGlnHa2ESL8WkiWHxXGuS7xjottPKJBCDr
         ddvtWUF8i6cF1rnSoAl/xnNBhY/8CLRcYwTF4M+Lo1T7rHI8cRoSz+0etyskIufS8Z
         62qQZbYvZuVXXVG7RON5EHczgzgHJ/VkaC/LS6Yn8OkZmgCpLhN7gmaw7A/qgZi18w
         aDzRrROFOgwhM4atIgo1sYyXVaxsq6qjkl5ucg3wNBprC1m3OfhbejKx++hgEeFR5D
         6e+axaXa9btx97jmnYEBf7qGVpKZOmYBAAexOQDg2wdbIvOZLHPHLjtJZr2jXN2Vfr
         0APUuVna0NcUS377Qs1575BU+fhNkOezH54xSTnlop9EHpD8FTmcSMjQ6U5LVHRiHN
         dxbfSyNmMbHTZsRVC0Z8DnKlTRbeT4FlkAD2jPQ4xJTTUX1dxuUMSZl9+u5qvhPNyX
         rRZN9fwxPjqZDUoQyyp9OD1xTjeemd3M0IXtuxMUj2Cpgt40c2v
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2 16/20] sha1_name: convert get_sha1_mb to struct object_id
Date:   Mon,  5 Sep 2016 20:08:07 +0000
Message-Id: <20160905200811.697889-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160905200811.697889-1-sandals@crustytoothpaste.net>
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the callers of this function use struct object_id, so rename it
to get_oid_mb and make it take struct object_id instead of
unsigned char *.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/checkout.c |  2 +-
 cache.h            |  2 +-
 sha1_name.c        | 18 +++++++++---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 13169221..8013a1b8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -973,7 +973,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
 
-	if (get_sha1_mb(arg, rev->hash)) {
+	if (get_oid_mb(arg, rev)) {
 		/*
 		 * Either case (3) or (4), with <something> not being
 		 * a commit, or an attempt to use case (1) with an
diff --git a/cache.h b/cache.h
index a679484e..e40165d1 100644
--- a/cache.h
+++ b/cache.h
@@ -1204,7 +1204,7 @@ extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
 
 extern int interpret_branch_name(const char *str, int len, struct strbuf *);
-extern int get_sha1_mb(const char *str, unsigned char *sha1);
+extern int get_oid_mb(const char *str, struct object_id *oid);
 
 extern int validate_headref(const char *ref);
 
diff --git a/sha1_name.c b/sha1_name.c
index e4404391..faf873cf 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -995,35 +995,35 @@ static int interpret_nth_prior_checkout(const char *name, int namelen,
 	return retval;
 }
 
-int get_sha1_mb(const char *name, unsigned char *sha1)
+int get_oid_mb(const char *name, struct object_id *oid)
 {
 	struct commit *one, *two;
 	struct commit_list *mbs;
-	unsigned char sha1_tmp[20];
+	struct object_id oid_tmp;
 	const char *dots;
 	int st;
 
 	dots = strstr(name, "...");
 	if (!dots)
-		return get_sha1(name, sha1);
+		return get_oid(name, oid);
 	if (dots == name)
-		st = get_sha1("HEAD", sha1_tmp);
+		st = get_oid("HEAD", &oid_tmp);
 	else {
 		struct strbuf sb;
 		strbuf_init(&sb, dots - name);
 		strbuf_add(&sb, name, dots - name);
-		st = get_sha1_committish(sb.buf, sha1_tmp);
+		st = get_sha1_committish(sb.buf, oid_tmp.hash);
 		strbuf_release(&sb);
 	}
 	if (st)
 		return st;
-	one = lookup_commit_reference_gently(sha1_tmp, 0);
+	one = lookup_commit_reference_gently(oid_tmp.hash, 0);
 	if (!one)
 		return -1;
 
-	if (get_sha1_committish(dots[3] ? (dots + 3) : "HEAD", sha1_tmp))
+	if (get_sha1_committish(dots[3] ? (dots + 3) : "HEAD", oid_tmp.hash))
 		return -1;
-	two = lookup_commit_reference_gently(sha1_tmp, 0);
+	two = lookup_commit_reference_gently(oid_tmp.hash, 0);
 	if (!two)
 		return -1;
 	mbs = get_merge_bases(one, two);
@@ -1031,7 +1031,7 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 		st = -1;
 	else {
 		st = 0;
-		hashcpy(sha1, mbs->item->object.oid.hash);
+		oidcpy(oid, &mbs->item->object.oid);
 	}
 	free_commit_list(mbs);
 	return st;
