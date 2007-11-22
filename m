From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Simplify the code and avoid an attribution.
Date: Thu, 22 Nov 2007 21:01:57 +0100
Organization: glandium.org
Message-ID: <20071122200157.GC19675@glandium.org>
References: <b8bf37780711211700m1aa32006t6302f134f9c3fb7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-15?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 21:02:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvIFe-00027a-KM
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 21:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbXKVUCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 15:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbXKVUB7
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 15:01:59 -0500
Received: from [80.12.242.17] ([80.12.242.17]:41007 "EHLO smtp19.orange.fr"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752378AbXKVUB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 15:01:59 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1907.orange.fr (SMTP Server) with ESMTP id 659011C0008C
	for <git@vger.kernel.org>; Thu, 22 Nov 2007 21:01:58 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-91-30.w86-217.abo.wanadoo.fr [86.217.53.30])
	by mwinf1907.orange.fr (SMTP Server) with ESMTP id 39CF61C00087;
	Thu, 22 Nov 2007 21:01:58 +0100 (CET)
X-ME-UUID: 20071122200158236.39CF61C00087@mwinf1907.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IvIFJ-0005lv-PA; Thu, 22 Nov 2007 21:01:57 +0100
Content-Disposition: inline
In-Reply-To: <b8bf37780711211700m1aa32006t6302f134f9c3fb7e@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65841>

On Wed, Nov 21, 2007 at 11:00:02PM -0200, Andr=E9 Goddard Rosa wrote:
> --- a/config.c
> +++ b/config.c
> @@ -447,15 +447,16 @@ int git_config_from_file(config_fn_t fn, const
> char *filename)
>  	int ret;
>  	FILE *f =3D fopen(filename, "r");
>=20
> -	ret =3D -1;
> -	if (f) {
> -		config_file =3D f;
> -		config_file_name =3D filename;
> -		config_linenr =3D 1;
> -		ret =3D git_parse_file(fn);
> -		fclose(f);
> -		config_file_name =3D NULL;
> -	}
> +	if (!f)
> +		return -1;
> +
> +	config_file =3D f;
> +	config_file_name =3D filename;
> +	config_linenr =3D 1;
> +	ret =3D git_parse_file(fn);
> +	fclose(f);
> +	config_file_name =3D NULL;
> +
>  	return ret;
>  }

Actually, since it is more likely that the file has been opened, the
original code is more optimal because it doesn't generate a jump in mos=
t
cases. And if you're worried about the ret variable, don't worry, it's
most likely stripped out by the compiler optimizations.

> -	if (f =3D=3D NULL)
> +	if (!f)

> -	if ((f =3D fopen(filename, "rb")) =3D=3D NULL)
> +	if (!(f =3D fopen(filename, "rb")))

It's a matter of taste

Mike
