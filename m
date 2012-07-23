From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: give a hint when a commit message has been
 abandoned
Date: Mon, 23 Jul 2012 17:13:12 -0400
Message-ID: <20120723211312.GA12533@sigill.intra.peff.net>
References: <20120723184634.GA31905@sigill.intra.peff.net>
 <20120723185218.GC27588@sigill.intra.peff.net>
 <7vzk6qjj7w.fsf@alter.siamese.dyndns.org>
 <20120723205209.GA6745@sigill.intra.peff.net>
 <7vr4s2jiqk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramana Kumar <ramana@member.fsf.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:13:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StPwP-0004DV-7t
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 23:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab2GWVNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 17:13:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59221 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754663Ab2GWVNP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 17:13:15 -0400
Received: (qmail 8896 invoked by uid 107); 23 Jul 2012 21:13:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jul 2012 17:13:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jul 2012 17:13:12 -0400
Content-Disposition: inline
In-Reply-To: <7vr4s2jiqk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201984>

On Mon, Jul 23, 2012 at 02:00:19PM -0700, Junio C Hamano wrote:

> >> Liberal use of atexit() for something like this makes me cringe
> >> somewhat.
> >
> > I don't like it either, but there's not really a better way. The die()
> > that Ramana triggered in the initial report is deep inside the ident
> > code. The only other option would be to hook into die_routine, which I
> > think is even uglier.
> 
> Then I would rather not worry about it.  A documentation update is
> probably a good first step, though.

I'm OK with dropping this one; the likely cause is ident problems, and
the previous patch already helped with that (the next likely is probably
commit hooks failing, but that is just a guess).

Here's a documentation patch.

-- >8 --
Subject: [PATCH] commit: document the temporary commit message file

We do not document COMMIT_EDITMSG at all, but users may want
to know about it for two reasons:

  1. They may want to tell their editor to configure itself
     for formatting a commit message.

  2. If a commit is aborted by an error, the user may want
     to recover the commit message they typed.

Let's put a note in git-commit(1).
---
 Documentation/git-commit.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f400835..87297dc 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -407,6 +407,15 @@ This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
 and `post-commit` hooks.  See linkgit:githooks[5] for more
 information.
 
+FILES
+-----
+
+`$GIT_DIR/COMMIT_EDITMSG`::
+	This file contains the commit message of a commit in progress.
+	If `git-commit` exits due to an error before creating a commit,
+	any commit message that has been provided by the user (e.g., in
+	an editor session) will be available in this file, but will be
+	overwritten by the next invocation of `git-commit`.
 
 SEE ALSO
 --------
