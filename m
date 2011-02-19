From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 3/3] gitweb/gitweb.perl: don't call S_ISREG() with undef
Date: Sat, 19 Feb 2011 16:57:02 +0100
Message-ID: <201102191657.02431.jnareb@gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com> <1298129262-10468-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 17:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqpJM-0000Zr-75
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 17:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab1BSQFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 11:05:12 -0500
Received: from mail-bw0-f52.google.com ([209.85.214.52]:38947 "EHLO
	mail-bw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322Ab1BSQFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 11:05:09 -0500
Received: by bwz4 with SMTP id 4so4406484bwz.11
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 08:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=iwyvGUcJ5/q6fu0JEQaDTKqSgauiBbu5Ekk6CdN3HbU=;
        b=eUhpm6Xi8Cr+T7HFY9LqURNyEDud/c765iBlTNB0pcnqukOfaeaYLo9108FIClJX18
         HRBSC3llVt8cKCo58Z9TUpLBjpT1NcHEB5ZSz7vrW/dmRAgiybAppB7BKsQoHq+U+G+Y
         5Fh7fdFE28V5gm5+BkfYg3mqxunUdmJdAZgXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FHzla7Dkv1GWO/8YuJ9ir+iviMPFfRl5MxVZxsTxasWtn7fWj9+cYA3RFROjOX/VBO
         XnlawMCU+VOzS5pxwTnUuimv0fyQu9GuQxI7LmHeWqlR2JTXafu3qIeOR4NblNpqUlu5
         ZT2Qum/DXLkHgX6pSaRK2ipjseXJwIfeI/y7Q=
Received: by 10.204.76.65 with SMTP id b1mr1758055bkk.29.1298131029395;
        Sat, 19 Feb 2011 07:57:09 -0800 (PST)
Received: from [192.168.1.13] (abwm176.neoplus.adsl.tpnet.pl [83.8.236.176])
        by mx.google.com with ESMTPS id v25sm2326857bkt.6.2011.02.19.07.57.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 07:57:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1298129262-10468-4-git-send-email-avarab@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167296>

On Sat, 19 Feb 2011, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Change S_ISREG($to_mode_oct) to S_ISREG($from_mode_oct) in the branch
> that handles from modes, not to modes. This logic appears to have bee=
n
> caused by copy/paste programming by Jakub Narebski in e8e41a93. It
> would be better to rewrite this code not to be duplicated, but I
> haven't done so.
>=20
> This issue caused a failing test on perl 5.13.9, which has a warning
> that turned this up:
>=20
>      gitweb.perl: Use of uninitialized value in subroutine entry at /=
home/avar/g/git/t/../gitweb/gitweb.perl line 4415.

[...]
> Reported-by: perl 5.13.9
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

Thanks for catching this.  I wonder why we didn't caught this earlier..=
=2E


=46or what it is worth it:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index b02372c..1b9369d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4412,7 +4412,7 @@ sub git_difftree_body {
>  		}
>  		if ($diff->{'from_mode'} ne ('0' x 6)) {
>  			$from_mode_oct =3D oct $diff->{'from_mode'};
> -			if (S_ISREG($to_mode_oct)) { # only for regular file
> +			if (S_ISREG($from_mode_oct)) { # only for regular file
>  				$from_mode_str =3D sprintf("%04o", $from_mode_oct & 0777); # per=
mission bits
>  			}
>  			$from_file_type =3D file_type($diff->{'from_mode'});
> --=20
> 1.7.2.3
>=20
>=20

--=20
Jakub Narebski
Poland
