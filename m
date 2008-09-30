From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Use "git_config_string" to simplify "builtin-gc.c"
	code where "prune_expire" is set
Date: Tue, 30 Sep 2008 13:04:23 -0700
Message-ID: <20080930200423.GL21310@spearce.org>
References: <20080930190549.GA9869@eratosthenes.cryptobackpack.org> <20080930195355.GA14499@eratosthenes.cryptobackpack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Bryson <david@statichacks.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 22:05:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KklTU-0004O5-3Z
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 22:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbYI3UEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 16:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbYI3UEY
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 16:04:24 -0400
Received: from george.spearce.org ([209.20.77.23]:49877 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYI3UEY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 16:04:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 648493835F; Tue, 30 Sep 2008 20:04:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080930195355.GA14499@eratosthenes.cryptobackpack.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97154>

David Bryson <david@statichacks.org> wrote:
> diff --git a/builtin-gc.c b/builtin-gc.c
> index fac200e..6260652 100644
> --- a/builtin-gc.c
> +++ b/builtin-gc.c
> @@ -57,15 +57,12 @@ static int gc_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  	if (!strcmp(var, "gc.pruneexpire")) {
> -		if (!value)
> -			return config_error_nonbool(var);
> -		if (strcmp(value, "now")) {
> +		if (value && strcmp(value, "now")) {
>  			unsigned long now = approxidate("now");
>  			if (approxidate(value) >= now)
>  				return error("Invalid %s: '%s'", var, value);
>  		}
> -		prune_expire = xstrdup(value);
> -		return 0;
> +		return git_config_string(&prune_expire, var, value);

The message formatting was a lot better.  But:

builtin-gc.c:65: warning: passing argument 1 of 'git_config_string' from incompatible pointer type

>From http://git.or.cz/gitwiki/Janitor:

  This is because the first argument to "git_config_string" should
  be a "const char **", not a "char **". There will be a compile
  time warning if a "char **" is passed instead of a "const char **"
  and the patch will be rejected. (And no, casting the "char **"
  into a "const char **" is not a good solution either.)"

-- 
Shawn.
