From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] pull: mention "pull", not "fetch" in the error message.
Date: Fri, 26 Mar 2010 15:18:41 +0100
Message-ID: <4BACC241.4010608@drmicha.warpmail.net>
References: <1269610699-13176-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Mar 26 15:22:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvAQF-00014j-2P
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 15:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab0CZOVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 10:21:33 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53166 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754122Ab0CZOVc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 10:21:32 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AF90AE9D8D;
	Fri, 26 Mar 2010 10:21:31 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 26 Mar 2010 10:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=IUm8A7ARkLsCO4lTfS6V2wpZK2Q=; b=hT+0wVNY32v9m8BDBwm8O2PGF2iKPzcUUDrezmCEm57bpYWEwYlRiyTaBN1u2iSJoBBCsc6szu6AplEDCDOi1NKgUCc/TYeELMaBsFQ1uS4kTDJqjUXbM2D0RN1KytiHyU0bZPxGNWq9KJVjST/yyf6nyra/udnXyVH7gtFXHP8=
X-Sasl-enc: OlcpoiumFn1fg25GLWWhI7Rz/zOa90Eqq1dHs4MAogWz 1269613291
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F27274BCB10;
	Fri, 26 Mar 2010 10:21:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <1269610699-13176-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143231>

Matthieu Moy venit, vidit, dixit 26.03.2010 14:38:
> For newbies who've just been taught "git push", the error message

Even though newbies don't read git.git's commit messages, you may want
to say "pull" here ;)

One way or the other, nothing beats the error messages in ident.c ;)

> "Where do you want to fetch from today?" is indeed confusing. Change it
> to "Where do you want to pull from today?" in case fetch was called from
> pull.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  builtin/fetch.c |    6 +++++-
>  git-pull.sh     |    3 ++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 957be9f..f3246f5 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -842,8 +842,12 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
>  	int ref_nr = 0;
>  	int exit_code;
>  
> +	char *cmd = getenv("GIT_USER_COMMAND");
> +	if (cmd == NULL || cmd[0] == '\0')
> +		cmd = "fetch";
> +
>  	if (!remote)
> -		die("Where do you want to fetch from today?");
> +		die("Where do you want to %s from today?", cmd);
>  
>  	transport = transport_get(remote, NULL);
>  	transport_set_verbosity(transport, verbosity, progress);
> diff --git a/git-pull.sh b/git-pull.sh
> index 1a4729f..abc233b 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -216,7 +216,8 @@ test true = "$rebase" && {
>  	done
>  }
>  orig_head=$(git rev-parse -q --verify HEAD)
> -git fetch $verbosity $progress --update-head-ok "$@" || exit 1
> +GIT_USER_COMMAND=pull \
> +    git fetch $verbosity $progress --update-head-ok "$@" || exit 1
>  
>  curr_head=$(git rev-parse -q --verify HEAD)
>  if test -n "$orig_head" && test "$curr_head" != "$orig_head"
