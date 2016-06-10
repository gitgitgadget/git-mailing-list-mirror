From: Jeff King <peff@peff.net>
Subject: Re: [BUG-ish] diff compaction heuristic false positive
Date: Fri, 10 Jun 2016 04:31:02 -0400
Message-ID: <20160610083102.GA14192@sigill.intra.peff.net>
References: <20160610075043.GA13411@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 10:31:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBHqU-0003l0-9I
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 10:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbcFJIbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 04:31:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:52355 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751065AbcFJIbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 04:31:06 -0400
Received: (qmail 30697 invoked by uid 102); 10 Jun 2016 08:31:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jun 2016 04:31:05 -0400
Received: (qmail 32038 invoked by uid 107); 10 Jun 2016 08:31:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jun 2016 04:31:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jun 2016 04:31:02 -0400
Content-Disposition: inline
In-Reply-To: <20160610075043.GA13411@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296957>

On Fri, Jun 10, 2016 at 03:50:43AM -0400, Jeff King wrote:

> I found a false positive with the new compaction heuristic in v2.9:
> [...]

And by the way, this is less "hey neat, I found a case" and more "wow,
this is a lot worse than I thought".

I diffed the old and new output for the top 10,000 commits in this
particular ruby code base. There were 45 commits with changed diffs.
Spot-checking them manually, a little over 1/3 of them featured this bad
pattern. The others looked like strict improvements.

That's a lot worse than the outcomes we saw on other code bases earlier.
1/3 bad is still a net improvement, so I dunno. Is this worth worrying
about? Should we bring back the documentation for the knob to disable
it? Should we consider making it tunable via gitattributes?

I don't think that last one really helps; the good cases _and_ the bad
ones are both in ruby code (though certainly the C code we looked at
earlier was all good).

It may also be possible to make it Just Work by using extra information
like indentation. I haven't thought hard enough about that to say.

-Peff
