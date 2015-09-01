From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] run-command: provide in_async query function
Date: Tue, 1 Sep 2015 18:17:05 -0400
Message-ID: <20150901221705.GA7862@sigill.intra.peff.net>
References: <20150901202215.GA17370@sigill.intra.peff.net>
 <20150901202243.GA6931@sigill.intra.peff.net>
 <xmqq613trdu3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:17:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWtrc-0002d7-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbbIAWRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:17:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:53364 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751574AbbIAWRI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:17:08 -0400
Received: (qmail 30097 invoked by uid 102); 1 Sep 2015 22:17:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 17:17:07 -0500
Received: (qmail 6429 invoked by uid 107); 1 Sep 2015 22:17:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 18:17:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 18:17:05 -0400
Content-Disposition: inline
In-Reply-To: <xmqq613trdu3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277054>

On Tue, Sep 01, 2015 at 03:09:56PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It's not easy for arbitrary code to find out whether it is
> > running in an async process or not. A top-level function
> > which is fed to start_async() can know (you just pass down
> > an argument saying "you are async"). But that function may
> > call other global functions, and we would not want to have
> > to pass the information all the way through the call stack.
> >
> > Nor can we simply set a global variable, as those may be
> > shared between async threads and the main thread (if the
> > platform supports pthreads). We need pthread tricks _or_ a
> > global variable, depending on how start_async is
> > implemented.
> >
> > The callers don't have enough information to do this right,
> > so let's provide a simple query function that does.
> > Fortunately we can reuse the existing infrastructure to make
> > the pthread case simple (and even simplify die_async() by
> > using our new function).
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> 
> What is not immediately obvious from the above description is why a
> code may want to care if it is in_async() in the first place.
> 
> If there weren't the die_async() update, the readers might have been
> left utterly baffled (or they can somehow see this is related to
> 2/2) but it is a bit hard to arrange in "git log" as going to child
> is harder.
> 
> The patch looks good.  Thanks.

Yeah, I almost mentioned "...in the next patch we'll need this", but I
wasn't sure how to bring that up without going into the complicated
reasoning in that patch. I don't know if it's worth adding "we don't
have any callers yet, but we will add one in a moment".

-Peff
