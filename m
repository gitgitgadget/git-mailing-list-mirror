From: Jeff King <peff@peff.net>
Subject: [PATCH] Documentation: point git-prune users to git-gc
Date: Tue, 29 Apr 2008 16:45:14 -0400
Message-ID: <20080429204514.GA21029@sigill.intra.peff.net>
References: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com> <7vve28sdys.fsf@gitster.siamese.dyndns.org> <20080423221316.GE30057@sigill.intra.peff.net> <20080424012836.GA30812@sigill.intra.peff.net> <32541b130804240843k471ecfeteb1008c44a56808b@mail.gmail.com> <20080424161407.GA23737@sigill.intra.peff.net> <32541b130804240959y3b05d4b5u67ac7a7c14bf187e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 22:46:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqwiE-0007k0-I2
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 22:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584AbYD2UpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 16:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbYD2UpS
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 16:45:18 -0400
Received: from peff.net ([208.65.91.99]:1597 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbYD2UpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 16:45:16 -0400
Received: (qmail 13334 invoked by uid 111); 29 Apr 2008 20:45:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Apr 2008 16:45:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2008 16:45:14 -0400
Content-Disposition: inline
In-Reply-To: <32541b130804240959y3b05d4b5u67ac7a7c14bf187e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80730>

On Thu, Apr 24, 2008 at 12:59:34PM -0400, Avery Pennarun wrote:

> I gather there's a movement in recent git versions (sorry, I only
> tuned in recently) to encourage people to use git-gc instead of
> git-prune in almost all cases.  The reasons I ever looked at git-prune

Yes, I don't think there is any reason for most people to use git-prune
at all, unless they are trying specifically to prune and don't want the
other gc effects to happen.

Junio, please correct me if I'm wrong there.

> Adding git-gc *and* git-reflog as See Also entries in git-prune would
> make sense to me.

Agreed. Below is a patch that will hopefully clarify the situation.

-- >8 --
Documentation: point git-prune users to git-gc

Most users should be using git-gc instead of directly
calling prune. For those who really do want more information
on pruning, let's point them at git-fsck, which goes into
slightly more detail on reachability.

And since we're pointing users there, let's make sure
reflogs are mentioned in git-fsck(1).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-fsck.txt  |    3 ++-
 Documentation/git-prune.txt |   20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index f16cb98..4cc26fb 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -22,7 +22,8 @@ OPTIONS
 	An object to treat as the head of an unreachability trace.
 +
 If no objects are given, git-fsck defaults to using the
-index file and all SHA1 references in .git/refs/* as heads.
+index file, all SHA1 references in .git/refs/*, and all reflogs (unless
+--no-reflogs is given) as heads.
 
 --unreachable::
 	Print out objects that exist but that aren't readable from any
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index f151cff..f92bb8c 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -13,6 +13,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
+NOTE: In most cases, users should run linkgit:git-gc[1], which calls
+git-prune. See the section "NOTES", below.
+
 This runs `git-fsck --unreachable` using all the refs
 available in `$GIT_DIR/refs`, optionally with additional set of
 objects specified on the command line, and prunes all
@@ -50,6 +53,23 @@ borrows from your repository via its
 $ git prune $(cd ../another && $(git-rev-parse --all))
 ------------
 
+Notes
+-----
+
+In most cases, users will not need to call git-prune directly, but
+should instead call linkgit:git-gc[1], which handles pruning along with
+many other housekeeping tasks.
+
+For a description of which objects are considered for pruning, see
+git-fsck's --unreachable option.
+
+See Also
+--------
+
+linkgit:git-fsck[1],
+linkgit:git-gc[1],
+linkgit:git-reflog[1]
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
-- 
1.5.5.1.172.g4dce
