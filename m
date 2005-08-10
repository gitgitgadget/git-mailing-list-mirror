From: John Ellson <ellson@research.att.com>
Subject: [PATCH] cg-cat   [was: Re: Newbie question:  equiv of:  cvs co -p
 <filename>  ? ]
Date: Wed, 10 Aug 2005 10:38:08 -0400
Message-ID: <42FA1150.7090506@research.att.com>
References: <ddb8vl$ifq$1@sea.gmane.org> <Pine.LNX.4.58.0508091725120.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020709080303080900070204"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 16:40:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2rj0-0006hW-02
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 16:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVHJOi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 10:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVHJOi0
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 10:38:26 -0400
Received: from mail-red.research.att.com ([192.20.225.110]:10119 "EHLO
	mail-white.research.att.com") by vger.kernel.org with ESMTP
	id S965134AbVHJOiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 10:38:25 -0400
Received: from [135.207.24.103] (ellson.research.att.com [135.207.24.103])
	by bigmail.research.att.com (8.13.3+Sun/8.11.6) with ESMTP id j7AEcxZl026568;
	Wed, 10 Aug 2005 10:38:59 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
Newsgroups: gmane.comp.version-control.git
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508091725120.3258@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------020709080303080900070204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Tue, 9 Aug 2005, John Ellson wrote:
> 
>>I hacked this:

> No. ...

> So you could do something like ...

> (totally untested)
> 
> 		Linus


Thanks Linus, also Rene and Johannes.

I applied a bit of polish and testing and now I'm ready to offer
my first contribution to cogito.

	cg-cat [-r rev] FILE

I hope that this is useful to others.


Signed-off-by: John Ellson <ellson@research.att.com>

---

--------------020709080303080900070204
Content-Type: text/x-patch;
 name="patch0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch0.patch"

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -14,11 +14,11 @@ INSTALL?=install
 
 SCRIPT=	commit-id tree-id parent-id cg-add cg-admin-lsobj cg-admin-uncommit \
 	cg-branch-add cg-branch-ls cg-reset cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-merge cg-mkpatch cg-patch \
 	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update \
-	cg cg-admin-ls cg-push cg-branch-chg
+	cg cg-admin-ls cg-push cg-branch-chg cg-cat
 
 LIB_SCRIPT=cg-Xlib cg-Xmergefile cg-Xnormid
 
 GEN_SCRIPT= cg-version
 
diff --git a/cg-cat b/cg-cat
new file mode 100755
--- /dev/null
+++ b/cg-cat
@@ -0,0 +1,42 @@
+#!/bin/sh
+#
+# Cat a file(s) by filename from a GIT repository.
+
+# Initiated from a request from:		    erg@research.att.com
+#   for an equivalent to "cvs co -p <filename>"
+# Question posted with really bad initial solution: ellson@research.att.com
+# Suggestions offered by:			    Johannes.Schindelin@gmx.de
+#						    rene.scharfe@lsrfire.ath.cx
+# This solution based on posting from:		    torvalds@osdl.org
+# Polish and test by:				    ellson@research.att.com
+
+USAGE="cg-cat [-r rev] FILE"
+
+. ${COGITO_LIB}cg-Xlib
+
+default=HEAD
+while optparse; do
+	if optparse -r; then
+		default="$OPTARG"
+	else
+		optfail
+	fi
+done
+
+[ "$ARGS" ] || usage
+
+git-ls-tree $(git-rev-parse --default $default "${ARGS[@]}") |
+	while read mode type sha name
+	do
+		case "$type" in
+		blob)
+			git-cat-file blob "$sha"
+			;;
+		tree)
+			git-ls-tree "$sha"
+			;;
+		*)
+			exit 1
+			;;
+		esac
+	done

--------------020709080303080900070204--
