From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Fri, 3 Jun 2011 10:51:54 -0400
Message-ID: <20110603145154.GB11273@sigill.intra.peff.net>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com>
 <20110603054303.GA5341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 16:52:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSVjR-00058G-Sr
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 16:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab1FCOv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 10:51:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54050
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862Ab1FCOv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 10:51:56 -0400
Received: (qmail 8569 invoked by uid 107); 3 Jun 2011 14:52:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Jun 2011 10:52:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2011 10:51:54 -0400
Content-Disposition: inline
In-Reply-To: <20110603054303.GA5341@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175010>

On Fri, Jun 03, 2011 at 01:43:03AM -0400, Jeff King wrote:

> On Fri, Jun 03, 2011 at 12:36:50AM -0500, Sverre Rabbelier wrote:
> 
> > On Fri, Jun 3, 2011 at 00:18, Jeff King <peff@peff.net> wrote:
> > > So I guess it doesn't like us asking for HEAD. But the fact that it
> > > sends weird data to fast-import instead of saying "hey, HEAD doesn't
> > > exist" has me confused. I'm not sure if this is something one should not
> > > be doing with remote helpers, or if the testgit helper is simply buggy
> > > or incomplete.
> > 
> > Definitely the latter, quite possibly the former. I don't know if
> > asking for "HEAD" makes much sense in a remote-helper context though.
> > In Mercurial it does (e.g., tip), and in svn sort of, but I don't know
> > about other vcs-es. Perhaps it should be guarded by a capability?
> 
> Yeah, I think it depends on the helper. Definitely smart-http should be
> able to do it. But protecting it with a capability does make sense, and
> then remote helpers can opt into it.

Actually, I forgot that I did consider this when writing the original
patch. The clone code will only ask for HEAD if the remote side
advertises it. So there is no capability required; either the helper
advertises a HEAD ref or it doesn't. If it does, it should be prepared
for us to ask for its sha1.

-Peff
