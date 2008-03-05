From: Jeff King <peff@peff.net>
Subject: [RFC] improve 'bad default revision' message for empty repo
Date: Tue, 4 Mar 2008 20:07:02 -0500
Message-ID: <20080305010701.GB20007@sigill.intra.peff.net>
References: <3f4fd2640803011140o38ba0830l7775c8528f812779@mail.gmail.com> <20080303081021.GA6578@sigill.intra.peff.net> <3f4fd2640803041351k6debe788xbf5e818951f70146@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Reece Dunn <msclrhd@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 02:07:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWi6j-0001Ky-Cg
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 02:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYCEBHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 20:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbYCEBHH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 20:07:07 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3652 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbYCEBHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 20:07:05 -0500
Received: (qmail 27974 invoked by uid 111); 5 Mar 2008 01:07:03 -0000
Received: from lawn-128-61-17-48.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.17.48)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 04 Mar 2008 20:07:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Mar 2008 20:07:02 -0500
Content-Disposition: inline
In-Reply-To: <3f4fd2640803041351k6debe788xbf5e818951f70146@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76163>

On Tue, Mar 04, 2008 at 09:51:02PM +0000, Reece Dunn wrote:

> >  > Consider the following workflow:
> >  >
> >  >     $ mkdir foo
> >  >     $ cd foo
> >  >     $ git --bare init
> >  >
> >  >     $ git log
> >  >     fatal: bad default revision 'HEAD'
> >  >
> >  > This message is confusing for a newbie. Displaying "no commits" would
> >  > make more sense here.

What do people think of this patch? It feels a little hack-ish to make
guesses as to the reasons for a failure, but in my experience an empty
repo is the cause of this message in 99% of cases.

We could special-case it to HEAD and make a better message, perhaps, but
that feels even more hack-ish.

---
 revision.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 63bf2c5..847dbc8 100644
--- a/revision.c
+++ b/revision.c
@@ -1324,7 +1324,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		struct object *object;
 		unsigned mode;
 		if (get_sha1_with_mode(def, sha1, &mode))
-			die("bad default revision '%s'", def);
+			die("unable to resolve '%s'; do you have any commits on this branch?", def);
 		object = get_reference(revs, def, sha1, 0);
 		add_pending_object_with_mode(revs, object, def, mode);
 	}
-- 
1.5.4.3.531.ga940.dirty
