From: Jeff King <peff@peff.net>
Subject: Re: git push --quiet option does not seem to work
Date: Mon, 16 May 2016 09:37:31 -0400
Message-ID: <20160516133731.GA6903@sigill.intra.peff.net>
References: <CADKp0pwrKzHG7KVSMH+6OHuv9sKXTcKSsdKMEZ_fFdjWT+kW6g@mail.gmail.com>
 <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com>
 <20160515212332.GB31809@sigill.intra.peff.net>
 <CADKp0pzPOdcSfBESzGMhrY5itSa4KDeOQ2VgwewuwH8CGZcwCw@mail.gmail.com>
 <20160516005824.GA1963@sigill.intra.peff.net>
 <CADKp0pzOLs5g9Jc6_sA6jr-XOifx0Yn6b7wDW2qcC2UB5Q_WPQ@mail.gmail.com>
 <alpine.DEB.2.20.1605161526510.3303@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris B <chris.blaszczynski@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 16 15:37:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2IiI-0004Tg-CA
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 15:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbcEPNhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 09:37:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:40158 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751815AbcEPNhf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 09:37:35 -0400
Received: (qmail 32074 invoked by uid 102); 16 May 2016 13:37:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 May 2016 09:37:34 -0400
Received: (qmail 5455 invoked by uid 107); 16 May 2016 13:37:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 May 2016 09:37:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2016 09:37:31 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1605161526510.3303@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294737>

On Mon, May 16, 2016 at 03:28:30PM +0200, Johannes Schindelin wrote:

> > PS H:\test-ps\myrepo> git push --quiet
> > git : remote:
> > At line:1 char:1
> > + git push --quiet
> > + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     + CategoryInfo          : NotSpecified: (remote: :String) [],
> > RemoteException
> >     + FullyQualifiedErrorId : NativeCommandError
> > 
> > remote: Analyzing objects... (3/3) (119 ms)
> > remote: Storing packfile... done (113 ms)
> > remote: Storing index... done (29 ms)
> 
> So it actually works, eh?
> 
> Could you please verify that this is a PowerShell-only problem by
> performing a similar push in Git CMD and in Git Bash?

I don't know much about PowerShell, but presumably it is responsible for
the first few lines.

But there is something else going on, too, which is those "remote:"
lines. Those are being relayed from the server by the git client. I
don't think it would be correct for the client to suppress them, even
with "--quiet", because the client side has no idea if they are progress
junk or critical error messages.

The client _does_ pass along the "quiet" flag to the server via the git
protocol, so it should be the server's responsibility to drop progress
output when it is present. The server side here is clearly not stock
git, from the content of those progress messages (some googling shows it
looks like whatever visualstudio.com is running, but I don't know what
that is). So either the server implementation doesn't support the
"quiet" protocol extension, or it is ignoring it. It might be worth
filing a bug with them.

-Peff
