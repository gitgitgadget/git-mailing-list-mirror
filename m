From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] better userdiff behavior for symlinks
Date: Tue, 21 Sep 2010 16:59:14 -0400
Message-ID: <20100921205914.GA1166@sigill.intra.peff.net>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
 <vpqhbhmx6tg.fsf@bauges.imag.fr>
 <7vpqwa254i.fsf@alter.siamese.dyndns.org>
 <20100920180046.GA1790@sigill.intra.peff.net>
 <7vaanbuggr.fsf@alter.siamese.dyndns.org>
 <20100921184241.GA28567@sigill.intra.peff.net>
 <20100921185613.GB28567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 22:59:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy9vv-0007yl-V5
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 22:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110Ab0IUU7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 16:59:16 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55800 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756024Ab0IUU7O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 16:59:14 -0400
Received: (qmail 11889 invoked by uid 111); 21 Sep 2010 20:59:14 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 21 Sep 2010 20:59:14 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Sep 2010 16:59:14 -0400
Content-Disposition: inline
In-Reply-To: <20100921185613.GB28567@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156760>

On Tue, Sep 21, 2010 at 02:56:13PM -0400, Jeff King wrote:

> We are again acting on the symlink's contents, which are a text
> pathname, as if they represented the content of that pathname.
> 
> So I think that is a bug, albeit one that is relatively uncommon to
> trigger. S_ISGITLINK files may have the same issues, but perhaps not,
> as I think they get routed out of the regular diff codepath early.

Here is a patch series to address this:

  [1/2]: diff: don't use pathname-based diff drivers for symlinks
  [2/2]: diff: add a special SYMLINK user-diff driver

The first one fixes the bug. The second one is similar to what I posted
before, but it may actually be more useful now, as it re-enables some
dubious functionality that the first patch dropped (but in a more sane
way). See the comments in each patch for details.

-Peff
