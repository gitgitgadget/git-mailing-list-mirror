From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight
 unevenly-sized hunks
Date: Thu, 18 Jun 2015 15:04:17 -0400
Message-ID: <20150618190417.GA12769@peff.net>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
 <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
 <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
 <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Palka <patrick@parcs.ath.cx>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 21:04:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5f6u-0002ba-ME
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 21:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbbFRTEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 15:04:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:48290 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754107AbbFRTET (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 15:04:19 -0400
Received: (qmail 21398 invoked by uid 102); 18 Jun 2015 19:04:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 14:04:19 -0500
Received: (qmail 6495 invoked by uid 107); 18 Jun 2015 19:04:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 15:04:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jun 2015 15:04:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272033>

On Thu, Jun 18, 2015 at 11:08:16AM -0700, Junio C Hamano wrote:

> So as I said, I do not think it would hurt to have this as an
> incremental improvement (albeit going in a possibly wrong
> direction).
> 
> Of course, it is a separate question if this change makes the output
> worse, by comparing unmatched early parts of two hunks and making
> nonsense highlight by calling highlight_pair() more often.  As long
> as that is not an issue, I am not opposed to this change, which was
> what I meant to say by "this might not hurt".

Yes, that is my big concern, and why I punted on mismatched-size hunks
in the first place. Now that we have a patch, it is easy enough to "git
log -p | diff-highlight" with the old and new versions to compare the
results.

It certainly does improve some cases. E.g.:

  -foo
  +foo &&
  +bar

in a test script becomes more clear. But some of the output is not so
great. For instance, the very commit under discussion has a
confusing and useless highlight. Or take a documentation patch like
5c31acfb, where I find the highlights actively distracting. We are saved
a little by the "if the whole line is different, do not highlight at
all" behavior of 097128d1bc.

So I dunno. IMHO this does more harm than good, and I would not want to
use it myself. But it is somewhat a matter of taste; I am not opposed to
making it a configurable option.

-Peff
