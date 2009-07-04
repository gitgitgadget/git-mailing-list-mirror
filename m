From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/7] MinGW: simplify waitpid() emulation macros
Date: Sat,  4 Jul 2009 21:26:38 +0200
Message-ID: <d63e9230d57698a058c8a550709155e5e3222348.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
 <b73cf4b4cd09f4225098e71182044f64e12380aa.1246734159.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 21:27:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNAtj-00052P-Eg
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 21:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbZGDT1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 15:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbZGDT1b
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 15:27:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17664 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752493AbZGDT1a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 15:27:30 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D6144CDF82;
	Sat,  4 Jul 2009 21:27:33 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A0E5B42785;
	Sat,  4 Jul 2009 21:27:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.17.g1665f
In-Reply-To: <b73cf4b4cd09f4225098e71182044f64e12380aa.1246734159.git.j6t@kdbg.org>
In-Reply-To: <cover.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122722>

Windows does not have signals. At least they cannot be diagnosed by the
parent process; all that the parent process can observe is the exit code.

This also adds a dummy definition of WTERMSIG.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 The dummy definition WTERMSIG will be used in a subsequent patch.

 compat/mingw.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 4f7ba4c..21ab124 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -17,9 +17,10 @@ typedef int pid_t;
 #define S_IROTH 0
 #define S_IXOTH 0
 
-#define WIFEXITED(x) ((unsigned)(x) < 259)	/* STILL_ACTIVE */
+#define WIFEXITED(x) 1
+#define WIFSIGNALED(x) 0
 #define WEXITSTATUS(x) ((x) & 0xff)
-#define WIFSIGNALED(x) ((unsigned)(x) > 259)
+#define WTERMSIG(x) SIGTERM
 
 #define SIGHUP 1
 #define SIGQUIT 3
-- 
1.6.3.17.g1665f
