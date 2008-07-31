From: Jeff King <peff@peff.net>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 04:25:54 -0400
Message-ID: <20080731082553.GA19522@sigill.intra.peff.net>
References: <20080730093903.GA14330@cuci.nl> <20080730150123.GB9758@atjola.homenet> <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com> <20080731064814.GA32431@sigill.intra.peff.net> <7vfxpq3559.fsf@gitster.siamese.dyndns.org> <20080731072149.GA2304@sigill.intra.peff.net> <7v8wvi33ok.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 10:27:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOTVA-0004wa-2G
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 10:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbYGaIZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 04:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbYGaIZ5
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 04:25:57 -0400
Received: from peff.net ([208.65.91.99]:3125 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbYGaIZz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 04:25:55 -0400
Received: (qmail 22061 invoked by uid 111); 31 Jul 2008 08:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 04:25:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 04:25:54 -0400
Content-Disposition: inline
In-Reply-To: <7v8wvi33ok.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90911>

On Thu, Jul 31, 2008 at 12:36:59AM -0700, Junio C Hamano wrote:

> Alas, shortlog does not take --all.  Yes, I know
> 
> 	git log --since=3.day --all | git shortlog | sort | uniq -c
> 
> is an obvious workaround, but it is mildly irritating.

Hmm. Could it be as simple as:

diff --git a/revision.c b/revision.c
index a843c42..eaa5572 100644
--- a/revision.c
+++ b/revision.c
@@ -1002,7 +1002,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
 	{
 		unkv[(*unkc)++] = arg;
-		return 0;
+		return 1;
 	}
 
 	if (!prefixcmp(arg, "--max-count=")) {

That is, handle_revision_opt says "yes we parsed this, and it should be
gone" even though it still gets stuck in the "unknown" section to be
parsed by setup_revisions later.

-Peff
