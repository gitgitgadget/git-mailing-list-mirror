Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E20B1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030266AbeF2BX3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:29 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:35520 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030241AbeF2BX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:26 -0400
Received: by mail-qk0-f201.google.com with SMTP id c3-v6so8021445qkb.2
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=xLiWNHr/nm85Zl8pIXjKeGXUZmTFkcZ6BCCnpRW88vA=;
        b=JDbD22QaDTpJYWCnILAyLL4UJ2bj44E/Y3qlTKZRfjl+r/G6DHa2sv1GvXBW5Qsywy
         sIysQ7eJD2A/O9au8p6j4iuKeWdbpUYKat4ZMapXNSKHhDKOyrnumSZPY7gS5ddPgub2
         wLOqykOx8cfRc3MiGHaQzO1numiwABhBCHlTNaU1AA/C1aBGrTgpwVi59bmIGUcke1DM
         U9jxoL0kvgOER7AAG5LcWnwtlfcXe6+rb5h+AAgq0qb4AKGvA3xR5I/fT3FOLtRD+KeJ
         wdzMSoLblywCSxUKSEIB/t8UjaOqM0vlRB/IPkf842YzI88HQyiLaat29glKwm6BzmRs
         yQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=xLiWNHr/nm85Zl8pIXjKeGXUZmTFkcZ6BCCnpRW88vA=;
        b=Gs1OsbunKhFoVDEs4vdTojzE2Vxmh/QcQs+yS/8gjTi61rJG2JE6viEQUntmsA4cCI
         5I5B9qJiPVhR2Biz3HV4yE2BgYhS4F2fGenCtRkwUzThcwOf+hj6fHDHK3LBqTyA1O4j
         yDQy1PLLXcBtVDP6032bu6Wq6j+5ExmbW1FidSSM4ADDBVVRgSmB1mEq+yVO5raTSB3v
         z5M4UCz9p7GenTtf0l1MXT9nHH76ldrHsR1kL92Hd1EVKYnLNY+0pGidDpZFkupu+Mcc
         d/0YmwHIzjZF1Sfgf0CPdw0U+rFhMisCVJx1RlAuQN5PRkM44PNK0Ils78DfBMOFTeuZ
         HUdg==
X-Gm-Message-State: APt69E2Oyw2R9dko/58rP0s1Scyhi/Dftb1VF9kxgq7KcEFXVTWNcjmQ
        DBCsahKWLHzY3WoBJQ4Xlq4/ItZX6yQuAkQMgKYqTv91MJYhuU7RTVFA/I5uj7uScLJMZ/toJZa
        M8s7MQ9Deztc8/rTmVwrtBmspfO4VHEi7R8Lat2IvYKzg5evVjq23j8dojGLk
X-Google-Smtp-Source: AAOMgpeputiaS7Gd5haSq+L7heAlHgdqFGwIVPvJXol3rWPeKcGASpXlAG02JX+CcAQvz3TZxunUh4kF9eNx
MIME-Version: 1.0
X-Received: by 2002:ac8:1e86:: with SMTP id c6-v6mr6572847qtm.53.1530235405589;
 Thu, 28 Jun 2018 18:23:25 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:13 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-24-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 23/32] commit.c: allow parse_commit_buffer to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
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
index 8749e151451..41d23352098 100644
--- a/commit.c
+++ b/commit.c
@@ -364,7 +364,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size, int check_graph)
+int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size, int check_graph)
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
@@ -384,11 +384,11 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 	if (get_oid_hex(bufptr + 5, &parent) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->maybe_tree = lookup_tree(the_repository, &parent);
+	item->maybe_tree = lookup_tree(r, &parent);
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
-	graft = lookup_commit_graft(the_repository, &item->object.oid);
+	graft = lookup_commit_graft(r, &item->object.oid);
 	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
@@ -403,7 +403,7 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 		 */
 		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
-		new_parent = lookup_commit(the_repository, &parent);
+		new_parent = lookup_commit(r, &parent);
 		if (new_parent)
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
@@ -411,7 +411,7 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 		int i;
 		struct commit *new_parent;
 		for (i = 0; i < graft->nr_parent; i++) {
-			new_parent = lookup_commit(the_repository,
+			new_parent = lookup_commit(r,
 						   &graft->parent[i]);
 			if (!new_parent)
 				continue;
diff --git a/commit.h b/commit.h
index 27888d82468..e9cb5aaaae9 100644
--- a/commit.h
+++ b/commit.h
@@ -81,8 +81,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
-#define parse_commit_buffer(r, i, b, s, g) parse_commit_buffer_##r(i, b, s, g)
-int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size, int check_graph);
+int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size, int check_graph);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
-- 
2.18.0.399.gad0ab374a1-goog

