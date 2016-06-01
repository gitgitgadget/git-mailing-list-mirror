From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Wed, 1 Jun 2016 01:40:48 -0400
Message-ID: <20160601054048.GB20797@sigill.intra.peff.net>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
 <20160531225628.GA4585@sigill.intra.peff.net>
 <CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
 <20160601023159.GA5411@sigill.intra.peff.net>
 <20160601033139.GB5411@sigill.intra.peff.net>
 <20160601034413.GC5411@sigill.intra.peff.net>
 <20160601053325.GA20797@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 07:41:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7ytk-0005Ls-JE
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 07:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757304AbcFAFkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 01:40:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:46966 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757183AbcFAFkw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 01:40:52 -0400
Received: (qmail 19416 invoked by uid 102); 1 Jun 2016 05:40:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 01:40:52 -0400
Received: (qmail 30099 invoked by uid 107); 1 Jun 2016 05:40:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 01:40:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 01:40:48 -0400
Content-Disposition: inline
In-Reply-To: <20160601053325.GA20797@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296052>

On Wed, Jun 01, 2016 at 01:33:25AM -0400, Jeff King wrote:

> Here is the "final" version of the more complicated scheme I came up
> with. That I think should be fairly portable, but the subshell thing is
> probably way less gross.

OK, last email tonight, I promise.

Here's the subshell version. I'm a little embarrassed not to have
thought of it sooner (though the other one was a fun exercise).

	test_env () {
		(
			while test $# -gt 0
			do
				case "$1" in
				*=*)
					eval "${1%%=*}=\${1#*=}"
					eval "export ${1%%=*}"
					shift
					;;
				*)
					"$@"
					exit
					;;
				esac
			done
		)
	}

-Peff
