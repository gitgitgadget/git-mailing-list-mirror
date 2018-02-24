Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE3F1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeBXAsP (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:15 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39161 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeBXAsK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:10 -0500
Received: by mail-pf0-f196.google.com with SMTP id c143so4190950pfb.6
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6OraGT1WopgxrYuADcVVjAL+SDHQr+Ay30fR/I2TH7g=;
        b=n/owqCbSZxeh6ZnD9i00lFC9AAI8N3B+w/Cnn6KbXKfLH31PbJwbneKKuoYDeo4RQN
         34SwAZgpIiNGoAChBmfLJkO9TQMZhORFXt23v+phiU6cwi7X3fD1dehQdvZzVV8MpIwa
         deu6qAhoOYulecu98X4xPv1nbJrCWyi04nHY8bs7du83bNvFBvKCUD0ezlxe6t5zu7Hu
         aLEzbVFDf8WStIISLz9wDeTL/cYNvHOq7XSytJ6yYfPGrKjgk7ZxJnSQ9sW7VPuL6c9y
         xTIftgDubBoHXMKK+NZSseB/CiFiIEksavK5A6gTlU3PFHgjC5qYfMbrMRYd1PT5TOi7
         Di7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6OraGT1WopgxrYuADcVVjAL+SDHQr+Ay30fR/I2TH7g=;
        b=mGoKBIztMRhnWvl5Gw5ESIXFAB+KvTicPqexrl3JpQPsFDyovml/ltZvMuzwRjD6Bd
         RqSFvgQP271S0sHunL70m+bcbCOoVMhXQn0wF1jte2XMVYRQ3kgPUN9QXm336bfOMIA+
         HcHMVw5chLv8ICw3QDMd7UkJbptP5X8avcOvKyRKbE9E9/8ZzBhWsrsjvl+tFmzF2J5q
         VPFNopimf7vt45O2pIwn9yCDOSwybOsBbvTM7zI6O5O+he1MMkiZ3wS4HYbYE0UNReqn
         oRX7/qTNkfadqsTzB6Dw1b7isIbs2qmMFgWbQkYAwhL1FmaqvpnhCs+M2d0GuFfEo9qS
         owhw==
X-Gm-Message-State: APf1xPAL2y3XzSKhCvCErhEH6erTnwE2ODAVt3B2yeJQwCnzi8QP+7nG
        f1MDYlhDAobUpdeFuNMn9d06+Q==
X-Google-Smtp-Source: AH8x225H+YIU4/YLsfeBiLMAK9ndV7WcSGl8PPoXwXqF5h87gXhSAGelpfcFDXZqHyJThi3zZ64eIA==
X-Received: by 10.98.23.136 with SMTP id 130mr3402366pfx.43.1519433290111;
        Fri, 23 Feb 2018 16:48:10 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t25sm5899961pge.41.2018.02.23.16.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:09 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 08/27] pack: move approximate object count to object store
Date:   Fri, 23 Feb 2018 16:47:35 -0800
Message-Id: <20180224004754.129721-9-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index bd6441e525f..31ca4d3f340 100644
--- a/object-store.h
+++ b/object-store.h
@@ -90,6 +90,14 @@ struct raw_object_store {
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
@@ -97,7 +105,7 @@ struct raw_object_store {
 	unsigned packed_git_initialized : 1;
 };
 
-#define RAW_OBJECT_STORE_INIT(o) { NULL, NULL, LIST_HEAD_INIT(o.packed_git_mru), NULL, NULL, 0 }
+#define RAW_OBJECT_STORE_INIT(o) { NULL, NULL, LIST_HEAD_INIT(o.packed_git_mru), NULL, NULL, 0, 0, 0 }
 
 void raw_object_store_clear(struct raw_object_store *o);
 
diff --git a/packfile.c b/packfile.c
index 3ee349ab1bd..8d7b1dd5f9c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -802,8 +802,6 @@ static void prepare_packed_git_one(char *objdir, int local)
 	strbuf_release(&path);
 }
 
-static int approximate_object_count_valid;
-
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -813,8 +811,8 @@ static int approximate_object_count_valid;
  */
 unsigned long approximate_object_count(void)
 {
-	static unsigned long count;
-	if (!approximate_object_count_valid) {
+	if (!the_repository->objects.approximate_object_count_valid) {
+		unsigned long count;
 		struct packed_git *p;
 
 		prepare_packed_git();
@@ -824,8 +822,9 @@ unsigned long approximate_object_count(void)
 				continue;
 			count += p->num_objects;
 		}
+		the_repository->objects.approximate_object_count = count;
 	}
-	return count;
+	return the_repository->objects.approximate_object_count;
 }
 
 static void *get_next_packed_git(const void *p)
@@ -900,7 +899,7 @@ void prepare_packed_git(void)
 
 void reprepare_packed_git(void)
 {
-	approximate_object_count_valid = 0;
+	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
 	prepare_packed_git();
 }
-- 
2.16.1.291.g4437f3f132-goog

