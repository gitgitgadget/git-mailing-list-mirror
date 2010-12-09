From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 2/3] config: add git_config_from_sha1() to read from a blob
Date: Thu, 9 Dec 2010 13:58:28 -0200
Message-ID: <AANLkTi=qt-uwXdUquRAv_1VpMUQuUR+aNMuxSHdpMhXd@mail.gmail.com>
References: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
	<1291907388-9068-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 16:58:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQit9-0002Bl-Va
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 16:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab0LIP6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 10:58:30 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:42962 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab0LIP6a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 10:58:30 -0500
Received: by eyg5 with SMTP id 5so1938869eyg.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 07:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fEdnzvvL5cOLpIc3BL0N9BFrNMIG//Wofguql9KOA7w=;
        b=KZTVyd6IZEJn6uBUkmRIn20YojWFScuIaSkbijWKJpsW5fFncjpN/SNQYumyZfqsW+
         J4Idi67LNDb08W9zXyhtiZ+FtT8ttUl+pMh5bnrVf5p137+3nBEDTWqlGwGXVYAuPGPZ
         ktc/sOkGl4WBBOLKn6oOX1/Ufien/sqqyUFSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gb6tkDSxU46pc4PyL4Tkl+alPEAZ0M69eKCA/Ziwc5qbuGnNDIRRVq3DkJaovx33XX
         C6sV4rE9RFWW7yirUJesGi6e2dyZOqyBJsB03XAlQ/HrjiowwUuIb4rPGaaC/3QGZm8M
         dBn24vzrC4wjRpFnG1PgdmOBH10zZsZQInCqE=
Received: by 10.204.84.197 with SMTP id k5mr3461928bkl.175.1291910308507; Thu,
 09 Dec 2010 07:58:28 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Thu, 9 Dec 2010 07:58:28 -0800 (PST)
In-Reply-To: <1291907388-9068-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163290>

2010/12/9 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0config.c | =C2=A0 34 ++++++++++++++++++++++++++++++++++
> =C2=A01 files changed, 34 insertions(+), 0 deletions(-)
>
> diff --git a/config.c b/config.c
> index c8bf46f..e7a9ff4 100644
> --- a/config.c
> +++ b/config.c
> @@ -809,6 +809,40 @@ int git_config_from_file(config_fn_t fn, const c=
har *filename, void *data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>

> +static int git_config_from_sha1(config_fn_t fn, const char *sha1_nam=
e, void *data)
> +{

Is worth documenting the return value of this function and what it
does? It returns 0 on success otherwise returns -1.

> + =C2=A0 =C2=A0 =C2=A0 unsigned char sha1[20];
> + =C2=A0 =C2=A0 =C2=A0 enum object_type type;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long size;
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (get_sha1(sha1_name, sha1)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("bad shared =
config reference '%s'", sha1_name);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 config_file =3D read_sha1_file(sha1, &type, &s=
ize);
> + =C2=A0 =C2=A0 =C2=A0 if (!config_file) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("bad shared =
config '%s'", sha1_name);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (type =3D=3D OBJ_BLOB) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_file_pos =3D=
 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_file_size =3D=
 size;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_file_name =3D=
 sha1_name;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_linenr =3D =
1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_file_eof =3D=
 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D git_parse_=
file(fn, data);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 else {

style nit: Shouldn't this else be on the end of the previous line?
