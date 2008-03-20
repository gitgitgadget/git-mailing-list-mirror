From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Improve description of git filter-branch.
Date: Thu, 20 Mar 2008 22:30:32 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080320213032.GO11261@ins.uni-bonn.de>
References: <20080315103900.GC14769@ins.uni-bonn.de> <7v8x0dw5sx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 22:31:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcSM4-0007iY-Dh
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 22:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793AbYCTVaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 17:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756865AbYCTVaj
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 17:30:39 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:55697 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758AbYCTVai (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 17:30:38 -0400
Received: from localhost.localdomain (xdsl-87-78-90-24.netcologne.de [87.78.90.24])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 2EAA4400026A7;
	Thu, 20 Mar 2008 22:30:37 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1JcSLI-0001eJ-Pb; Thu, 20 Mar 2008 22:30:32 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8x0dw5sx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77686>

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

* Junio C Hamano wrote on Thu, Mar 20, 2008 at 08:31:42PM CET:
> Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:
> 
> > +	This filter may be used if you only need to modify the environment
> > +	in which the commit will be performed.  Specifically, you might
> > +	want to rewrite the author/committer name/email/time environment
> 
> Ok.  Without needless line rewrapping this would have been much less time
> consuming to review, though.

Apologies, and thanks for the review.  Here's an updated patch.

Cheers,
Ralf

 Documentation/git-filter-branch.txt |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 543a1cf..2a78549 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -25,7 +25,7 @@ Otherwise, all information (including original commit times or merge
 information) will be preserved.
 
 The command will only rewrite the _positive_ refs mentioned in the
-command line (i.e. if you pass 'a..b', only 'b' will be rewritten).
+command line (e.g. if you pass 'a..b', only 'b' will be rewritten).
 If you specify no filters, the commits will be recommitted without any
 changes, which would normally have no effect.  Nevertheless, this may be
 useful in the future for compensating for some git bugs or such,
@@ -42,7 +42,7 @@ Always verify that the rewritten version is correct: The original refs,
 if different from the rewritten ones, will be stored in the namespace
 'refs/original/'.
 
-Note that since this operation is extensively I/O expensive, it might
+Note that since this operation is very I/O expensive, it might
 be a good idea to redirect the temporary directory off-disk with the
 '-d' option, e.g. on tmpfs.  Reportedly the speedup is very noticeable.
 
@@ -51,14 +51,15 @@ Filters
 ~~~~~~~
 
 The filters are applied in the order as listed below.  The <command>
-argument is always evaluated in shell using the 'eval' command (with the
-notable exception of the commit filter, for technical reasons).
+argument is always evaluated in the shell context using the 'eval' command
+(with the notable exception of the commit filter, for technical reasons).
 Prior to that, the $GIT_COMMIT environment variable will be set to contain
 the id of the commit being rewritten.  Also, GIT_AUTHOR_NAME,
 GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL,
-and GIT_COMMITTER_DATE are set according to the current commit. If any
-evaluation of <command> returns a non-zero exit status, the whole operation
-will be aborted.
+and GIT_COMMITTER_DATE are set according to the current commit.  The values
+of these variables after the filters have run, are used for the new commit.
+If any evaluation of <command> returns a non-zero exit status, the whole
+operation will be aborted.
 
 A 'map' function is available that takes an "original sha1 id" argument
 and outputs a "rewritten sha1 id" if the commit has been already
@@ -71,9 +72,9 @@ OPTIONS
 -------
 
 --env-filter <command>::
-	This is the filter for modifying the environment in which
-	the commit will be performed.  Specifically, you might want
-	to rewrite the author/committer name/email/time environment
+	This filter may be used if you only need to modify the environment
+	in which the commit will be performed.  Specifically, you might
+	want to rewrite the author/committer name/email/time environment
 	variables (see linkgit:git-commit[1] for details).  Do not forget
 	to re-export the variables.
 
@@ -149,7 +150,7 @@ definition impossible to preserve signatures at any rate.)
 -d <directory>::
 	Use this option to set the path to the temporary directory used for
 	rewriting.  When applying a tree filter, the command needs to
-	temporary checkout the tree to some directory, which may consume
+	temporarily check out the tree to some directory, which may consume
 	considerable space in case of large projects.  By default it
 	does this in the '.git-rewrite/' directory but you can override
 	that choice by this parameter.
-- 
1.5.5.rc0.22.g65daf
