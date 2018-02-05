Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925DD1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeBEX62 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:58:28 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37299 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeBEX6N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:58:13 -0500
Received: by mail-pl0-f65.google.com with SMTP id ay8so90296plb.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qdj3zsbh1AWYFd7nUpw5ZMAN1zuayHP4mcKQjblIIV0=;
        b=gz/hlW7e2PTfI+mDfb79EIjGStkzLiWzBAi7HRjv5A30I5Jmg+ZayZ5YLnQiJe5Dxx
         IoshH3V94XlJKNrwAeLGCRk9Hcr7v7RdvAzYZmsNirEHiFq9S713KQ0N+WO9gEL/1AYb
         YaEfsEYz38ypOU57yMHms1iNKxm6/iM+t82jD+9XXeAyTaCMqgppNw7v3WJ64lIfXvij
         XF4jkoQ013PM3GXD5cT8JJw450ereY5aUn8xobeSB4KJqa7opTwZOSuiSKw1zoVRN1Dn
         27Mfwf/PKRV6ylBnTNOJh0DLeSwZ0P7AllrNSW1PnRekLeqYRC13IPPXfL3F+gTrxoVo
         fNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qdj3zsbh1AWYFd7nUpw5ZMAN1zuayHP4mcKQjblIIV0=;
        b=J/7v/HG5XtwKYX8lxO0Xd9yLg6aboLbpoXjYPMvCqC0V8yr5XSdzK1CVm/U6iDhp+v
         gDcK7lly200PHUy3aVLVFhmAE37BtjQlE+7759rsdgjbhWta1HeYLqF4Wtl855qmSclu
         CiyagYM5cercJI8eNGbojS3h1YJ8XXlsvy8bHdFQenxA+LRboW/a9sX5r+rk1pA9eBn+
         YGODe7Oy6T2PrL8nBchZBUmFN2EckLrLlopsglGM9fPNIviaF8zlcvz1InvFc+2/WAtx
         GqJifsOME8eqGLUlkH+MMDpaub3Wnm1/RG6gsI4p5z8som0v7f1q07mfGxfV7bFj2aZ0
         7mnQ==
X-Gm-Message-State: APf1xPBXehKwxe6DOCW65URnVg1n5z75QutqS62FTuGFS4+14WXlpQTA
        a1xjWOYPOMPBJreUKmUJdi7/oPQ9oVU=
X-Google-Smtp-Source: AH8x2248qX1tc3tf8dtd9pY7HH/auevZwE07fzOUhRhKENIXMXUC/ACLbySgHlCsOxOGL/aEoWsexQ==
X-Received: by 2002:a17:902:6849:: with SMTP id f9-v6mr499527pln.113.1517875092185;
        Mon, 05 Feb 2018 15:58:12 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r24sm18735880pfg.51.2018.02.05.15.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:58:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 024/194] sha1_file: allow alt_odb_usable to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:45 -0800
Message-Id: <20180205235735.216710-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index af0bf57e07..c639c52f5f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -25,6 +25,7 @@
 #include "repository.h"
 #include "object-store.h"
 #include "streaming.h"
+#include "path.h"
 #include "dir.h"
 #include "mru.h"
 #include "list.h"
@@ -351,17 +352,18 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-#define alt_odb_usable(r, p, n) alt_odb_usable_##r(p, n)
-static int alt_odb_usable_the_repository(struct strbuf *path,
-					 const char *normalized_objdir)
+static int alt_odb_usable(struct repository *r, struct strbuf *path,
+			  const char *normalized_objdir)
 {
 	struct alternate_object_database *alt;
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path->buf)) {
-		error("object directory %s does not exist; "
-		      "check .git/objects/info/alternates.",
-		      path->buf);
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_repo_git_path(&sb, r, "objects/info/alternates");
+		error("object directory %s does not exist; check %s",
+		      path->buf, sb.buf);
+		strbuf_release(&sb);
 		return 0;
 	}
 
@@ -369,7 +371,7 @@ static int alt_odb_usable_the_repository(struct strbuf *path,
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
-- 
2.15.1.433.g936d1b9894.dirty

