Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382B81F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968433AbeE3AtQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:16 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:41766 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968558AbeE3AtA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:49:00 -0400
Received: by mail-pg0-f48.google.com with SMTP id d14-v6so7326196pgv.8
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ztz7I5/Yq8gRrwBbOaE7CVaWAwv2GOIBDb+Mwnl+3oc=;
        b=GbyTsswgH5t3bqD5oncrxhvb9I4qsFYMDEEdQ5UO4+IDdXyPtoHbp7vfqm3Zf3x6V7
         Cp9/a/5H62BkIFQUuCHkHLSTgBdD5Q4iEuoam+gGfLW3jYGYi6pdqq5LIC9Xkbf2Vykg
         NsmV4Z3iV/7GBs/EEJFPz7v7jWmx0/a5b0akhlxVESPiDGkacvFg+IOhUqoTfa0LagYG
         2cKE5XMzTN9TBj794OXvDPlbaTqhnt95Ap84MeK7CZLjhFyaN9+N5ipK4Wc58USUuCLq
         jA5xtAOYb3dAZGBHK3TzKHzd1kNXHOpvIDc2tIMKueR15kevYOnzRg0X2UaSv8r2iTAX
         ikyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ztz7I5/Yq8gRrwBbOaE7CVaWAwv2GOIBDb+Mwnl+3oc=;
        b=qVKbWPVTVrLarVOTpgSZY/pFzQ36ZTKFJmFyqcv9NmGosa+H1iULMlB041csT3OG9s
         W5pjiB9wSVzIwhT1CE8PfL2zaz6PB+I6VxAPB9yYDQCxATf18Gniuc6ug9x2cbn5pUT+
         5iIG3j9QNBLAF9NYX5fizTzD75u7+WMDHHaaPggshbsMvd7PyECE9QDD3OEwvmauw7Xh
         fQtcs5Vf51o0bJlxoStiBQwaMwLXCPZhglFOaskNZ1UdRxywb7xdaT8zPE3HWCpT8U/z
         TGa9OSNq3sotj8sO9IV20AswlTbmoYt4Fta8uX5t35OLrEimex6zu8N3NZBeL6OvRpM3
         9/sw==
X-Gm-Message-State: ALKqPwdMOHPybLrUQvKt9dM5vJPpQ8/3axSg/SQrNO6zg6QQYsgAZ3n4
        btJUUWTOJQPNse9bTF2GjNgh7L0TSJg=
X-Google-Smtp-Source: ADUXVKJKwboBGe7W/SkbzM3Wm8nwtHYjKN7kgU/Qx9WCC9/au7u7QoFZ3uHVzD6KrboGHumg/RB/Cg==
X-Received: by 2002:a63:b34e:: with SMTP id x14-v6mr471820pgt.243.1527641338745;
        Tue, 29 May 2018 17:48:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id o88-v6sm91304941pfa.29.2018.05.29.17.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 26/35] commit.c: allow parse_commit_buffer to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:48:01 -0700
Message-Id: <20180530004810.30076-27-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 10 +++++-----
 commit.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 492bccf10eb..fd31c453fdc 100644
--- a/commit.c
+++ b/commit.c
@@ -335,7 +335,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size)
+int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size)
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
@@ -355,11 +355,11 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->tree = lookup_tree(the_repository, &parent);
+	item->tree = lookup_tree(r, &parent);
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
-	graft = lookup_commit_graft(the_repository, &item->object.oid);
+	graft = lookup_commit_graft(r, &item->object.oid);
 	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
@@ -374,7 +374,7 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 		 */
 		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
-		new_parent = lookup_commit(the_repository, &parent);
+		new_parent = lookup_commit(r, &parent);
 		if (new_parent)
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
@@ -382,7 +382,7 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 		int i;
 		struct commit *new_parent;
 		for (i = 0; i < graft->nr_parent; i++) {
-			new_parent = lookup_commit(the_repository,
+			new_parent = lookup_commit(r,
 						   &graft->parent[i]);
 			if (!new_parent)
 				continue;
diff --git a/commit.h b/commit.h
index b96a57ad295..536fa03955f 100644
--- a/commit.h
+++ b/commit.h
@@ -71,8 +71,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
-#define parse_commit_buffer(r, i, b, s) parse_commit_buffer_##r(i, b, s)
-int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size);
+int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size);
 #define parse_commit_gently(r, i, q) parse_commit_gently_##r(i, q)
 int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing);
 #define parse_commit(r, i) parse_commit_##r(i)
-- 
2.17.0.582.gccdcbd54c44.dirty

