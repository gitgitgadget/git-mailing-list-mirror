From: Jeff King <peff@peff.net>
Subject: Re: shallow&single-branch clone?
Date: Thu, 20 Oct 2011 21:22:59 -0400
Message-ID: <20111021012259.GA13421@sigill.intra.peff.net>
References: <4E9ED108.5020505@native-instruments.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Norbert Nemec <norbert.nemec@native-instruments.de>
X-From: git-owner@vger.kernel.org Fri Oct 21 03:24:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RH3qV-00023Z-HX
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 03:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab1JUBXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 21:23:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36422
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab1JUBXC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 21:23:02 -0400
Received: (qmail 15858 invoked by uid 107); 21 Oct 2011 01:23:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Oct 2011 21:23:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2011 21:22:59 -0400
Content-Disposition: inline
In-Reply-To: <4E9ED108.5020505@native-instruments.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184047>

On Wed, Oct 19, 2011 at 03:30:48PM +0200, Norbert Nemec wrote:

> Truncating history is done by 'git clone --depth 1', there is not way
> to restrict 'clone' to a single branch (the --branch option still
> downloads all branches and only then chooses something other than
> HEAD as active branch).
> 
> The manual sequence
> 	git init
> 	git remote add -t master -f origin URL
> 	git checkout
> allows a clone of a single branch but offers no means to truncate history.

You can do:

  git init
  git remote add -t master origin URL
  git fetch --depth=1
  git checkout

But obviously that's not as nice as an option to clone.

> The least intrusive solution would be an additional option to clone,
> perhaps '--branch-only'.

Agreed, that would be better. We might want to make it more flexible,
like:

  git clone --fetch=branch1 --fetch=branch2

and then by default choose "-b branch1" since it was mentioned first.

> More user friendly, this options should be on by default when --depth
> is set. After all: who would expect branches to be cloned when the
> history is explicitely truncated?

Yeah, that probably makes sense. If the branches are related, it's
probably not saving much, but if you have unrelated branches, it would
be a nice convenience. OTOH, how would you tell git "no, I really do
want the tip of every branch"?

-Peff
