From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Improve option parsing for cg-log
Date: Thu, 12 May 2005 22:51:54 +0200
Message-ID: <1115931114.18499.66.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-SnhEfCA+pLe1/jam9acV"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 22:44:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWKX9-0001Zv-8y
	for gcvg-git@gmane.org; Thu, 12 May 2005 22:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVELUvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 16:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVELUvg
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 16:51:36 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:8881 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262115AbVELUv3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 16:51:29 -0400
Received: from pegasus (p5487C16D.dip.t-dialin.net [84.135.193.109])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4CKqrWX018889
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 12 May 2005 22:52:54 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.83/875/Tue May 10 13:27:59 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-SnhEfCA+pLe1/jam9acV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch changes the option parsing, because otherwise we are
stuck to a specific order.

Regards

Marcel


Signed-off-by: Marcel Holtmann <marcel@holtmann.org>


--=-SnhEfCA+pLe1/jam9acV
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: cg-log
===================================================================
--- 456fffab323ed972b8e47fa0fb83c3b5cd9243d7/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -27,29 +27,34 @@
 # at least somewhere it does. Bash is broken.
 trap exit SIGPIPE
 
-if [ "$1" = "-c" ]; then
-	shift
-	# See terminfo(5), "Color Handling"
-	colheader="$(tput setaf 2)"    # Green
-	colauthor="$(tput setaf 6)"    # Cyan
-	colcommitter="$(tput setaf 5)" # Magenta
-	colfiles="$(tput setaf 4)"     # Blue
-	colsignoff="$(tput setaf 3)"   # Yellow
-	coldefault="$(tput op)"        # Restore default
-else
-	colheader=
-	colauthor=
-	colcommitter=
-	colfiles=
-	colsignoff=
-	coldefault=
-fi
-
+colheader=
+colauthor=
+colcommitter=
+colfiles=
+colsignoff=
+coldefault=
 list_files=
-if [ "$1" = "-f" ]; then
-	shift
-	list_files=1
-fi
+while [ "$1" ]; do
+	case "$1" in
+	-c)
+		# See terminfo(5), "Color Handling"
+		colheader="$(tput setaf 2)"    # Green
+		colauthor="$(tput setaf 6)"    # Cyan
+		colcommitter="$(tput setaf 5)" # Magenta
+		colfiles="$(tput setaf 4)"     # Blue
+		colsignoff="$(tput setaf 3)"   # Yellow
+		coldefault="$(tput op)"        # Restore default
+		shift
+		;;
+	-f)
+		list_files=1
+		shift
+		;;
+	*)
+		break
+		;;
+	esac
+done
 
 list_commit_files()
 {

--=-SnhEfCA+pLe1/jam9acV--

