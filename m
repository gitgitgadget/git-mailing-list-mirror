From: Jeff King <peff@peff.net>
Subject: Re: Different diff strategies in add --interactive
Date: Mon, 10 Jun 2013 17:11:41 -0400
Message-ID: <20130610211140.GD13333@sigill.intra.peff.net>
References: <20130610142825.GI22905@serenity.lan>
 <7v38sphiiw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um9NV-0001mu-Lj
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab3FJVLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:11:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:48256 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095Ab3FJVLp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:11:45 -0400
Received: (qmail 32637 invoked by uid 102); 10 Jun 2013 21:12:36 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 16:12:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 17:11:41 -0400
Content-Disposition: inline
In-Reply-To: <7v38sphiiw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227383>

On Mon, Jun 10, 2013 at 12:28:55PM -0700, Junio C Hamano wrote:

> John Keeping <john@keeping.me.uk> writes:
> 
> > I think the first thing to do is read the "diff.algorithm" setting in
> > git-add--interactive and pass its value to the underlying diff-index and
> > diff-files commands, but should we also have a command line parameter to
> > git-add to specify the diff algorithm in interactive mode?  And if so,
> > can we simply add "--diff-algorithm" to git-add, or is that too
> > confusing?
> 
> Making "git add--interactive" read from diff.algorithm is probably a
> good idea, because the command itself definitely is a Porcelain.  We
> would probably need a way to defeat the configured default for
> completeness, either:
> 
>     git add -p --diff-algorithm=default
>     git -c diff.algorithm=default add -p
> 
> but I suspect that a new option to "git add" that only takes effect
> together with "-p" is probably an overkill, only in order to support
> the former and not having to say the latter, but I can be persuaded
> either way.

Worse than that, you would need to add such an option to "checkout -p",
"reset -p", "stash -p", etc. I think the latter form you suggest is
probably acceptable in this case.

Overall, I think respecting diff.algorithm in add--interactive is a very
sane thing to do. I would even be tempted to say we should allow a few
other select diff options (e.g., fewer or more context lines). If you
allowed diff options like this:

  git add --patch="--patience -U5"

that is very flexible, but I would not want to think about what the code
does when you pass --patch="--raw" or equal nonsense.

But I cannot off the top of my head think of other options besides -U
that would be helpful. I have never particularly wanted it for "add -p",
either, though I sometimes generate patches to the list with a greater
number of context lines when I think it makes the changes to a short
function more readable.

-Peff
