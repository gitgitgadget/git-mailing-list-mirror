Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A75C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 19:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbhLQTa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 14:30:28 -0500
Received: from mout.web.de ([217.72.192.78]:59329 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236763AbhLQTa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 14:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1639769337;
        bh=26V4yo3JOAm/3mDb/eGdNaZtyH5RysPiLYwhzFNU9uU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HGYHKVwzG+BtOTTEuHD+RLhW3wJ8Owr3+Npi0Hvom+jqETut+tgu2aoEGwdO8It6f
         /Kcez5YgZTfasTPNZ/aVzcslF3aeBhJJsEfyvM1K4RnuBUneVxkqN7OLq18a1YcOdM
         8j8fxbARyAYciWy2umjRO2oXdLR6sr/EsQH1/PQg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3ouw-1mXfEv1ENU-0106Mm; Fri, 17
 Dec 2021 20:28:57 +0100
Message-ID: <c860c56f-ce25-4391-7f65-50c9d5d80c2c@web.de>
Date:   Fri, 17 Dec 2021 20:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v6 1/6] object-file.c: release strbuf in
 write_loose_object()
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211210103435.83656-1-chiyutianyi@gmail.com>
 <20211217112629.12334-2-chiyutianyi@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20211217112629.12334-2-chiyutianyi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MesmxbcqwMsEeKYzgS3vlSm0RN1bhBpzguc8KBiqyqfkkyuzxJl
 Y8fJCB8zXDpT9OTW/o8xPzphaohJ7lGwbuiHf/afoVf2hX6SaubKaO7olEIabw+FOhor1OD
 EHJ3vBKTLr9GzFDFeEjYYxg28A0Dd2Uhe3635Xj4QD4ZWchEdBb6eDJXyMenVQHq8/foDx1
 taDFe9ZTYs7HCgfxi7zMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VLGEwFzAHuI=:JbFASxuFa3aSNkn08fCO92
 346mruWru0e+CIW9S2vIzPe+1crBOyxtoytX1GMOSUfrZ0zd2mHqbf3FLEuTVoXO3mFh9tY6d
 ldheQjNuJAehR5Y09cSM5Amb/+YhlXY/XFloEo1BbLIvYvUiJ1aDqjV9ixQwfkQlWGYgNL0xD
 2nKH6iEx6S6SffzQUOspnn1zBrVH0erSnzlvGcRPwY8SPGm5z2ojvMPpxWR4I8/xhel03Q029
 SRQeq6Rf1qTyT96jQiQtbY3vh2bfPhf0BF2JJt1s3UqxPrCBsKwmCpZDQuAT6FZkLaB/r/3t3
 PfU3PkAjBW0yy4Lni14G4GlzVolu5boMNvH64qGUtH2/8wElPSPtnV01Xsadu0HuerQe8hnKL
 3qCDRFlYoSY+gAA4QoXrR/GlyzJk0kVkcP2Vp/d7Hiy22YahLSwEvnNWmuEaQlOlJl/XYqnne
 Xr8yEDxepNqehgVstQEqCQMrk3b63td7gy+MeEsqC8o8vi2yaaFCW/zKQRlb20C7N4QBYW3r/
 J4q6zQDeyHsxmICq8V2zxBxVMBDkfHzi6UdpYPcVd7yr9QyVw75qtlufEsVTGZZcjI/2j8aU3
 kBfWaB5onWgJefN+vKDBFzaC0iIRivwanfld4gpfnFFxkY9ZnMvFOtIOy7n2TyjDl+XQCGGp1
 dsWQDrMRIXG4gz9aOyR8PJCxqEqDdVtB3cBSeUvpr+2PTdY8rDxxh9JFy3V9p8f+A+qkiUtNL
 Xe3Cd+WCD/HVR6LT8gvby/xYOCugSNFjNswys2td0Aynt+eG+TC+MZSeNe7aI+bTRcJkg8p33
 gArYE+GbQ91L0Qo1Caa7BxoqP7d0CYm9Px2ZBVejRs0YunAgDWGv2vUkLQHCBbWNsPA4UUXDV
 96bhAZnnEbIw/qmQCVnZzhEF78lx2xha6+zEmO3zrmEuTqMy79tgfW1RRSJmBjcFeLxHAuUXM
 3XviZNqSvcZf55pYIlo+j4cwCqiZKVoV7oNDMxq/MmDpnX1YG4uEA9zxOc7UsIDsNCKb82M++
 AEa5i2HYfrMcP1aVpOBpLtKb8N7SFogRIiiPXuNbErQiWdq4VdpoZ+I/5iQzyj/Ceog2MN8En
 hhU2tQ+yivv/mA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.12.21 um 12:26 schrieb Han Xin:
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> Fix a strbuf leak in "write_loose_object()" sugguested by
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  object-file.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index eb1426f98c..32acf1dad6 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1874,11 +1874,14 @@ static int write_loose_object(const struct objec=
t_id *oid, char *hdr,


Relevant context lines:

	static struct strbuf tmp_file =3D STRBUF_INIT;
	static struct strbuf filename =3D STRBUF_INIT;

	loose_object_path(the_repository, &filename, oid);

>  	fd =3D create_tmpfile(&tmp_file, filename.buf);
>  	if (fd < 0) {
>  		if (flags & HASH_SILENT)
> -			return -1;
> +			ret =3D -1;
>  		else if (errno =3D=3D EACCES)
> -			return error(_("insufficient permission for adding an object to repo=
sitory database %s"), get_object_directory());
> +			ret =3D error(_("insufficient permission for adding an "
> +				      "object to repository database %s"),
> +				    get_object_directory());
>  		else
> -			return error_errno(_("unable to create temporary file"));
> +			ret =3D error_errno(_("unable to create temporary file"));
> +		goto cleanup;
>  	}
>
>  	/* Set it up */
> @@ -1930,7 +1933,11 @@ static int write_loose_object(const struct object=
_id *oid, char *hdr,
>  			warning_errno(_("failed utime() on %s"), tmp_file.buf);
>  	}
>
> -	return finalize_object_file(tmp_file.buf, filename.buf);
> +	ret =3D finalize_object_file(tmp_file.buf, filename.buf);
> +cleanup:
> +	strbuf_release(&filename);
> +	strbuf_release(&tmp_file);

There was no leak before.  Both strbufs are static and both functions
they are passed to (loose_object_path() and create_tmpfile()) reset
them first.  So while the allocated memory was not released before,
it was reused.

Not sure if making write_loose_object() allocate and release these
buffers on every call has much of a performance impact.  The only
reason I can think of for wanting such a change is to get rid of the
static buffers, to allow the function to be used by concurrent
threads.

So I think either keeping the code as-is or also making the strbufs
non-static would be better (but then discussing a possible
performance impact in the commit message would be nice).

> +	return ret;
>  }
>
>  static int freshen_loose_object(const struct object_id *oid)

