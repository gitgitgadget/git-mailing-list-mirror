From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] diff: remove ternary operator evaluating always to true
Date: Mon, 12 Aug 2013 10:38:58 +0200
Message-ID: <52089F22.6010106@googlemail.com>
References: <1375986704-11441-1-git-send-email-stefanbeller@googlemail.com> <20130810072114.GD30185@sigill.intra.peff.net> <7vli471mxy.fsf@alter.siamese.dyndns.org> <52089D81.5010506@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3D967807EFD5640F55F2CAAE"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 10:38:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8neL-0001Tn-RS
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 10:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120Ab3HLIip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 04:38:45 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:44681 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab3HLIio (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 04:38:44 -0400
Received: by mail-we0-f179.google.com with SMTP id t57so5290307wes.10
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 01:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=iFTkYRphcVGyS/4czOvhFbLyN1DsWs2L6BOg19iYZQ4=;
        b=DzwdUeuU/nz5QRhRyxVzh2aangur3mxP42XsXGR6JSfmW552yyDALVqmcv5xVdwggo
         fKJ2EJ64czYh6GfQGTIxKJJf9AdVy/J9OwvFxzP+Z/xPfwbHzeu5yhRLGu6ZWkrDo60g
         /WYJdeh3c/lL5D2HfM/eaD65rsWI0VA056sCxOyGLVH4WHuGX7l6P0ifY8b6qgnlq3i8
         WmWF1nQuSPgaIXl0JkF6Qo513KbU+BCwlsoUd43nKCgQQ0L/ZxHPTx7+sC1FVOA3tQBr
         VyhEvnKo1RotI02QhJVHe806yRSIYEsipr4XoDYtwiVgkJ2Kw7QzovNLU5pkuvCeOtWL
         7rTg==
X-Received: by 10.194.120.225 with SMTP id lf1mr6283601wjb.74.1376296723403;
        Mon, 12 Aug 2013 01:38:43 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id dt17sm14815144wic.1.2013.08.12.01.38.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 01:38:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <52089D81.5010506@googlemail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232179>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3D967807EFD5640F55F2CAAE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/12/2013 10:32 AM, Stefan Beller wrote:
>=20
> diff --git a/diff.c b/diff.c
> index e53ddad..de21971 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2254,8 +2254,11 @@ static void builtin_diff(const char *name_a,
>  			(!two->mode || S_ISGITLINK(two->mode))) {
>  		const char *del =3D diff_get_color_opt(o, DIFF_FILE_OLD);
>  		const char *add =3D diff_get_color_opt(o, DIFF_FILE_NEW);
> -		show_submodule_summary(o->file, one ? one->path : two->path,
> -				line_prefix,
> +		struct diff_filespec *spec =3D one && DIFF_FILE_VALID(one) ? one : t=
wo;
> +		if (!spec && !DIFF_FILE_VALID(spec))
> +			die("BUG: two invalid diff_filespec structs in diff");
> +
> +		show_submodule_summary(o->file, spec->path, line_prefix,
>  				one->sha1, two->sha1, two->dirty_submodule,
>  				meta, del, add, reset);
>  		return;

This doesn't make sense, as we're definitely dereferencing both=20
one and two with ->sha1, so we do not need the "one &&" and the=20
"!spec &&".=20
I think the originally sent patches are correct, but the commit=20
message may need rewriting to comply with Jeffs nitpicking.




--------------enig3D967807EFD5640F55F2CAAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSCJ8iAAoJEJQCPTzLflhqiL4QAIytRB8SajT+KnWEF1mwPaDd
9FOy5cRY9nPvV7LWHaiQrcDq16mwYPI4JlhUn/sz/iKoK3ARa52mm2U8Z9ymDC5V
NWgrbMUrQ30D+EVQvb5O8/EooMfiUrjH5SJyzWYraBR0bWn6XGFndW1+emcZpuNk
miBzRGunAZ6jZrtFBIt7dowKMgmHd2QMN/y4Autpz6EiGOtT872d7DBT3MwO1SGD
ZlX9wjunEE1U3/FnqTIaJAjHkhEvrbf+maa1YjmUmNDrwK+InC+bl0DC2GFcpGb+
eGDtVEKevn0blqjl4iTGH85BOLwY/R6Cqw7nP1P3u+mWVRf1d10qPBnNX1lY33jC
dTwskKx/h2XBPiGqDqV7gU76UOLvwGGEydrET07n4BmQm9e7AA54EWToMz7RN+zm
+VQhKXXd+eY/weMfnTafe08Wqh+Gv+P7MdgNzHkTM16IVDfwc3y8wu397ecQuzjk
YgRzHWKfqRuCjD4CEZk7Maqu6UAgMT0K4+F0fbD8HzQFiXe0i+2YFl4CsG3CsA4s
9g+u39shK8gV0/91rD+NoKONv6oysXSIAHYY80kugbRXk2yfQlZ6ss0Kia1IGOyK
eONUwFCq+wBs0FSroBxhY/0ajBhQ4zJpQ9QilUgkR4obCVV29VfSlAHAn08riQ9g
2IPhRDIdz0PsaYqX0F9w
=dlK5
-----END PGP SIGNATURE-----

--------------enig3D967807EFD5640F55F2CAAE--
