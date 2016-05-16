From: Jeff King <peff@peff.net>
Subject: Re: git push --quiet option does not seem to work
Date: Mon, 16 May 2016 11:17:21 -0400
Message-ID: <20160516151721.GA8678@sigill.intra.peff.net>
References: <CADKp0pwrKzHG7KVSMH+6OHuv9sKXTcKSsdKMEZ_fFdjWT+kW6g@mail.gmail.com>
 <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com>
 <20160515212332.GB31809@sigill.intra.peff.net>
 <CADKp0pzPOdcSfBESzGMhrY5itSa4KDeOQ2VgwewuwH8CGZcwCw@mail.gmail.com>
 <20160516005824.GA1963@sigill.intra.peff.net>
 <CADKp0pzOLs5g9Jc6_sA6jr-XOifx0Yn6b7wDW2qcC2UB5Q_WPQ@mail.gmail.com>
 <alpine.DEB.2.20.1605161526510.3303@virtualbox>
 <20160516133731.GA6903@sigill.intra.peff.net>
 <CADKp0px3v3K4vqNeNk7NdWZFdSCyqMa+i_Nv0wW80Tkf0C=RUQ@mail.gmail.com>
 <alpine.DEB.2.20.1605161700360.3303@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris B <chris.blaszczynski@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 16 17:17:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2KGv-0000TZ-Q8
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 17:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbcEPPRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 11:17:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:40196 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752202AbcEPPRY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 11:17:24 -0400
Received: (qmail 6218 invoked by uid 102); 16 May 2016 15:17:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 May 2016 11:17:23 -0400
Received: (qmail 5979 invoked by uid 107); 16 May 2016 15:17:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 May 2016 11:17:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2016 11:17:21 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1605161700360.3303@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294741>

On Mon, May 16, 2016 at 05:04:34PM +0200, Johannes Schindelin wrote:

> > Anyway, it is not a Powershell thing. I tested on another repo on
> > GitHub and it worked as expected. So I guess indeed the problem lies
> > with Microsoft's implementation.
> 
> This is *really* unclear.
> 
> What "Microsoft's implementation"??? Do you refer to VSTS, or do you refer
> to Git for Windows, or PowerShell?
> 
> Please. To make it really simple for everybody involved, try to repeat as
> closely as possible the same push from PowerShell, Git CMD and Git Bash.
> We want to compare oranges to oranges.

I don't think there is much to debug there. According to

  http://superuser.com/questions/213848/using-powershell-call-native-command-line-app-and-capture-stderr/462362#462362

and other sources, it looks like PowerShell is very picky about calling
programs which produce any output on stderr, and may in an error object.
So I think both Powershell and Git are working as advertised, it's just
that their behaviors are incompatible.

The "bug" is that the server is asking the client to write non-error
output to stderr, even though the client should have asked the server to
be quiet (though it would not hurt to check that it is doing so by
looking at the output of GIT_TRACE_PACKET).

-Peff
