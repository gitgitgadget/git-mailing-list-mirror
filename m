From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Add -u option to cg-log to show only commits from a
	specific user
Date: Thu, 12 May 2005 23:58:45 +0200
Message-ID: <1115935125.18499.74.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qeN+KEWqw33O1309QXf8"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 23:52:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWLaN-0002r1-St
	for gcvg-git@gmane.org; Thu, 12 May 2005 23:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVELV6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 17:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVELV6w
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 17:58:52 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:10673 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262153AbVELV6V
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 17:58:21 -0400
Received: from pegasus (p5487C16D.dip.t-dialin.net [84.135.193.109])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4CLxhWX019343
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 12 May 2005 23:59:44 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.83/875/Tue May 10 13:27:59 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-qeN+KEWqw33O1309QXf8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch introduces the -u option for cg-log. Now you can give
a username or a part of an username and only commits with a matching
author or committer will be displayed. Based on a patch from Sean.

Regards

Marcel


Signed-off-by: Marcel Holtmann <marcel@holtmann.org>


--=-qeN+KEWqw33O1309QXf8
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: cg-log
===================================================================
--- 7fa81b554162c34c616e74392960939412d18081/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -15,6 +15,9 @@
 #
 # Takes an -f option to list which files was changed.
 #
+# Takes -u"username" to list only commits where author or
+# committer contains username.
+#
 # Takes an -r followed with id resolving to a commit to start from
 # (HEAD by default), or id1:id2 representing an (id1;id2] range
 # of commits to show.
@@ -34,6 +37,7 @@
 colsignoff=
 coldefault=
 list_files=
+user=
 while [ "$1" ]; do
 	# TODO: Parse -r here too.
 	case "$1" in
@@ -51,6 +55,10 @@
 		list_files=1
 		shift
 		;;
+	-u*)
+		user="${1#-u}"
+		shift
+		;;
 	*)
 		break
 		;;
@@ -123,6 +131,9 @@
 		parent=$(git-cat-file commit $commit | sed -n '2s/parent //p;2Q')
 		[ "$parent" ] && [ "$(git-diff-tree -r $commit $parent "$@")" ] || continue
 	fi
+	if [ "$user" ]; then
+		git-cat-file commit $commit | grep -e '^author ' -e '^committer ' | grep -qi "$user" || continue
+	fi
 	echo $colheader""commit ${commit%:*} $coldefault;
 	git-cat-file commit $commit | \
 		while read key rest; do

--=-qeN+KEWqw33O1309QXf8--

