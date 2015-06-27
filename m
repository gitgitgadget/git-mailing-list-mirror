From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] p5310: Fix broken && chain in performance test
Date: Sat, 27 Jun 2015 02:14:45 -0400
Message-ID: <20150627061444.GB9353@peff.net>
References: <1435354020-11675-1-git-send-email-sbeller@google.com>
 <xmqq616artpz.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYCcexkdcF4D4GhUydh=0u0UOZGb0QGbtg6gbKWeO2M_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 08:15:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8jOJ-0008Hb-38
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 08:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbbF0GOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 02:14:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:52608 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752006AbbF0GOr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 02:14:47 -0400
Received: (qmail 17296 invoked by uid 102); 27 Jun 2015 06:14:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Jun 2015 01:14:47 -0500
Received: (qmail 22874 invoked by uid 107); 27 Jun 2015 06:14:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Jun 2015 02:14:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Jun 2015 02:14:45 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYCcexkdcF4D4GhUydh=0u0UOZGb0QGbtg6gbKWeO2M_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272853>

On Fri, Jun 26, 2015 at 03:34:19PM -0700, Stefan Beller wrote:

> > Thanks.  How did you find this (does the auto &&-chain test apply to
> > t/perf stuff as well)?
> 
> Apparently the &&-chain tests for it as I got a warning for it while
> benchmarking some changes in ALLOC_GROW. (which originally
> should have fixed the coverity false positives, but I was side tracked
> wondering about performance)

That makes sense; we use test_expect_success here, so I think it is good
for it to check that we are actually creating a sane exit status.

It looks like we do not extend the same protection to test_perf (it uses
test_eval_, bnot test_run_). That is probably OK, as those tests are
more about measuring the time than about correctness. OTOH, we do notice
when a test_perf reports failure, so perhaps it would make sense to
extend &&-chaining checks there.

-Peff
