From: Jeff King <peff@peff.net>
Subject: Re: no-xmailer tests fail under Mac OS
Date: Sat, 6 Dec 2014 00:34:34 -0500
Message-ID: <20141206053434.GF31301@peff.net>
References: <CAO2U3Qg3KsjvWJFza4MfiQDa2LbCpOy1Nxf9Vt3NSgXc7Bee9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	Luis Henriques <henrix@camandro.org>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 06:34:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx80u-0000ZG-79
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 06:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbaLFFeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 00:34:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:49309 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750746AbaLFFeg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 00:34:36 -0500
Received: (qmail 6416 invoked by uid 102); 6 Dec 2014 05:34:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 23:34:36 -0600
Received: (qmail 9627 invoked by uid 107); 6 Dec 2014 05:34:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Dec 2014 00:34:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Dec 2014 00:34:34 -0500
Content-Disposition: inline
In-Reply-To: <CAO2U3Qg3KsjvWJFza4MfiQDa2LbCpOy1Nxf9Vt3NSgXc7Bee9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260939>

On Fri, Dec 05, 2014 at 06:05:24PM -0800, Michael Blume wrote:

> Failures start from
> 
> commit d2384abff7a6181fd7b9a51af7e780aa21e5cb8d (refs/bisect/bad)
> Author: Luis Henriques <henrix@camandro.org>
> Date:   Thu Dec 4 19:11:30 2014 +0000
> 
>     test/send-email: --[no-]xmailer tests
> 
>     Add tests for the --[no-]xmailer option.
> 
>     Signed-off-by: Luis Henriques <henrix@camandro.org>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> but continue with Junio's SQUASH??? commit at b728d078

The commit contains:

  +       test "z$(grep ^X-Mailer: out | wc -l)" = "z$expected"

We have had trouble in the past with "wc -l" output not being strictly
portable. I do not recall offhand which systems, but it is a good bet
that this is the culprit. Doing:

  grep ^X-Mailer: out >mailer &&
  test_line_count = $expected mailer

should fix it. It might be even nicer to actually compare the x-mailer
line we find to an expected output, but that may introduce complications
if the value changes with the version or something (you'd have to
sanitize the output, and then I do not know that the test is really
buying much over just seeing whether it exists).

-Peff
