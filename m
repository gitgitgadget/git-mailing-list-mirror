Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF4520248
	for <e@80x24.org>; Fri,  1 Mar 2019 17:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389546AbfCARuo (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 12:50:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34198 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCARun (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 12:50:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so26816116wrg.1
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 09:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cr30SaUaC/WnlTNamd7dxiUXhnMVGmG9Br79AwTUbgA=;
        b=hIa/c6VeQ/0QjXHqQgdZcPK61XdLIjJV9/Q10bDKQ4iOpuQMcBGWYiPdlsLjqyr+VF
         XNOucSRm1BfzVt7njNxvXpiaPnuWgW4t2bsiUnNtKSDgy/QypLt9mFd4SxyLqDL21YcA
         Wu0cf+wVKX/iOlD5o/O2RmpItrH4Iz3AAlHXw8mLpnZspc48pU8XKpu3iOMtHaIHCO93
         0leSr4yZcKBPVDJ2OpCcnXpY7fKR5T4u67qzW6mVI1wZNJxh6VcY1JsIvGTSl2yWfP+A
         T5rvWodkW6CyQemxja43j1oyZvaY9mINZvNWgaNMb/WMJp/gB+bytI7/eDwPNlO+Qqmb
         SuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cr30SaUaC/WnlTNamd7dxiUXhnMVGmG9Br79AwTUbgA=;
        b=F7HmUMEWHAF1nAuShtgWxNFOBgOVH1N2Ci+SyEl01X94hP/eK05fJx8YBj6y2+A41a
         /trjTBHj5QEzMI1x+WkAoHoFQhhAw1hnnI6yTnp379VHwcs9t7sWKJ28mQla5zbWK1UD
         lLeqF0qlyReBkpFsD7CXg1eeY60mYhvGq6EWTcO227YGQs7QwubUmsfJWGkqRmPCPByc
         WnR5LRPOM/HFUOHWdZwmjjOQrMv2Vs9HD3pIrhNjOSMHMyJKMhvFzapW9uX0/9jJD59V
         2G6cKPKbSAHmLpH8ajZPMjZEBsKajFU0+zPJlw8ZNyJdXgjIXFGjSn3H2Of/jnaVKuuZ
         T30w==
X-Gm-Message-State: APjAAAXCKFM5Kpqx9kKcDzfRXX71dX8meLr5Y+EaPqMIxOQyM+zuFl/r
        Yfa/DtuFXSuXdunn/eIOIKAZ11yx
X-Google-Smtp-Source: APXvYqzHyrO1nGNVACvhvGczZMJt2wDYYurWGZhXXb1z/KgaEoc3ZRtryl0oN4eAPE2JO9N+1HJQnA==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr4490070wrx.203.1551462641801;
        Fri, 01 Mar 2019 09:50:41 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-112-206.w86-199.abo.wanadoo.fr. [86.199.35.206])
        by smtp.googlemail.com with ESMTPSA id o8sm11672247wma.1.2019.03.01.09.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 09:50:41 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 3/4] name-rev: check if a commit should be named before naming it
Date:   Fri,  1 Mar 2019 18:50:23 +0100
Message-Id: <20190301175024.17337-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301175024.17337-1-alban.gruin@gmail.com>
References: <20190301175024.17337-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Until now, name_rev() named every commit it found, even it the name
would ultimately be unused.

This makes name_rev() take a commit_list and check if the commit it wants
to name is part of the list.  If it is, the commit is named, and
name_rev() signals to its caller that the name should not be freed.  If
it is not, the commit is left unnamed.  In this case, the name can still
be used by the first descendant of this commit (or one of its descendants).

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/name-rev.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 0719a9388d..2f89ed50a1 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -80,7 +80,7 @@ static int is_better_name(struct rev_name *name,
 static int name_rev(struct commit *commit,
 		const char *tip_name, timestamp_t taggerdate,
 		int generation, int distance, int from_tag,
-		int deref)
+		int deref, struct commit_list *commits)
 {
 	struct rev_name *name = get_commit_rev_name(commit);
 	struct commit_list *parents;
@@ -107,12 +107,18 @@ static int name_rev(struct commit *commit,
 	} else if (is_better_name(name, tip_name, taggerdate,
 				  generation, distance, from_tag)) {
 copy_data:
-		name->tip_name = tip_name;
+		if (commit_list_contains(commits, commit) ||
+		    commit_list_count(commits) == 0) {
+			name->tip_name = tip_name;
+			free_alloc = 0;
+		} else {
+			name->tip_name = NULL;
+		}
+
 		name->taggerdate = taggerdate;
 		name->generation = generation;
 		name->distance = distance;
 		name->from_tag = from_tag;
-		free_alloc = 0;
 	} else {
 		free(to_free);
 		return 1;
@@ -135,12 +141,12 @@ static int name_rev(struct commit *commit,
 
 			if (name_rev(parents->item, new_name, taggerdate, 0,
 				      distance + MERGE_TRAVERSAL_WEIGHT,
-				      from_tag, 0))
+				      from_tag, 0, commits))
 				free(new_name);
 		} else {
 			free_alloc &= name_rev(parents->item, tip_name, taggerdate,
 					       generation + 1, distance + 1,
-					       from_tag, 0);
+					       from_tag, 0, commits);
 		}
 	}
 
@@ -279,7 +285,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 			taggerdate = ((struct commit *)o)->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
 		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
-			 from_tag, deref);
+			 from_tag, deref, NULL);
 	}
 	return 0;
 }
-- 
2.20.1

