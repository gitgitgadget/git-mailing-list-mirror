From: Bernd Ahlers <bernd@ba-net.org>
Subject: [PATCH] 64-bit fix for date.c.
Date: Mon, 6 Apr 2009 19:26:37 +0200
Message-ID: <20090406172637.GA17437@jenna.bytemine.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 19:55:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqt36-0002GO-JG
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 19:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbZDFRyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 13:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbZDFRyY
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 13:54:24 -0400
Received: from alk.gottorp.bytemine.net ([62.153.215.156]:34365 "EHLO
	mail4.bytemine.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbZDFRyX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 13:54:23 -0400
X-Greylist: delayed 1646 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2009 13:54:23 EDT
Received: from andor.bytemine.net ([134.106.146.206]:51060 helo=jenna.bytemine.net)
	by mail4.bytemine.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <bernd@ba-net.org>)
	id 1Lqsaw-0006QW-L6
	for git@vger.kernel.org; Mon, 06 Apr 2009 19:26:51 +0200
Received: from jenna.bytemine.net (bernd@localhost [127.0.0.1])
	by jenna.bytemine.net (8.14.3/8.14.3) with ESMTP id n36HQc2l000296
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 6 Apr 2009 19:26:38 +0200 (CEST)
Received: (from bernd@localhost)
	by jenna.bytemine.net (8.14.3/8.14.3/Submit) id n36HQbnV024337
	for git@vger.kernel.org; Mon, 6 Apr 2009 19:26:37 +0200 (CEST)
X-Authentication-Warning: jenna.bytemine.net: bernd set sender to bernd@ba-net.org using -f
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115859>

Hello!

This unbreaks the localtime_r call on OpenBSD/sparc64 and removes
the following compiler warning.

"passing arg 1 of `localtime_r' from incompatible pointer type"
---
 date.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/date.c b/date.c
index 1165d30..409a17d 100644
--- a/date.c
+++ b/date.c
@@ -871,13 +871,15 @@ unsigned long approxidate(const char *date)
 	int number = 0;
 	struct tm tm, now;
 	struct timeval tv;
+	time_t time_sec;
 	char buffer[50];
 
 	if (parse_date(date, buffer, sizeof(buffer)) > 0)
 		return strtoul(buffer, NULL, 10);
 
 	gettimeofday(&tv, NULL);
-	localtime_r(&tv.tv_sec, &tm);
+	time_sec = tv.tv_sec;
+	localtime_r(&time_sec, &tm);
 	now = tm;
 	for (;;) {
 		unsigned char c = *date;
-- 
1.6.2.2
