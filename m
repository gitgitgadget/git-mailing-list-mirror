From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH v2] Fix symlink __stdcall problem at MSVC
Date: Thu, 20 Aug 2009 22:21:12 +0800
Message-ID: <1250778072-4324-1-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Aug 20 16:21:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me8W1-0007IL-DG
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 16:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbZHTOVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 10:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbZHTOVM
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 10:21:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:43005 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbZHTOVL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 10:21:11 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1600001rvb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=8F4hWBJo5JBu6mDSUvSabjj6+UP9HlL6U5r0peB3mW0=;
        b=aY11SerIZqS5ByR0/JhSx1J582f4JDwHchVzJNvUQyHnAThPeUxOG3q16Sodwg6uKM
         G6JD18DFc6NQn8WmbQ2Fp9Keisvkts4TwevmDt2Fk4YFIP4D79LT9aiYxzf1IzzUVnM/
         lJWvK4+tk8qlB6s4rgLF+S282tDqDtO2j24WE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bd1BvYPC87uh0+P6Hgs7JqttmxjYyZGF5dV64+wBExPBgloTo6b9H17rf6rVaEIAkc
         AkvKc+x4B5wE6AVt3EhjTNM4a7JzvC5C/roMAGmwax4qlCpMWz3rwPXumvpBfMG2YFaj
         qtBEJc5buWoQYrIYDuOA1P0f+cD8VdOug+e7g=
Received: by 10.141.29.16 with SMTP id g16mr4553413rvj.81.1250778073517;
        Thu, 20 Aug 2009 07:21:13 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id g14sm943615rvb.5.2009.08.20.07.21.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 07:21:12 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126643>

MSVC requires that __stdcall be between return value and function name.
Further, all Win32 API definitions look like this:

	TYPE WINAPI function_name...

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/mingw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index fd642e4..4256243 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1421,7 +1421,7 @@ int link(const char *oldpath, const char *newpath)
 
 int symlink(const char *oldpath, const char *newpath)
 {
-	typedef BOOL WINAPI (*symlink_fn)(const char*, const char*, DWORD);
+	typedef BOOL (WINAPI *symlink_fn)(const char*, const char*, DWORD);
 	static symlink_fn create_symbolic_link = NULL;
 	if (!create_symbolic_link) {
 		create_symbolic_link = (symlink_fn) GetProcAddress(
-- 
1.6.4.msysgit.0
