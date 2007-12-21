From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Make git send-email accept $EDITOR with arguments
Date: Fri, 21 Dec 2007 14:23:59 -0500
Message-ID: <20071221192359.GA10660@coredump.intra.peff.net>
References: <20071220203211.GA12296@bit.office.eurotux.com> <1198237002-21470-1-git-send-email-hendeby@isy.liu.se> <20071221133412.GA15198@sigill.intra.peff.net> <476BDA5F.4070306@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: luciano@eurotux.com, git@vger.kernel.org, gitster@pobox.com
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Fri Dec 21 20:24:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5nTy-0005f3-1Y
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 20:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbXLUTYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 14:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbXLUTYE
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 14:24:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4296 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbXLUTYC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 14:24:02 -0500
Received: (qmail 2883 invoked by uid 111); 21 Dec 2007 19:24:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 21 Dec 2007 14:24:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Dec 2007 14:23:59 -0500
Content-Disposition: inline
In-Reply-To: <476BDA5F.4070306@isy.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69085>

On Fri, Dec 21, 2007 at 04:23:11PM +0100, Gustaf Hendeby wrote:

> > If you are going to do it that way, I suspect you want to quotemeta
> > $compose_filename.
> Generally that would be true, but is that really necessary when I know
> $compose_filename is defined as:
> 
> my $compose_filename = ".msg.$$";

I know; it is just easier to see that it is correct with the quotemeta
(and correct in the face of somebody changing the message later).

> Or, should I take it that you prefer the version using split?  I didn't
> really feel good about the possibility of splitting paths with spaces
> that came with that one though.

I am fine with using the shell. Though keep in mind that the two
solutions will behave differently with

  EDITOR='foo; bar'

That is, system("$editor $message") will actually invoke the shell,
whereas system(split(/ /, $editor), $message) will _just_ split on
whitespace. We should do whatever is consistent with the rest of the git
commands (off the top of my head, I don't know).

-Peff
