From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] test-lib.sh: support -x option for shell-tracing
Date: Fri, 10 Oct 2014 02:27:22 -0400
Message-ID: <20141010062722.GB17481@peff.net>
References: <20141010060636.GA15057@peff.net>
 <20141010061355.GC15277@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 08:27:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcTfs-0004bU-9c
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 08:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbaJJG1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 02:27:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:57095 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbaJJG1X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 02:27:23 -0400
Received: (qmail 29030 invoked by uid 102); 10 Oct 2014 06:27:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 01:27:24 -0500
Received: (qmail 30769 invoked by uid 107); 10 Oct 2014 06:27:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 02:27:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Oct 2014 02:27:22 -0400
Content-Disposition: inline
In-Reply-To: <20141010061355.GC15277@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 10, 2014 at 02:13:55AM -0400, Jeff King wrote:

> +	-x)
> +		test_eval_start_='set -x'
> [...]
> +	eval "$test_eval_start_ $*"
> +}

Hmph. I had originally intended to make this "set -x;" with a semicolon,
to keep it split from $*. But I forgot to, and much to my surprise, all
of the tests still passed. I think that is because each of the tests
is one of:

  1. Long, in which case we split the commands into their own line,
     like:

        test_expect_success 'foo' '
		some command
	'

     and the leading newline serves as the separator.

or

  2. Short, like:

       test_expect_success 'foo' 'bar'

     in which case we did not run the test at all, but merely set $1 to
     'bar', which of course succeeded. Whoops!

Still, I'm surprised that nothing failed due to case 2.  I'll send a
re-roll in a moment.

-Peff
