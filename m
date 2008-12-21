From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] connect.c: stricter port validation, silence compiler
 warning
Date: Sun, 21 Dec 2008 02:12:11 +0100
Message-ID: <1229821931.31765.12.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 02:14:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LECtl-0004OV-Kq
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 02:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbYLUBNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 20:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbYLUBNF
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 20:13:05 -0500
Received: from india601.server4you.de ([85.25.151.105]:43294 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbYLUBNE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 20:13:04 -0500
Received: from [10.0.1.101] (p57B7C7C1.dip.t-dialin.net [87.183.199.193])
	by india601.server4you.de (Postfix) with ESMTPSA id 4E6A22F805F;
	Sun, 21 Dec 2008 02:13:01 +0100 (CET)
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103678>

In addition to checking if the provided port is numeric, also check
that the string isn't empty and that the port number is within the
valid range.  Incidentally, this silences a compiler warning about
ignoring strtol's return value.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 connect.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 584e04c..2f55ad2 100644
--- a/connect.c
+++ b/connect.c
@@ -480,8 +480,8 @@ char *get_port(char *host)
 	char *p = strchr(host, ':');
 
 	if (p) {
-		strtol(p+1, &end, 10);
-		if (*end == '\0') {
+		long port = strtol(p + 1, &end, 10);
+		if (end != p + 1 && *end == '\0' && 0 <= port && port < 65536) {
 			*p = '\0';
 			return p+1;
 		}
-- 
1.6.1.rc3.52.g589372
