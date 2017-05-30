Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBDBE2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbdE3Rcv (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:51 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34460 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdE3Rbm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:42 -0400
Received: by mail-pf0-f173.google.com with SMTP id 9so78320762pfj.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mpSKezxUmQoEhA1UbBZj6KhK5rt96pU3DQEOB8j4VKc=;
        b=ipQiyWMIipcUxmNCWBksrqR0J5PPmlQCmdmqcpTWySweyQZ6B397jnB2UamihMMGB7
         h9R+LfTyBAA74Ih+AtWVD3o4PSakv/gi4AfyCoNzkoCXkIcGERPBHi4sqzXJNfxo7Nw3
         f7TmVnxPiMROfIF5A6+FTX83mRN12f8gw9AzMf1zC6UDOg3XskRQy7rxvfMgNMWKf/7N
         66wzHhL7Ov1bfbb/nPkwb/b/0aWp1A5oq6zTAkHUYCNm2meFBI1GKf+qGlcdfSrCZa7w
         k0mzAm7akR8CuVd/Uja6ciKrJRIFZon/ctSg+ZjGk+RwEjcij05BkzHgj8QkB5OwfcxI
         WMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mpSKezxUmQoEhA1UbBZj6KhK5rt96pU3DQEOB8j4VKc=;
        b=lgObxajZAXTwfKWX7JJPNQRnEGGX8c2+xEIY4x8fH0ArxjLn7pSmLA4vLhxbubOncG
         Q/cyWNmW8C5enhCjcSNi6yfMbZXQxT9rHZOT97scbjTxisrt8q+KReeVcHdL++NeKh06
         uR7RStb/YqDw60PiVJPTL2Pp8/KgVD2zIADyBT6BVCAx21Yws91Ejp9RQlrnYg0h+KJu
         N0AVU8hJIhnd89nB9r15VwNoe93pG/JN9K0wCyxTtejVDEvTUFwIJxhtPz9Or+/M1zLH
         7+872Yn78uAc46wsFRfgbmDq4oGw9n7464IR7rFvqTIiiWPuOfvJcah1R7SUw+cORBdp
         Ixdw==
X-Gm-Message-State: AODbwcC0TGRyzmkn2E9/bdHrpGO29KIGiJD8l2AcGJJECzhdBu8up89c
        umUTIE8Q4oUMHI1b
X-Received: by 10.84.213.8 with SMTP id f8mr44014233pli.22.1496165491459;
        Tue, 30 May 2017 10:31:31 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 11/33] diff: convert diff_addremove to struct object_id
Date:   Tue, 30 May 2017 10:30:47 -0700
Message-Id: <20170530173109.54904-12-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert diff_addremove to take a struct object_id.  In addtion convert
the function pointer type 'add_remove_fn_t' to also take a struct
object_id.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff-lib.c  | 6 +++---
 diff.c      | 8 ++++----
 diff.h      | 8 ++++----
 revision.c  | 4 ++--
 tree-diff.c | 8 ++++----
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 2c838aaf4..7984ff962 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -210,14 +210,14 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 					continue;
 				}
 				diff_addremove(&revs->diffopt, '-', ce->ce_mode,
-					       ce->oid.hash,
+					       &ce->oid,
 					       !is_null_oid(&ce->oid),
 					       ce->name, 0);
 				continue;
 			} else if (revs->diffopt.ita_invisible_in_index &&
 				   ce_intent_to_add(ce)) {
 				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
-					       EMPTY_BLOB_SHA1_BIN, 0,
+					       &empty_tree_oid, 0,
 					       ce->name, 0);
 				continue;
 			}
@@ -260,7 +260,7 @@ static void diff_index_show_file(struct rev_info *revs,
 				 unsigned dirty_submodule)
 {
 	diff_addremove(&revs->diffopt, prefix[0], mode,
-		       oid->hash, oid_valid, ce->name, dirty_submodule);
+		       oid, oid_valid, ce->name, dirty_submodule);
 }
 
 static int get_stat_data(const struct cache_entry *ce,
diff --git a/diff.c b/diff.c
index f3546536b..3fa335f44 100644
--- a/diff.c
+++ b/diff.c
@@ -5081,8 +5081,8 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
 
 void diff_addremove(struct diff_options *options,
 		    int addremove, unsigned mode,
-		    const unsigned char *sha1,
-		    int sha1_valid,
+		    const struct object_id *oid,
+		    int oid_valid,
 		    const char *concatpath, unsigned dirty_submodule)
 {
 	struct diff_filespec *one, *two;
@@ -5114,9 +5114,9 @@ void diff_addremove(struct diff_options *options,
 	two = alloc_filespec(concatpath);
 
 	if (addremove != '+')
-		fill_filespec(one, sha1, sha1_valid, mode);
+		fill_filespec(one, oid->hash, oid_valid, mode);
 	if (addremove != '-') {
-		fill_filespec(two, sha1, sha1_valid, mode);
+		fill_filespec(two, oid->hash, oid_valid, mode);
 		two->dirty_submodule = dirty_submodule;
 	}
 
diff --git a/diff.h b/diff.h
index d75e6d15e..1086975a5 100644
--- a/diff.h
+++ b/diff.h
@@ -31,8 +31,8 @@ typedef void (*change_fn_t)(struct diff_options *options,
 
 typedef void (*add_remove_fn_t)(struct diff_options *options,
 		    int addremove, unsigned mode,
-		    const unsigned char *sha1,
-		    int sha1_valid,
+		    const struct object_id *oid,
+		    int oid_valid,
 		    const char *fullpath, unsigned dirty_submodule);
 
 typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
@@ -247,8 +247,8 @@ extern int diff_can_quit_early(struct diff_options *);
 extern void diff_addremove(struct diff_options *,
 			   int addremove,
 			   unsigned mode,
-			   const unsigned char *sha1,
-			   int sha1_valid,
+			   const struct object_id *oid,
+			   int oid_valid,
 			   const char *fullpath, unsigned dirty_submodule);
 
 extern void diff_change(struct diff_options *,
diff --git a/revision.c b/revision.c
index 475d5b2dc..71519193c 100644
--- a/revision.c
+++ b/revision.c
@@ -401,8 +401,8 @@ static int tree_difference = REV_TREE_SAME;
 
 static void file_add_remove(struct diff_options *options,
 		    int addremove, unsigned mode,
-		    const unsigned char *sha1,
-		    int sha1_valid,
+		    const struct object_id *oid,
+		    int oid_valid,
 		    const char *fullpath, unsigned dirty_submodule)
 {
 	int diff = addremove == '+' ? REV_TREE_NEW : REV_TREE_OLD;
diff --git a/tree-diff.c b/tree-diff.c
index e164e532b..f2c747ea5 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -78,21 +78,21 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
 			1, 1, p->path, 0, 0);
 	}
 	else {
-		const unsigned char *sha1;
+		const struct object_id *oid;
 		unsigned int mode;
 		int addremove;
 
 		if (p->mode) {
 			addremove = '+';
-			sha1 = p->oid.hash;
+			oid = &p->oid;
 			mode = p->mode;
 		} else {
 			addremove = '-';
-			sha1 = p0->oid.hash;
+			oid = &p0->oid;
 			mode = p0->mode;
 		}
 
-		opt->add_remove(opt, addremove, mode, sha1, 1, p->path, 0);
+		opt->add_remove(opt, addremove, mode, oid, 1, p->path, 0);
 	}
 
 	return 0;	/* we are done with p */
-- 
2.13.0.219.gdb65acc882-goog

