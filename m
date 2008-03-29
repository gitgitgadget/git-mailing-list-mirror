From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Sat, 29 Mar 2008 18:00:11 -0400
Message-ID: <20080329220011.GC30851@coredump.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803291354.10368.robin.rosenberg.lists@dewire.com> <20080329211849.GA30851@coredump.intra.peff.net> <200803292243.40733.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 23:01:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfj6s-0004OP-RD
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 23:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbYC2WAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 18:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbYC2WAQ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 18:00:16 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4949 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbYC2WAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 18:00:15 -0400
Received: (qmail 8430 invoked by uid 111); 29 Mar 2008 22:00:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 29 Mar 2008 18:00:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Mar 2008 18:00:11 -0400
Content-Disposition: inline
In-Reply-To: <200803292243.40733.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78486>

On Sat, Mar 29, 2008 at 10:43:40PM +0100, Robin Rosenberg wrote:

> First that is even by random an unlikely sequence. For any "real" is string
> it simply won't happen, even in this context. Try scanning everything you
> can think of and see if you find such a sequence that is not actually UTF-8.

That's the problem I was mentioning: "everything I can think of" is
basically just us-ascii with a few accented characters. I don't know
how, e.g., Japanese texts will fare with such a test.

> > But over all commonly used encodings, what is the probability in an
> > average text of that encoding that it contains valid UTF-8?
> > For example, I have no idea what patterns can be found in EUCJP.
> 
> See here http://www.ifi.unizh.ch/mml/mduerst/papers/PDF/IUC11-UTF-8.pdf

Thanks, that is an interesting read. And he seems to indicate that you
can guess with a reasonable degree of success. But a few points on that
work:

  - he has a specific methodology for guessing, which is more elaborate
    than what you proposed. So to get his results, you would need to
    implement his method. Hopefully if perl does have a "guess if this
    looks like utf8" method, it uses a similar scheme.

  - he does admit that some encodings have difficult to assess
    probabilities, and it will vary from language to language. See page
    22:

      If a specific language does not use all three letters (a single
      letter on the left and the corresponding two letters on the
      right), then this combination presents no danger. Further checks
      can then be made with a dictionary, although there is the problem
      that a dictionary never contains all possible words, and that of
      course resource names don't necessarily have to be words.

  - he mentions Latin, Cyrillic, and Hebrew encodings. I note the
    conspicuous absence of any Asian languages.

> Note that a random string is a randomly generated string. Not a random
> string from the set of actually existing strings.

Sure. But looking at random strings isn't terribly useful; there is a
non-uniform distribution over the set of strings, dependent on the
_actual_ encoding. So there are going to be "good" encodings that will
guess well, and there will be "bad" encodings that might not (and by
"will", I mean "there may be"; that is the very thing I am saying we
don't have good evidence for).

-Peff
