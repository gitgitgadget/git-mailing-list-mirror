Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B753820ABE
	for <e@80x24.org>; Sat, 21 Jan 2017 01:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbdAUBIg (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 20:08:36 -0500
Received: from 89-28-117-31.starnet.md ([89.28.117.31]:54122 "EHLO
        home.thecybershadow.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdAUBIg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 20:08:36 -0500
Received: by home.thecybershadow.net (Postfix, from userid 1000)
        id E4B9F55BDF3; Sat, 21 Jan 2017 01:08:32 +0000 (UTC)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     git@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH v2 4/4] show-ref: Inline show_one
Date:   Sat, 21 Jan 2017 01:08:21 +0000
Message-Id: <20170121010821.25046-5-git@thecybershadow.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170121010821.25046-1-git@thecybershadow.net>
References: <20170121010821.25046-1-git@thecybershadow.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the small function is now only called from a single place, there is
no point in keeping it as a separate function any longer.

Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
---
 builtin/show-ref.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 3cf344d47..ec44164d8 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -17,15 +17,6 @@ static int deref_tags, show_head, tags_only, heads_only, found_match, verify,
 static const char **pattern;
 static const char *exclude_existing_arg;
 
-static void show_one(const char *refname, const struct object_id *oid)
-{
-	const char *hex = find_unique_abbrev(oid->hash, abbrev);
-	if (hash_only)
-		printf("%s\n", hex);
-	else
-		printf("%s %s\n", hex, refname);
-}
-
 static int show_ref(const char *refname, const struct object_id *oid,
 		    int flag, void *cbdata)
 {
@@ -74,7 +65,11 @@ static int show_ref(const char *refname, const struct object_id *oid,
 	if (quiet)
 		return 0;
 
-	show_one(refname, oid);
+	hex = find_unique_abbrev(oid->hash, abbrev);
+	if (hash_only)
+		printf("%s\n", hex);
+	else
+		printf("%s %s\n", hex, refname);
 
 	if (!deref_tags)
 		return 0;
-- 
2.11.0

