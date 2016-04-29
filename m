From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] http: expand http.cookieFile as a path
Date: Fri, 29 Apr 2016 10:12:12 -0400
Message-ID: <20160429141212.GB26643@sigill.intra.peff.net>
References: <20160429062357.12647-1-computersforpeace@gmail.com>
 <20160429062357.12647-2-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 16:12:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw99Y-0006Vn-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbcD2OMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 10:12:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:59107 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753404AbcD2OMP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 10:12:15 -0400
Received: (qmail 8243 invoked by uid 102); 29 Apr 2016 14:12:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 10:12:14 -0400
Received: (qmail 22033 invoked by uid 107); 29 Apr 2016 14:12:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 10:12:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2016 10:12:12 -0400
Content-Disposition: inline
In-Reply-To: <20160429062357.12647-2-computersforpeace@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293000>

On Fri, Apr 29, 2016 at 12:23:57AM -0600, Brian Norris wrote:

> This should handle .gitconfig files that specify things like:
> 
> [http]
> 	cookieFile = "~/.gitcookies"

Seems like a good idea, and the implementation looks obviously correct.

For the documentation:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index a775ad885a76..d3ef2d3b5d13 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1660,6 +1660,9 @@ http.cookieFile::
>  	in the Git http session, if they match the server. The file format
>  	of the file to read cookies from should be plain HTTP headers or
>  	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
> +	The value of `http.cookieFile` is subject to tilde expansion: `~/` is
> +	expanded to the value of `$HOME`, and `~user/` to the specified user's
> +	home directory.
>  	NOTE that the file specified with http.cookieFile is used only as
>  	input unless http.saveCookies is set.

I'm not sure if it's a good idea to go into so much detail about
expand_user_path() here. There are a lot of options that use the same
rules, and we probably don't want to go into a complete explanation
inside each option's description. Is there a canonical definition of how
we do expansion in config.txt that we can just reference (and if not,
can we add one)?

-Peff
