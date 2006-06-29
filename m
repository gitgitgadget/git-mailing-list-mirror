From: Luca Barbato <lu_zero@gentoo.org>
Subject: Re: [patch] Make git-svn init accept a target dir
Date: Thu, 29 Jun 2006 02:41:14 +0200
Message-ID: <44A321AA.6080703@gentoo.org>
References: <44A30BAD.60907@gentoo.org> <20060629002852.GA29147@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090207090705040003090005"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 02:41:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvkb9-0001Ag-Ad
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 02:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWF2AlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 20:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWF2AlT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 20:41:19 -0400
Received: from smtp0.libero.it ([193.70.192.33]:43741 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S932096AbWF2AlR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 20:41:17 -0400
Received: from localhost (172.16.1.246) by smtp0.libero.it (7.0.027-DD01)
        id 446C5C4E02AAFB11; Thu, 29 Jun 2006 02:41:16 +0200
Received: from smtp2.libero.it ([172.16.1.225])
 by localhost (asav14.libero.it [193.70.193.42]) (amavisd-new, port 10024)
 with ESMTP id 07263-02; Thu, 29 Jun 2006 02:41:16 +0200 (CEST)
Received: from [192.168.0.6] (adsl-ull-62-62.44-151.net24.it [151.44.62.62])
	by smtp2.libero.it (Postfix) with ESMTP id 13886A8C14;
	Thu, 29 Jun 2006 02:41:15 +0200 (MEST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060629002852.GA29147@hand.yhbt.net>
X-Enigmail-Version: 0.94.0.0
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22830>

This is a multi-part message in MIME format.
--------------090207090705040003090005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Eric Wong wrote:

> 
> Sounds useful and I'll probably accept it, but I don't see the actual
> patch, though...
> 

ops...

-- 

Luca Barbato

Gentoo/linux Gentoo/PPC
http://dev.gentoo.org/~lu_zero


--------------090207090705040003090005
Content-Type: text/plain;
 name="git-svn-init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-svn-init.patch"

--- /usr/bin/git-svn	2006-06-29 00:57:26.000000000 +0200
+++ /usr/bin/git-svn.new	2006-06-28 03:40:11.000000000 +0200
@@ -5,7 +5,7 @@
 use strict;
 use vars qw/	$AUTHOR $VERSION
 		$SVN_URL $SVN_INFO $SVN_WC $SVN_UUID
-		$GIT_SVN_INDEX $GIT_SVN
+		$GIT_SVN_INDEX $GIT_SVN $REPO_PATH
 		$GIT_DIR $REV_DIR/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '1.1.0-pre';
@@ -98,6 +98,7 @@
 $GIT_SVN ||= $ENV{GIT_SVN_ID} || 'git-svn';
 $GIT_SVN_INDEX = "$GIT_DIR/$GIT_SVN/index";
 $SVN_URL = undef;
+$REPO_PATH = undef;
 $REV_DIR = "$GIT_DIR/$GIT_SVN/revs";
 $SVN_WC = "$GIT_DIR/$GIT_SVN/tree";
 
@@ -227,6 +228,16 @@
 sub init {
 	$SVN_URL = shift or die "SVN repository location required " .
 				"as a command-line argument\n";
+        $REPO_PATH = shift;
+        
+        if ($REPO_PATH) {
+            unless (-d $REPO_PATH) {
+                mkpath([$REPO_PATH]);
+            }
+            $GIT_DIR=$REPO_PATH . "/.git";
+            $ENV{GIT_DIR}=$GIT_DIR;
+        }
+
 	unless (-d $GIT_DIR) {
 		sys('git-init-db');
 	}

--------------090207090705040003090005--
