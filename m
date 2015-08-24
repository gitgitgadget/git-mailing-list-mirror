From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] "am" state file fix with write_file() clean-up
Date: Mon, 24 Aug 2015 14:35:55 -0400
Message-ID: <20150824183554.GA5883@sigill.intra.peff.net>
References: <20150824065033.GA4124@sigill.intra.peff.net>
 <1440436186-7894-1-git-send-email-gitster@pobox.com>
 <20150824174142.GA4794@sigill.intra.peff.net>
 <xmqqlhd04ko4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:36:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTwbb-0001QO-Qe
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 20:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbbHXSgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 14:36:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:49187 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932387AbbHXSf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 14:35:57 -0400
Received: (qmail 10977 invoked by uid 102); 24 Aug 2015 18:35:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 13:35:57 -0500
Received: (qmail 26156 invoked by uid 107); 24 Aug 2015 18:35:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 14:35:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2015 14:35:55 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhd04ko4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276475>

On Mon, Aug 24, 2015 at 11:15:55AM -0700, Junio C Hamano wrote:

> > This all looks good to me. The topics-in-flight compatibility stuff in
> > patches 3 and 5 is neatly done. Usually I would just cheat and change
> > the order of arguments to make the compiler notice such problems, but
> > that's hard to do here because of the varargs (you cannot just bump
> > "flags" to the end).
> 
> Actually, I think my compatibility stuff is worthless.  It would not
> catch new callers that wants to only probe and do their own error
> handling by passing 0 (and besides, assert() is a shoddy way to do
> this---there is no guarantee that tests will trigger all the
> codepaths in the first place).

Oh, hrm, you're right. I was focused on making sure the common 1-passers
were not broken, but patch 3 does break 0-passers (obviously, because
they needed updated in the same patch ;) ).

And I do agree that build-time assertions are much better than run-time
ones.

> We should deprecate and remove write_file() by renaming the one with
> the updated semantics to something else, possibly with a backward
> compatiblity thin wrapper around it that is called write_file(), or
> without it to force a link-time error.

That sounds reasonable. Maybe "format_to_file" or something?

-Peff
