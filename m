From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] Makefile: do not compile git with debugging symbols by default
Date: Thu, 22 Jan 2015 18:50:37 +0600
Message-ID: <1421931037-21368-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 13:50:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEHDr-0004ot-VX
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 13:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbbAVMuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 07:50:52 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:47286 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbbAVMuv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 07:50:51 -0500
Received: by mail-la0-f52.google.com with SMTP id hs14so1362529lab.11
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 04:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/ahb0il+HFVIbAwScuFOwQxEISSHf4sKSVxeSPe4GQQ=;
        b=bYofbo2vFMn9huaVO79XY7/PqcD8OWIofbOJdGi0C9mXVzGxadx2bVcE9Id/uDCFJ9
         R2uMmJQH8zHIctYX3V9ITSyp475R3LOj7DtJcFIgGTg+UrD9Ds6SOhYdm2x6GE6yDd8l
         9pvuxg1N2s87TMYrr0Mq0UhAe06tCsUS48X51HQe8xbo5PYVBkspONykS3h2H4utoAF+
         ltqM8SIQEeyn5pxpC/5J7wQ5+bi+BRrx1hY08fnKODqZX0Y2HeJtqqI5QbQbmrm8ETUB
         wZ49ysCLBfaJHtxBTT9Nj3lx5HDuYfxhvf6JCY7+CxVbtAhlVutz4IEtltWSMUQOuqsp
         Owkw==
X-Received: by 10.112.169.34 with SMTP id ab2mr1272383lbc.77.1421931049556;
        Thu, 22 Jan 2015 04:50:49 -0800 (PST)
Received: from localhost.localdomain ([5.251.234.181])
        by mx.google.com with ESMTPSA id bs3sm5708831lbd.37.2015.01.22.04.50.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jan 2015 04:50:48 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262826>

Standard user has no need in debugging information. This patch adds
DEBUG=1 option to compile git with debugging symbols and compile without
it by default.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b5b4cee..83ff691 100644
--- a/Makefile
+++ b/Makefile
@@ -3,6 +3,8 @@ all::
 
 # Define V=1 to have a more verbose compile.
 #
+# Define DEBUG=1 to compile git with debugging symbols.
+#
 # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
 #
 # Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
@@ -363,8 +365,13 @@ GIT-VERSION-FILE: FORCE
 -include GIT-VERSION-FILE
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
+DEBUG_CFLAGS=
+
+ifdef DEBUG
+	DEBUG_CFLAGS = -g
+endif
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = $(DEBUG_CFLAGS) -O2 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-- 
2.3.0.rc1
