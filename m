From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] replace: parse revision argument for -d
Date: Mon, 12 Nov 2012 15:42:55 -0500
Message-ID: <20121112204254.GH4623@sigill.intra.peff.net>
References: <50A0B896.8050700@drmicha.warpmail.net>
 <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:43:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY0qf-0002Vl-5w
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 21:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab2KLUm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 15:42:59 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45001 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285Ab2KLUm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 15:42:59 -0500
Received: (qmail 13862 invoked by uid 107); 12 Nov 2012 20:43:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 15:43:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 15:42:55 -0500
Content-Disposition: inline
In-Reply-To: <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209523>

On Mon, Nov 12, 2012 at 03:18:02PM +0100, Michael J Gruber wrote:

> 'git replace' parses the revision arguments when it creates replacements
> (so that a sha1 can be abbreviated, e.g.) but not when deleting
> replacements.
> 
> Make it parse the argument to 'replace -d' in the same way.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> 
> Notes:
>     v3 safeguards the hex buffer against reuse

Thanks, I don't see any other functional problems.

> diff --git a/builtin/replace.c b/builtin/replace.c
> index e3aaf70..33e6ec3 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -46,24 +46,28 @@ typedef int (*each_replace_name_fn)(const char *name, const char *ref,
>  
>  static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
>  {
> -	const char **p;
> +	const char **p, *q;

I find this readable today, but I wonder if in six months we will wonder
what in the world "q" means. Maybe "short_refname" or something would be
appropriate?

-Peff
