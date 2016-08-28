Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 590731F859
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756234AbcH1X2c (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:32 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41092 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932313AbcH1X2J (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4A905280B5;
        Sun, 28 Aug 2016 23:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426886;
        bh=RtJCn2NFBzs7ZHk2sb9S7fFqyvJNmIRdKJrOl7pmm/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bL0qyuHgjpvBYYpkAL61FTo4Q8EZMOM9+2sFJ1KMDurqudxL/hw2nnhbhf4DS3vEC
         UTxbwcwsv7uouPamh4oFEBOztF7p7Y4SRCTxXB/7GAKJCq49g9H51YWNIEKeWt7iW9
         dnXr+Uta7IOTUvnF2VJlWWrDaZdxwYqkLMofCtJ8BqZAjmIrbHtr8yjvkS6qIGnAC+
         Yhr+zSotEvy+zr9BaSg980X6/vcptNo7+4x14tUZHob7fSPfrlE0eS/v09GVY6rx2J
         Sjhwn5f4OWJiTj7KotgycviaaPAxSCJKV/+raY/F6yBVZQtOrpJcNEPI7nH6U/Bubo
         Y9bU3NmpFrmkTroNOfly/MTGAYYCeC6XfVwO+//9BccB8XWu9s9bEGGxonpMrnPEyR
         pU6KPRs1BUwYf6yVLrQMXM9kH5avDs4HSTFtKayEDAWUM1DzYEoOhBji/i16NZ9kDr
         IUj7NpXqq7YdlxyA2FjIcvEhbC6IkGbPaPeQN5aOzNfLNdd5NvK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 16/20] sha1_name: convert get_sha1_mb to struct object_id
Date:   Sun, 28 Aug 2016 23:27:53 +0000
Message-Id: <20160828232757.373278-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
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
