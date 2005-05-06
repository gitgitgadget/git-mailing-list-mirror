From: "Thomas Kolejka" <Thomas.Kolejka@gmx.at>
Subject: Re: How do I...
Date: Fri, 6 May 2005 21:35:07 +0200 (MEST)
Message-ID: <15316.1115408107@www80.gmx.net>
References: <Pine.LNX.4.58.0505061158520.2233@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 21:29:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU8VH-00073H-Rm
	for gcvg-git@gmane.org; Fri, 06 May 2005 21:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVEFTfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 15:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVEFTfV
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 15:35:21 -0400
Received: from pop.gmx.net ([213.165.64.20]:14785 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261276AbVEFTfI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 15:35:08 -0400
Received: (qmail 1909 invoked by uid 0); 6 May 2005 19:35:07 -0000
Received: from 141.130.250.71 by www80.gmx.net with HTTP;
	Fri, 6 May 2005 21:35:07 +0200 (MEST)
To: Linus Torvalds <torvalds@osdl.org>
X-Priority: 3 (Normal)
X-Authenticated: #20307258
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I've written a script that shows all commits when a certain file was
changed.

It goes back the commits, looks into the tree ... and if a change is found,
print out the commit.


Thomas



--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ git-file-history-script	2005-05-06 21:24:41.000000000 +0200
@@ -0,0 +1,59 @@
+#!/bin/sh
+# 
+# Copyright (C) 2005 Thomas Kolejka
+#
+# usage - $0 [commit] pathname
+
+
+if [ $# -gt 1 ]
+then
+	HEAD=$1
+	shift
+else
+	HEAD=`cat $SHA1_FILE_DIRECTORY/../HEAD`
+fi
+
+git-cat-file commit $HEAD >> /dev/null
+
+if [ $? -ne 0 ]
+then
+	exit
+fi
+
+f_name=$1
+
+
+echo "starting from commit $HEAD"
+
+last_sha1="last-revision"
+last_commit=$HEAD
+
+git-rev-list $HEAD | while read the_commit
+do
+
+	the_tree=`git-cat-file commit $the_commit|head -n1 | awk '{ print $2 }'`
+
+
+	the_sha1=`git-ls-tree -r $the_tree|grep -w "${f_name}$"|awk '{ print $3
}'`
+
+	if [ -z "$the_sha1" ]
+	then
+		continue
+	fi
+
+
+	if [ $last_sha1 != $the_sha1 ]
+	then
+		echo commit $the_commit - tree $the_tree - sha1 $the_sha1
+		echo " "
+		# echo "$the_sha1 -> $last_sha1"
+		last_sha1=$the_sha1
+		git-cat-file commit $last_commit
+
+		echo " "
+		echo " "
+		echo " "
+	fi
+
+	last_commit=$the_commit
+done

-- 
+++ Neu: Echte DSL-Flatrates von GMX - Surfen ohne Limits +++
Always online ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl
