From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 04/12] mingw.c: Use the O_BINARY flag to open files
Date: Wed, 19 Aug 2009 23:52:39 +0800
Message-ID: <1250697167-5536-4-git-send-email-lznuaa@gmail.com>
References: <1250697167-5536-1-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-2-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-3-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:54:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdnV2-0002JE-S7
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbZHSPxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbZHSPxl
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:53:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:42065 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbZHSPxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:53:40 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1310962rvb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rnYklR48Xy8ucL8shCWn77ivG9XSotQ8CDYgBgo0cmY=;
        b=AFDoEQxESAN8g1MfKijdAhyF4l6h/1hd6ViBimUG5NHEQZnwA05O3/oOX6kvkjWeaM
         wIRoX/5JEDxHGhQP5A5Zg2tQJlxOJNGKa2LVBsNG5uAh/uzVMAKYMyt47Ub6BdDXLFj/
         jAnPBCCQUXPrbFCvL9zYJiV0yXLWkcjrqHAWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JBFQ/soaRYwuiS9WLjtqvTAij9sl8yivBjkbD2kbymroD7iPA3mU6cTjA09P025vGv
         4+NX4IQei9haGWBpBvKB9QfW2PTv1cHP5d43E7zc9xl53eaaZj6Tgze/kKqY60fO5L7p
         1rZcF3kemhQMav1B2tKA2Tj50iejotPpTSTjw=
Received: by 10.140.126.17 with SMTP id y17mr2028802rvc.2.1250697222224;
        Wed, 19 Aug 2009 08:53:42 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id g31sm26674426rvb.46.2009.08.19.08.53.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 08:53:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250697167-5536-3-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126555>

On Windows, non-text files must be opened using the O_BINARY flag.
MinGW does this for us automatically, but Microsoft Visual C++
does not.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/mingw.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 75c74b1..d5fa0ed 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -132,7 +132,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	if (!strcmp(filename, "/dev/null"))
 		filename = "nul";
 
-	fd = open(filename, oflags, mode);
+	fd = open(filename, oflags | O_BINARY, mode);
 
 	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
 		DWORD attrs = GetFileAttributes(filename);
@@ -278,7 +278,7 @@ int mkstemp(char *template)
 	char *filename = mktemp(template);
 	if (filename == NULL)
 		return -1;
-	return open(filename, O_RDWR | O_CREAT, 0600);
+	return open(filename, O_RDWR | O_CREAT | O_BINARY, 0600);
 }
 
 int gettimeofday(struct timeval *tv, void *tz)
-- 
1.6.4.msysgit.0
