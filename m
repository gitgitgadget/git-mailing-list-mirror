From: Jeff King <peff@peff.net>
Subject: Re: RFC: dynamic "auto" date formats
Date: Fri, 27 May 2016 00:00:31 -0400
Message-ID: <20160527040031.GB24972@sigill.intra.peff.net>
References: <CA+55aFzWEf2sN647v0mfiPOFE=KindQpweoHwdPmDshUb0YVsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 27 06:00:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b68ww-0004KM-Vu
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 06:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbcE0EAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 00:00:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:45064 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750914AbcE0EAe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 00:00:34 -0400
Received: (qmail 1928 invoked by uid 102); 27 May 2016 04:00:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 May 2016 00:00:34 -0400
Received: (qmail 26633 invoked by uid 107); 27 May 2016 04:00:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 May 2016 00:00:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 May 2016 00:00:31 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzWEf2sN647v0mfiPOFE=KindQpweoHwdPmDshUb0YVsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295726>

On Thu, May 26, 2016 at 08:36:57PM -0700, Linus Torvalds wrote:

> Note that this doesn't add any gitconfig setting to do this, which
> would be part of the whole point if this is actually sensible. But I'm
> not entirely convinced it's worth it in the first place, thus this
> email to see how people react ("That's just stupid" vs "yeah, I didn't
> even know I wanted it, but now I need it").
> 
> And no, I'm not at all sure that the 24-hour cut-off is the right
> thing, but it didn't seem completely crazy either. I tend to like the
> relative date format when it is "19 minutes ago" vs "2 hours ago", at
> some point it's long enough ago that it's more useful to know "Tuesday
> at 3pm" than about how long ago it was.

Seems like a reasonable idea, though I doubt I'd use it myself. In
addition to possibly making the cutoff-time configurable, I'd expect
people would want the fallback format to be configurable, too.

I wonder if something like:

  --date=relative:24h:iso

would make sense as "relative up to 24 hours, then iso". You could even
chain them, so your:

> (And yes, it would be even better to have the "short term relative
> date" turn into a "medium-term 'day of the week at time x'" and then
> turn into "full date" when it's more than a week ago, but this patch
> only has the two modes of "short term" and "long term" and nothing in
> between).

could be something like:

  --date=relative:24h:short:1w:normal

(where "short" actually kind of sucks; we'd introduce a new format for
your "Tuesday at 10pm" output).

I admit it's a bit baroque to look at, though.

-Peff
