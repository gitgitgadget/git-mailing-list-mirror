From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] diff.c: guard config parser from value=NULL
Date: Sun, 10 Feb 2008 22:13:41 +0100
Message-ID: <20080210211341.GA24976@auto.tuwien.ac.at>
References: <20080210193534.d11d8b15.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Govind Salinas <blix@sophiasuchtig.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:14:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJVh-0005ym-K5
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 22:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438AbYBJVNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 16:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755597AbYBJVNo
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 16:13:44 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:33431 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384AbYBJVNn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 16:13:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 1DD7D680BEAC;
	Sun, 10 Feb 2008 22:13:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J26n3lr75W1q; Sun, 10 Feb 2008 22:13:42 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id EE5A068018C6; Sun, 10 Feb 2008 22:13:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080210193534.d11d8b15.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73416>

On Sun, Feb 10, 2008 at 07:35:34PM +0100, Christian Couder wrote:
> In fact we also guard for value=3D"" as it doesn't make more sense
> for the variables here.
>=20
> We do that by using a new function 'xstrdup_confval' to avoid code
> duplication.
>=20
> By the way this changes a 'strdup' into 'xstrdup'.
>=20
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  diff.c |   23 +++++++++++++----------
>  1 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/diff.c b/diff.c
> index 5b8afdc..d51aecb 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -60,6 +60,14 @@ static struct ll_diff_driver {
>  	char *cmd;
>  } *user_diff, **user_diff_tail;
> =20
> +static int xstrdup_confval(const char *dest, const char *var, const =
char *value)
> +{
> +	if (!value || !*value)
> +		return error("%s: lacks value", var);
> +	dest =3D xstrdup(value);
> +	return 0;
> +}
> +
>  /*
>   * Currently there is only "diff.<drivername>.command" variable;
>   * because there are "diff.color.<slot>" variables, we are parsing

This function could be used in config.c too. So move it to a common fil=
e.

mfg Martin K=F6gler
