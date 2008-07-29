From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH] Make it clear that push can take multiple refspecs
Date: Wed, 30 Jul 2008 04:43:38 +0530
Message-ID: <20080729231338.GA30717@toroid.org>
References: <1217362159-25440-1-git-send-email-ams@toroid.org> <7vbq0gcsxg.fsf@gitster.siamese.dyndns.org> <20080729212808.GA27076@toroid.org> <7viquobb0e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 01:14:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNyOx-00078d-0n
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 01:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbYG2XNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 19:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbYG2XNm
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 19:13:42 -0400
Received: from fugue.toroid.org ([85.10.196.113]:43995 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbYG2XNm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 19:13:42 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 0C944558261;
	Wed, 30 Jul 2008 01:13:40 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 00A82ADC369; Wed, 30 Jul 2008 04:43:38 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7viquobb0e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90702>

At 2008-07-29 15:06:57 -0700, gitster@pobox.com wrote:
>
> If you saw the question asked many times in the real world, that
> would be a good indication that this patch falls into the "helpful"
> category, not "noise". Will queue.

Thanks.

You may find the appended patch less noisy still. I certainly like being
able to get rid of the "any number of..." sentence; and I also think the
example is clearer, though I merged it into an existing one.

(I would also change the '+?<src>:<dst>' to '[+]<src>:<dst>'. It's a bit
weird to use BOTH regex format and SYNOPSIS format in the same string.)

> I wonder if there are other manual pages with <thing>... notation that
> benefits from similar changes, though.

Yes, I see now that there are several that could use minor changes.
Often nothing more than the following is needed:

-<committish>::
-       The object name of the committish.
+<committish>...::
+       A list of committish object names to describe.

(For git-describe, whose SYNOPSIS already mentions '<committish>...')

I'll submit another patch for those later.

-- ams

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 94d07ab..7f28ea6 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
-           [--repo=all] [-f | --force] [-v | --verbose] [<repository> <refspec>...]
+           [--repo=all] [-f | --force] [-v | --verbose]
+           [<repository> <refspec>...]
 
 DESCRIPTION
 -----------
@@ -29,8 +30,8 @@ OPTIONS
 	The "remote" repository that is destination of a push
 	operation.  See the section <<URLS,GIT URLS>> below.
 
-<refspec>::
-	The canonical format of a <refspec> parameter is
+<refspec>...::
+	The canonical format of each <refspec> parameter is
 	`+?<src>:<dst>`; that is, an optional plus `+`, followed
 	by the source ref, followed by a colon `:`, followed by
 	the destination ref.
@@ -180,11 +181,11 @@ git push origin :experimental::
 	Find a ref that matches `experimental` in the `origin` repository
 	(e.g. `refs/heads/experimental`), and delete it.
 
-git push origin master:satellite/master::
-	Find a ref that matches `master` in the source repository
-	(most likely, it would find `refs/heads/master`), and update
-	the ref that matches `satellite/master` (most likely, it would
-	be `refs/remotes/satellite/master`) in `origin` repository with it.
+git push origin master:satellite/master dev:satellite/dev::
+	Use the source ref that matches `master` (e.g. `refs/heads/master`)
+	to update the ref that matches `satellite/master` (most probably
+	`refs/remotes/satellite/master`) in the `origin` repository, then
+	do the same for `dev` and `satellite/dev`.
 
 git push origin master:refs/heads/experimental::
 	Create the branch `experimental` in the `origin` repository
