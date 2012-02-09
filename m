From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Thu, 9 Feb 2012 14:33:14 -0500
Message-ID: <20120209193314.GA19690@sigill.intra.peff.net>
References: <20120206062713.GA9699@sigill.intra.peff.net>
 <m31uq63143.fsf@localhost.localdomain>
 <20120209033059.GA4347@sigill.intra.peff.net>
 <201202092024.43381.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 20:33:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvZkA-0000ZY-8X
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 20:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758454Ab2BITdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 14:33:17 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60141
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757903Ab2BITdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 14:33:16 -0500
Received: (qmail 29367 invoked by uid 107); 9 Feb 2012 19:40:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Feb 2012 14:40:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Feb 2012 14:33:14 -0500
Content-Disposition: inline
In-Reply-To: <201202092024.43381.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190310>

On Thu, Feb 09, 2012 at 08:24:42PM +0100, Jakub Narebski wrote:

> > So the patch would look something like this. However, is the actual
> > filename really what callers want? It seems like in David's case, an
> > annotation of "repo", "global", or "system" (possibly in addition to the
> > filename) would be the most useful (because in the git-cola UI, it is
> > still nice to list things as "repo" or "global" instead of spewing the
> > whole filename at the user -- but you would still want the individual
> > filename for handling updates of includes).
> 
> I'm not sure if "system" / "global" / "local" or "repo" would be a good
> idea.
> 
> First, in the case of includes you would have to provide pathnames of
> included files.  This would introduce inconsistency.  Is "system"
> the '/etc/gitconfig' file, or 'system' file in '.git' directory?

Yeah, it would have to be syntactically unambiguous with the filename.
I was thinking something of just including both, like this:

  global:/home/peff/.gitconfig<TAB>include.path=other-file
  global:/home/peff/other-file<TAB>some.key=value

That is, give a "context" (repo, global, system) to each lookup, and
then mention the individual file as well (either because it is the root
of that context, or because it was included). So a config editor could
present the context to the user as a purely decorative thing (i.e., tell
the user "these options affect all of your repos"), but use the filename
to actually update the values (i.e., "git config -f
/home/peff/other-file some.key newvalue").

> Second, people can have different build configuration, e.g. the prefix
> might differ, so that "system" is not always '/etc/gitconfig'.  If you
> want to edit config you would want to know which file to edit... and though
> there is "git config --system --edit" it depends on having editor
> configured correctly.

Without includes, something like git-cola could possibly get away with:

  git config --system some.key value

but that doesn't work for included files; for those, you'd want to have
the actual filename.

-Peff
