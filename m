From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 1/4] svndump: move struct definitions to .h
Date: Tue, 28 Aug 2012 11:15:01 +0200
Message-ID: <1346145304-27149-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1346145304-27149-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 11:15:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HtU-0002xi-3o
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 11:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613Ab2H1JPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 05:15:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34395 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab2H1JPU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 05:15:20 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1542990bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 02:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=w8TcTa1EWR+iZfOrseJuYYcKG011i68gHTN1PDwF3rk=;
        b=uPvLdDB+yEozK/VY0HFTC7oeHvY0qnmyg9pzoAmcIGn/TsK1jxuqQW3behD80uEHTN
         6/Ew3ZsiYi9kX4W81ogbxb6HXD7s8l1D5djNJRYWZe+URO45bB/D3myKtdDxjgVlNnwv
         6tT9oNumdI+/Ll4Or09Zc8KJB7mKH5eXVMXC9tQEJDbSNuHsyk90/Rf7qo3fLpHy0t6E
         Lxd/2/y3ypz33GACEJSBzpLMjJRq264T2KTI4P5xRX5C5vYmWefJtY1zJiCrP/PxQpgw
         C9xgHUShdNewfdlGQr/GLmFTqW3mR9Sxd3k4UxZ8Hyd3Ot+AvEiTB4ju+Wa+QF612hyC
         nWKA==
Received: by 10.204.132.77 with SMTP id a13mr4516656bkt.99.1346145320186;
        Tue, 28 Aug 2012 02:15:20 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id c18sm12120186bkv.8.2012.08.28.02.15.17
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 02:15:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346145304-27149-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204420>

This is a preparation for adding branch detection code in separate
.c files.

External branch detection functions will need to use these.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 vcs-svn/svndump.c |   21 ++++-----------------
 vcs-svn/svndump.h |   19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 31d1d83..6ca94de 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -38,23 +38,10 @@
 
 static struct line_buffer input = LINE_BUFFER_INIT;
 
-static struct {
-	uint32_t action, srcRev, type;
-	off_t prop_length, text_length;
-	struct strbuf src, dst;
-	uint32_t text_delta, prop_delta;
-} node_ctx;
-
-static struct {
-	uint32_t revision;
-	unsigned long timestamp;
-	struct strbuf log, author, note;
-} rev_ctx;
-
-static struct {
-	uint32_t version;
-	struct strbuf uuid, url;
-} dump_ctx;
+static struct node_ctx_t node_ctx;
+static struct rev_ctx_t rev_ctx;
+static struct dump_ctx_t dump_ctx;
+
 
 static void reset_node_ctx(char *fname)
 {
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index b8eb129..d545453 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -1,5 +1,6 @@
 #ifndef SVNDUMP_H_
 #define SVNDUMP_H_
+#include "cache.h"
 
 int svndump_init(const char *filename);
 int svndump_init_fd(int in_fd, int back_fd);
@@ -7,4 +8,22 @@ void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 void svndump_deinit(void);
 void svndump_reset(void);
 
+struct node_ctx_t {
+	uint32_t action, srcRev, type;
+	off_t prop_length, text_length;
+	struct strbuf src, dst;
+	uint32_t text_delta, prop_delta;
+};
+
+struct rev_ctx_t {
+	uint32_t revision;
+	unsigned long timestamp;
+	struct strbuf log, author, note;
+};
+
+struct dump_ctx_t {
+	uint32_t version;
+	struct strbuf uuid, url;
+};
+
 #endif
-- 
1.7.9.5
