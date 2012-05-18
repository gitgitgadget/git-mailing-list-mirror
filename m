From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] pack-objects, streaming: turn "xx >= big_file_threshold" to ".. > .."
Date: Fri, 18 May 2012 14:05:47 -0700
Message-ID: <xmqqk4092o9g.fsf@junio.mtv.corp.google.com>
References: <1336818375-16895-1-git-send-email-pclouds@gmail.com>
	<1337169731-23416-1-git-send-email-pclouds@gmail.com>
	<1337169731-23416-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 23:06:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVUN3-0002Rw-1W
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 23:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967589Ab2ERVFu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 17:05:50 -0400
Received: from mail-yx0-f202.google.com ([209.85.213.202]:57545 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967520Ab2ERVFs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 17:05:48 -0400
Received: by yenl3 with SMTP id l3so418916yen.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 14:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=jNuo1AEMhXlYoewx533UFeEqwTVZVKs0Z4Ui7Y8uVx0=;
        b=o9aW38dilhjZ04dvcX0PujB9hX/MApKw7MwQDi755aBESZ8sUwCYv95wQc2ybvk/eZ
         yB2btBq1+LafIV9ryLr7DLTCNYMkz+imu59kk3oE+bLwSHzgv9P91Gb1sja+KAStnqtH
         4fWK8CqEur/TL5IzuVzBw/kJ/OUIgYj0/+scLOiWgcEaZ4jQV6SeEaKohRLIl3q+8KK1
         uf9SbwSfBZQQx4n3yKZ0k3mLiPYAXVtQH339g6Na+GnJ3d6V5ArBuTAtDexiS8ob6Gxz
         YEVsDYDmnh5uHu7fjcUuqFR4iU7ZQ7+SxCEUpGvu7qswx/elZ4SAHS/4AIPrafxdBVaV
         Q3yw==
Received: by 10.236.73.131 with SMTP id v3mr19511296yhd.6.1337375147924;
        Fri, 18 May 2012 14:05:47 -0700 (PDT)
Received: by 10.236.73.131 with SMTP id v3mr19511291yhd.6.1337375147882;
        Fri, 18 May 2012 14:05:47 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id f27si3713911anj.1.2012.05.18.14.05.47
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 18 May 2012 14:05:47 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id BE1F8100052;
	Fri, 18 May 2012 14:05:47 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 6A513E1772; Fri, 18 May 2012 14:05:47 -0700 (PDT)
In-Reply-To: <1337169731-23416-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 16
 May 2012 19:02:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlHHPvsLdeTQJoBzj7aaO0iKmSiKR1cjWL7g8dasPvZ0ft62eiEv0tigkhLCP3JkmQvVKnmyC/0ghqGLYNnIJNqkbnsqy1vwVXoFDnYg6KTTar6g0jU6t0YcQjOCb1s88wf20NAj44P57SivkI/VmknbUGH2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197973>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is because all other places do "xx > big_file_threshold"
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Without two comparisons I added recently in archive-*.c, it's still
>  inconsistent (two xx >=3D big_file and one xx > big_file).  I have n=
o
>  preference between > and >=3D. If some of you vote >=3D, I'll update=
 the
>  patch.

Thanks; I do not have huge preference between the two, but "I want
special treatment for anything bigger than 2MiB" is probably more
natural than "I want special treatment for things that are exactly 2MiB
and also things bigger than that threashold".

>  builtin/pack-objects.c |    2 +-
>  streaming.c            |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 1861093..b2e0940 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1327,7 +1327,7 @@ static void get_object_details(void)
>  	for (i =3D 0; i < nr_objects; i++) {
>  		struct object_entry *entry =3D sorted_by_offset[i];
>  		check_object(entry);
> -		if (big_file_threshold <=3D entry->size)
> +		if (big_file_threshold < entry->size)
>  			entry->no_try_delta =3D 1;
>  	}
> =20
> diff --git a/streaming.c b/streaming.c
> index 38b39cd..829ce7d 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -121,7 +121,7 @@ static enum input_source istream_source(const uns=
igned char *sha1,
>  	case OI_LOOSE:
>  		return loose;
>  	case OI_PACKED:
> -		if (!oi->u.packed.is_delta && big_file_threshold <=3D size)
> +		if (!oi->u.packed.is_delta && big_file_threshold < size)
>  			return pack_non_delta;
>  		/* fallthru */
>  	default:
