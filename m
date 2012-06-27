From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Allow help.htmlpath to be an http: URL
Date: Wed, 27 Jun 2012 17:05:02 -0400
Message-ID: <20120627210502.GB2292@sigill.intra.peff.net>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340830514.git.chris@arachsys.com>
 <233b27a14d16a2a1cb38b9f3e07a3a79b09a3256.1340830514.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 23:05:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjzQe-00076J-1F
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 23:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194Ab2F0VFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 17:05:07 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:47263
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757530Ab2F0VFF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 17:05:05 -0400
Received: (qmail 3452 invoked by uid 107); 27 Jun 2012 21:05:08 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jun 2012 17:05:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jun 2012 17:05:02 -0400
Content-Disposition: inline
In-Reply-To: <233b27a14d16a2a1cb38b9f3e07a3a79b09a3256.1340830514.git.chris@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200753>

On Wed, Jun 27, 2012 at 09:55:13PM +0100, Chris Webb wrote:

> Setting this to a URL prefix instead of a path to a local directory allows
> git-help --web to work even when HTML docs aren't locally installed, by
> pointing the browser at a copy accessible on the web. For example,
> 
>     [help]
>       format = html
>       htmlpath = http://git-scm.com/docs
> 
> will use the publicly available documentation on the git homepage.

Nice.

>  	/* Check that we have a git documentation directory. */
> -	if (stat(mkpath("%s/git.html", html_path), &st)
> -	    || !S_ISREG(st.st_mode))
> -		die(_("'%s': not a documentation directory."), html_path);
> +	if (prefixcmp(html_path, "http:")) {
> +		if (stat(mkpath("%s/git.html", html_path), &st)
> +				|| !S_ISREG(st.st_mode))
> +			die("'%s': not a documentation directory.", html_path);
> +	}

I'd rather not tie this directly to http. Is there any reason not to
allow https, for example? Can we maybe just look for strstr("://")
instead? That's the same magic we use to differentiate URLs from paths
when looking for repositories.

-Peff
