From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/8] gitweb: esc_html_hl_regions(): Don't create empty <span> elements
Date: Sat, 24 Mar 2012 19:58:23 +0100
Message-ID: <201203241958.23835.jnareb@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com> <1332543417-19664-2-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 19:58:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBWAY-0005Xa-9I
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 19:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab2CXS60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 14:58:26 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50777 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab2CXS6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 14:58:25 -0400
Received: by wibhq7 with SMTP id hq7so3093327wib.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=I1p2QhWvft+tJahG6Jb2HrnSZpq+Ugh7em4StFf+w+4=;
        b=vxgUX3K8OCXnCUu/DYQ93n8VgNnWzVhgPVHRZ+M7b7GJF4v0zFtFf7QurDXT+yVdur
         /hVuT2qsGxbjhfcKyvk6Gp7nfmV+u4PEpaMLdVjRsEYVwer0NX9OjTV59/drQVUFCNay
         ydNdRmsanzBn0pZNbPAxxAd+797sMakJougT7VRVOwWmMQibyaFSreYM+BBTPbI9MffD
         aSwwX3AMTL4C2cgZDiESKmE2bQb6vtJj4uxPB6IxL8gqjfzLFo+Eus2vld91IxWMmlZC
         YnDnIDp1ITXcFcOC/NhjCfajYWQrhOgLIX+LJXuX6Wj22SrYamhpld6OLslZLRdOtSMf
         +3OA==
Received: by 10.216.132.226 with SMTP id o76mr9309705wei.93.1332615504294;
        Sat, 24 Mar 2012 11:58:24 -0700 (PDT)
Received: from [192.168.1.13] (epw177.neoplus.adsl.tpnet.pl. [83.20.64.177])
        by mx.google.com with ESMTPS id gg2sm41229263wib.7.2012.03.24.11.58.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Mar 2012 11:58:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1332543417-19664-2-git-send-email-michal.kiedrowicz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193839>

Note: all those minor issues can be fixed while applying, I think.

On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:

> if $s->[1] is equal to or less than $s->[0], esc_html_hl_regions()
  ^^
s/if/If/

> generates an empty <span> element.  It normally shouldn't be visible =
in
> the web broweser, but it doesn't look good when looking at page sourc=
e.
          ^^^^^^^^=20
s/broweser/browser/

> It also minimally increases generated page size for no special reason=
=2E
>=20
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>=20
> I don't know if any code currently can produce empty <span> elements,
> but diff refinement highlighning does it.

I didn't want to make esc_html_hl_regions() paranoid and boggle it down
with checking that gitweb called it with sane values of parameters,
but this one is cheap and simple. =20

It might be better to make esc_html_hl_regions() more robust instead
of modifying future caller to skip empty regions.

I have not read the rest of this series; for the time being conditional
ACK from me.

>  gitweb/gitweb.perl |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a8b5fad..af645e5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1738,6 +1738,9 @@ sub esc_html_hl_regions {
>  	my $pos =3D 0;
> =20
>  	for my $s (@sel) {
> +		# Don't craete empty <span> elements.
                        ^^^^^^
s/craete/create/

> +		next if $s->[1] <=3D $s->[0];
> +
>  		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos))
>  			if ($s->[0] - $pos > 0);
>  		$out .=3D $cgi->span({-class =3D> $css_class},
> --=20
> 1.7.8.4
=20
P.S. I wonder if it wouldn't be better if we created and used loop-loca=
l
variables with descriptive names, e.g.

  my ($beg, $end) =3D @$s;

and use $beg in place of $s->[0] and $end in place of $s->[1], which ar=
e
a bit cryptic.

This of course doesn't affect this patch.

--=20
Jakub Narebski
Poland
