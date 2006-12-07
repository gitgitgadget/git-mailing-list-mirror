X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: reorganize cvs-migration.txt
Date: Thu, 7 Dec 2006 12:43:06 -0500
Message-ID: <20061207174306.GC16858@fieldses.org>
References: <20061206.105251.144349770.wl@gnu.org> <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org> <Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061206171950.GD1714@fieldses.org> <20061206172450.GE1714@fieldses.org> <7v7ix47wbr.fsf@assigned-by-dhcp.cox.net> <20061207041805.GC3457@fieldses.org> <Pine.LNX.4.63.0612071522080.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 17:43:21 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612071522080.28348@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33600>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsNHB-0005ek-8B for gcvg-git@gmane.org; Thu, 07 Dec
 2006 18:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162585AbWLGRnM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 12:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162584AbWLGRnM
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 12:43:12 -0500
Received: from mail.fieldses.org ([66.93.2.214]:59941 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1162585AbWLGRnL (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 12:43:11 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GsNH0-0005oh-TZ; Thu, 07 Dec 2006
 12:43:06 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Thu, Dec 07, 2006 at 03:28:33PM +0100, Johannes Schindelin wrote:
> This is a laudable goal, and the order makes sense (put first that what 
> most people are interested in).
> 
> A few comments:

Thanks for the comments!  Patch, incremental against the previous one,
appended.

> - just skimming the patch, I found "commiting" (needs another "t"), and 
>   "-bare" (needs another "-").

Got it, thanks.

> - It might make more sense to "git init-db --shared" and fetch the initial 
>   revision into it, rather than clone it and then fix.

I do like the idea of anything that gets rid of the ugly find|xargs
chmod.  Result included below (untested).  Is that what you were
thinking of?

>   You might also want
>   to mention that the "--shared" of -clone is different in meaning from 
>   that of -init-db (make just a footnote of it, to avoid intimidating 
>   readers).

I'm ignoring this for now.  We can add it later if someone says they've
run into it.  (But honestly it's partly just laziness on my part--no
objection if you want to make the patch.)

It's too bad about that option-name conflict.  It'd be nice just to be
able to do the whole thing with one clone commandline.  And it'd also
make sense to allow clone and init-db to share commandline options where
it made sense.

> - By far the easiest method to import from cvs is to go to a checked out
>   _CVS_ working directory, and just say "git cvsimport".

Neat, I didn't know about that.  Done.  I left the "-C" in there on the
assumption they often won't want to drop the result into the CVS working
directory.

Also did some miscellaneous cleanup.

--b.

commit 48ec79a74d0daa134b677ed5458beb873aa06e9a
Author: J. Bruce Fields <bfields@citi.umich.edu>
Date:   Thu Dec 7 12:38:09 2006 -0500

    Documentation: simpler shared repo creation, miscellaneous cleanup
    
    Create the shared repo with init-db --shared, fetch, and manual extraction
    of .git directory, instead of using clone --bare.
    
    Suggest running git-cvsimport from cvs working directory, more convenient
    thatn providing all the CVS information on the commandline.
    
    Fix a couple mispellings, add a couple manpage links.
    
    Thanks to Johannes Schindelin.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 773fc99..4fab0d7 100644
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
@@ -76,11 +76,23 @@ possibly created from scratch or from a tarball (see the
 link:tutorial.html[tutorial]), or imported from an already existing CVS
 repository (see the next section).
 
-If your project's working directory is /home/alice/myproject, you can
-create a shared repository at /pub/repo.git with:
+Assume your existing repo is at /home/alice/myproject.  Create a temporary
+empty shared repository and fetch your project into it:
 
 ------------------------------------------------
-$ git clone -bare /home/alice/myproject /pub/repo.git
+$ mkdir /pub/temporary
+$ cd /pub/temporary
+$ git init-db --shared
+$ git fetch /home/alice/myproject master:master
+------------------------------------------------
+
+Then create a "bare" repository at /pub/repo.git by just moving the contents of
+the .git directory there.  The temporary repository can then be discarded.
+
+------------------------------------------------
+$ mv .git /pub/repo.git
+$ cd ..
+$ rm -rf temporary
 ------------------------------------------------
 
 Next, give every team member read/write access to this repository.  One
@@ -107,15 +119,15 @@ Importing a CVS archive
 
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
