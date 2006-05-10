From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Tue, 9 May 2006 20:48:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605092043270.3718@g5.osdl.org>
References: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 05:48:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fdfgp-0000Bz-F3
	for gcvg-git@gmane.org; Wed, 10 May 2006 05:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWEJDsk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 23:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWEJDsk
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 23:48:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62436 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964796AbWEJDsk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 23:48:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4A3mStH007408
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 May 2006 20:48:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4A3mRpl001054;
	Tue, 9 May 2006 20:48:27 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19869>



On Tue, 9 May 2006, Junio C Hamano wrote:
> 
> * The 'pu' branch, in addition, has the proposed configuration
>   file syntax updates from Linus with a patch from Sean.  I
>   haven't had time to really look at it, and it seems to fail a
>   test right now, but I left it as is.

The reason for the failure is the new syntax for multi-section variables.

This patch makes the test succed, by changing

	[1.2.3]

into

	[1 "2.3"]

which is how subsections now end up being shown (you can still _parse_ 
them the old way, but they get created the new way, which is why the test 
fails)

That's a very strange test-case, and on the face of it the new syntax 
looks "worse", but if you were to be realistic about this kind of section 
name, it would more likely explain _what_ that number sequence means, so 
you would more realistically name your sections something like

	[version "1.2.3"]

which I think everybody agrees looks nicer than

	[version.1.2.3]

or similar.

Of course, I don't think we currently actually have any _users_ of any 
multi-level section names at all, so this is all entirely theoretical 
until we start actually using them.

		Linus
---
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 7090ea9..54b3394 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -241,7 +241,7 @@ # empty line
 	NoNewLine = wow2 for me
 [123456]
 	a123 = 987
-[1.2.3]
+[1 "2.3"]
 	alpha = beta
 EOF
 
