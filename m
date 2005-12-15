From: Pavel Roskin <proski@gnu.org>
Subject: Re: qgit reports errors in the git repository
Date: Thu, 15 Dec 2005 00:27:57 -0500
Message-ID: <1134624477.5360.6.camel@dv>
References: <1134433440.3798.27.camel@dv>
	 <Pine.LNX.4.64.0512121700010.15597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Thu Dec 15 06:29:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emlf4-0007LG-Fh
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 06:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbVLOF2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 00:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbVLOF2L
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 00:28:11 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:7332 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161122AbVLOF2K
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 00:28:10 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Emldd-0003oi-9j
	for git@vger.kernel.org; Thu, 15 Dec 2005 00:26:45 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Emlen-0008Lm-NQ; Thu, 15 Dec 2005 00:27:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512121700010.15597@g5.osdl.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13678>

On Mon, 2005-12-12 at 17:06 -0800, Linus Torvalds wrote:
> 
> Basically, qgit should do either:
> 
>  - check the type of the object by hand first (using "git-cat-file -t" and 
>    then follow any tags it finds by hand)

I'm a complete Qt newbie, but this patch seems to work for me.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/src/git_startup.cpp b/src/git_startup.cpp
index e08d466..1f6e9ad 100644
--- a/src/git_startup.cpp
+++ b/src/git_startup.cpp
@@ -111,6 +111,10 @@ bool Git::getRefs() {
 
 		if (itNext != rLst.constEnd() && (*itNext).right(3) == "^{}") {
 			signedTag = true;
+			if (!run("git-cat-file -t " + refSha, &runOutput))
+				continue; // invalid SHA1
+			if (runOutput != "tag\n")
+				continue; // not a tag
 			if (run("git-cat-file tag " + refSha, &runOutput)) {
 				QString msg(runOutput.section("\n\n", 1));
 				if (!msg.isEmpty())


-- 
Regards,
Pavel Roskin
