From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] improved out-of-the-box color settings
Date: Thu, 16 Jan 2014 23:14:30 -0500
Message-ID: <20140117041430.GB19551@sigill.intra.peff.net>
References: <52D87A79.6060600@rawbw.com>
 <20140117014758.GF7249@sigill.intra.peff.net>
 <52D88F30.4000807@rawbw.com>
 <20140117021320.GA12444@sigill.intra.peff.net>
 <20140117022921.GU18964@google.com>
 <20140117023548.GB13023@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Yuri <yuri@rawbw.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 05:14:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W40pJ-00077I-FQ
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 05:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbaAQEOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 23:14:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:33975 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751181AbaAQEOc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 23:14:32 -0500
Received: (qmail 14778 invoked by uid 102); 17 Jan 2014 04:14:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 22:14:32 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 23:14:30 -0500
Content-Disposition: inline
In-Reply-To: <20140117023548.GB13023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240569>

On Thu, Jan 16, 2014 at 09:35:48PM -0500, Jeff King wrote:

> I can prepare a patch series, but I happily no longer have any antique
> systems to test this kind of stuff on.

Here it is. For those just joining us, the problem is that on some
systems, "git log" out of the box produces ANSI codes which are munged
by the pager and look terrible. I'm trying to improve that by
auto-configuring "more" (to get color in more cases that can handle it),
and by dynamically adjusting color.pager's default based on which pager
is in use (to turn off color in cases we know won't work).

I was able to test my assumptions about "MORE" on Debian, and adjusted
the patches accordingly from the previous discussion. I am still
guessing that versions of "more" without "R" will pass through the ANSI
codes as-is. That works on Debian. If anybody has an older system to
test and report on, I'd love to hear it.

The second patch turns on "MORE=R" only for FreeBSD. Yuri, if you can
confirm that my patch works for you, that would be excellent. And if you
(or anyone) has access to NetBSD or OpenBSD to test the second patch on,
I'd welcome updates to config.mak.uname for those systems.

We also set "LV=-c" along with "LESS". I punted on detecting that in the
third patch, as I do not know the exact format of "LV". It looks like
just checking for "c" might not be enough, and I need to actually
understand the option format (i.e., "-c" or "-dc", but not "-Ac"). I'll
leave that to somebody who cares more about LV to improve (with these
patches, the behavior for them should remain the same, so it's at least
not making anything worse).

  [1/3]: setup_pager: refactor LESS/LV environment setting
  [2/3]: setup_pager: set MORE=R
  [3/3]: pager: disable colors for some known-bad configurations

-Peff
