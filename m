From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] winansi: support ESC [ K (erase in line)
Date: Tue, 10 Mar 2009 22:58:09 +0100
Message-ID: <200903102258.09521.j6t@kdbg.org>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <49B61703.8030602@viscovery.net> <200903102254.17517.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 22:59:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh9zB-00012W-UW
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 22:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbZCJV6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 17:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755171AbZCJV6N
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 17:58:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:43644 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755081AbZCJV6N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 17:58:13 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E48CC2C4006;
	Tue, 10 Mar 2009 22:58:09 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9B90D3FFC3;
	Tue, 10 Mar 2009 22:58:09 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200903102254.17517.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112852>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This is your patch without the write() part.

 -- Hannes

 compat/winansi.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index e2d96df..44dc293 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -18,8 +18,6 @@
 
  This file is git-specific. Therefore, this file does not attempt
  to implement any codes that are not used by git.
-
- TODO: K
 */
 
 static HANDLE console;
@@ -79,6 +77,20 @@ static void set_console_attr(void)
 	SetConsoleTextAttribute(console, attributes);
 }
 
+static void erase_in_line(void)
+{
+	CONSOLE_SCREEN_BUFFER_INFO sbi;
+
+	if (!console)
+		return;
+
+	GetConsoleScreenBufferInfo(console, &sbi);
+	FillConsoleOutputCharacterA(console, ' ',
+		sbi.dwSize.X - sbi.dwCursorPosition.X, sbi.dwCursorPosition,
+		NULL);
+}
+
+
 static const char *set_attr(const char *str)
 {
 	const char *func;
@@ -218,7 +230,7 @@ static const char *set_attr(const char *str)
 		set_console_attr();
 		break;
 	case 'K':
-		/* TODO */
+		erase_in_line();
 		break;
 	default:
 		/* Unsupported code */
-- 
1.6.2.103.gb3eac.dirty
