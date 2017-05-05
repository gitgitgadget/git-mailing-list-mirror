Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7772207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755623AbdEETyD (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:54:03 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33416 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdEETyB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:54:01 -0400
Received: by mail-pf0-f175.google.com with SMTP id q20so7142027pfg.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aU00/GE+jJV2IwcAtrNTWtah/Rg1X4I8C3FQ6/U6Sp8=;
        b=c1zwgjcI4Odpsc0PFmLGTVcVHha6LQf2r+9NNbQRMdgtxrU2Ma/GHj5SEtV9Sztwlo
         CWdL9L/qJFMP/ROUUrMHrp5RJBASEjRqR4tZRPQwi5sltPNYYZMMoC1y39D3x/Yjkf5a
         YeH5deLn6AC7le3XTIxnuuLPGjZlJNGDPHhMMzN0lr6z1L3rWcEapemdsbUfwqFhMel3
         6gX5zFnqpZbUk0sp2HW3uxBBXpM5fK3CrFI1bfhsyYqGKC1PWWD3RE8JnkatdDLxLfk9
         ce0gEWgOBNPG3tGWQxEk7Wo+hFUnIr4uUm1J+pTLlDw9XVxjmAtwvKw+2h9YAfkLdMrN
         rPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aU00/GE+jJV2IwcAtrNTWtah/Rg1X4I8C3FQ6/U6Sp8=;
        b=Ucvpe1hsUbBgy9G+mSzp/wLopY983zXVZpWR1amMpx2Fh6yEVsRIq+TsBmlzCDy12d
         AaV9rkeAAEuS9Hyrd5mctBixlx3qyS4zCd14TkM2TCJYHi9W5RsAbD+MlbGkoqZQIyOw
         Agx7E42VYXideCWBrlVfir3BikNzvc5Dg0JUpJbOgclFPfVqYwrMK5TRmfnjIIOD4sfX
         mrL6kj0OiFZHDYREvrbgB/Ynrl1r3fm9SsMK5iGhNIS/UT3nOkWjQB44qcNzqvvBuKgo
         OK1vc+hi6wliYSbnfbAOzdDXP7gK5WASA+mGvM8pCwkLYMa5IWv7RQHn8qZUA5i7YTNS
         ctMQ==
X-Gm-Message-State: AN3rC/5ICVM4q5LsiLMsspHaRtwB87wyfJ/ZWpmBkdFCxkhdG7/i+Vj4
        HAkebIw2RXkez4jU
X-Received: by 10.99.169.10 with SMTP id u10mr5327369pge.26.1494014035277;
        Fri, 05 May 2017 12:53:55 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:53:54 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 07/14] dir: convert is_excluded_from_list to take an index
Date:   Fri,  5 May 2017 12:53:27 -0700
Message-Id: <20170505195334.121856-8-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c          | 5 +++--
 dir.h          | 6 ++++--
 unpack-trees.c | 4 ++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 077b756c2..497a2db85 100644
--- a/dir.c
+++ b/dir.c
@@ -1010,10 +1010,11 @@ static struct exclude *last_exclude_matching_from_list(const char *pathname,
  */
 int is_excluded_from_list(const char *pathname,
 			  int pathlen, const char *basename, int *dtype,
-			  struct exclude_list *el)
+			  struct exclude_list *el, struct index_state *istate)
 {
 	struct exclude *exclude;
-	exclude = last_exclude_matching_from_list(pathname, pathlen, basename, dtype, el, &the_index);
+	exclude = last_exclude_matching_from_list(pathname, pathlen, basename,
+						  dtype, el, istate);
 	if (exclude)
 		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return -1; /* undecided */
diff --git a/dir.h b/dir.h
index a9f809983..64254c7e7 100644
--- a/dir.h
+++ b/dir.h
@@ -217,8 +217,10 @@ extern int within_depth(const char *name, int namelen, int depth, int max_depth)
 extern int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec);
 extern int read_directory(struct dir_struct *, const char *path, int len, const struct pathspec *pathspec);
 
-extern int is_excluded_from_list(const char *pathname, int pathlen, const char *basename,
-				 int *dtype, struct exclude_list *el);
+extern int is_excluded_from_list(const char *pathname, int pathlen,
+				 const char *basename, int *dtype,
+				 struct exclude_list *el,
+				 struct index_state *istate);
 struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 				  struct index_state *istate,
 				  const char *pathname, int len);
diff --git a/unpack-trees.c b/unpack-trees.c
index 6b7356dab..9bcb13e4f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1040,7 +1040,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
 	int ret = is_excluded_from_list(prefix->buf, prefix->len,
-					basename, &dtype, el);
+					basename, &dtype, el, &the_index);
 	int rc;
 
 	strbuf_addch(prefix, '/');
@@ -1143,7 +1143,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 		/* Non-directory */
 		dtype = ce_to_dtype(ce);
 		ret = is_excluded_from_list(ce->name, ce_namelen(ce),
-					    name, &dtype, el);
+					    name, &dtype, el, &the_index);
 		if (ret < 0)
 			ret = defval;
 		if (ret > 0)
-- 
2.13.0.rc1.294.g07d810a77f-goog

