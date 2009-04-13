From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-branch - allow deleting a fully specified
	branch-name
Date: Mon, 13 Apr 2009 06:57:42 -0400
Message-ID: <20090413105742.GA15676@coredump.intra.peff.net>
References: <1239323335-4684-1-git-send-email-mlevedahl@gmail.com> <200904092119.10520.mlevedahl@gmail.com> <7vbpr519jq.fsf@gitster.siamese.dyndns.org> <200904111301.31250.mlevedahl@gmail.com> <20090412072056.GA25837@coredump.intra.peff.net> <7v7i1qb7sw.fsf@gitster.siamese.dyndns.org> <20090413085622.GC9846@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 13:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtJty-00036d-Vr
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 13:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbZDMK5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 06:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbZDMK5p
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 06:57:45 -0400
Received: from peff.net ([208.65.91.99]:50729 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbZDMK5p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 06:57:45 -0400
Received: (qmail 31630 invoked by uid 107); 13 Apr 2009 10:57:46 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Apr 2009 06:57:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Apr 2009 06:57:42 -0400
Content-Disposition: inline
In-Reply-To: <20090413085622.GC9846@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116425>

On Mon, Apr 13, 2009 at 04:56:22AM -0400, Jeff King wrote:

> > I think "the apporachable part" aka "synopsis" should be kept the way it
> > is, but we should clarify in the description when the most general form is
> > different from the white lie we feed to newbies.
> 
> Hmm. I tried something in this direction, but I actually think it ended
> up more confusing.

I meant to attach a patch here so you could judge for yourself, but I
forgot. I am preparing a patch series which I think is better, but for
reference, here is what I came up with before:

---
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 223ea9c..344c57a 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -131,15 +131,20 @@ the conflicted merge in the specified paths.
 	the index will be used.
 
 <branch>::
-	Branch to checkout (when no paths are given); may be any object
-	ID that resolves to a commit.  Defaults to HEAD.
+	If "-b" is not given, specifies the branch to checkout. If it
+	names a non-branch (i.e., a name that, when prepended with
+	"refs/heads/", does not exist) but does point to a
+	valid commit object, then the HEAD becomes 'detached', and you
+	are no longer on any branch.  As a special case, the `"@\{-N\}"`
+	syntax for the N-th last branch checks out the branch (instead
+	of detaching).  You may also specify `-` which is synonymous
+	with `"@\{-1\}"`.
 +
-When this parameter names a non-branch (but still a valid commit object),
-your HEAD becomes 'detached'.
+If "-b" is given, specifies the start point of the newly created
+branch. Specifying a non-branch is irrelevant here, since git will
+checkout the newly created branch, not the start point.
 +
-As a special case, the `"@\{-N\}"` syntax for the N-th last branch
-checks out the branch (instead of detaching).  You may also specify
-`-` which is synonymous with `"@\{-1\}"`.
+In either case, if the parameter is omitted, it defaults to HEAD.
 
 
 Detached HEAD
