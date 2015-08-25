From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] dir.c: make last_exclude_matching_from_list() run til the end
Date: Tue, 25 Aug 2015 13:28:08 -0700
Message-ID: <xmqqmvxfxgdj.fsf@gitster.dls.corp.google.com>
References: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
	<1440334214-32131-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 22:28:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUKpL-0002Nr-Se
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 22:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbbHYU2L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 16:28:11 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35038 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbbHYU2K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 16:28:10 -0400
Received: by pacdd16 with SMTP id dd16so134661225pac.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Mox3932qTu8k66VUv9SUAQ3wcjaNS6BNJfwZjq4FUuM=;
        b=DfHSY+njDQ+EmmDYwMFm1l3tEivjMI/Jx0/CqlnESFETxDiRr5aBtSUm6gKkkiQv7q
         s4LgZ63MEfcE5nXamowsbFo/JaXSO4c5Zq7XOE3kN4EYkRBLr9i0N9g0RJOoUzbNalj+
         u9W07oWUROIUZT+oTM0TKSV4CqvJ3OBsaPlfhRR63p9PmAbZ7lS6DzuH8Wm5CuA09Ow9
         QSeoLiQUo/6V6WfbCe+45cyBMV3wBoXZnNcLEhNyzFkCw9Y7NOivIb8Nyvvma4fz/kNQ
         CIzYqBrmpO/dkm3NVWLwWgOm0GDKsYpE+88EAab13/s3tA136ZgfHt51IWujYpdU3GUf
         zP6A==
X-Received: by 10.66.147.131 with SMTP id tk3mr61041745pab.104.1440534489584;
        Tue, 25 Aug 2015 13:28:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id ts1sm22004952pbc.74.2015.08.25.13.28.08
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 13:28:08 -0700 (PDT)
In-Reply-To: <1440334214-32131-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 23
 Aug 2015 19:50:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276570>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Because?  Title just tells what the patch meant to do (i.e. instead
of returning it keeps looping), but does not say why it is a good
idea.  Besides, this a no-op patch and does not make it keep looping.

> ---
>  dir.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index c00c7e2..3a7630a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -901,6 +901,7 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
>  						       int *dtype,
>  						       struct exclude_list *el)
>  {
> +	struct exclude *exc =3D NULL; /* undecided */
>  	int i;
> =20
>  	if (!el->nr)
> @@ -922,18 +923,22 @@ static struct exclude *last_exclude_matching_fr=
om_list(const char *pathname,

Note that we are in a big for() loop that scans backwards an array.

>  			if (match_basename(basename,
>  					   pathlen - (basename - pathname),
>  					   exclude, prefix, x->patternlen,
> -					   x->flags))
> -				return x;
> +					   x->flags)) {
> +				exc =3D x;
> +				break;
> +			}

We used to return x immediately; now we store x to exc and break,
i.e. leave the loop.

>  			continue;
>  		}
> =20
>  		assert(x->baselen =3D=3D 0 || x->base[x->baselen - 1] =3D=3D '/');
>  		if (match_pathname(pathname, pathlen,
>  				   x->base, x->baselen ? x->baselen - 1 : 0,
> -				   exclude, prefix, x->patternlen, x->flags))
> -			return x;
> +				   exclude, prefix, x->patternlen, x->flags)) {
> +			exc =3D x;
> +			break;

We used to return x immediately; now we store x to exc and break,
i.e. leave the loop.

> +		}
>  	}
> -	return NULL; /* undecided */
> +	return exc;

And then we return exc.

>  }
