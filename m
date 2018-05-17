Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC461F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeEQWwQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:16 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:46753 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeEQWwN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:13 -0400
Received: by mail-pl0-f44.google.com with SMTP id 30-v6so3380021pld.13
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x+z1SvmPeIit6pHWRN0tv0oXQYNNWeeYH9ACIQOBma0=;
        b=IE4iv2fUMUuiRPaoBkNQNMkHraUxsiHRFO/F3GRiRJMRYMnx30xaUxHTlHvLMTkBNc
         Yy7tbVmKLyX5cS98iRyn7cN4tT2A8jpktY++3HaYpna+4Tj6/H34SIFpYd9UXudh+e8m
         w0lo3m0CFfPVMXXMtLMiDlWN20US7n7xJnZXZo8DlarAnF5zVZTKrWz8YIamRKG2oBHc
         RXSIwziPdB3g+UfPC+yYfzG5NAl6EW5JPZ6JFo5gBWRa7d/kCYgyu+Gc+H+Ew7c4VEUX
         +eDx+y3fJvXkwQ1Ld8RVG+0DYsvQ+OnLxgh0CXNkHu43bgglfKK6/G/AyHsN8z1Nx7no
         /vNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x+z1SvmPeIit6pHWRN0tv0oXQYNNWeeYH9ACIQOBma0=;
        b=j/OdLWPb8UFM+4BNccRL5YsAnlDzDis0AV2HIxY4Q0Ov9I84X+CpgPHUa8KsKUm5W4
         ddndeIxUFIWppt6rn63e2+9SCMertem+gnovlTMzUout1QzT1Dyo7AelirlE2N7Q90if
         /gFSdsK3glpsC/Syaqpk5izzgkrThONVTNf4Ax9eJiIdk7D2ZapQgStZtg7FXR3wvb0P
         cx00vM/gewTLAh9cHEa1f8oI2sJfbWOXIHeddVAcxTThsPAgV1r2IdahS7XRFVyJNanS
         xK4FulEVt5tPKxjSDtR+AlWreVIM9jzRj++9vayXT3EL0atwFbFGTBJd7xuSnDUjYQuL
         cdCw==
X-Gm-Message-State: ALKqPwc/C5/JRmNWzbVc7XE/SFC5JFMYWXEe3NFoR4/w/XbcVCFChA9J
        yvKZdngXziB+AX6fwg83MBk/Kg==
X-Google-Smtp-Source: AB8JxZpg972xKVAnZaBZaBdUR2L9RQPoo55p6KsYIxb1ZxCjVwR0tYboSLXMCCF2ppX6/PoHQV1EKQ==
X-Received: by 2002:a17:902:b60a:: with SMTP id b10-v6mr6812246pls.221.1526597532534;
        Thu, 17 May 2018 15:52:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j14-v6sm8990810pfn.151.2018.05.17.15.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/19] object: move grafts to object parser
Date:   Thu, 17 May 2018 15:51:37 -0700
Message-Id: <20180517225154.9200-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Grafts are only meaningful in the context of a single repository.
Therefore they cannot be global.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 42 +++++++++++++++++++++++-------------------
 object.h |  4 ++++
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/commit.c b/commit.c
index b053f07f305..a0c9eb05c82 100644
--- a/commit.c
+++ b/commit.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tag.h"
 #include "commit.h"
+#include "repository.h"
 #include "object-store.h"
 #include "pkt-line.h"
 #include "utf8.h"
@@ -97,9 +98,6 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
 	return parse_timestamp(dateptr, NULL, 10);
 }
 
-static struct commit_graft **commit_graft;
-static int commit_graft_alloc, commit_graft_nr;
-
 static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 {
 	struct commit_graft **commit_graft_table = table;
@@ -108,7 +106,8 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 
 static int commit_graft_pos(const unsigned char *sha1)
 {
-	return sha1_pos(sha1, commit_graft, commit_graft_nr,
+	return sha1_pos(sha1, the_repository->parsed_objects->grafts,
+			the_repository->parsed_objects->grafts_nr,
 			commit_graft_sha1_access);
 }
 
@@ -120,18 +119,22 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 		if (ignore_dups)
 			free(graft);
 		else {
-			free(commit_graft[pos]);
-			commit_graft[pos] = graft;
+			free(the_repository->parsed_objects->grafts[pos]);
+			the_repository->parsed_objects->grafts[pos] = graft;
 		}
 		return 1;
 	}
 	pos = -pos - 1;
-	ALLOC_GROW(commit_graft, commit_graft_nr + 1, commit_graft_alloc);
-	commit_graft_nr++;
-	if (pos < commit_graft_nr)
-		MOVE_ARRAY(commit_graft + pos + 1, commit_graft + pos,
-			   commit_graft_nr - pos - 1);
-	commit_graft[pos] = graft;
+	ALLOC_GROW(the_repository->parsed_objects->grafts,
+		   the_repository->parsed_objects->grafts_nr + 1,
+		   the_repository->parsed_objects->grafts_alloc);
+	the_repository->parsed_objects->grafts_nr++;
+	if (pos < the_repository->parsed_objects->grafts_nr)
+		memmove(the_repository->parsed_objects->grafts + pos + 1,
+			the_repository->parsed_objects->grafts + pos,
+			(the_repository->parsed_objects->grafts_nr - pos - 1) *
+			sizeof(*the_repository->parsed_objects->grafts));
+	the_repository->parsed_objects->grafts[pos] = graft;
 	return 0;
 }
 
@@ -213,14 +216,14 @@ struct commit_graft *lookup_commit_graft(const struct object_id *oid)
 	pos = commit_graft_pos(oid->hash);
 	if (pos < 0)
 		return NULL;
-	return commit_graft[pos];
+	return the_repository->parsed_objects->grafts[pos];
 }
 
 int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
 {
 	int i, ret;
-	for (i = ret = 0; i < commit_graft_nr && !ret; i++)
-		ret = fn(commit_graft[i], cb_data);
+	for (i = ret = 0; i < the_repository->parsed_objects->grafts_nr && !ret; i++)
+		ret = fn(the_repository->parsed_objects->grafts[i], cb_data);
 	return ret;
 }
 
@@ -229,10 +232,11 @@ int unregister_shallow(const struct object_id *oid)
 	int pos = commit_graft_pos(oid->hash);
 	if (pos < 0)
 		return -1;
-	if (pos + 1 < commit_graft_nr)
-		MOVE_ARRAY(commit_graft + pos, commit_graft + pos + 1,
-			   commit_graft_nr - pos - 1);
-	commit_graft_nr--;
+	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
+		MOVE_ARRAY(the_repository->parsed_objects->grafts + pos,
+			   the_repository->parsed_objects->grafts + pos + 1,
+			   the_repository->parsed_objects->grafts_nr - pos - 1);
+	the_repository->parsed_objects->grafts_nr--;
 	return 0;
 }
 
diff --git a/object.h b/object.h
index 7916edb4edf..ec908f9bcc1 100644
--- a/object.h
+++ b/object.h
@@ -12,6 +12,10 @@ struct parsed_object_pool {
 	struct alloc_state *tag_state;
 	struct alloc_state *object_state;
 	unsigned commit_count;
+
+	/* parent substitutions from .git/info/grafts and .git/shallow */
+	struct commit_graft **grafts;
+	int grafts_alloc, grafts_nr;
 };
 
 struct parsed_object_pool *parsed_object_pool_new(void);
-- 
2.17.0.582.gccdcbd54c44.dirty

