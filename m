From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 02/12] Convert starts_with() to skip_prefix() for option
 parsing
Date: Fri, 20 Dec 2013 07:51:00 +0100
Message-ID: <52B3E8D4.1030805@viscovery.net>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com> <1387378437-20646-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 20 07:51:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vttva-0002Yf-Pc
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 07:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab3LTGvH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Dec 2013 01:51:07 -0500
Received: from so.liwest.at ([212.33.55.18]:38216 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004Ab3LTGvG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 01:51:06 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VttvJ-0005X9-Me; Fri, 20 Dec 2013 07:51:01 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3C7AB16613;
	Fri, 20 Dec 2013 07:51:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1387378437-20646-3-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239563>

Am 12/18/2013 15:53, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> The code that's not converted to use parse_options() often does
>=20
>   if (!starts_with(arg, "foo=3D")) {
>      value =3D atoi(arg + 4);
>   }
>=20
> This patch removes those magic numbers with skip_prefix()
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/fetch-pack.c     | 13 +++++----
>  builtin/index-pack.c     | 17 +++++------
>  builtin/ls-remote.c      |  9 +++---
>  builtin/mailinfo.c       |  5 ++--
>  builtin/reflog.c         |  9 +++---
>  builtin/rev-parse.c      | 41 +++++++++++++-------------
>  builtin/send-pack.c      | 18 ++++++------
>  builtin/unpack-objects.c |  5 ++--
>  builtin/update-ref.c     | 21 +++++++-------
>  daemon.c                 | 75 ++++++++++++++++++++++++--------------=
----------
>  diff.c                   | 49 +++++++++++++++----------------
>  git.c                    | 13 +++++----
>  merge-recursive.c        | 13 +++++----
>  revision.c               | 60 +++++++++++++++++++-------------------
>  upload-pack.c            |  5 ++--
>  15 files changed, 182 insertions(+), 171 deletions(-)
>=20
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 8b8978a2..2df1423 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -47,13 +47,14 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
> =20
>  	for (i =3D 1; i < argc && *argv[i] =3D=3D '-'; i++) {
>  		const char *arg =3D argv[i];
> +		const char *optarg;
> =20
> -		if (starts_with(arg, "--upload-pack=3D")) {
> -			args.uploadpack =3D arg + 14;
> +		if ((optarg =3D skip_prefix(arg, "--upload-pack=3D")) !=3D NULL) {
> +			args.uploadpack =3D optarg;

Quite frankly, I do not think this is an improvement. The old code is
*MUCH* easier to understand because "starts_with" is clearly a predicat=
e
that is either true or false, but the code with "skip_prefix" is much
heavier on the eye with its extra level of parenthesis. That it removes=
 a
hard-coded constant does not count much IMHO because it is very clear
where the value comes from.

-- Hannes
