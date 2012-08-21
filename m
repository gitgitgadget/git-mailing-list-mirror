From: Jeff King <peff@peff.net>
Subject: Re: How to request a fast-forward pull
Date: Tue, 21 Aug 2012 02:41:38 -0400
Message-ID: <20120821064138.GA3238@sigill.intra.peff.net>
References: <20120820202803.GA8378@windriver.com>
 <20120820204033.GA636@mannheim-rule.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, Bart Trojanowski <bart@jukie.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 08:42:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3iA9-0004LK-QF
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 08:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab2HUGlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 02:41:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43460 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478Ab2HUGlm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 02:41:42 -0400
Received: (qmail 28642 invoked by uid 107); 21 Aug 2012 06:41:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Aug 2012 02:41:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2012 02:41:38 -0400
Content-Disposition: inline
In-Reply-To: <20120820204033.GA636@mannheim-rule.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203943>

On Mon, Aug 20, 2012 at 01:40:33PM -0700, Jonathan Nieder wrote:

> > When you have a moment, would you please migrate this
> > across to your main linux-stable repository?
> >
> > Both a branch and signed tag are present and pointing at
> > the same commit, but "git request-pull" does favour output
> > of the tag over the branch name.
> >
> > But merging the tag will want to create a merge commit.
> >
> > So, to avoid a merge commit in your repo, you can fetch
> > (fast fwd) into your (local) branch from my branch at:
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux-stable.git linux-2.6.34.y
> >
> > and then fetch the signed tag listed below after that.
> 
> Can this be made easier?  I could imagine request-pull learning
> --ff-only that generates a message like
> 
> 	Greg,
> 
> 	Please pull --ff-only
> 
> 	 git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux-stable.git linux-2.6.34.y
> 
> 	to get the following changes [...]
> 
> which could work ok if the recipient notices the --ff-only, but I
> wonder if there is a simpler way.

If it is something important for the sender to communicate to the
recipient as part of the pull command-line, then I would think the
natural place is on the line with the rest of it, like:

  Please pull:

    --ff-only <remote> <ref>

It's maximally noticeable to the recipient, then, and anybody
cutting-and-pasting the whole line would get it automagically. That is
as close to machine-readable as pull-request emails get.

However, I have to wonder if that is a good idea in general. Isn't the
decision to --ff-only or not really the puller's business? In the
general case, I would not expect senders of pull request to have advice
in this area.

This particular case seems to be caused by a policy mismatch between the
project and request-pull. The latter's behavior to favor a matching tag
is because tags carry more information. But in this case, it sounds like
the project would rather avoid the extra merge commits, even if it means
losing information. So the right solution would be to teach request-pull
an option to follow the project's policy better.

Or is this just a one-off thing? In that case, the simplest thing would
be to tweak the pull-request email to mention the branch name instead of
the tag, rather than talking about --ff-only.

-Peff
