From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Thu, 26 Jan 2012 18:00:54 -0500
Message-ID: <20120126230054.GC12855@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126074208.GD30474@sigill.intra.peff.net>
 <7vbopq2mk9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 00:01:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqYJT-0003Ma-MK
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 00:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114Ab2AZXA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 18:00:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46051
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753615Ab2AZXA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 18:00:58 -0500
Received: (qmail 30443 invoked by uid 107); 26 Jan 2012 23:07:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 18:07:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 18:00:54 -0500
Content-Disposition: inline
In-Reply-To: <7vbopq2mk9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189171>

On Thu, Jan 26, 2012 at 01:14:46PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +You can also include configuration from a blob stored in your repository
> > +by setting the special `include.ref` variable to the name of an object
> > +containing your configuration data (in the same format as a regular
> > +config file).
> 
> Hmm, the concept is surely *fun*, but is this really worth it?
> [you could just tell people to copy the file into .git]

Yes, that does work. I liked the idea of putting it in the repo, though,
because it means you can actually _track_ the contents, including any
local changes you make.

So yeah, if you are just going to copy it once, or even periodically, it
is not that big an advantage. And the example I gave using "git tag" did
just that. But I also wanted to allow more complex things, like this:

  # clone and inspect
  git clone git://example.com/project.git
  cd project
  git show origin:devtools/std_gitconfig

  # well, that looks pretty good. But I'd like to tweak something.
  git checkout -b config origin
  $EDITOR devtools/std_gitconfig
  git commit -a -m "drop the foo option, which I hate"

  # OK, let's use it now.
  git config include.ref config:devtools/std_gitconfig

  # Weeks pass. Somebody else updates the std_gitconfig.
  git fetch
  # let's inspect the changes
  git checkout config
  git diff @{u} -- devtools/std_gitconfig
  # looks good, let's merge (not copy!) them in
  git merge @{u}

This is obviously an advanced thing to be doing. But it's cool to me,
because even if you aren't working on a shared project, it is a means of
versioning your config.

-Peff
