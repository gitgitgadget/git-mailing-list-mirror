Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A117220756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162354AbdAJUGd (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:06:33 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34035 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162334AbdAJUGb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:06:31 -0500
Received: by mail-pf0-f171.google.com with SMTP id 127so52066149pfg.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3U9iE9y44nC/nhCNkHeSC0/Q591nSNG1i6GBUFFBVHA=;
        b=F4yz4XyKPYtTIZKFaZULsKT7VhENNujVuDi65wa6B7JZr1G1G8SpZ8INqo7FuTyCke
         nEd6ha4DidPHgwjPjh4bomK+NBGLgd/nde+diHVyMXXb61Q2pXqMpGHyk4Qw0vhIPQJt
         KtnRu22+C1Tg8dmG12afK9mtYkWd3Y4ifFd2nPnZ4rG47uz7t1RxhIUBQ8zXZHitoGEl
         gODbD94vPUjnvemiFvVinWE0NYsr+KF37M5hnAZJX46a9ZphIBquoQjM4i7d6y76xhub
         pKrs+85GBMqR5K7qfs0EGe+02/EUWDewjrBWtJ+RskhCJtQtrA6DdjILBzbEjXxZs63l
         Pysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3U9iE9y44nC/nhCNkHeSC0/Q591nSNG1i6GBUFFBVHA=;
        b=PzMAg2B39avUgr9la2fGMUcEsrhjYuB3tzlWjpa2QplrEVO606yH85bZFOrEpf3RWT
         6CoGLVVGd5bXOowgm9nTH+BS+GScQnpDLnlZDmgXJPhVALZdamDH2oqlY+V63pHZZJ+C
         0c364AF/9anSVXEHNraurSIpPbXu9C5c2nC4zFJUCISF8dYHhgyGWjwGWtvaNw9jLrR/
         XKhwUYhbYk5YWUOr/oFHd73pLS2H62K1y8ETfRbLGdAwNTLWYgN1+L1RTlSE6Axz8671
         U+B1xQ+eb8I1vn6KgFLO2iad76EoIRYfV9xLhNLEsUDBJMPlRfdrwsLkjpliqlT84l7R
         yl/g==
X-Gm-Message-State: AIkVDXI4LQr0yQIm0ujRSsqLOF+baXoHrC3m40rcZFjCqQRn88/TXw7MFvH8vn/z4EVtkXPR
X-Received: by 10.98.159.141 with SMTP id v13mr5850077pfk.50.1484078785218;
        Tue, 10 Jan 2017 12:06:25 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id o126sm7770081pga.34.2017.01.10.12.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:06:24 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH] index: improve constness for reading blob data
Date:   Tue, 10 Jan 2017 12:06:10 -0800
Message-Id: <20170110200610.146596-1-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve constness of the index_state parameter to the
'read_blob_data_from_index' function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h      | 2 +-
 read-cache.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index a50a61a19..363953c1a 100644
--- a/cache.h
+++ b/cache.h
@@ -599,7 +599,7 @@ extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, char
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 extern void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
 extern int index_name_is_other(const struct index_state *, const char *, int);
-extern void *read_blob_data_from_index(struct index_state *, const char *, unsigned long *);
+extern void *read_blob_data_from_index(const struct index_state *, const char *, unsigned long *);
 
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
diff --git a/read-cache.c b/read-cache.c
index f92a912dc..6ee044442 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2292,7 +2292,8 @@ int index_name_is_other(const struct index_state *istate, const char *name,
 	return 1;
 }
 
-void *read_blob_data_from_index(struct index_state *istate, const char *path, unsigned long *size)
+void *read_blob_data_from_index(const struct index_state *istate,
+				const char *path, unsigned long *size)
 {
 	int pos, len;
 	unsigned long sz;
-- 
2.11.0.390.gc69c2f50cf-goog

