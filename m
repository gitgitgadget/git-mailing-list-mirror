From: Jeff King <peff@peff.net>
Subject: Re: Fail to push over HTTP with MySQL authentication (Apache2)
Date: Sat, 29 Dec 2012 16:01:28 -0500
Message-ID: <20121229210128.GB21058@sigill.intra.peff.net>
References: <50DF4A78.5000206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Davide Baldini <baldiniebaldini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 22:01:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tp3XV-00046t-Me
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 22:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab2L2VBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 16:01:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39026 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161Ab2L2VBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 16:01:30 -0500
Received: (qmail 31923 invoked by uid 107); 29 Dec 2012 21:02:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 16:02:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 16:01:28 -0500
Content-Disposition: inline
In-Reply-To: <50DF4A78.5000206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212317>

On Sat, Dec 29, 2012 at 08:54:32PM +0100, Davide Baldini wrote:

> SETUP:
> -----
> [...]
> Git repository has been configured as:
>     cd /var/www/public/GT_rulesets/GT00.git
>     git init --bare
>     mv hooks/post-update.sample hooks/post-update
>     git update server-info
>     chmode 777 /var/www/public/GT_rulesets/GT00.git  # for testing.

Should this last line be a "chmod -R"? Git init will create many
subdirectories, and you want to make sure they are all writable for
push.

> _   Git:
>         Git can fetch the repository without problems:
>         git clone http://username:password@greatturn.org:8081/GT00.git
> 
> Pushing the locally fetched repository back to the remote one doesn't
> work:
> [...]
> > 87.19.240.177 - - [29/Dec/2012:16:43:26 +0100] "PROPFIND /GT00.git/ HTTP/1.1" 401 767 "-" "git/1.7.8.3"

If fetch is working and push is not, I'd suspect WebDAV configuration
problems (and indeed, your credentials seem fine, but the PROPFIND is
returning a 401). Fetch works over stock HTTP and does not use WebDAV at
all. There is some documentation on setting up DAV here:

  https://github.com/git/git/blob/master/Documentation/howto/setup-git-server-over-http.txt

but I have no idea if it is up-to-date or not.

However, before trying to investigate that avenue, have you considered
using git's smart-http backend instead of WebDAV? It's significantly
more efficient. You can get details and example apache configuration
from "git help http-backend".

-Peff
