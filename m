From: Rogan Dawes <rogan@dawes.za.net>
Subject: [PATCH] Allow git-mergetool to handle paths with a leading space
Date: Sun, 06 Jan 2008 11:25:18 +0200
Message-ID: <47809E7E.2090708@dawes.za.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040300030001060405080704"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 10:29:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBRp4-0005aD-VA
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 10:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbYAFJ3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 04:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYAFJ3L
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 04:29:11 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:53870 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbYAFJ3K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 04:29:10 -0500
Received: from spunkymail-a2.g.dreamhost.com (balanced.mail.policyd.dreamhost.com [208.97.132.119])
	by hapkido.dreamhost.com (Postfix) with ESMTP id E41371783AE
	for <git@vger.kernel.org>; Sun,  6 Jan 2008 01:29:09 -0800 (PST)
Received: from [192.168.201.100] (dsl-243-127-236.telkomadsl.co.za [41.243.127.236])
	by spunkymail-a2.g.dreamhost.com (Postfix) with ESMTP id C514C88014
	for <git@vger.kernel.org>; Sun,  6 Jan 2008 01:26:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69721>

This is a multi-part message in MIME format.
--------------040300030001060405080704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Signed-off-by: Rogan Dawes <rogan@dawes.za.net>

---
I am working on a project which has the root directory constructed with 
a leading space. i.e. ./ dir/. "read" skips the leading space char, and 
ends up with an incorrect filename, which can then not be found. Setting 
IFS=\n solves this problem.

Thanks to Mikachu and Tv on #git for assistance and suggestions.

Unfortunately, Thunderbird is not very easy to convince not to mangle 
patches, so I am attaching the patch as well. Sorry.

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 2f31fa2..8521ca3 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -394,7 +394,7 @@ if test $# -eq 0 ; then
                 exit 0
         fi
         echo Merging the files: $files
-       git ls-files -u | sed -e 's/^[^ ]*      //' | sort -u | while read i
+       git ls-files -u | sed -e 's/^[^ ]*      //' | sort -u | while 
IFS=\n read i
         do
                 printf "\n"
                 merge_file "$i" < /dev/tty > /dev/tty

--------------040300030001060405080704
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 2f31fa2..8521ca3 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -394,7 +394,7 @@ if test $# -eq 0 ; then
 		exit 0
 	fi
 	echo Merging the files: $files
-	git ls-files -u | sed -e 's/^[^	]*	//' | sort -u | while read i
+	git ls-files -u | sed -e 's/^[^	]*	//' | sort -u | while IFS=\n read i
 	do
 		printf "\n"
 		merge_file "$i" < /dev/tty > /dev/tty

--------------040300030001060405080704--
