From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH il/rfc-remote-fd-ext] Fix build on Windows
Date: Sat, 14 Aug 2010 00:09:19 +0200
Message-ID: <201008140009.19291.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 00:09:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok2RL-0007sC-47
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 00:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab0HMWJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 18:09:21 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:35026 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754532Ab0HMWJV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 18:09:21 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D3993CDF86;
	Sat, 14 Aug 2010 00:09:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5FD7E19F5AF;
	Sat, 14 Aug 2010 00:09:19 +0200 (CEST)
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153518>

This adds the necessary #defines so that the programs can be built, but
since the poll emulation is not extended to support POLLOUT and POLLNVAL,
the resulting programs will most likely not function properly. (The test
does not check them, yet.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 3b2477b..f27a7b6 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -23,6 +23,9 @@ typedef int pid_t;
 #define WEXITSTATUS(x) ((x) & 0xff)
 #define WTERMSIG(x) SIGTERM
 
+#define EWOULDBLOCK EAGAIN
+#define SHUT_WR SD_SEND
+
 #define SIGHUP 1
 #define SIGQUIT 3
 #define SIGKILL 9
@@ -50,6 +53,8 @@ struct pollfd {
 };
 #define POLLIN 1
 #define POLLHUP 2
+#define POLLOUT 4
+#define POLLNVAL 8
 #endif
 
 typedef void (__cdecl *sig_handler_t)(int);
-- 
1.7.1.402.gf1eeb
