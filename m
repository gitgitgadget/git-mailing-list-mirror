From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 9/9] vcs-svn: use strchr to find RFC822 delimiter
Date: Sat, 19 Mar 2011 18:03:51 +1100
Message-ID: <1300518231-20008-10-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:12:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qLH-0004uk-8u
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab1CSHMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:12:44 -0400
Received: from [119.15.97.146] ([119.15.97.146]:56523 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754159Ab1CSHMO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:12:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 0E1A9C04B;
	Sat, 19 Mar 2011 18:00:36 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SqeP7Pcygkp5; Sat, 19 Mar 2011 18:00:33 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id D1E32C054;
	Sat, 19 Mar 2011 18:00:28 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169394>

This is a small optimisation (4% reduction in user time) but is the largest
artifact within the parsing portion of svndump.c

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/svndump.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index fd67db8..7bc2d3d 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -296,10 +296,12 @@ void svndump_read(const char *url)
 
 	reset_dump_ctx(url);
 	while ((t = buffer_read_line(&input))) {
-		val = strstr(t, ": ");
+		val = strchr(t, ':');
 		if (!val)
 			continue;
 		*val++ = '\0';
+		if (*val != ' ')
+			continue;
 		*val++ = '\0';
 
 		/* strlen(key) */
-- 
1.7.3.2.846.gf4b062
