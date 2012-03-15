From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] help: Fix help message for aliases
Date: Thu, 15 Mar 2012 00:17:34 -0400
Message-ID: <20120315041734.GD4149@sigill.intra.peff.net>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Namhyung Kim <namhyung.kim@lge.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 05:17:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S828E-0002Yp-Sc
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 05:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956Ab2COERh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 00:17:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49599
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818Ab2COERh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 00:17:37 -0400
Received: (qmail 16330 invoked by uid 107); 15 Mar 2012 04:17:48 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Mar 2012 00:17:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Mar 2012 00:17:34 -0400
Content-Disposition: inline
In-Reply-To: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193177>

On Thu, Mar 15, 2012 at 11:52:47AM +0900, Namhyung Kim wrote:

> The current "`git br' is aliased to `branch'" looks a bit
> strange. Prepend 'git' to aliased output too so that the
> end result will be looked like this:
> 
>  $ git help br
>  `git br' is aliased to `git branch'

I think that is a sensible improvement, but...

> diff --git a/builtin/help.c b/builtin/help.c
> index 61ff798..f85c870 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -445,7 +445,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  
>  	alias = alias_lookup(argv[0]);
>  	if (alias && !is_git_command(argv[0])) {
> -		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
> +		printf("`git %s' is aliased to `git %s'\n", argv[0], alias);
>  		return 0;

What output does this produce for:

  $ git config alias.foo '!f() { git log $1@{u}..$1; }; f'
  $ git help foo

?

-Peff
