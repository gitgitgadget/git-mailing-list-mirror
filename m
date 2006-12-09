X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: reorganize cvs-migration.txt
Date: Fri, 8 Dec 2006 22:58:50 -0500
Message-ID: <20061209035850.GA18204@fieldses.org>
References: <Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061206171950.GD1714@fieldses.org> <20061206172450.GE1714@fieldses.org> <7v7ix47wbr.fsf@assigned-by-dhcp.cox.net> <20061207041805.GC3457@fieldses.org> <Pine.LNX.4.63.0612071522080.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061207174306.GC16858@fieldses.org> <Pine.LNX.4.63.0612071849340.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061208033400.GD30129@fieldses.org> <7vmz5yn92a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 03:59:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vmz5yn92a.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33795>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GstMY-000381-Of for gcvg-git@gmane.org; Sat, 09 Dec
 2006 04:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758154AbWLID6w (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 22:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758306AbWLID6w
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 22:58:52 -0500
Received: from mail.fieldses.org ([66.93.2.214]:60506 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758154AbWLID6v (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 22:58:51 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GstMQ-0006dn-Lf; Fri, 08 Dec 2006
 22:58:50 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, Dec 07, 2006 at 11:25:17PM -0800, Junio C Hamano wrote:
> Well, this does not apply at all, as I do not have a commit with
> 4fab0d7 blob and already applied the reordering patch from you.

OK, sorry for the confusion.

> Could you fix up and send again after I push out the latest?

Definitely.  Is this better?

--b.

Documentation: simpler shared repository creation

Take Johannes Schindelin's suggestions for a further simplification of
the shared repository creation using git --bare init-db --shared, and
for a simplified cvsimport using an existing CVS working directory.

Also insert more man page references.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

 cvs-migration.txt |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

---

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 47846bd..b657f45 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -43,8 +43,8 @@ Pull: refs/heads/master:refs/remotes/origin/master
 ------------
 ================================
 
-You can update the shared repository with your changes by first commiting
-your changes, and then using:
+You can update the shared repository with your changes by first committing
+your changes, and then using the gitlink:git-push[1] command:
 
 ------------------------------------------------
 $ git push origin master
@@ -76,11 +76,15 @@ possibly created from scratch or from a tarball (see the
 link:tutorial.html[tutorial]), or imported from an already existing CVS
 repository (see the next section).
 
-If your project's working directory is /home/alice/myproject, you can
-create a shared repository at /pub/repo.git with:
+Assume your existing repo is at /home/alice/myproject.  Create a new "bare"
+repository (a repository without a working tree) and fetch your project into
+it:
 
 ------------------------------------------------
-$ git clone -bare /home/alice/myproject /pub/repo.git
+$ mkdir /pub/my-repo.git
+$ cd /pub/my-repo.git
+$ git --bare init-db --shared
+$ git --bare fetch /home/alice/myproject master:master
 ------------------------------------------------
 
 Next, give every team member read/write access to this repository.  One
@@ -93,10 +97,7 @@ Put all the committers in the same group, and make the repository
 writable by that group:
 
 ------------------------------------------------
-$ cd /pub
-$ chgrp -R $group repo.git
-$ find repo.git -mindepth 1 -type d |xargs chmod ug+rwx,g+s
-$ GIT_DIR=repo.git git repo-config core.sharedrepository true
+$ chgrp -R $group /pub/my-repo.git
 ------------------------------------------------
 
 Make sure committers have a umask of at most 027, so that the directories
@@ -107,15 +108,15 @@ Importing a CVS archive
 
 First, install version 2.1 or higher of cvsps from
 link:http://www.cobite.com/cvsps/[http://www.cobite.com/cvsps/] and make
-sure it is in your path.  The magic command line is then
+sure it is in your path.  Then cd to a checked out CVS working directory
+of the project you are interested in and run gitlink:git-cvsimport[1]:
 
 -------------------------------------------
-$ git cvsimport -v -d <cvsroot> -C <destination> <module>
+$ git cvsimport -C <destination>
 -------------------------------------------
 
 This puts a git archive of the named CVS module in the directory
-<destination>, which will be created if necessary.  The -v option makes
-the conversion script very chatty.
+<destination>, which will be created if necessary.
 
 The import checks out from CVS every revision of every file.  Reportedly
