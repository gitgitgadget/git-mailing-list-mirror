Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68E420323
	for <e@80x24.org>; Thu, 16 Mar 2017 14:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbdCPO1F (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 10:27:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:45107 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbdCPO1E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 10:27:04 -0400
Received: (qmail 4625 invoked by uid 109); 16 Mar 2017 14:27:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 14:27:03 +0000
Received: (qmail 15856 invoked by uid 111); 16 Mar 2017 14:27:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 10:27:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 10:27:00 -0400
Date:   Thu, 16 Mar 2017 10:27:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/5] move odb_* declarations out of git-compat-util.h
Message-ID: <20170316142700.llf6zpiss5l4xurs@sigill.intra.peff.net>
References: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These functions were originally conceived as wrapper
functions similar to xmkstemp(). They were later moved by
463db9b10 (wrapper: move odb_* to environment.c,
2010-11-06). The more appropriate place for a declaration is
in cache.h.

While we're at it, let's add some basic docstrings.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h           | 12 ++++++++++++
 git-compat-util.h |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index c95826971..68ad06e15 100644
--- a/cache.h
+++ b/cache.h
@@ -1634,6 +1634,18 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 
 extern void pack_report(void);
 
+/*
+ * Create a temporary file rooted in the object database directory.
+ */
+extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
+
+/*
+ * Create a pack .keep file in the object database's pack directory, for
+ * a pack with checksum "sha1". The return value is a file descriptor opened
+ * for writing, or -1 on error. The name of the keep file is written to "name".
+ */
+extern int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1);
+
 /*
  * mmap the index file for the specified packfile (if it is not
  * already mmapped).  Return 0 on success.
diff --git a/git-compat-util.h b/git-compat-util.h
index e626851fe..8a4a3f85e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -798,8 +798,6 @@ extern FILE *xfopen(const char *path, const char *mode);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
 extern int xmkstemp_mode(char *template, int mode);
-extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
-extern int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1);
 extern char *xgetcwd(void);
 extern FILE *fopen_for_writing(const char *path);
 
-- 
2.12.0.623.g86ec6c963

