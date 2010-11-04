From: Jeff King <peff@peff.net>
Subject: [PATCH] docs: clarify git diff modes of operation
Date: Thu, 4 Nov 2010 17:17:29 -0400
Message-ID: <20101104211729.GA5551@sigill.intra.peff.net>
References: <AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
 <87fwvl2d4d.fsf@gmail.com>
 <87hbfxgg86.fsf_-_@gmail.com>
 <20101104174917.GA30628@sigill.intra.peff.net>
 <20101104180242.GA16431@burratino>
 <20101104181357.GA31016@sigill.intra.peff.net>
 <20101104183851.GA16865@burratino>
 <20101104185545.GB31016@sigill.intra.peff.net>
 <87d3qkhm3d.fsf@gmail.com>
 <20101104204304.GA4641@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:16:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7B2-0004IT-5r
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab0KDVQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 17:16:51 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59787 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437Ab0KDVQu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 17:16:50 -0400
Received: (qmail 3854 invoked by uid 111); 4 Nov 2010 21:16:49 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 04 Nov 2010 21:16:49 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Nov 2010 17:17:29 -0400
Content-Disposition: inline
In-Reply-To: <20101104204304.GA4641@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160770>

It is an oversimplification to say that we can take
"[<commit> [<commit>]]", as it really depends on what
options have been given. Instead, let's list the major modes
of operation separately, as we do in other manpages.

This patch also adjusts the text immediately after the
synopsis to match the lines given in the synopsis.

For git-difftool, which has the same issue, let's refer the
user to the git-diff manpage rather than spelling it all out
again.

Signed-off-by: Jeff King <peff@peff.net>
---
On Thu, Nov 04, 2010 at 04:43:04PM -0400, Jeff King wrote:

> > So AIUI the patch can still be applied and we/you can then work on
> > improving the usage string in other ways -- providing that we agree that
> > the {M,N} notation should go, of course, which we apparently still
> > don't?
> 
> My main argument against that would be that if we are planning on
> changing it to something totally different right now anyway, your patch
> will just end up making textual conflicts for Junio to resolve. :)

I had intially thought I would tweak all three sites that you did, but
after thinking about it, I really just want to change the one in
Documentation/git-diff.txt. Which turned my patch into a mix of two
different changes, and means it probably should just go on top of yours.

So here is my patch, which should apply on top of yours.

Note that in all versions (the original, yours, and mine) we gloss over
the fact that <commit> can actually be any two objects (as long as they
are bother either tree-ishs or blobs). I'm not sure if it is worth
documenting that subtlety here (at least the tree-ish thing gets
mentioned later in the description; I'm not sure we ever document "git
diff HEAD:Makefile HEAD^:Makefile" anywhere).

Jonathan, does this look ok based on our earlier discussion?

 Documentation/git-diff.txt     |   11 ++++++++---
 Documentation/git-difftool.txt |    3 ++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 61728f6..f6ac847 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -8,12 +8,17 @@ git-diff - Show changes between commits, commit and working tree, etc
 
 SYNOPSIS
 --------
-'git diff' [<common diff options>] [<commit> [<commit>]] [--] [<path>...]
+[verse]
+'git diff' [options] [<commit>] [--] [<path>...]
+'git diff' [options] --cached [<commit>] [--] [<path>...]
+'git diff' [options] <commit> <commit> [--] [<path>...]
+'git diff' [options] [--no-index] [--] <path> <path>
 
 DESCRIPTION
 -----------
-Show changes between two trees, a tree and the working tree, a
-tree and the index file, or the index file and the working tree.
+Show changes between the working tree and the index or a tree, changes
+between the index and a tree, changes between two trees, or changes
+between two files on disk.
 
 'git diff' [--options] [--] [<path>...]::
 
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index a02e3b5..6fffbc7 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -13,7 +13,8 @@ DESCRIPTION
 -----------
 'git difftool' is a git command that allows you to compare and edit files
 between revisions using common diff tools.  'git difftool' is a frontend
-to 'git diff' and accepts the same options and arguments.
+to 'git diff' and accepts the same options and arguments. See
+linkgit:git-diff[1].
 
 OPTIONS
 -------
-- 
1.7.3.2.218.g4ee9d
