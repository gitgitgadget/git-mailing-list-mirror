Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911AB1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeBUBy6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:54:58 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37319 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeBUByz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:54:55 -0500
Received: by mail-pg0-f65.google.com with SMTP id y26so62263pgv.4
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8lWPz+mwDyxxH03XKX/I/RWtfftZRPKVNjRkiXJhtDs=;
        b=MHzNoscAm9LC1ZTcgEhd2tzMsQ1aG4DUAB/dFC3q55tUMKUdpQWw/Hg7GztebPik3V
         +nP6Eyv+5hHpbwvtyxEIbFPQ/+YiW4YlFfwy/8t8xh85nJhseZ7fNB+V4tDWDGlTC2Ls
         gZU4sbXq+qBWvv2qZp5dGnK5mwXBeJLQQq8rdYP7rxHPQBKZX1DrdXla3MKiaAqBq5q9
         7SrkDGBb8xaetGIdL+wkLHC5zOUhuo3n+05h/Je/DuDE1XVMeNxVCjT5MIb+5SeOk4Kh
         UbPT98vSv+mq27pQ1jSAcGXMN/Sg7WEFGnUiXx+FjARVt6pzXfDh/0NLMjN7MkDHVYpP
         8twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8lWPz+mwDyxxH03XKX/I/RWtfftZRPKVNjRkiXJhtDs=;
        b=Tz2NQMZS4IQVRqcyIXrXoZs0jCGnuKvOLIK2wSMNopb+qZ2uK/G9szHur7s3Vqbs2s
         mak4tVFYYfyTda4/mbInH7Ply+tN4zPzQ/Dr+TmPHw5Z//D1OXyo2pE4Bt3jiofU6ypJ
         FzFkkoGtV4OAiEetCFYcNqQTuKugtV4MsKMeCkthSZbsJKavX+3XFaqGjjkdUB6r5kQW
         cFwqz6c7d0SPCuxppR15T0Dhz7N9nGKefE3jgbRMdVfIfkREi34dPL/rG23BAreZ9fUS
         ACeqNWmwXAJ5JbuFZB38H113MaFgzwr48Ct8pkIRak8rBXzSIcL9q3ulACjqOWFg0SUn
         ZPOw==
X-Gm-Message-State: APf1xPAQb5/2uUKFuNepyQdw+XUMxiA3cBq4EMQRQKcKOr1gADopdH06
        bzWQSo9O/U9n0UzeiTcwfKkYrx2XlHg=
X-Google-Smtp-Source: AH8x226Bs0QMz4eSPWmSfAjVACoM/W3gHPzBZBjcNMSg9ThBZ8ENlUL8m8/zC6GIjP5WItWWcFjn5w==
X-Received: by 10.98.14.200 with SMTP id 69mr1581953pfo.168.1519178094976;
        Tue, 20 Feb 2018 17:54:54 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t85sm32911006pfg.159.2018.02.20.17.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/27] sha1_file: add repository argument to link_alt_odb_entry
Date:   Tue, 20 Feb 2018 17:54:13 -0800
Message-Id: <20180221015430.96054-11-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the link_alt_odb_entry caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Since the implementation does not yet work with other repositories,
use a wrapper macro to enforce that the caller passes in
the_repository as the first argument. It would be more appealing to
use BUILD_ASSERT_OR_ZERO to enforce this, but that doesn't work
because it requires a compile-time constant and common compilers like
gcc 4.8.4 do not consider "r == the_repository" a compile-time
constant.

This and the following three patches add repository arguments to
link_alt_odb_entry, read_info_alternates, link_alt_odb_entries
and prepare_alt_odb. Three out of the four functions are found
in a recursive call chain, calling each other, and one of them
accesses the repositories `objectdir` (which was migrated; it
was an obvious choice) and `ignore_env` (which we need to keep in
the repository struct for clarify); hence we will pass through the
repository unlike just the object store object + the ignore_env flag.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index a8e23bd2f8..aaa6276211 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -390,8 +390,9 @@ static int alt_odb_usable(struct raw_object_store *o,
  * terminating NUL.
  */
 static void read_info_alternates(const char * relative_base, int depth);
-static int link_alt_odb_entry(const char *entry, const char *relative_base,
-	int depth, const char *normalized_objdir)
+#define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
+static int link_alt_odb_entry_the_repository(const char *entry,
+	const char *relative_base, int depth, const char *normalized_objdir)
 {
 	struct alternate_object_database *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
@@ -488,7 +489,8 @@ static void link_alt_odb_entries(const char *alt, int sep,
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(entry.buf, relative_base, depth, objdirbuf.buf);
+		link_alt_odb_entry(the_repository, entry.buf,
+				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
-- 
2.16.1.291.g4437f3f132-goog

