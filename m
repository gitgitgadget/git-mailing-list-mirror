From: Jeff King <peff@peff.net>
Subject: Re: no-xmailer tests fail under Mac OS
Date: Sat, 6 Dec 2014 01:32:46 -0500
Message-ID: <20141206063245.GA5966@peff.net>
References: <CAO2U3Qg3KsjvWJFza4MfiQDa2LbCpOy1Nxf9Vt3NSgXc7Bee9g@mail.gmail.com>
 <20141206053434.GF31301@peff.net>
 <CAO2U3QjkJRPrFvapK=LDU_GG5Ne6_zVD+S61JP+iV_Xi-gk5JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	Luis Henriques <henrix@camandro.org>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 07:32:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx8vE-0000Kt-AF
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 07:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbaLFGcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 01:32:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:49325 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750965AbaLFGcs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 01:32:48 -0500
Received: (qmail 9115 invoked by uid 102); 6 Dec 2014 06:32:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Dec 2014 00:32:48 -0600
Received: (qmail 9963 invoked by uid 107); 6 Dec 2014 06:32:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Dec 2014 01:32:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Dec 2014 01:32:46 -0500
Content-Disposition: inline
In-Reply-To: <CAO2U3QjkJRPrFvapK=LDU_GG5Ne6_zVD+S61JP+iV_Xi-gk5JQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260942>

On Fri, Dec 05, 2014 at 10:27:40PM -0800, Michael Blume wrote:

> > We have had trouble in the past with "wc -l" output not being strictly
> > portable. I do not recall offhand which systems, but it is a good bet
> > that this is the culprit. Doing:
> >
> >   grep ^X-Mailer: out >mailer &&
> >   test_line_count = $expected mailer
> >
> > should fix it. It might be even nicer to actually compare the x-mailer
> > line we find to an expected output, but that may introduce complications
> > if the value changes with the version or something (you'd have to
> > sanitize the output, and then I do not know that the test is really
> > buying much over just seeing whether it exists).
> >
> > -Peff
> 
> Actually need to drop the '&&', but yes, that works perfectly, thanks =)

Ah, right, we might be looking for 0 sometimes. The right way to do it
without destroying the &&-chaining is:

  { grep ^X-Mailer: out || true } &&
  test_line_count = $expected mailer

-Peff
