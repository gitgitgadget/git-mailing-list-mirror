From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Fri, 18 Feb 2011 06:08:10 -0500
Message-ID: <20110218110810.GC7262@sigill.intra.peff.net>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 12:08:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqOCC-0005ma-1S
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 12:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab1BRLIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 06:08:15 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57575 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874Ab1BRLIO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 06:08:14 -0500
Received: (qmail 31389 invoked by uid 111); 18 Feb 2011 11:08:12 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 18 Feb 2011 11:08:12 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Feb 2011 06:08:10 -0500
Content-Disposition: inline
In-Reply-To: <20110218092518.GB30648@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167198>

On Fri, Feb 18, 2011 at 03:25:18AM -0600, Jonathan Nieder wrote:

> Thanks again for both of your help.  I've put up an updated series at
> 
>  git://repo.or.cz/git/jrn.git flatten-source

s/flatten/un&/

> Changes since the series sent to the list:
> 
>  - put headers in libgit/ with the source files.  I don't
>    know what I was thinking before.

That is much nicer, I think.

>  - renamed nonbuiltin/ to commands/.  Names like
>    commands/add--interactive.perl even seem to make a kind of sense.

Definitely a better name.

>  - moved the http support mini-library to http/.

Seems like a weird one-off to me, as it only has two files.

>  - renamed git_remote_helpers to python/, though I'm not very happy
>    about that.

I think this has been discussed a couple of times, and there was some
confusion about what the directory means. It is "this is a python
library called git_remote_helpers". It is not "this is generic python
code for git", nor is it "this is generic remote helper code". So I
think python/git_remote_helpers would probably be a more appropriate
name in case we ever grow more python code.

> This is all very off-the-cuff.  I'd be happy for others to pick this
> up and remold it to their taste (after all, I'm too used to the
> current layout to remember what matters).  It doesn't feel cooked yet.

Two overall comments that are vague and you can feel free to ignore:

  1. I was one of the initial complainers of a source reorganization.
     But my complaint was mainly "let's only do it if there is some real
     benefit". Unlike simply shoving everything most of what's in the
     top-level into a src/ directory, I think this is shaping up to be a
     real reorganization, and the structure is easier to look at.

  2. I found it most instructive to actually checkout the result and
     look at the organization from a new user perspective. Here are my
     impressions:

       - There are a still a lot of directories. I wonder if we should
         be going deeper. Like commands/builtin. Or lib/*.

       - Some names seem funny. Like "gitk-git", which really should
         just be "gitk". But I think that is a limitation of the subtree
         merge. Maybe it's time for us to eat our own submodules
         dogfood? :)

       - Before build, "ls | wc -l" reports 35 entries. Afterwards, it
         reports 213, and any structure you uncovered in reorganization
         is lost. Maybe that doesn't matter, since the clean tree is
         what people will see first when they are getting their
         bearings. Or maybe not, since maybe they build first, then
         hack. I dunno. I'm not sure what the solution is. There are
         some obvious things, like throwing the test-* built executables
         into test-programs (which will require some magic in
         test-lib.sh to find them). Maybe git-* should stay in commands.
         I dunno.

-Peff
