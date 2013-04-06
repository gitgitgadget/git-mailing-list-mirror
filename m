From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] show-branch: use strbuf instead of static buffer
Date: Sat, 6 Apr 2013 00:58:33 -0400
Message-ID: <20130406045833.GB26544@sigill.intra.peff.net>
References: <20130405211550.GA4880@sigill.intra.peff.net>
 <20130405234915.GU30308@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Roman <eroman@chromium.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:34:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWSN-0001b9-VL
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab3DFE6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 00:58:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58594 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab3DFE6m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 00:58:42 -0400
Received: (qmail 21292 invoked by uid 107); 6 Apr 2013 05:00:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Apr 2013 01:00:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Apr 2013 00:58:33 -0400
Content-Disposition: inline
In-Reply-To: <20130405234915.GU30308@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220217>

On Fri, Apr 05, 2013 at 04:49:15PM -0700, Jonathan Nieder wrote:

> > Though this is a stack overflow, I don't know that it's exploitable for
> > anything interesting; an attacker does not get to write arbitrary data,
> > but rather only a sequence of "^%d" and "~%d" relative history markers.
> > Perhaps in theory one could devise a history such that the sequence
> > markers spelled out some malicious code, but it would be quite a
> > challenge
> 
> Overwrite the return address and return-to-libc?

Still hard, since you need to construct a usable address (and arguments)
out of sequences of "^[0-9]+" and "~[0-9]+". But I'd love to see a
working exploit if somebody thinks they can do it. :)

> Very clean and obviously correct.  Thanks.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

> A test would be nice, though.

What should it be testing? That a giant chain of second-parent merges
that exceeds 1000 bytes doesn't segfault? Tests like that are not all
that interesting, because they do not catch real-world regressions. We
have closed this barn door; it is not impossible that it will be
re-opened, but it is not likely. A test that checks only for a very
specific type of failure is only ever going to see that failure.

If you want to design a suite of tests that check that show-branch gives
correct output for particular brands of large repo, that would be
generic and potentially useful. But I don't think it's actually worth
spending a lot of time on (reviewing the code for more static buffers
and sprintfs would probably be a much more fruitful use of time).

-Peff
