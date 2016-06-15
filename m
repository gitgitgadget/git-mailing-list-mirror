From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] gpg-interface: check gpg signature creation status
Date: Tue, 14 Jun 2016 20:56:14 -0400
Message-ID: <20160615005614.GB32601@sigill.intra.peff.net>
References: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
 <8e08b63b58302b6e7fe91f0dfb5b476781bfd37d.1465915311.git.git@drmicha.warpmail.net>
 <xmqq60tbaba5.fsf@gitster.mtv.corp.google.com>
 <20160614215019.GB22334@sigill.intra.peff.net>
 <20160614222633.GA32020@sigill.intra.peff.net>
 <xmqqporj72p4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	ZhenTian <loooseleaves@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 02:56:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCz84-00038K-F1
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 02:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbcFOA4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 20:56:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:54967 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752159AbcFOA4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 20:56:17 -0400
Received: (qmail 23247 invoked by uid 102); 15 Jun 2016 00:56:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 20:56:16 -0400
Received: (qmail 1775 invoked by uid 107); 15 Jun 2016 00:56:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 20:56:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 20:56:14 -0400
Content-Disposition: inline
In-Reply-To: <xmqqporj72p4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297348>

On Tue, Jun 14, 2016 at 04:47:35PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm still undecided on whether it is a better approach than making
> > sure the stdout we got looks sane. In particular I'd worry that it
> > would make things harder for somebody trying to plug in something
> > gpg-like (e.g., if you wanted to do something exotic like call a
> > program which fetched the signature from a remote device or
> > something).  But it's probably not _that_ hard for such a script
> > to emulate --status-fd.
> 
> I share the same thinking, but at the same time, it already is a
> requirement to give --status-fd output that is close enough on the
> signature verification side, isn't it?

Yeah, though I could see somebody wanting to sit amidst the signing side
but not verification (e.g., if your keys are elsewhere from the machine
running git). Of course such a case could probably ferry --status-fd
from the other side anyway.

I admit I don't know of such a case in practice, though, and
implementing a rudimentary --status-fd to say "SIG OK" or whatever on
the signing side is not _that_ big a deal. So if we think this approach
is a more robust solution in the normal case, let's not hold it up over
what-ifs.

-Peff
