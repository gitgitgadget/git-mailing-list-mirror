From: Jeff King <peff@peff.net>
Subject: Re: syntax error in git-rebase while running t34* tests
Date: Wed, 11 May 2016 09:36:16 -0400
Message-ID: <20160511133615.GA19356@sigill.intra.peff.net>
References: <CALR6jEiF9Ooi1f0O3KG0wYmN0KRWBQTNarXx79-wBD2E-8q2jA@mail.gmail.com>
 <xmqq60ulpw1s.fsf@gitster.mtv.corp.google.com>
 <20160510204758.GB19958@sigill.intra.peff.net>
 <xmqqy47hmy6z.fsf@gitster.mtv.corp.google.com>
 <20160510210709.GD19958@sigill.intra.peff.net>
 <alpine.DEB.2.20.1605111518470.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 11 15:36:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0UJP-0004uX-11
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbcEKNgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:36:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:38002 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932271AbcEKNgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:36:19 -0400
Received: (qmail 13558 invoked by uid 102); 11 May 2016 13:36:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 May 2016 09:36:18 -0400
Received: (qmail 11469 invoked by uid 107); 11 May 2016 13:36:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 May 2016 09:36:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 May 2016 09:36:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1605111518470.4092@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294343>

On Wed, May 11, 2016 at 03:28:35PM +0200, Johannes Schindelin wrote:

> Looks obviously correct to me.

Thanks.

> I had a look at our other shell scripts and it looks as if there is only
> one more candidate for this issue: git-bisect.sh has a couple of 'for arg
> in "$@"' constructs. But from a cursory look, it appears that none of
> these "$@" can be empty lists because at least one parameter is passed to
> those functions (check_expected_revs() is only called from bisect_state()
> with 1 or 2 parameters, bisect_skip() makes no sense without parameters,
> and bisect_state() has another for loop if it got 2 parameters).
> 
> So I think we're fine.

I'm not even sure that:

  for arg in "$@"

is a problem if "$@" is empty. The issue here is the eval, in which we
generate syntactically funny code and expect the shell to interpret it.
It's possible a shell could get the more mundane case wrong, but I'd
expect most to get it right.

I did some brief grepping around myself, but didn't find any other
interesting cases. That doesn't mean much, though; tracking down what
content actually makes it into some of our "eval" calls would be pretty
time-consuming. So I'd rely on people like Armin to report failures in
the test suite.

-Peff
