From: Linus Torvalds <torvalds@osdl.org>
Subject: Make git config variable names case-insensitive
Date: Tue, 11 Oct 2005 18:09:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510111803540.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 12 03:10:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPV7c-000548-QQ
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 03:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVJLBJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 21:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVJLBJY
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 21:09:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17816 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932369AbVJLBJX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 21:09:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9C19A4s014511
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Oct 2005 18:09:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9C1991k007035;
	Tue, 11 Oct 2005 18:09:09 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9995>


They always were meant to be case-insensitive, but I had missed one 
"tolower()", making that not true.

The actual _values_ aren't case-insensitive, of course, although some uses 
of them may be (ie boolean parsing uses "strcasecmp()" to match against 
the strings "true" and "false").

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This should independent of the other patch - it should apply whether 
you've taken the [user]name/email config thing or not. But it was 
generated on top of that change.


diff --git a/config.c b/config.c
index cf80358..9b7c6f2 100644
--- a/config.c
+++ b/config.c
@@ -168,7 +168,7 @@ static int git_parse_file(config_fn_t fn
 		}
 		if (!isalpha(c))
 			break;
-		var[baselen] = c;
+		var[baselen] = tolower(c);
 		if (get_value(fn, var, baselen+1) < 0)
 			break;
 	}
