Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AC682027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbdE3Rbl (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:41 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33002 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbdE3Rbj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:39 -0400
Received: by mail-pf0-f180.google.com with SMTP id e193so78464919pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ueFDZGGs8CFk75KFnIfHelr8E6t2qBKRSOgUe3uNeaM=;
        b=hGd/H6pOpPrLcZTbhDsnSm3z0BbljrXNUuowwRabroMN6OsczjBeFJ0iWUeT9R6JdV
         y75aVYK/kGfPIdGDSRoCUnhShyHoNOvOK+LfzZdwfMYhB6jwfQcAqctb2IEAdN2AG37v
         wiuKno5aK4JwjdiKtTWwuHM1xsU7p67nYUrGxCnSskJjIVQXicrWGpgHaJh6NyDJPkg8
         6BcIS/o8Zq7CuElnfX3ylsIja1Wy9u2kyf1SuYVrt11QMDWNHj8FzChceqMrvsCweDZo
         Usgeobtqo0PoGWaa64UOFIvdPsK56s8FmEuwZOvHwtvjIs0btRJ5IivPfIBPb6PapQvu
         RZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ueFDZGGs8CFk75KFnIfHelr8E6t2qBKRSOgUe3uNeaM=;
        b=HGLOtUyOt/pC4hGsKxWXfig/rEZtY3izmR5AtT7IXoscXLkIXGZV+ac30GARec5FmY
         P/S3aKa2n+GihtdXb88D2jpdiwgb7byJxR8EZIgoVoVDtkrnG6l1xeq0YgJjxeAzzvMo
         qD2uopJCL7Rm4NgRmGZemhLpGKpN2cq47l/F0pHDewp5tHLWAKl+slxBmI2cR0PQ2nIM
         mocBYHGN+oSWCH91CCQ1QNYeDUyfmbzGzn3kOaGcwbcftf3y0sg16NM9sRxLRC2DFwsE
         no8mKDV4y2eLydR1W+YIXJtq8lT9L/Tpxpgd69a/c9RiIq8g72eO5+N1ftTbaIsIGeql
         8T/w==
X-Gm-Message-State: AODbwcBxlHoJqR1fgcvj78zKxdN7pfJC1Q/hMc1b6BzeQ0bgzoK0h+2+
        KzhhEP2KsqgW6QwWDTZgHA==
X-Received: by 10.99.227.81 with SMTP id o17mr26661054pgj.41.1496165497742;
        Tue, 30 May 2017 10:31:37 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:36 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 15/33] diff: convert reuse_worktree_file to struct object_id
Date:   Tue, 30 May 2017 10:30:51 -0700
Message-Id: <20170530173109.54904-16-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index e0c179f5f..084c8b2d0 100644
--- a/diff.c
+++ b/diff.c
@@ -2717,7 +2717,7 @@ void fill_filespec(struct diff_filespec *spec, const struct object_id *oid,
  * the work tree has that object contents, return true, so that
  * prepare_temp_file() does not have to inflate and extract.
  */
-static int reuse_worktree_file(const char *name, const unsigned char *sha1, int want_file)
+static int reuse_worktree_file(const char *name, const struct object_id *oid, int want_file)
 {
 	const struct cache_entry *ce;
 	struct stat st;
@@ -2748,7 +2748,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * objects however would tend to be slower as they need
 	 * to be individually opened and inflated.
 	 */
-	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1))
+	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(oid->hash))
 		return 0;
 
 	/*
@@ -2768,7 +2768,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * This is not the sha1 we are looking for, or
 	 * unreusable because it is not a regular file.
 	 */
-	if (hashcmp(sha1, ce->oid.hash) || !S_ISREG(ce->ce_mode))
+	if (oidcmp(oid, &ce->oid) || !S_ISREG(ce->ce_mode))
 		return 0;
 
 	/*
@@ -2842,7 +2842,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		return diff_populate_gitlink(s, size_only);
 
 	if (!s->oid_valid ||
-	    reuse_worktree_file(s->path, s->oid.hash, 0)) {
+	    reuse_worktree_file(s->path, &s->oid, 0)) {
 		struct strbuf buf = STRBUF_INIT;
 		struct stat st;
 		int fd;
@@ -3008,7 +3008,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 
 	if (!S_ISGITLINK(one->mode) &&
 	    (!one->oid_valid ||
-	     reuse_worktree_file(name, one->oid.hash, 1))) {
+	     reuse_worktree_file(name, &one->oid, 1))) {
 		struct stat st;
 		if (lstat(name, &st) < 0) {
 			if (errno == ENOENT)
-- 
2.13.0.219.gdb65acc882-goog

