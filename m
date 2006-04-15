From: Linus Torvalds <torvalds@osdl.org>
Subject: Clean up trailing whitespace when pretty-printing commits
Date: Fri, 14 Apr 2006 21:20:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604142118550.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Apr 15 06:21:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUcHc-0007gg-D3
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 06:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWDOEU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 00:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWDOEU7
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 00:20:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030230AbWDOEU7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Apr 2006 00:20:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3F4KstH018283
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Apr 2006 21:20:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3F4Kpfj023856;
	Fri, 14 Apr 2006 21:20:52 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18725>


Partly because we've messed up and now have some commits with trailing 
whitespace, but partly because this also just simplifies the code, let's 
remove trailing whitespace from the end when pretty-printing commits.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/commit.c b/commit.c
index c7bb8db..ca25574 100644
--- a/commit.c
+++ b/commit.c
@@ -557,16 +557,11 @@ unsigned long pretty_print_commit(enum c
 		if (fmt == CMIT_FMT_ONELINE)
 			break;
 	}
-	if (fmt == CMIT_FMT_ONELINE) {
-		/* We do not want the terminating newline */
-		if (buf[offset - 1] == '\n')
-			offset--;
-	}
-	else {
-		/* Make sure there is an EOLN */
-		if (buf[offset - 1] != '\n')
-			buf[offset++] = '\n';
-	}
+	while (offset && isspace(buf[offset-1]))
+		offset--;
+	/* Make sure there is an EOLN for the non-oneline case */
+	if (fmt != CMIT_FMT_ONELINE)
+		buf[offset++] = '\n';
 	buf[offset] = '\0';
 	return offset;
 }
