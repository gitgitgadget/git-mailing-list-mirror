From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] alias.c: use git_config_string() to get alias_val
Date: Sat, 5 Apr 2008 18:19:46 +0200
Message-ID: <200804051819.46904.chriscool@tuxfamily.org>
References: <20080405121834.GB14565@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Apr 05 18:15:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiB2p-0008I2-2s
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 18:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbYDEQOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Apr 2008 12:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752157AbYDEQOW
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 12:14:22 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:57545 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbYDEQOV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Apr 2008 12:14:21 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2F16B1AB2F9;
	Sat,  5 Apr 2008 18:14:20 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0E5A81AB2E0;
	Sat,  5 Apr 2008 18:14:20 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20080405121834.GB14565@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78849>

Le samedi 5 avril 2008, Stephan Beyer a =E9crit :
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
> Hi,
>
> This is a `Janitor patch' to get involved ;-)

Great!

> See
> 	http://git.or.cz/gitwiki/Janitor

Did you see:

"(And no, casting the "char **" into a "const char **" is not a good=20
solution either.)"

in the above page ?

> It does not (at least, should not) change any functionality and
> it has been tested using some aliases.
>
> Regards,
> Stephan
>
>  alias.c |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/alias.c b/alias.c
> index 116cac8..ac88d38 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -4,12 +4,8 @@ static const char *alias_key;
>  static char *alias_val;
>  static int alias_lookup_cb(const char *k, const char *v)
>  {
> -	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
> -		if (!v)
> -			return config_error_nonbool(k);
> -		alias_val =3D xstrdup(v);
> -		return 0;
> -	}
> +	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key))
> +		return git_config_string((const char**)&alias_val, k, v);

Are you sure this ugly cast to "const char**" is needed ?
Isn't there a better way to do it ?

>  	return 0;
>  }

Thanks,
Christian.
