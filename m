From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] speed: reuse char instead of recreation in loop
Date: Mon, 25 May 2009 22:16:02 +0200
Message-ID: <20090525201602.GA18471@atjola.homenet>
References: <pan.2009.05.25.19.44.10@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Spura <tomspur@fedoraproject.org>
X-From: git-owner@vger.kernel.org Mon May 25 22:16:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8gan-0000bh-6I
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 22:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbZEYUQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 16:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbZEYUQF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 16:16:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:44321 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751483AbZEYUQE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 16:16:04 -0400
Received: (qmail invoked by alias); 25 May 2009 20:16:04 -0000
Received: from i59F55D76.versanet.de (EHLO atjola.local) [89.245.93.118]
  by mail.gmx.net (mp036) with SMTP; 25 May 2009 22:16:04 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/9dVEIM6H9KZTURXNGatebRC2vQSVAux0VrdsRNr
	BoZ7BTqiDjWkDp
Content-Disposition: inline
In-Reply-To: <pan.2009.05.25.19.44.10@fedoraproject.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119961>

On 2009.05.25 19:44:10 +0000, Thomas Spura wrote:
> Move a char and a char * outside of a for loop for speed improvements
>=20
> Signed-off-by: Thomas Spura <tomspur@fedoraproject.org>
> ---
> Comments?
>=20
>  transport.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/transport.c b/transport.c
> index 17891d5..e350937 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -263,11 +263,10 @@ static int write_refs_to_temp_dir(struct strbuf=
=20
> *temp_dir,
>  		int refspec_nr, const char **refspec)
>  {
>  	int i;
> +	unsigned char sha1[20];
> +	char *ref;
> =20
>  	for (i =3D 0; i < refspec_nr; i++) {
> -		unsigned char sha1[20];
> -		char *ref;
> -

I doubt that this makes any difference at all.

>  		if (dwim_ref(refspec[i], strlen(refspec[i]), sha1, &ref) !
> =3D 1)
>  			return error("Could not get ref %s", refspec[i]);
> =20
> @@ -275,8 +274,8 @@ static int write_refs_to_temp_dir(struct strbuf=20
> *temp_dir,
>  			free(ref);
>  			return -1;
>  		}
> -		free(ref);
>  	}
> +	free(ref);

And this now leaks memory.

Bj=F6rn
