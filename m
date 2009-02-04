From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] builtin-remote: make rm operation safer in
	mirrored repository
Date: Wed, 4 Feb 2009 11:16:54 -0500
Message-ID: <20090204161654.GA9218@sigill.intra.peff.net>
References: <76718490902030638y36299191i1fcc2ab8646b9593@mail.gmail.com> <1233683473-87893-2-git-send-email-jaysoffian@gmail.com> <20090204154227.GE6896@sigill.intra.peff.net> <76718490902040756m1f5c6f37o45865c51ad1a2e6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 17:18:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUkSL-0004iO-D6
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 17:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbZBDQRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 11:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbZBDQRC
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 11:17:02 -0500
Received: from peff.net ([208.65.91.99]:60901 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbZBDQRA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 11:17:00 -0500
Received: (qmail 30216 invoked by uid 107); 4 Feb 2009 16:17:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 04 Feb 2009 11:17:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Feb 2009 11:16:54 -0500
Content-Disposition: inline
In-Reply-To: <76718490902040756m1f5c6f37o45865c51ad1a2e6d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108391>

On Wed, Feb 04, 2009 at 10:56:06AM -0500, Jay Soffian wrote:

> On Wed, Feb 4, 2009 at 10:42 AM, Jeff King <peff@peff.net> wrote:
> >> +     /* don't delete non-remote branches */
> >> +     if (prefixcmp(refname, "refs/remotes")) {
> >> +             if (!prefixcmp(refname, "refs/heads/"))
> >> +                     string_list_append(abbrev_branch(refname),
> >> +                                        branches->skipped);
> >> +             return 0;
> >> +     }
> >
> > Why does this version introduce the "only skip refs/heads/" check?
> > Shouldn't we also protect other random refs (or if not, shouldn't the
> > commit message explain why not)?
> 
> Note that we do protect refs, but we only emit messages about those
> refs which are obviously branches. Frankly, I wasn't sure what other
> kinds of refs there might be, so wasn't sure what an appropriate
> message is for anything other than those under refs/heads.

Oh, right. I was just reading it wrong. Your new version with the two
comments makes it even more clear.

> Note: A non-remote branch was not removed; to delete it use:
>    git branch -d ...
> 
> Note: Tags were not removed, to delete them use:
>    git tag -d ...
>
> Note: Some refs were ignored:
>    refs/whoknows/whatthisis
>    refs/whoknows/whatthiscouldbe

Nah, I think deleting branches was the main intention. So we are
properly protecting everything now, but only warning about what you
_might_ have meant.

> But that's getting a little insane me thinks.

Agreed.

-Peff
