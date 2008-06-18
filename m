From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/4] Split up default "user" config parsing into helper
 routine
Date: Wed, 18 Jun 2008 15:31:08 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806181530420.2907@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Denis Bueno <dbueno@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 00:34:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K96Ef-0004V9-L4
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 00:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326AbYFRWcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 18:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757227AbYFRWc2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 18:32:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40315 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757221AbYFRWc0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 18:32:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IMV9oP017071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jun 2008 15:31:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IMV85b024108;
	Wed, 18 Jun 2008 15:31:08 -0700
In-Reply-To: <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.853 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85418>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Jun 2008 14:40:35 -0700
Subject: [PATCH 2/4] Split up default "user" config parsing into helper routine

This follows the example of the "core" config, and splits out the
default "user" config option parsing into a helper routine.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 config.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index c3597e0..ee7642b 100644
--- a/config.c
+++ b/config.c
@@ -464,11 +464,8 @@ static int git_default_core_config(const char *var, const char *value)
 	return 0;
 }
 
-int git_default_config(const char *var, const char *value, void *dummy)
+static int git_default_user_config(const char *var, const char *value)
 {
-	if (!prefixcmp(var, "core."))
-		return git_default_core_config(var, value);
-
 	if (!strcmp(var, "user.name")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -487,6 +484,18 @@ int git_default_config(const char *var, const char *value, void *dummy)
 		return 0;
 	}
 
+	/* Add other config variables here and to Documentation/config.txt. */
+	return 0;
+}
+
+int git_default_config(const char *var, const char *value, void *dummy)
+{
+	if (!prefixcmp(var, "core."))
+		return git_default_core_config(var, value);
+
+	if (!prefixcmp(var, "user."))
+		return git_default_user_config(var, value);
+
 	if (!strcmp(var, "i18n.commitencoding"))
 		return git_config_string(&git_commit_encoding, var, value);
 
-- 
1.5.6.rc3.7.g336d0.dirty
