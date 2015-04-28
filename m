From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] connect: improve check for plink to reduce false
 positives
Date: Mon, 27 Apr 2015 23:53:44 -0400
Message-ID: <20150428035344.GA24580@peff.net>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-4-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 05:53:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymwan-0007vT-6j
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 05:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbbD1Dxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 23:53:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:50927 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932222AbbD1Dxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 23:53:47 -0400
Received: (qmail 14212 invoked by uid 102); 28 Apr 2015 03:53:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Apr 2015 22:53:47 -0500
Received: (qmail 11163 invoked by uid 107); 28 Apr 2015 03:54:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Apr 2015 23:54:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Apr 2015 23:53:44 -0400
Content-Disposition: inline
In-Reply-To: <1430080212-396370-4-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267890>

On Sun, Apr 26, 2015 at 08:30:12PM +0000, brian m. carlson wrote:

> The git_connect function has code to handle plink and tortoiseplink
> specially, as they require different command line arguments from
> OpenSSH (-P instead of -p for ports; tortoiseplink additionally requires
> -batch).  However, the match was done by checking for "plink" anywhere
> in the string, which led to a GIT_SSH value containing "uplink" being
> treated as an invocation of putty's plink.
> 
> Improve the check by looking for "plink" or "tortoiseplink" (or those
> names suffixed with ".exe") only in the final component of the path.
> This has the downside that a program such as "plink-0.63" would no
> longer be recognized, but the increased robustness is likely worth it.
> Add tests to cover these cases to avoid regressions.

Thanks, I think this version looks good. It's possible that it's too
tight, but I think it represents our best guess at what is reasonable,
and we can only know more by getting it into the hands of users
(hopefully while it is cooking during this release cycle, but I am not
incredibly optimistic about such things).

-Peff
