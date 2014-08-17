From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] convert: Stream from fd to required clean filter
 instead of mmap
Date: Sun, 17 Aug 2014 03:27:47 -0400
Message-ID: <20140817072746.GD23808@peff.net>
References: <1407303134-16635-1-git-send-email-prohaska@zib.de>
 <1407303134-16635-3-git-send-email-prohaska@zib.de>
 <20140816102703.GD7857@serenity.lan>
 <FA3F1197-25C5-42E4-9418-1C821D430819@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 09:27:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIusb-0004VF-PW
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 09:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbaHQH1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 03:27:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:53528 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750809AbaHQH1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 03:27:48 -0400
Received: (qmail 6058 invoked by uid 102); 17 Aug 2014 07:27:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 02:27:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 03:27:47 -0400
Content-Disposition: inline
In-Reply-To: <FA3F1197-25C5-42E4-9418-1C821D430819@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255352>

On Sat, Aug 16, 2014 at 06:26:08PM +0200, Steffen Prohaska wrote:

> > Is the 15MB limit supposed to be imposed somewhere or is it just a guide
> > of how much memory we expect Git to use in this scenario?
> 
> The test should confirm that the the file that is added is not mmapped
> to memory.  The process size should be relatively small independently
> of the size of the file that is added.  I wanted to keep the file size
> small.  The chosen sizes worked for me on Mac and Linux.

Measuring memory usage seems inherently a bit flaky for the test suite.
It's also a little out of place, as the test suite is generally about
correctness and outcomes, and this is a performance issue.

Would it make more sense to construct a t/perf test that shows off the
change? I suppose the run-time change may not be that impressive, but it
would be cool if t/perf could measure max memory use, too. Then we can
just compare results between versions, which is enough to detect
regressions.

There's some prior art in the jk/pack-bitmap-reuse-deltas series (which
is not merged), where I taught it to measure output sizes of commands.
That should provide the necessary refactoring base, I think.

-Peff
