From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/20] dir.h: move struct exclude declaration to top level
Date: Wed,  7 May 2014 21:51:42 +0700
Message-ID: <1399474320-6840-3-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:52:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3Cm-0005VP-0l
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbaEGOwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:52:14 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36963 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756247AbaEGOwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:52:12 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so1164533pdj.10
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IL1Pw7ptl39Gzol3486LJdrXoWnh0cOwREwpE3R8r3c=;
        b=WdCuLXyiKj9iAEHBdxsOQ1AqGTVkZ0RQkdqRVn+QjDcN+aN2mEB6LlLC6WZ+g14MOw
         rQZ/aadVUDoMTMcYlrrcyD8oolSBOIrrFTMyy8jcaNq/XOhMxYKNGp3ipLQybve89P86
         Hti4VnLwnU2vdK9TgARpc9OChJq/yZB4jKbPhkSYUZfRp1W1t3HHv1RAACddbakSf8kw
         SCbp3I82GRl+/tTtjqoj3zUiu6Un+ApCaShwpSFP30wAM+igZkxW6X1IZKaVypTLqH9S
         cnbzTtrfxd96Tkr3vF6+Dmac6N+1mwhZ8rp/mtlObttgKQTXwfAZteOaG6s+x6eGeh+S
         M91A==
X-Received: by 10.66.148.98 with SMTP id tr2mr19739134pab.33.1399474332009;
        Wed, 07 May 2014 07:52:12 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id be7sm4092738pad.9.2014.05.07.07.52.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:52:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:52:12 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248308>

There is no actual nested struct here. Move it out for clarity.
---
 dir.h | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/dir.h b/dir.h
index 55e5345..02e3710 100644
--- a/dir.h
+++ b/dir.h
@@ -15,6 +15,27 @@ struct dir_entry {
 #define EXC_FLAG_MUSTBEDIR 8
 #define EXC_FLAG_NEGATIVE 16
 
+struct exclude {
+	/*
+	 * This allows callers of last_exclude_matching() etc.
+	 * to determine the origin of the matching pattern.
+	 */
+	struct exclude_list *el;
+
+	const char *pattern;
+	int patternlen;
+	int nowildcardlen;
+	const char *base;
+	int baselen;
+	int flags;
+
+	/*
+	 * Counting starts from 1 for line numbers in ignore files,
+	 * and from -1 decrementing for patterns from CLI args.
+	 */
+	int srcpos;
+};
+
 /*
  * Each excludes file will be parsed into a fresh exclude_list which
  * is appended to the relevant exclude_list_group (either EXC_DIRS or
@@ -32,26 +53,7 @@ struct exclude_list {
 	/* origin of list, e.g. path to filename, or descriptive string */
 	const char *src;
 
-	struct exclude {
-		/*
-		 * This allows callers of last_exclude_matching() etc.
-		 * to determine the origin of the matching pattern.
-		 */
-		struct exclude_list *el;
-
-		const char *pattern;
-		int patternlen;
-		int nowildcardlen;
-		const char *base;
-		int baselen;
-		int flags;
-
-		/*
-		 * Counting starts from 1 for line numbers in ignore files,
-		 * and from -1 decrementing for patterns from CLI args.
-		 */
-		int srcpos;
-	} **excludes;
+	struct exclude **excludes;
 };
 
 /*
-- 
1.9.1.346.ga2b5940
