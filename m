From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH] Fix symlink __stdcall problem at MSVC
Date: Thu, 20 Aug 2009 21:24:40 +0800
Message-ID: <1250774680-4720-1-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Aug 20 15:24:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me7dR-0004Mx-20
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbZHTNYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 09:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754119AbZHTNYs
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:24:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:42593 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbZHTNYr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:24:47 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1585878rvb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Deg3BswIr82EWsN/iuOORHK3Vg0Hr7Madu0c0kiVnCM=;
        b=tpbdq3eKwczfJlFBW222KAHW5XTjoeGwNIW3xHknvH7Q90DUuA0MGEvIptgxiJTJTB
         snt1pr9kT2rN6yYFLQlQR5o6A3EVU4VPZCLUDP3K6rxRTPOQzJXcRPMx6z87ceFi5Mjx
         mO1o68rjRjg+xeDc411QbijN3+ipVv7wAsIwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=eXzX0xOJ6Aq1H+oxQZqPcRbgbh3BR5fhx7JGaHMJr5fYa1dW2z2jU55X+ibKP12bLW
         E51VQNZkvZYIXU3k/KU2GeUaHAeT8vSRW2GFV+KpF+oz6NKp+isct7GblAvWY4Vjrnus
         45seXYkt2TPJfcH8M+jzg4WY77Lu5jS/TmD0g=
Received: by 10.140.166.20 with SMTP id o20mr4435459rve.75.1250774689261;
        Thu, 20 Aug 2009 06:24:49 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id l31sm5545514rvb.54.2009.08.20.06.24.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:24:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126619>

MSVC requires that __stdcall be between return value and function name.
Further, all Win32 API definitions look like this:

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
