Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D351F202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbdCOV1w (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:27:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:44822 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbdCOV1v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:27:51 -0400
Received: (qmail 3975 invoked by uid 109); 15 Mar 2017 21:27:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 21:27:51 +0000
Received: (qmail 11776 invoked by uid 111); 15 Mar 2017 21:28:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 17:28:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 17:27:47 -0400
Date:   Wed, 15 Mar 2017 17:27:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] move odb_* declarations out of git-compat-util.h
Message-ID: <20170315212747.ome5oth5xpwquf6o@sigill.intra.peff.net>
References: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
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
2.12.0.613.g6e7c52a0d

