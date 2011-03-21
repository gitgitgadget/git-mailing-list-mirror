From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 11/11] vcs-svn: use strchr to find RFC822 delimiter
Date: Tue, 22 Mar 2011 10:50:00 +1100
Message-ID: <1300751400-7427-12-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 00:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1orv-0006bP-DI
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 00:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928Ab1CUXu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 19:50:27 -0400
Received: from mailhost.cordelta.com ([119.15.97.146]:62604 "EHLO
	mailhost.cordelta" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755913Ab1CUXuW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 19:50:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 8BF5CC050;
	Tue, 22 Mar 2011 10:46:55 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kj-in+aBaLNJ; Tue, 22 Mar 2011 10:46:47 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 2724EC05E;
	Tue, 22 Mar 2011 10:46:39 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169689>

This is a small optimisation (4% reduction in user time) but is the largest
artifact within the parsing portion of svndump.c

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/svndump.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 897349e..88abf60 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -301,10 +301,12 @@ void svndump_read(const char *url)
 
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
 
 		/* strlen(key) + 1 */
-- 
1.7.3.2.846.gf4b062
