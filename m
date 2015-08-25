From: Jeff King <peff@peff.net>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Tue, 25 Aug 2015 14:52:10 -0400
Message-ID: <20150825185210.GA10032@sigill.intra.peff.net>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
 <20150825171238.GB9674@sigill.intra.peff.net>
 <xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gabor Bernat <bernat@primeranks.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 20:52:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUJKT-0003Sw-Fg
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 20:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbbHYSwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 14:52:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:49939 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751816AbbHYSwN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 14:52:13 -0400
Received: (qmail 15324 invoked by uid 102); 25 Aug 2015 18:52:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 13:52:12 -0500
Received: (qmail 6525 invoked by uid 107); 25 Aug 2015 18:52:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 14:52:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2015 14:52:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276559>

On Tue, Aug 25, 2015 at 11:33:49AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +start=$(date +%s)
> 
> Is that a GNU extension?

Thanks, I meant to mention that, too. POSIX has "+" formats, but
apparently no way to get an integer number of seconds. I don't know how
widely "%s" is supported; BSD "date" seems to know about it.

> An alternative implementation may be to ask `date` every 1000
> commits (or whatever sufficiently large value that we can amortise
> the cost) to measure the rate and compute $remain based on that
> measurement.  That way, we can afford to use more portable ways to
> ask `date` about the current time and compute the "how many seconds"
> ourselves.

Yeah, that would probably be a good solution, assuming there is a
portable "how many seconds" (I do not relish the thought of
reconstructing it based on the current hours/minutes/seconds).

I wonder how awful it would be to make a tool like "git-progress", where
you'd tell it "--total=$commits --eta" on the command line, and then
occasionally print the current count its stdin. It might be a little
painful to use, though. You'd want to background it with a pipe to its
stdin, which is annoying without bash-style "<()" anonymous pipes.

-Peff
