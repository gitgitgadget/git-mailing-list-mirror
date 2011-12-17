From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] make "git push -v" actually verbose
Date: Sat, 17 Dec 2011 14:50:24 -0500
Message-ID: <20111217195024.GA32441@sigill.intra.peff.net>
References: <20111217093713.GA2073@sigill.intra.peff.net>
 <20111217094142.GA10451@sigill.intra.peff.net>
 <7vobv7dmak.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 20:50:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc0HA-0004q7-LP
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 20:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab1LQTu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 14:50:29 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45113
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab1LQTu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 14:50:28 -0500
Received: (qmail 15819 invoked by uid 107); 17 Dec 2011 19:57:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 Dec 2011 14:57:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Dec 2011 14:50:24 -0500
Content-Disposition: inline
In-Reply-To: <7vobv7dmak.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187405>

On Sat, Dec 17, 2011 at 11:34:59AM -0800, Junio C Hamano wrote:

> > One minor clarification: it is not technically true that "git push -v"
> > does nothing. It just does not do the interesting "show a verbose status
> > table" operation, which is almost certainly what the user wants (and
> > what happened before the commits I mentioned). It does print "Pushing to
> > $url", since that happens above the transport layer. But I'm pretty sure
> > that is not what users of "-v" are interested in. :)
> 
> Thanks, but don't be so sure about that.
> 
> When you are so used to say "git push ko", from time to time you want to
> check which one of your kernel.org machine you are pushing into; that
> "pushing to this exact url" is actually quite useful.

But we will also print that as part of the status table, so it really is
redundant. The only difference is that it comes before the object
transfer phase, so if the whole thing barfs before you even make it to
the status table, you get a little more debugging output (although
typically the URL is mentioned in the die() message, anyway).

E.g.:

  $ git push github
  Counting objects: 214, done.
  Compressing objects: 100% (131/131), done.
  Writing objects: 100% (135/135), 33.73 KiB, done.
  Total 135 (delta 102), reused 9 (delta 4)
  To https://github.com/peff/git.git
   + 710a44a...0fa8107 private -> private (forced update)

Before my patch, adding "-v" would just put the "Pushing to https://..."
before the object phase.

Anyway, regardless of the utility of that message, I think the fix makes
sense. It really looks like an unintended regression in 8afd8dc, and
certainly the original intent of the code was to match fetch's use of
"-v" to show up-to-date entries in the status table (which I know
because I wrote it).

-Peff
