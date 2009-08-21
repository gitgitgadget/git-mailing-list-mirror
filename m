From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 06/14] mingw.c: Use the O_BINARY flag to open files
Date: Fri, 21 Aug 2009 15:30:38 +0200
Message-ID: <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
 <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
 <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUE8-00012X-Nt
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387AbZHUNbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbZHUNbM
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:12 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:57834 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbZHUNbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:09 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so637048ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=TqlXeX58hs37Nnuhp4w6HdIDy0oX5aL3HwLhx+s3B5w=;
        b=cJ3MhpMJTR5W/C0hXWNSuopIGJ4zK6DCXLbxWmhHNdeu/HqdQMG5gMRUFrtHjlnXLe
         BGTdP/ssqgYy7YWc6DUZKF3p3E+U0U65hw3ZwMnogW/zoP/apmMK91ONCSuri+NZlRx0
         3AvZWUFWLGvlEUD4BbLv4s3Ywyzl7+wqhtr4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UheJ+wEJEY689mDorz0hAHfh5w2t+FY8faOxnN8pEHtUV//m+IwIjkL5SlDafmV3ZP
         LQftSMLlMEBE2YpKRBLK05DbLid65lj2fbUmc5d9F0JR1sSOH5c7NutwmD5tpnKOLZTP
         ZKW+qnf98v8Xy3DT+l8fv4Js6NKhVCWxMFZvY=
Received: by 10.210.127.15 with SMTP id z15mr420723ebc.35.1250861471170;
        Fri, 21 Aug 2009 06:31:11 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.10
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126720>

From: Frank Li <lznuaa@gmail.com>

On Windows, binary files must be opened using the O_BINARY flag for
untranslated mode. MinGW does this for us automatically, but Microsoft
Visual C++ does not.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e4e0e60..836426c 100644
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
1.6.3.msysgit.0.18.gef407
