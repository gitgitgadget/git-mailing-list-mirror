X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: reorganize cvs-migration.txt
Date: Thu, 7 Dec 2006 22:34:00 -0500
Message-ID: <20061208033400.GD30129@fieldses.org>
References: <4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org> <Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061206171950.GD1714@fieldses.org> <20061206172450.GE1714@fieldses.org> <7v7ix47wbr.fsf@assigned-by-dhcp.cox.net> <20061207041805.GC3457@fieldses.org> <Pine.LNX.4.63.0612071522080.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061207174306.GC16858@fieldses.org> <Pine.LNX.4.63.0612071849340.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 03:34:13 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612071849340.28348@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33654>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsWUz-0006PM-Uq for gcvg-git@gmane.org; Fri, 08 Dec
 2006 04:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424177AbWLHDeF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 22:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424174AbWLHDeF
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 22:34:05 -0500
Received: from mail.fieldses.org ([66.93.2.214]:50177 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1424177AbWLHDeD (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 22:34:03 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GsWUq-0000xu-2S; Thu, 07 Dec 2006
 22:34:00 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Thu, Dec 07, 2006 at 06:50:50PM +0100, Johannes Schindelin wrote:
> Even easier:
> 
> $ mkdir /pub/my-repo.git
> $ cd /pub/my-repo.git
> $ git --bare init-db --shared
> $ git --bare fetch /home/alice/myproject master:master
> 
> (Totally untested, of course.)

Of course--for some reason I didn't think of doing init-db with --bare.
Thanks again.

--b.

From 22e5bdd9de398f29dfb11125a0921bb4529e2ab7 Mon Sep 17 00:00:00 2001
From: J. Bruce Fields <bfields@citi.umich.edu>
Date: Thu, 7 Dec 2006 22:32:28 -0500
Subject: [PATCH] Documentation: simpler shared repository creation

Take Johannes Schindelin's suggestion for a further simplification of the
shared repository creation using git --bare init-db --shared.

Also fix a mistake from the previous patch: I forgot to remove the manual setup
which the --shared does for us.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/cvs-migration.txt |   27 ++++++++-------------------
 1 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 4fab0d7..20c5719 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -76,23 +76,15 @@ possibly created from scratch or from a tarball (see the
 link:tutorial.html[tutorial]), or imported from an already existing CVS
 repository (see the next section).
 
-Assume your existing repo is at /home/alice/myproject.  Create a temporary
-empty shared repository and fetch your project into it:
+Assume your existing repo is at /home/alice/myproject.  Create a new "bare"
+repository (a repository without a working tree) and fetch your project into
+it:
 
 ------------------------------------------------
-$ mkdir /pub/temporary
-$ cd /pub/temporary
-$ git init-db --shared
-$ git fetch /home/alice/myproject master:master
-------------------------------------------------
-
-Then create a "bare" repository at /pub/repo.git by just moving the contents of
-the .git directory there.  The temporary repository can then be discarded.
-
-------------------------------------------------
-$ mv .git /pub/repo.git
-$ cd ..
-$ rm -rf temporary
+$ mkdir /pub/my-repo.git
+$ cd /pub/my-repo.git
+$ git --bare init-db --shared
+$ git --bare fetch /home/alice/myproject master:master
 ------------------------------------------------
 
 Next, give every team member read/write access to this repository.  One
@@ -105,10 +97,7 @@ Put all the committers in the same group, and make the repository
 writable by that group:
 
 ------------------------------------------------
-$ cd /pub
-$ chgrp -R $group repo.git
-$ find repo.git -mindepth 1 -type d |xargs chmod ug+rwx,g+s
-$ GIT_DIR=repo.git git repo-config core.sharedrepository true
+$ chgrp -R $group /pub/my-repo.git
 ------------------------------------------------
 
 Make sure committers have a umask of at most 027, so that the directories
-- 
1.4.4.1.GIT
