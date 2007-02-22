From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Added "-kb" to all the entries lines sent to the client
Date: Thu, 22 Feb 2007 16:06:42 +0000
Message-ID: <200702221606.42638.andyparkins@gmail.com>
References: <200702221504.32848.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 22 17:08:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKGT9-0004Pp-Gh
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 17:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933107AbXBVQGs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 11:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933111AbXBVQGs
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 11:06:48 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:63809 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933107AbXBVQGr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 11:06:47 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 22 Feb 2007 16:08:59 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HKGSz-0005Dh-00
	for <git@vger.kernel.org>; Thu, 22 Feb 2007 16:06:45 +0000
In-Reply-To: <200702221504.32848.andyparkins@gmail.com>
X-TUID: 0bf9f15ad583d21f
X-UID: 250
X-Length: 3383
Content-Disposition: inline
X-OriginalArrivalTime: 22 Feb 2007 16:08:59.0750 (UTC) FILETIME=[C328D060:01C7569B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40351>

git doesn't distinguish between binary and text files - so force the
client to do the same by sending everything as a binary.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
DON'T APPLY TO REPOSITORY

Turns out the CVS protocol isn't as hard as I thought.

http://soc.if.usp.br/doc/cvs/html-cvsclient/cvsclient_5.html#SEC6

Was all I needed.  I've changed every entries line to send "-kb" as one of
options.  I believe this will make all files into binaries as far as CVS
clients are concerned.

I am certain this is too heavy handed for most users.  I submit this patch
only to help other poor souls who might have the same problem in the
future.  (Hello poor soul).

Perhaps when the whole .gitattributes system has settled down that could be
used to conditionally set -kb

 git-cvsserver.perl |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index f6ddf34..e8d74ae 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -374,7 +374,7 @@ sub req_add
 
         print "Checked-in $dirpart\n";
         print "$filename\n";
-        print "/$filepart/0///\n";
+        print "/$filepart/0//-kb/\n";
 
         $addcount++;
     }
@@ -455,7 +455,7 @@ sub req_remove
 
         print "Checked-in $dirpart\n";
         print "$filename\n";
-        print "/$filepart/-1.$wrev///\n";
+        print "/$filepart/-1.$wrev//-kb/\n";
 
         $rmcount++;
     }
@@ -726,7 +726,7 @@ sub req_co
        print $state->{CVSROOT} . "/$module/" . ( defined ( $git->{dir} ) and 
$git->{dir} ne "./" ? $git->{dir} . "/" : "" ) . "$git->{name}\n";
 
         # this is an "entries" line
-        print "/$git->{name}/1.$git->{revision}///\n";
+        print "/$git->{name}/1.$git->{revision}//-kb/\n";
         # permissions
         print "u=$git->{mode},g=$git->{mode},o=$git->{mode}\n";
 
@@ -917,8 +917,8 @@ sub req_update
 		print $state->{CVSROOT} . "/$state->{module}/$filename\n";
 
 		# this is an "entries" line
-		$log->debug("/$filepart/1.$meta->{revision}///");
-		print "/$filepart/1.$meta->{revision}///\n";
+		$log->debug("/$filepart/1.$meta->{revision}//-kb/");
+		print "/$filepart/1.$meta->{revision}//-kb/\n";
 
 		# permissions
 		$log->debug("SEND : u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}");
@@ -961,8 +961,8 @@ sub req_update
                     print "Update-existing $dirpart\n";
                     
$log->debug($state->{CVSROOT} . "/$state->{module}/$filename");
                     print 
$state->{CVSROOT} . "/$state->{module}/$filename\n";
-                    $log->debug("/$filepart/1.$meta->{revision}///");
-                    print "/$filepart/1.$meta->{revision}///\n";
+                    $log->debug("/$filepart/1.$meta->{revision}//-kb/");
+                    print "/$filepart/1.$meta->{revision}//-kb/\n";
                 }
             }
             elsif ( $return == 1 )
@@ -975,7 +975,7 @@ sub req_update
                 {
                     print "Update-existing $dirpart\n";
                     print 
$state->{CVSROOT} . "/$state->{module}/$filename\n";
-                    print "/$filepart/1.$meta->{revision}/+//\n";
+                    print "/$filepart/1.$meta->{revision}/+/-kb/\n";
                 }
             }
             else
@@ -1207,7 +1207,7 @@ sub req_ci
         } else {
             print "Checked-in $dirpart\n";
             print "$filename\n";
-            print "/$filepart/1.$meta->{revision}///\n";
+            print "/$filepart/1.$meta->{revision}//-kb/\n";
         }
     }
 
-- 
1.5.0.1.51.g5a369
