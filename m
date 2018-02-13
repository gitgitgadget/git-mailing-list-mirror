Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7BFE1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933199AbeBMBXC (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:02 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33668 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933187AbeBMBW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:22:57 -0500
Received: by mail-pg0-f68.google.com with SMTP id g12so358983pgs.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mnLkLrws/HIaY8KqLeLvqstRytadfzuwx51ZCTY+HUI=;
        b=ayyRQY/NHf/7mopnYC4WU/oIMK4gcZlz6HxrM6BRXP5PJisccomeXU2z8LkCjD+R3n
         yTu6MUOC32eJi5/YAZsMd1iJB+y/0zjP6l/RCxlmRFZLHbZjbYcAkGcD51uCJW5z3L/W
         WjdnSX6ndw/QKpn5mRN5RSZpH93Q/PNXZK2k6OoPkjEBwkhVvN3bNeoq1kA82MnRkRir
         vT3Cn3pxSamiphyHYwlIgaz234LsE9pil5hsowd5sIfc+331g25Y6Un+NISb20lm4oHW
         ViCsvF78vi5zn7T6LlBbcF6IRfl1i+2SksCP76GPgQZ6eoPOljcCnQGWotHtlCMS8McI
         VEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mnLkLrws/HIaY8KqLeLvqstRytadfzuwx51ZCTY+HUI=;
        b=ph/+TB0U/cPmYsI6+se19xkV4VylWudAgf8HljAiIuKZbpneACsPFi2rEPMAaz3pDN
         OAtbgRM9BWxxAqgZIkfz7tSkySdP6sX9PKcA77pCiInMO9OW40VyOh8rR/P7a2l6NmbR
         SKm1qcQlc5b/nRa4IgE1DgwDVlRKWSTn4h11Hg2dS8PeVuM04QsPVsQE7RDKoIAcl9kq
         EH15zk1UNNA4kQXnzI0SfNsdunXYT2z+3Ws6p9tzdLwDldM9p1jJVx9jvFwIKmZoroVu
         44fzxuASCWYGcw7BXhO9ZPbjpD9ZgH7/DyrsbqugCI4V+wC0ofLdWwKjhawE+jK1JKAv
         5nKg==
X-Gm-Message-State: APf1xPAoSBOODZj02uVvobWmWjoOu+V0lKfFCa1iYlhzxRbP6J/FDYSQ
        A06OJmCaseUd9cEWRGqZxDT1Cw==
X-Google-Smtp-Source: AH8x225HMy+iDSSh35gHVKyJk9tmbmfuDlxrr7jQhWcSIV2ilrg3F1kG6ZJ2kYVc25Rl/gAVAy9DXQ==
X-Received: by 10.98.209.93 with SMTP id t29mr13220559pfl.233.1518484976759;
        Mon, 12 Feb 2018 17:22:56 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id a23sm31351126pfa.149.2018.02.12.17.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:22:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/26] pack: move approximate object count to object store
Date:   Mon, 12 Feb 2018 17:22:22 -0800
Message-Id: <20180213012241.187007-8-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

The approximate_object_count() function maintains a rough count of
objects in a repository to estimate how long object name abbreviates
should be.  Object names are scoped to a repository and the
appropriate length may differ by repository, so the object count
should not be global.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 10 +++++++++-
 packfile.c     | 11 +++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/object-store.h b/object-store.h
index 9fd109fa9c..86f1ec2cd0 100644
--- a/object-store.h
+++ b/object-store.h
@@ -21,13 +21,21 @@ struct raw_object_store {
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
 
+	/*
+	 * A fast, rough count of the number of objects in the repository.
+	 * These two fields are not meant for direct access. Use
+	 * approximate_object_count() instead.
+	 */
+	unsigned long approximate_object_count;
+	unsigned approximate_object_count_valid : 1;
+
 	/*
 	 * Whether packed_git has already been populated with this repository's
 	 * packs.
 	 */
 	unsigned packed_git_initialized : 1;
 };
-#define RAW_OBJECT_STORE_INIT { NULL, NULL, MRU_INIT, NULL, NULL, 0 }
+#define RAW_OBJECT_STORE_INIT { NULL, NULL, MRU_INIT, NULL, NULL, 0, 0, 0 }
 
 void raw_object_store_clear(struct raw_object_store *o);
 
diff --git a/packfile.c b/packfile.c
index c107fce171..a53706cf16 100644
--- a/packfile.c
+++ b/packfile.c
@@ -793,8 +793,6 @@ static void prepare_packed_git_one(char *objdir, int local)
 	strbuf_release(&path);
 }
 
-static int approximate_object_count_valid;
-
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -804,8 +802,8 @@ static int approximate_object_count_valid;
  */
 unsigned long approximate_object_count(void)
 {
-	static unsigned long count;
-	if (!approximate_object_count_valid) {
+	if (!the_repository->objects.approximate_object_count_valid) {
+		unsigned long count;
 		struct packed_git *p;
 
 		prepare_packed_git();
@@ -815,8 +813,9 @@ unsigned long approximate_object_count(void)
 				continue;
 			count += p->num_objects;
 		}
+		the_repository->objects.approximate_object_count = count;
 	}
-	return count;
+	return the_repository->objects.approximate_object_count;
 }
 
 static void *get_next_packed_git(const void *p)
@@ -890,7 +889,7 @@ void prepare_packed_git(void)
 
 void reprepare_packed_git(void)
 {
-	approximate_object_count_valid = 0;
+	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
 	prepare_packed_git();
 }
-- 
2.16.1.73.ga2c3e9663f.dirty

