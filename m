From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 2/2] Allow testing of _relative family of time formatting
	and parsing functions
Date: Fri, 28 Aug 2009 23:05:11 +0200
Message-ID: <20090828210511.GB11867@blimp.localdomain>
References: <20090828210404.GA11867@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 23:05:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh8db-0001J4-H0
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 23:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbZH1VF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 17:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbZH1VF0
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 17:05:26 -0400
Received: from mout6.freenet.de ([195.4.92.96]:44294 "EHLO mout6.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251AbZH1VF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 17:05:26 -0400
Received: from [195.4.92.20] (helo=10.mx.freenet.de)
	by mout6.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1Mh8dJ-0007g9-GX; Fri, 28 Aug 2009 23:05:17 +0200
Received: from x54ff.x.pppool.de ([89.59.84.255]:55906 helo=tigra.home)
	by 10.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #94)
	id 1Mh8dJ-0006Iq-73; Fri, 28 Aug 2009 23:05:17 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 8BDEC277D8;
	Fri, 28 Aug 2009 23:05:11 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 767AD36D28; Fri, 28 Aug 2009 23:05:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090828210404.GA11867@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127352>

To complement the testability of approxidate.
---
 test-date.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/test-date.c b/test-date.c
index 62e8f23..dcc7973 100644
--- a/test-date.c
+++ b/test-date.c
@@ -4,6 +4,17 @@ int main(int argc, char **argv)
 {
 	int i;
 
+	struct tm tm;
+	struct timeval when = {0, 0};
+	tm.tm_sec  = 0;
+	tm.tm_min  = 0;
+	tm.tm_hour = 12;
+	tm.tm_mday = 1;
+	tm.tm_mon  = 0  /* January */;
+	tm.tm_year = 90 /* 1990 */ ;
+	tm.tm_isdst = -1;
+	when.tv_sec = mktime(&tm);
+
 	for (i = 1; i < argc; i++) {
 		char result[100];
 		time_t t;
@@ -15,6 +26,12 @@ int main(int argc, char **argv)
 
 		t = approxidate(argv[i]);
 		printf("%s -> %s\n", argv[i], ctime(&t));
+
+		t = approxidate_relative(argv[i], &when);
+		printf("relative: %s -> %s\n", argv[i], ctime(&t));
+
+		printf("relative: %s, out of %s\n",
+		       show_date_relative(t, 0, &when), ctime(&t));
 	}
 	return 0;
 }
-- 
1.6.4.1.263.g468a
