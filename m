From: Jeff King <peff@peff.net>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Mon, 9 May 2011 06:44:47 -0400
Message-ID: <20110509104446.GB9060@sigill.intra.peff.net>
References: <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
 <BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
 <20110506065601.GB13351@elie>
 <BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
 <20110506172334.GB16576@sigill.intra.peff.net>
 <BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
 <20110509073535.GA5657@sigill.intra.peff.net>
 <BANLkTi=tfxPN=WLmfn=d+jrHV3U-Rp8T=A@mail.gmail.com>
 <20110509081219.GB6205@sigill.intra.peff.net>
 <BANLkTimKRo_36Ce2aFWWXdM1a+EgQ-u77Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 12:45:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJNxS-0006gQ-Tv
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 12:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab1EIKou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 06:44:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37013
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab1EIKot (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 06:44:49 -0400
Received: (qmail 7431 invoked by uid 107); 9 May 2011 10:46:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 06:46:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 06:44:47 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimKRo_36Ce2aFWWXdM1a+EgQ-u77Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173217>

On Mon, May 09, 2011 at 06:45:56PM +1000, Jon Seymour wrote:

> I am starting to think that deploy-via-zip/tar is unworkable for the
> case where the extension wants to supply html, since I think an
> attempt has to be made to deploy HTML in the path reported by git
> --html-path for reasons of HTML  linkability from extension back to
> the pages from git-core.

Yeah, I don't see a way around that without post-processing the HTML
links at install time (or creating a symlink farm with all of the HTML
pages).

> So, suppose we call it --preferred-extension-path*, then if the user
> (root or otherwise) defines
> 
>     git config core.preferrred-extension-path ${HOME}/.gitplugins
> 
> then they get to choose where the installer next run will install extensions.

I thought about suggesting that, but a config option didn't seem a good
fit to me. The decision of where to put a package seems more likely to
be related to which _package_ it is, than which user you are. So a
command-line option would make more sense. And even if you have a config
option, you would sitll need a command-line one to override, so it's not
like you are reducing the amount of code or complexity.

Which again makes it not a git issue at all, but an issue for
package-writers who want to provide a script. It's their job to interact
with the user and find out where the user wants to put things (i.e.,
personal or system directories).

I don't really see any need for git's role in this to be more than:

  1. Check a set list of directories for extra paths to add to PATH and
     MANPATH.

  2. Tell the packager's script what that set list is, so they can be
     sure to put their files in the right spot.

-Peff
