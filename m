From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Escape attribute in chop_and_escape_str()
Date: Tue, 29 Nov 2011 11:33:39 -0800 (PST)
Message-ID: <m3liqylo5u.fsf@localhost.localdomain>
References: <CAKD0UuyOMRFHE6DvuDj0ancfwFfg8ADKab6emv99+FN5RfZ=mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: =?iso-8859-15?q?J=FCrgen_Kreileder?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Nov 29 20:33:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVTRA-0003Zw-KC
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 20:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab1K2Tdn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 14:33:43 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58537 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756285Ab1K2Tdm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 14:33:42 -0500
Received: by bkas6 with SMTP id s6so923706bka.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 11:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=ukEFfoYeu5FP5iBk57J+j9nhEiE/5Ec6hzU/5rqu37s=;
        b=hgx9lg43U0xJnYeGRsl/mJSxEbhyGAxe2p2CZdhmDqut+Mg72P7wxKUYcb8S7seUK4
         IUbWqRLDqIT4e+gkYbQZm3UioELTfZva5UoGqMyf1VqSDT8Q83KqfEKbkHDA9t16Cacf
         VmoyAE7EemdCXyXR+LjbMg6+wfnq5D8Mr9p3o=
Received: by 10.204.10.81 with SMTP id o17mr51794306bko.65.1322595220734;
        Tue, 29 Nov 2011 11:33:40 -0800 (PST)
Received: from localhost.localdomain (abvz161.neoplus.adsl.tpnet.pl. [83.8.223.161])
        by mx.google.com with ESMTPS id e18sm39104174bkr.15.2011.11.29.11.33.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 11:33:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pATJXDWs001984;
	Tue, 29 Nov 2011 20:33:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pATJX2he001979;
	Tue, 29 Nov 2011 20:33:02 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAKD0UuyOMRFHE6DvuDj0ancfwFfg8ADKab6emv99+FN5RfZ=mQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186075>

J=C3=BCrgen Kreileder <jk@blackdown.de> writes:

> Fixes the title attribute in <span title=3D"J=C3=83=C2=BCrgen Kreiled=
er">J=C3=BCrgen
> Kreileder</span> for example because to_utf8() is called implicitly n=
ow.
>=20
> (Not sure why the attribute is there at all in the example. From my
> point of view nothing got chopped.)

Hmmm... this should not happen because of

	my $chopped =3D chop_str(@_);
	if ($chopped eq $str) {
		return esc_html($chopped);
	} else=20
=20
Perhaps it is a matter of doing to_utf8() on $str prior to comparison?

> Signed-off-by: Juergen Kreileder <jk@blackdown.de>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4f0c3bd..fd76407 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1699,7 +1699,7 @@ sub chop_and_escape_str {
>  		return esc_html($chopped);
>  	} else {
>  		$str =3D~ s/[[:cntrl:]]/?/g;
> -		return $cgi->span({-title=3D>$str}, esc_html($chopped));
> +		return $cgi->span({-title =3D> esc_attr($str)}, esc_html($chopped)=
);
>  	}
>  }
>=20
> --=20

esc_attr() is a wrong solution here, because $cgi->span(...) should
properly escape attributes.  You should simply use to_utf8() or
sanitize().

Well, uless we simply do

  $str =3D to_utf8($str);

earlier.

--=20
Jakub Nar=C4=99bski
