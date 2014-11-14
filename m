From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 15:02:39 -0500
Message-ID: <20141114200239.GA11581@peff.net>
References: <1415918419-20807-1-git-send-email-blume.mike@gmail.com>
 <546656C8.3070009@kdbg.org>
 <CAO2U3QgmuwatfDDO8f461cwq2SctPx+owL8gDMBpNyDcaxaWGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:02:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpN4v-0002lA-Rn
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 21:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbaKNUCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 15:02:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:40458 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753231AbaKNUCl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 15:02:41 -0500
Received: (qmail 13745 invoked by uid 102); 14 Nov 2014 20:02:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 14:02:41 -0600
Received: (qmail 16165 invoked by uid 107); 14 Nov 2014 20:02:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 15:02:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Nov 2014 15:02:39 -0500
Content-Disposition: inline
In-Reply-To: <CAO2U3QgmuwatfDDO8f461cwq2SctPx+owL8gDMBpNyDcaxaWGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, 2014 at 11:48:36AM -0800, Michael Blume wrote:

> My understanding is that && and || have equal precedence, and this
> seems to be borne out in testing at my shell. If the if/then method is
> clearer I'm happy to go with that.

I think the problem is that there are earlier parts of the chain. It
currently looks like:

  foo &&
  bar &&
  do_something

but you are making it:

  foo &&
  bar || baz &&
  do_something

which will do_something whether or not "foo" is true. You need to put
your "||" at a lower precedence than the rest of the chain. The "if"
that Johannes mentioned works, though I think

  test_have_prereq PERL &&
  {
    test "$(uname -s)" != Darwin ||
    test "$(uname -r | cut -d. -f1)" -ge 13
  } &&
  ...

is more obvious to read (but that's subjective, of course).

-Peff
