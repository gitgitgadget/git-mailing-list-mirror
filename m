From: Jeff King <peff@peff.net>
Subject: Re: Http/s authentication failure with some git versions
Date: Mon, 25 Jul 2011 10:32:23 -0600
Message-ID: <20110725163223.GB7071@sigill.intra.peff.net>
References: <20110725132317.GA21590@tp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Christoph Blank <sol@textmode.at>
X-From: git-owner@vger.kernel.org Mon Jul 25 18:32:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlO52-0006v8-NY
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 18:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426Ab1GYQc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 12:32:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53159
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403Ab1GYQc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 12:32:26 -0400
Received: (qmail 10652 invoked by uid 107); 25 Jul 2011 16:32:56 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Jul 2011 12:32:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2011 10:32:23 -0600
Content-Disposition: inline
In-Reply-To: <20110725132317.GA21590@tp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177800>

On Mon, Jul 25, 2011 at 03:23:17PM +0200, Christoph Blank wrote:

> Following command: 
> git clone "https://git%40app.example.com:myp...@git.example.com/app-comm 
> 
> This works fine with git versions: 
> 1.7.4.1 
> 1.7.6 
> 
> and fails with: 
> 1.7.1 
> 1.7.2.5 
> 1.7.33 
> 
> does anyone know why, or if there was a particular bug fixed? 
> I don't want to upgrade git on the production systems without a reason..
> Can't find anything and I'm getting desperate...

I skimmed through:

  git log v1.7.3.3..v1.7.4.1 http.c

and came up with:

  commit f39f72d8cf03b61407f64460eba3357ec532280e
  Author: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
  Date:   Sun Nov 14 02:51:15 2010 +0100

      Fix username and password extraction from HTTP URLs

      Change the authentification initialisation to percent-decode username
      and password for HTTP URLs.

which seems a likely candidate based on the example you gave. You could
try cherry-picking that commit onto your older version if you don't want
to do a full upgrade.

Now, I happened to know that http.c was where the relevant code lived
(because I was working on it recently), and limiting my search to
commits that touched that file made the list quite short. But knowing
nothing else except a test case that works on some versions and not on
others, you could always "git bisect", which would find the relevant
commit for you.

-Peff
