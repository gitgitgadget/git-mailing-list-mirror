From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] tests: Prepare --textconv tests for
 correctly-failing conversion program
Date: Tue, 28 Sep 2010 11:58:45 -0400
Message-ID: <20100928155845.GA10271@sigill.intra.peff.net>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru>
 <66d4603c7e21561557f612690d6196e7ae0b38f9.1285351816.git.kirr@landau.phys.spbu.ru>
 <7vsk0vyriw.fsf@alter.siamese.dyndns.org>
 <20100928120722.GA29525@landau.phys.spbu.ru>
 <7vlj6lubg1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 17:58:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ca3-0005et-80
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 17:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab0I1P6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 11:58:50 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55653 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753452Ab0I1P6u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 11:58:50 -0400
Received: (qmail 30355 invoked by uid 111); 28 Sep 2010 15:58:49 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 28 Sep 2010 15:58:49 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Sep 2010 11:58:45 -0400
Content-Disposition: inline
In-Reply-To: <7vlj6lubg1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157438>

On Tue, Sep 28, 2010 at 08:36:46AM -0700, Junio C Hamano wrote:

> >> >  cat >helper <<'EOF'
> >> >  #!/bin/sh
> >> > -sed 's/^/converted: /' "$@" >helper.out
> >> > +grep -q '^bin: ' "$@" || { echo "E: $@ is not \"binary\" file" 1>&2; exit 1; }
> >>  ...
> > ...
> > I too think (1) is right. It was just that originally there was $@
> > (which I now understand was wrong).
> 
> Well, the original's use of "$@" is perfectly fine; it would do the right
> thing with one argument, of course, but it would do the right thing with
> more than one, too.  On the other hand, your use inside "echo" is not.

Moreover, the use of "grep" is wrong. Giving it two files, one of which
has "^bin: " and one of which doesn't, will silently accept the latter.
If it's going to handle multiple files, it must be a for-loop (or you
could invert "grep -qv", but I think that might be getting too clever to
remain readable).

Which is why I suggested just dropping the t4042 bit, which is the only
part that actually needs to handle multiple arguments. The other ones
can just switch to using "$1". The helper script is simple enough that
there is no need for them to share the same code.

-Peff
