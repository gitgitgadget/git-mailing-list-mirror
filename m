From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs (Was: Re: git annoyances)
Date: Wed, 9 Apr 2008 20:11:52 -0400
Message-ID: <20080410001152.GB16800@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net> <20080410000349.GA16800@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Apr 10 02:12:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjkPG-00073i-3X
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 02:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbYDJAL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 20:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753955AbYDJAL5
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 20:11:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3358 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627AbYDJALz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 20:11:55 -0400
Received: (qmail 24238 invoked by uid 111); 10 Apr 2008 00:11:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 09 Apr 2008 20:11:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Apr 2008 20:11:52 -0400
Content-Disposition: inline
In-Reply-To: <20080410000349.GA16800@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79161>

On Wed, Apr 09, 2008 at 08:03:49PM -0400, Jeff King wrote:

> Here is a patch that fixes the breakage, which should be done either
> way. If people think this is a good thing to show in general (and I do,
> but then I am not a very frequent user of "fetch without tracking
> branches"), then there is an obvious one-liner to make it always show.

And here is that one-liner, in case there is interest. The only negative
I can think of is that git-pull will now produce two extra lines of
output mentioning FETCH_HEAD (which I actually think is a positive, but
I can see that people might consider it clutter).

-- >8 --
git-fetch: always show status of non-tracking-ref fetches

Previously, a fetch like:

  git fetch git://some/url

would show no ref status output (just the object downloading
status, if there was any), leading to some confusion.

With this patch, we now show the usual ref table, with
remote refs going into FETCH_HEAD. Previously this output
was shown only if "-v"erbose was specified.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-fetch.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 139a6b1..e4486e4 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -360,12 +360,10 @@ static int store_updated_refs(const char *url, struct ref *ref_map)
 
 		if (ref)
 			update_local_ref(ref, what, verbose, note);
-		else if (verbose)
+		else
 			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
 				SUMMARY_WIDTH, *kind ? kind : "branch",
 				 REFCOL_WIDTH, *what ? what : "HEAD");
-		else
-			*note = '\0';
 		if (*note) {
 			if (!shown_url) {
 				fprintf(stderr, "From %.*s\n",
-- 
1.5.5.26.g8c565.dirty
