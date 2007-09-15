From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/2] Add xmemdup that duplicates a block of memory, and NUL terminates it.
Date: Sat, 15 Sep 2007 23:53:05 +0200
Message-ID: <20070917161141.CC8AA344A49@madism.org>
References: <20070917161113.GB460@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 18:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXJCP-00052A-4t
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 18:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbXIQQLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 12:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbXIQQLo
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 12:11:44 -0400
Received: from pan.madism.org ([88.191.52.104]:48341 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbXIQQLn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 12:11:43 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9D0096AB;
	Mon, 17 Sep 2007 18:11:42 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CC8AA344A49; Mon, 17 Sep 2007 18:11:41 +0200 (CEST)
In-Reply-To: <20070917161113.GB460@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58456>

Implement xstrndup using it.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-compat-util.h |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 1bfbdeb..429b0a3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -211,19 +211,20 @@ static inline void *xmalloc(size_t size)
 	return ret;
 }
 
-static inline char *xstrndup(const char *str, size_t len)
+static inline void *xmemdup(const void *data, size_t len)
 {
-	char *p;
-
-	p = memchr(str, '\0', len);
-	if (p)
-		len = p - str;
-	p = xmalloc(len + 1);
-	memcpy(p, str, len);
+	char *p = xmalloc(len + 1);
+	memcpy(p, data, len);
 	p[len] = '\0';
 	return p;
 }
 
+static inline char *xstrndup(const char *str, size_t len)
+{
+	char *p = memchr(str, '\0', len);
+	return xmemdup(str, p ? p - str : len);
+}
+
 static inline void *xrealloc(void *ptr, size_t size)
 {
 	void *ret = realloc(ptr, size);
-- 
1.5.3.1
