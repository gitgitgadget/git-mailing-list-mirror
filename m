Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE0620754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967068AbdADSFr (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:05:47 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35319 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbdADSET (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:19 -0500
Received: by mail-pg0-f49.google.com with SMTP id i5so164986551pgh.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F/81IPQl/C1aasOAzs1Lem6JxsSpsfEGsIyTW048ILw=;
        b=pI+4y/3Mkdyv+RJUE/8gPj7//MVGfFpDDJDkptiqHwF6m0T9luIfxhNSjvQ5k+x1S9
         k5pPEN8peMpiZox9bNwNZr/aq5OdgiY9VwZj+8BebiTEUW/B9FMci7orX1bZJ66qQj7b
         n46RfoaUf3crNrTKRGboobyFQQgf2buz0qJSsX0qQlclgwpWOihG8hAVY0O0He7G9OiF
         fGPFL/Er0FVhHrEAhnF+fuLTpYxQkPE5Raq2zzxISIdOY1QyxQlFqjJa51t1q/vuBf94
         uX59qutY3DK8QeU4o3X3dXCvZb4t0oDvPxhzVL21JNeWDvoDU48PheBblgmO3nHxJHLx
         /mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F/81IPQl/C1aasOAzs1Lem6JxsSpsfEGsIyTW048ILw=;
        b=XJeT9ZbsUnxBI/CvqQ1JHXhFG8tQFMEcl8Y/Ti+fsDeNGi/twgTFOBUYLmBn+5Q/xi
         7zPT8EQ/PWhgFtmtyZPKQ3Pb7bcvMrpeeCINBprb0fqtjAAJU9Bi0ZxFKdaNMEuSDR9t
         FQ5LyYT+q8P/TXPr1IwhYu1t+pMk1jeC2eklITyAA4PmPXZ9PKTio1s9Gd3U1PO2E64D
         HktBFzWcuU5lHnxRJGa2SM6iGWH/4Afa0U4vNH0pqodJYzObl5xm2SKdrwpR+D7B0eLN
         pecTBJdU/Yj3AgkeOFrjTBwqoUlEhVsq4oUuf0iczHa1Zle06krG/MHSIV9zZo5J4uo1
         VTTA==
X-Gm-Message-State: AIkVDXJS4gR5b+DhWqvpLfkPFBgWiGxQ/X/UJgVwos/0MejAaa0ahfvcOty7GW6NnGr3gh/1
X-Received: by 10.98.74.142 with SMTP id c14mr63469101pfj.139.1483553058432;
        Wed, 04 Jan 2017 10:04:18 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:17 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 00/16] pathspec cleanup
Date:   Wed,  4 Jan 2017 10:03:55 -0800
Message-Id: <20170104180411.150000-1-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v5:
* Move GUARD_PATHSPEC to prevent checking if pathspec is null twice.
* Mark a string containing 'mnemonic' for translation.

Brandon Williams (16):
  mv: remove use of deprecated 'get_pathspec()'
  dir: remove struct path_simplify
  dir: convert fill_directory to use the pathspec struct interface
  ls-tree: convert show_recursive to use the pathspec struct interface
  pathspec: remove the deprecated get_pathspec function
  pathspec: copy and free owned memory
  pathspec: remove unused variable from unsupported_magic
  pathspec: always show mnemonic and name in unsupported_magic
  pathspec: simpler logic to prefix original pathspec elements
  pathspec: factor global magic into its own function
  pathspec: create parse_short_magic function
  pathspec: create parse_long_magic function
  pathspec: create parse_element_magic helper
  pathspec: create strip submodule slash helpers
  pathspec: small readability changes
  pathspec: rename prefix_pathspec to init_pathspec_item

 Documentation/technical/api-setup.txt |   2 -
 builtin/ls-tree.c                     |  16 +-
 builtin/mv.c                          |  50 ++--
 cache.h                               |   1 -
 dir.c                                 | 191 ++++++--------
 pathspec.c                            | 480 +++++++++++++++++++---------------
 pathspec.h                            |   5 +-
 7 files changed, 388 insertions(+), 357 deletions(-)

--- interdiff between v4 and v5

diff --git a/dir.c b/dir.c
index e8ddd7f8a..bc5ff7216 100644
--- a/dir.c
+++ b/dir.c
@@ -1353,18 +1353,17 @@ static int simplify_away(const char *path, int pathlen,
 {
 	int i;
 
-	if (pathspec)
-		GUARD_PATHSPEC(pathspec,
-			       PATHSPEC_FROMTOP |
-			       PATHSPEC_MAXDEPTH |
-			       PATHSPEC_LITERAL |
-			       PATHSPEC_GLOB |
-			       PATHSPEC_ICASE |
-			       PATHSPEC_EXCLUDE);
-
 	if (!pathspec || !pathspec->nr)
 		return 0;
 
+	GUARD_PATHSPEC(pathspec,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_MAXDEPTH |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB |
+		       PATHSPEC_ICASE |
+		       PATHSPEC_EXCLUDE);
+
 	for (i = 0; i < pathspec->nr; i++) {
 		const struct pathspec_item *item = &pathspec->items[i];
 		int len = item->nowildcard_len;
@@ -1394,18 +1393,17 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
 {
 	int i;
 
-	if (pathspec)
-		GUARD_PATHSPEC(pathspec,
-			       PATHSPEC_FROMTOP |
-			       PATHSPEC_MAXDEPTH |
-			       PATHSPEC_LITERAL |
-			       PATHSPEC_GLOB |
-			       PATHSPEC_ICASE |
-			       PATHSPEC_EXCLUDE);
-
 	if (!pathspec || !pathspec->nr)
 		return 0;
 
+	GUARD_PATHSPEC(pathspec,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_MAXDEPTH |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB |
+		       PATHSPEC_ICASE |
+		       PATHSPEC_EXCLUDE);
+
 	for (i = 0; i < pathspec->nr; i++) {
 		const struct pathspec_item *item = &pathspec->items[i];
 		int len = item->nowildcard_len;
diff --git a/pathspec.c b/pathspec.c
index bcf3ba039..ff2509ddd 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -417,7 +417,7 @@ static void NORETURN unsupported_magic(const char *pattern,
 			strbuf_addstr(&sb, ", ");
 
 		if (m->mnemonic)
-			strbuf_addf(&sb, "'%s' (mnemonic: '%c')",
+			strbuf_addf(&sb, _("'%s' (mnemonic: '%c')"),
 				    m->name, m->mnemonic);
 		else
 			strbuf_addf(&sb, "'%s'", m->name);

-- 
2.11.0.390.gc69c2f50cf-goog

