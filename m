From: Jeff King <peff@peff.net>
Subject: Re: syntax error in git-rebase while running t34* tests
Date: Tue, 10 May 2016 16:47:58 -0400
Message-ID: <20160510204758.GB19958@sigill.intra.peff.net>
References: <CALR6jEiF9Ooi1f0O3KG0wYmN0KRWBQTNarXx79-wBD2E-8q2jA@mail.gmail.com>
 <xmqq60ulpw1s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:48:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0EZc-0004Yk-KP
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 22:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbcEJUsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 16:48:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:37253 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751227AbcEJUsC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 16:48:02 -0400
Received: (qmail 28270 invoked by uid 102); 10 May 2016 20:48:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 16:48:01 -0400
Received: (qmail 1248 invoked by uid 107); 10 May 2016 20:48:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 16:48:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2016 16:47:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqq60ulpw1s.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294189>

On Tue, May 10, 2016 at 12:11:59PM -0700, Junio C Hamano wrote:

> Armin Kunaschik <megabreit@googlemail.com> writes:
> 
> > I fail to see why eval is really necessary here.
> 
> It is necessary to work correctly with any strategy option with $IFS
> in it, I would think.  The calling script "git-rebase" accumulates
> --strategy-option values after passing each of them through
> "rev-parse --sq-quote" for that reason.
> 
> which means that eval'ed string here:
> 
> > My quick and dirty hotfix is to place a
> > test -n "$strategy_opts" &&
> > in front of the eval.
> > The tests run fine after this change.
> >
> > What do you think?
> 
> I do not see why "test -n &&" is necessary here, and would be very
> hesitant to accept a change that nobody understands why it works.

I think it is clear why it works. If $strategy_opts is empty, then the
code we generate looks like:

  for strategy_opt in
  do
          ...
  done

and some shells (apparently) are not happy with no content after the
"in". If the variable is empty, there is no need to run the loop at all,
so it is OK to skip it the eval entirely.

-Peff
