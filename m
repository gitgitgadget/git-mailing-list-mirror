From: Jeff King <peff@peff.net>
Subject: Re: [WIP/RFH/PATCH 3/3] t/lib-git-svn: adjust config to apache 2.4
Date: Fri, 10 Apr 2015 05:23:17 +0200
Message-ID: <20150410032317.GB11280@peff.net>
References: <cover.1428505184.git.git@drmicha.warpmail.net>
 <0631c09d394dedb803a100e81ce4052a57b4e73e.1428505184.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 10 05:23:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgPXT-0004G1-LB
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 05:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbbDJDXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 23:23:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:44138 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753457AbbDJDXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2015 23:23:21 -0400
Received: (qmail 32625 invoked by uid 102); 10 Apr 2015 03:23:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Apr 2015 22:23:21 -0500
Received: (qmail 6668 invoked by uid 107); 10 Apr 2015 03:23:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Apr 2015 23:23:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Apr 2015 05:23:17 +0200
Content-Disposition: inline
In-Reply-To: <0631c09d394dedb803a100e81ce4052a57b4e73e.1428505184.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267004>

On Wed, Apr 08, 2015 at 05:05:26PM +0200, Michael J Gruber wrote:

> The current config is tailored to apache 2.2. Apache 2.4 fails to start
> with it.
> 
> Adjust the config to apache 2.4.

I think this needs more conditional config. See the similar fixes I did
in:

  296f0b3 (t/lib-httpd/apache.conf: configure an MPM module for apache
  2.4, 2013-06-09)

and:

  0442743 (t/lib-httpd/apache.conf: do not use LockFile in apache >=
  2.4, 2013-06-09)

And also beware of the ordering problem fixed by:

  5bdc47e (lib-httpd/apache.conf: check version only after mod_version
  loads, 2013-06-21)

Curiously, though, the git-svn tests seem to run fine for me on Apache
2.4 without your patch. I wonder if the fixes I mentioned above (which I
definitely needed to get the regular http tests running on Debian back
then) are not necessary on my system anymore (e.g., because the apache2
package now ships with better-compatible config).

>     Again, I'm wondering who is running these tests at all, but also:

I run the http tests regularly (and have for a long time). I don't
usually run the svn tests, though.

>     Why do we leverage lib-httpd so little from lib-git-svn?

I don't mind us doing the minimal work here to bring the svn tests to a
working state for your platform. As Eric mentions, refactoring test
infrastructure is boring and thankless work. :)

But an alternate solution for patches 2 and 3 might be to share more of
the startup code and config between the two. I don't know how painful
that would be. From a cursory look, I think t/lib-httpd/apache.conf
would have to get split into two parts: one to get apache running at
all, and one to setup the <Location> and other bits related directly to
the http tests.

-Peff
