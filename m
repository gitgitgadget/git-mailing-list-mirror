From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] fix status_printf_ln calls "zero-length format"
 warnings
Date: Mon, 10 Mar 2014 15:51:21 -0400
Message-ID: <20140310195121.GB24568@sigill.intra.peff.net>
References: <1394479647-22361-1-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 20:51:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6ER-0001Ck-Co
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 20:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbaCJTvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 15:51:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:36721 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752304AbaCJTvW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 15:51:22 -0400
Received: (qmail 17770 invoked by uid 102); 10 Mar 2014 19:51:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Mar 2014 14:51:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Mar 2014 15:51:21 -0400
Content-Disposition: inline
In-Reply-To: <1394479647-22361-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243801>

On Mon, Mar 10, 2014 at 08:27:25PM +0100, Benoit Pierre wrote:

> Those happens with "gcc -Wformat-zero-length". Since passing NULL does not
> generate a warning (as __attribute__((printf())) does not imply nonull), modify
> status_printf/status_printf_ln to allow a NULL format and update calls with an
> empty string.

Most of us who compile with -Wall decided a while ago to use
-Wno-format-zero-length, because it really is a silly complaint (it
assumes there are no side effects of the function besides printing the
format string, which is obviously not true in this case).

It would be nice to compile out of the box with "-Wall -Werror", and I
think your solution looks relatively clean. But I am slightly concerned
about the assumption that it is OK to pass a NULL fmt parameter to a
function marked with __attribute__((format)).  It certainly seems to be
the case now, and I do not know of any plans for that to change, but it
seems like a potentially obvious thing for the compiler to check.

I dunno; perhaps it has already been considered and rejected by gcc
folks to allow the exact escape hatch we are using here.

-Peff
