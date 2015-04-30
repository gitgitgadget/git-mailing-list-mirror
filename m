From: Jeff King <peff@peff.net>
Subject: Re: CURLOPT_NOBODY
Date: Wed, 29 Apr 2015 23:55:12 -0400
Message-ID: <20150430035512.GC12361@peff.net>
References: <CACnwZYdCitEJ=pr=1+C_Wz5pKTbSYj4hD7mQHLC3gaDO8CqnrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 05:55:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnfZI-0002iU-QG
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 05:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbbD3DzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 23:55:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:52046 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751428AbbD3DzP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 23:55:15 -0400
Received: (qmail 9524 invoked by uid 102); 30 Apr 2015 03:55:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 22:55:15 -0500
Received: (qmail 1577 invoked by uid 107); 30 Apr 2015 03:55:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 23:55:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 23:55:12 -0400
Content-Disposition: inline
In-Reply-To: <CACnwZYdCitEJ=pr=1+C_Wz5pKTbSYj4hD7mQHLC3gaDO8CqnrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268054>

On Wed, Apr 29, 2015 at 11:20:55PM -0300, Thiago Farina wrote:

> Do we need to set CURLOPT_NOBODY to 0 in
> https://code.googlesource.com/git/+/master/http.c#1138? Do we do this
> for the sake of doing, because it doesn't hurt?
> 
> According to the documentation in
> http://curl.haxx.se/libcurl/c/CURLOPT_HTTPGET.html, if we set HTTPGET
> to 1 it will automatically set NOBODY to 0, so the answer for the
> above question would be no.

It may have been necessary at one time...

Running "git blame" on the curl repository's lib/url.c shows that the
behavior started in 726b9e2, which is in curl 7.14.1, released in 2005.

Grepping for LIBCURL_VERSION_NUM in git, we definitely support versions
older than that.  Most of those version checks are quite old, too, and
we could probably stop supporting antique versions of curl. But unless
there is a compelling benefit (e.g., we get to clean up some old cruft),
I'd rather leave things as-is.

Dropping this one line does not seem like a compelling cleanup to me,
though it's possible if we said "you must have curl from the last 5
years" we could do other cleanups, and this would come along for the
ride.

> Also, according to http://curl.haxx.se/libcurl/c/CURLOPT_NOBODY.html,
> it is 0 by default.

We reuse curl handles, so we reinitialize the request-specific options
for each request.

-Peff
