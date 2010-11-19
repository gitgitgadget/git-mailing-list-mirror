From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] get_cwd_relative(): do not misinterpret root path
Date: Fri, 19 Nov 2010 21:41:59 +0100
Message-ID: <20101119204159.GA28622@localhost>
References: <1290158239-12138-1-git-send-email-pclouds@gmail.com>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	fullung@gmail.com, matthijs@stdin.nl
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 21:41:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJXmK-0001pI-8b
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 21:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab0KSUlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 15:41:47 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60979 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab0KSUlq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 15:41:46 -0500
Received: by bwz15 with SMTP id 15so4288568bwz.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 12:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=B1HD/mQrlJFCs3DmdeWoO1IWKCdnh3J60+jnBKqTnqI=;
        b=k+nXIUyihlppeCWjsPb2klJgVw3TTAnC4HqX6b9meIYexTms3lrtQHV5UI2Ly7w0oz
         x3g4oBKbVwz0D7xB/jZYSE6F+5r6nf2ok+zV73Ced4K6WTXoQpbz3sZlF0X6P7tgE+Wf
         rQlpp8TgZClMxnnYvs3D5pX0e3PueHKcQmqA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=FuKsxnYsON3NltycOAkedwEGrs2xkgPvkmOWJ+COJZx2w87G/oH1tT6ApFiFSHLJzX
         xgj2kX5rwtSU7sTFkS3fOwHT0RMnSQtAPVnMO+EIgNhmuKOQMnYMcJpcmbh6XcF5B2l9
         tUJeJhIxc2jI0I654AcAg/XP2x0NpAflTHDV0=
Received: by 10.204.61.20 with SMTP id r20mr2684578bkh.57.1290199305241;
        Fri, 19 Nov 2010 12:41:45 -0800 (PST)
Received: from darc.lan (p549A340F.dip.t-dialin.net [84.154.52.15])
        by mx.google.com with ESMTPS id p22sm1069668bkp.9.2010.11.19.12.41.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 12:41:43 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PJXmR-0007Uu-5T; Fri, 19 Nov 2010 21:41:59 +0100
Content-Disposition: inline
In-Reply-To: <1290158239-12138-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161783>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Duy,

Thanks for looking into this.

On Fri, Nov 19, 2010 at 04:17:19PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
>=20
> @@ -965,6 +965,12 @@ char *get_relative_cwd(char *buffer, int size, const=
 char *dir)
>  	case '/':
>  		return cwd + 1;
>  	default:
> +		/*
> +		 * dir can end with a path separator when it's root
> +		 * directory. Return proper prefix in that case.
> +		 */
> +		if (is_dir_sep(dir[-1]))
> +			return cwd;
>  		return NULL;
>  	}
>  }

make_absolute_path() already rewrites dir to contain slashes only.
I think it is confusing to use is_dir_sep() here, when we only
check for / above.

Otherwise, the patch looks good to me.

Clemens

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJM5uEXAAoJELKdZexG8uqMgLsH/RIoYzuJ+oIMhT4piioJ3vaI
SpuFEwMltSsH8CBfG42IH43BtugH6JQq6oPOoL7RKmirng0kypp3Kpyrd7uSwMxG
TQKAhdQNdZdr1mNkvvFaiRlNsAVRPjVeG6HTQ7Kc0HP1FB2xAhpQUw9RsM0pmhLf
4IJg6fBIYHBnlfiwrBHWLEF9GvTE4dXNYHr4CJ7QBJT+geqbLpMtHSH6WjSAGHEM
OeVuzd+uk0r0lDXd0TGTsBINi9T4ERzh7fi86pKuO1n84/4MGA0ItUSwzIFQuPH9
3XSJlmDYT7u0Evl/a+vx8e2kx6lWCTkiN5mMX81CaKP7nzvXt8xg40mGQLuOofY=
=nalh
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
