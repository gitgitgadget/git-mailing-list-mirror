Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819292027C
	for <e@80x24.org>; Tue, 30 May 2017 17:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbdE3Rc5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:57 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36348 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdE3Rbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:35 -0400
Received: by mail-pf0-f171.google.com with SMTP id m17so78255350pfg.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KeqLFdw7fPpSf4sQQN6sAwPZDTOeAho/MBtezAq/vBE=;
        b=ObOkORg0y/8DtrhooshnRQdDmO9x05o/9WKaKkG/FjwN6rzLycwsPa/2I4ADgLMnCV
         b87ossAq+IRJKxic+kDMlxsR6Yk644UH5GaV6TAj0QR+93zb5k4m6iEMj9Cj217wAS/P
         2I0pspkY8HGbsPH8lW/iLkqTkGeI8mn7nf4IylsO99Mw8yniC7nFpyn2so1e0jPRpCYL
         Usus4KP3asN2g8F9S1bWa3PWpfwegVs3XOtjQSvvEyytjJ7INDLsqyBZ1uN8pM+IV3eW
         IIRk4ZIFBFKNoEw4yGjENlXuXVdQW6YeTxNlom6WiEQ6bGP39q03NS2jmzocARgNtC1g
         GDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KeqLFdw7fPpSf4sQQN6sAwPZDTOeAho/MBtezAq/vBE=;
        b=ivcid27u7m0ycHZzBEYVelBZITMV0aisp33yiJ6jt3S8EKS++mRzC0ErV5kgqOOQ1T
         rPLDhIZq2H1O2Fg6xynZUcdHk/cf5D7s/3qep1aWF4w35uwYlTFfoHhnmL41F5KeEq2/
         7Iz80k+54NXDfE6EfikaqEz4D4gIfUqATg78Tg1eSmFZazmaKtyjGr9RBpRqEZLsBaCm
         X7hH4debyZavf1F0R2wmVU6AKkJoBswCg7pgTSJopM3IR1rV0rD5/9cG10OqRkVN7cav
         TK9REFBSECb9UZ+lpdQBH+1FPgIxFDnO4GOWxIeJPSc7sdoOQto01UoP8E455vG+ljpH
         YrNA==
X-Gm-Message-State: AODbwcAzy1xsNFcHaraJj8bfKfk0PO+sqKlEm68efbs9d6+ArWO/m4sC
        TsMqi/Ju++FdldlBbAd0Pg==
X-Received: by 10.98.130.1 with SMTP id w1mr25241479pfd.128.1496165494172;
        Tue, 30 May 2017 10:31:34 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:33 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 13/33] diff: convert diff_change to struct object_id
Date:   Tue, 30 May 2017 10:30:49 -0700
Message-Id: <20170530173109.54904-14-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert diff_change to take a struct object_id.  In addition convert the
function pointer type 'change_fn_t' to also take a struct object_id.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff-lib.c  |  4 ++--
 diff.c      | 14 +++++++-------
 diff.h      | 13 ++++++-------
 revision.c  |  6 +++---
 tree-diff.c |  2 +-
 5 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index c82b07dc1..1e8215df5 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -236,7 +236,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		old_oid = &ce->oid;
 		new_oid = changed ? &null_oid : &ce->oid;
 		diff_change(&revs->diffopt, oldmode, newmode,
-			    old_oid->hash, new_oid->hash,
+			    old_oid, new_oid,
 			    !is_null_oid(old_oid),
 			    !is_null_oid(new_oid),
 			    ce->name, 0, dirty_submodule);
@@ -367,7 +367,7 @@ static int show_modified(struct rev_info *revs,
 		return 0;
 
 	diff_change(&revs->diffopt, oldmode, mode,
-		    old->oid.hash, oid->hash, 1, !is_null_oid(oid),
+		    &old->oid, oid, 1, !is_null_oid(oid),
 		    old->name, 0, dirty_submodule);
 	return 0;
 }
diff --git a/diff.c b/diff.c
index 3fa335f44..b9bb3f6ca 100644
--- a/diff.c
+++ b/diff.c
@@ -5127,9 +5127,9 @@ void diff_addremove(struct diff_options *options,
 
 void diff_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
-		 const unsigned char *old_sha1,
-		 const unsigned char *new_sha1,
-		 int old_sha1_valid, int new_sha1_valid,
+		 const struct object_id *old_oid,
+		 const struct object_id *new_oid,
+		 int old_oid_valid, int new_oid_valid,
 		 const char *concatpath,
 		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
 {
@@ -5142,8 +5142,8 @@ void diff_change(struct diff_options *options,
 
 	if (DIFF_OPT_TST(options, REVERSE_DIFF)) {
 		SWAP(old_mode, new_mode);
-		SWAP(old_sha1, new_sha1);
-		SWAP(old_sha1_valid, new_sha1_valid);
+		SWAP(old_oid, new_oid);
+		SWAP(old_oid_valid, new_oid_valid);
 		SWAP(old_dirty_submodule, new_dirty_submodule);
 	}
 
@@ -5153,8 +5153,8 @@ void diff_change(struct diff_options *options,
 
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
-	fill_filespec(one, old_sha1, old_sha1_valid, old_mode);
-	fill_filespec(two, new_sha1, new_sha1_valid, new_mode);
+	fill_filespec(one, old_oid->hash, old_oid_valid, old_mode);
+	fill_filespec(two, new_oid->hash, new_oid_valid, new_mode);
 	one->dirty_submodule = old_dirty_submodule;
 	two->dirty_submodule = new_dirty_submodule;
 	p = diff_queue(&diff_queued_diff, one, two);
diff --git a/diff.h b/diff.h
index 1086975a5..fcf334bb6 100644
--- a/diff.h
+++ b/diff.h
@@ -23,9 +23,9 @@ typedef int (*pathchange_fn_t)(struct diff_options *options,
 
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
-		 const unsigned char *old_sha1,
-		 const unsigned char *new_sha1,
-		 int old_sha1_valid, int new_sha1_valid,
+		 const struct object_id *old_oid,
+		 const struct object_id *new_oid,
+		 int old_oid_valid, int new_oid_valid,
 		 const char *fullpath,
 		 unsigned old_dirty_submodule, unsigned new_dirty_submodule);
 
@@ -253,10 +253,9 @@ extern void diff_addremove(struct diff_options *,
 
 extern void diff_change(struct diff_options *,
 			unsigned mode1, unsigned mode2,
-			const unsigned char *sha1,
-			const unsigned char *sha2,
-			int sha1_valid,
-			int sha2_valid,
+			const struct object_id *old_oid,
+			const struct object_id *new_oid,
+			int old_oid_valid, int new_oid_valid,
 			const char *fullpath,
 			unsigned dirty_submodule1, unsigned dirty_submodule2);
 
diff --git a/revision.c b/revision.c
index 71519193c..7637e7556 100644
--- a/revision.c
+++ b/revision.c
@@ -414,9 +414,9 @@ static void file_add_remove(struct diff_options *options,
 
 static void file_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
-		 const unsigned char *old_sha1,
-		 const unsigned char *new_sha1,
-		 int old_sha1_valid, int new_sha1_valid,
+		 const struct object_id *old_oid,
+		 const struct object_id *new_oid,
+		 int old_oid_valid, int new_oid_valid,
 		 const char *fullpath,
 		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
 {
diff --git a/tree-diff.c b/tree-diff.c
index f2c747ea5..7ae1f10b2 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -74,7 +74,7 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
 {
 	struct combine_diff_parent *p0 = &p->parent[0];
 	if (p->mode && p0->mode) {
-		opt->change(opt, p0->mode, p->mode, p0->oid.hash, p->oid.hash,
+		opt->change(opt, p0->mode, p->mode, &p0->oid, &p->oid,
 			1, 1, p->path, 0, 0);
 	}
 	else {
-- 
2.13.0.219.gdb65acc882-goog

