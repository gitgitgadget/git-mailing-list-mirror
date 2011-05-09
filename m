From: Jeff King <peff@peff.net>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Mon, 9 May 2011 08:21:37 -0400
Message-ID: <20110509122137.GA10095@sigill.intra.peff.net>
References: <20110506172334.GB16576@sigill.intra.peff.net>
 <BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
 <20110509073535.GA5657@sigill.intra.peff.net>
 <BANLkTi=tfxPN=WLmfn=d+jrHV3U-Rp8T=A@mail.gmail.com>
 <20110509081219.GB6205@sigill.intra.peff.net>
 <BANLkTimKRo_36Ce2aFWWXdM1a+EgQ-u77Q@mail.gmail.com>
 <20110509104446.GB9060@sigill.intra.peff.net>
 <BANLkTikUjGLBH6_ze7EvRfoKb9h-RREmuA@mail.gmail.com>
 <20110509112428.GE9060@sigill.intra.peff.net>
 <BANLkTikQQNoYf=vZwMwAXPu0-S_2s9Y79w@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 09 14:21:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJPT7-0008Aq-CP
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 14:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab1EIMVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 08:21:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42761
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587Ab1EIMVj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 08:21:39 -0400
Received: (qmail 8270 invoked by uid 107); 9 May 2011 12:23:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 08:23:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 08:21:37 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikQQNoYf=vZwMwAXPu0-S_2s9Y79w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173225>

On Mon, May 09, 2011 at 09:28:26PM +1000, Jon Seymour wrote:

> > Anyway, with respect to "core.preferredPluginPath", if you do want to go
> > in that direction, I don't think any extra git support is needed. You
> > can already just do "git config --path core.preferredPluginPath" to get
> > the value (with tilde-expansion, even).
> 
> I still think it would be useful for the git wrapper to add
> core.preferredPluginPrefix/bin to the PATH, so that there is no
> requirement for the user to do this separately via mechanisms that
> will differ according to platform, shell etc.

Ah, yeah, that probably does make sense.

My original conception was that it would be more like
"preferredExtensionType" and would be either "user" or "system", from
which the installer would select either "$HOME/.gitplugins" or "git
--system-extension-dir" respectively. And I was still thinking in those
terms, even though the example you showed was obviously an arbitrary
path.

If you want to go the arbitrary path route, then yeah, it would need to
be added to git's expansion list.

There is one drawback with that, though. Consider something like this:

  $ git config core.preferredPluginPrefix /opt/git-plugins
  $ cd git-foo && ./install
  [installs in /opt/git-plugins/git-foo]
  $ git foo ;# works fine

  [time passes; now you decide you want to install new plugins in your
   home directory]
  $ git config core.preferredPluginPrefix $HOME/.gitplugins
  $ cd git-bar && ./install
  [installs in $HOME/.gitplugins]
  $ git bar ;# works fine
  $ git foo ;# now broken!

So there is some value to separating the concept of "these are the paths
git looks in" and "this is the path we install into" and enforcing that
the latter points to one of the former.

-Peff
