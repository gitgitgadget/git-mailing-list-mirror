From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] upload-pack: keep poll(2)'s timeout to -1
Date: Fri, 22 Aug 2014 11:44:45 -0400
Message-ID: <20140822154445.GA19135@peff.net>
References: <20140822151911.GA8531@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 17:44:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKr1J-00011C-Bv
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 17:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbaHVPot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 11:44:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:56875 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932098AbaHVPot (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 11:44:49 -0400
Received: (qmail 5057 invoked by uid 102); 22 Aug 2014 15:44:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Aug 2014 10:44:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Aug 2014 11:44:45 -0400
Content-Disposition: inline
In-Reply-To: <20140822151911.GA8531@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255679>

On Fri, Aug 22, 2014 at 03:19:11PM +0000, Edward Thomson wrote:

> Keep poll's timeout at -1 when uploadpack.keepalive = 0, instead of
> setting it to -1000, since some pedantic old systems (eg HP-UX) and
> the gnulib compat/poll will treat only -1 as the valid value for
> an infinite timeout.

That makes sense, and POSIX only specifies the behavior for -1 anyway.
The patch itself looks obviously correct. Thanks.

Since we're now translating the keepalive value, and since there's no
way to set it to "0" (nor would that really have any meaning), I guess
we could switch the internal "no keepalive" value to 0, and do:

  ret = poll(pfd, pollsize, keepalive ? 1000 * keepalive : -1);

which would let us avoid setting it to -1 in some other spots.  I dunno
if that actually makes a real difference to maintainability, though.
Either way:

  Acked-by: Jeff King <peff@peff.net>

-Peff
