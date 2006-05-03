From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: segfault bug in internal git grep from next
Date: Wed, 3 May 2006 10:32:29 +0200
Message-ID: <20060503083229.GA15579@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
X-From: git-owner@vger.kernel.org Wed May 03 10:32:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbCmg-00031u-MI
	for gcvg-git@gmane.org; Wed, 03 May 2006 10:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWECIcc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 04:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWECIcb
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 04:32:31 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:51367 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S965123AbWECIcb
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 May 2006 04:32:31 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1FbCmb-0002xG-Qj
	for git@vger.kernel.org; Wed, 03 May 2006 10:32:29 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19462>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello!

I'm using the next branch as of commit 6a40327d242dac9f85c6d63c94d537b45ba86e89

A segfault occurs in using the new builtin grep when using it on a
binary file, so no regular \n endings.

A testcase is the attached (if it survives the vger filters) "git.png"
icon as it is used for example on the http://www.kernel.org/git website.

I tried the obvious, this is the line that gives the segfault:

diff --git a/builtin-grep.c b/builtin-grep.c
index 09e3677..5d4f319 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -121,7 +121,7 @@ static void compile_patterns(struct grep
 static char *end_of_line(char *cp, unsigned long *left)
 {
 	unsigned long l = *left;
-	while (l && *cp != '\n') {
+	while (l && *cp && *cp != '\n') {
 		l--;
 		cp++;
 	}

but it did not solve the problem. Unfortunately I have no time at the
moment to investigate further, so just this report at the moment.

On a side-note it might be handy to add the icon to the main git
repository and to use it in (new) test cases for git grep. Of course
grepping in binary files is mostly not very useful, but lots of
real-world repo's have some binaries.
-- 
Marco Roeland

--/04w6evG8XlLl3ft
Content-Type: image/png
Content-Description: git.png
Content-Disposition: attachment; filename="git.png"
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAEgAAAAbBAMAAAAt2dQtAAAAGFBMVEX///9gYF2wr6oAgADO
zcfAAADo6Ob39/aVDKdHAAAAc0lEQVQoz2NIZyAESlwYCggqYlNhIAIIDWlFrKGhATAMk2A2
JlKRsQER1uFVZGxszGxsDKIMcCpiBirBYh2zAQJTpAjoAAMYJlYR1OEglxvgtA41JHEpgpkw
uJMKEblFiMGNoKJEIQYnQYJAhcFFiSBwAQCkPSHFEhya/gAAAABJRU5ErkJggg==

--/04w6evG8XlLl3ft--
