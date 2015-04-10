From: Jeff King <peff@peff.net>
Subject: Re: [WIP/RFH/PATCH 3/3] t/lib-git-svn: adjust config to apache 2.4
Date: Fri, 10 Apr 2015 05:39:54 +0200
Message-ID: <20150410033953.GC11280@peff.net>
References: <cover.1428505184.git.git@drmicha.warpmail.net>
 <0631c09d394dedb803a100e81ce4052a57b4e73e.1428505184.git.git@drmicha.warpmail.net>
 <20150410032317.GB11280@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 10 05:40:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgPnW-0003an-NX
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 05:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbbDJDj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 23:39:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:44142 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753088AbbDJDj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2015 23:39:57 -0400
Received: (qmail 941 invoked by uid 102); 10 Apr 2015 03:39:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Apr 2015 22:39:57 -0500
Received: (qmail 6720 invoked by uid 107); 10 Apr 2015 03:40:18 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Apr 2015 23:40:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Apr 2015 05:39:54 +0200
Content-Disposition: inline
In-Reply-To: <20150410032317.GB11280@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267005>

On Fri, Apr 10, 2015 at 05:23:17AM +0200, Jeff King wrote:

> Curiously, though, the git-svn tests seem to run fine for me on Apache
> 2.4 without your patch. I wonder if the fixes I mentioned above (which I
> definitely needed to get the regular http tests running on Debian back
> then) are not necessary on my system anymore (e.g., because the apache2
> package now ships with better-compatible config).

Ah, I see. I am not in fact running apache.

If you do not set SVN_HTTPD_PORT (which I don't), then lib-git-svn.sh's
start_httpd silently returns success without bothering to setup the
apache server at all. And yet the rest of the tests run to completion
just fine.

It looks like setting this variable is a way to say "run the same set of
tests, but do it over svn-over-httpd instead of svn's direct filesystem
access". Setting SVN_HTTPD_PORT does cause the tests to fail for me.

I don't know how important it is to run these tests over httpd. If so,
it would be nice to do something like lib-httpd does: try the apache
setup by default, and if it fails, gracefully skip the tests (or
fallback to the non-httpd version).

I'm also not sure if there's value in running both the httpd and
local-filesystem forms of the test. IOW, should we be factoring out the
tests and having two separate scripts that set $svnrepo as appropriate,
and then runs the tests?

-Peff
