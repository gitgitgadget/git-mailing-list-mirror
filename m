Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD71C6FA83
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 10:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbiIEKPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 06:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbiIEKOC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 06:14:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C615C57249
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 03:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662372784;
        bh=ys2vj3T6QRrlVs7ymZmij0kBuHSGIfKZvhmEO4SoRGE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kjLs+JkyfubFhkXOG8rygVrGMdeak5+15Ulz2Gng+nZkqqCjexFfEe3B4cBipfJIx
         KJl2JqocZFZBNPKvd8WRc8CgAzkm2YglEsEfs/RSBLwPzNHCB5nWSjuQl4OAwQ8Spm
         Yw910WI5Hy1IQMp1Tz56U7aPgt385lF8l/fRZK7M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MulqD-1pM0XL1fLH-00rlws; Mon, 05
 Sep 2022 12:13:04 +0200
Date:   Mon, 5 Sep 2022 12:13:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, alexander.s.m@gmail.com
Subject: Re: [PATCH v4 2/2] diff.c: More changes and tests around
 utf8_strwidth()
In-Reply-To: <20220903053934.15629-1-tboegi@web.de>
Message-ID: <772s47o8-o5r2-0s9p-5681-9ooo9r144p57@tzk.qr>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com> <20220903053934.15629-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5cvstOjm7FT440u/LK+qTMEkXDCy1IScg8Pp+br5y36Vj8aYViE
 cS0G2S9YPLCPH6pvaoScv4ZfKEnui3GhqCSPv7l4GiNNpZ05+nqT7jMmEXg/H3wxUY1/RhP
 M6eHdrJt2PO0/OLRXehob9RQFRP/OrxbortTy9QQdOpVT/1pL/Wbhj8kXdOku7AasFh+No0
 wJ2PTOda+3lejyXUJLiPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y6yTG/H3FWY=:R5rBGFcL6ppA30qzhBwe8g
 nI5GMKKUhIW9A+wBdMF70/YdSpUpuTVhYjWjxeiifRafQskll0yWGD5bVV2yukl/w5Sgg+FXN
 /v43QToTlHjyc91bi/PSLUN/3yRESgbFEiUnb8B+goWhyoqVB4TJwKCSKEaWZgwIqc60i+zr9
 bCvl1pkPclvRLxJEHvp9CiagHUMxrXfZW3riJY77WHYyWhf8gvZBJaKsk2sirBXo4rPpyzO6N
 aW+PnXwE4jGkXUyDc638VJ/ScgP9OeHEgRX4QU6LBs5frn/JZ8FkA39AXmctcJonkv4LjF0GC
 JoBxFVvhjcNlS0kIEpg07kKI7l36Z6CouMtyaGBzmFsr0lVSaNwZMpgvLos8LxJYZ975Qs5p9
 jZbGqL+9cPQ0tdEg4ePmdQaYWmYxy8rVWMx5TkxsimdGTjgjGC4XASSqvIyjFvyalAZntieSc
 Vn+xwe2szB/GpEM7S8rcHby+qVxFIjEhq9tQPC2EFLkJkTaLhx9kMZuslrKvFtfW94RWuLimv
 lEq0BehpP0O+36e+Y/fTjrueU+E9dnHTTj1JXe+9qTjCpwHCUCX8xk9EIzNWod3qTsGkoxoa8
 ctye3oAFScU8Eb7X5ZXc8RqF0I7xGSRR9dRGnFil39Q8IqMEN6gIZP9XII3ReS2ZQmT+QfNyG
 bAjY4sI/CkTh+tCOJwWDYKMdu5ylSnw5hhN7vJGY4pNZxdgwb2r4Y352s0sOxULL4XWbi3n9D
 61rcDmZKwJ8OFMa4J4l7rReK2MiK/RzMM5wJszfXhgvd2IjrYez6UibeTi6V18e7WWqqyyNX6
 G+WYQs3xlnfPR9MVg06YHlAQl1hsx+rNfFy0hFQTSzEWoI+w9yI79XQwl9vZa2ZnfnUoHs0no
 1O7nJGSJ7ad9FEoQbQlt83f34dAUU6p3OxEjUJou9iBEu4Rt2VTfUa8/QL1X7b90bfnLP4tfK
 snA644X/ilYNn2Y6RBv0XZEeLfnvWYuZwIrZ98M8YaizPa2PncsNExpW8nDrbjdeg7/dSXutb
 5fPR8G8IUIJJuZSPLg4J5IZO5rz2tKu+whMW/1qxwFkHhh9bwjrdxTItUilv2Tawl5DTK2G0X
 uqWRj7n9lG4YWVy8MsyALtCZKUBX3ZWhbWr0QwNet7HJdbCz08fViXmxKQdJuCoZkFHx/MNeP
 CcyW5mvkrX1TFtxhd8Q5jpoeCT
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten,

thank you for working on a new iteration!

On Sat, 3 Sep 2022, tboegi@web.de wrote:

> [...]
> diff --git a/diff.c b/diff.c
> index b5df464de5..35b9da90fe 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2734,7 +2734,7 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
>  		char *name =3D file->print_name;
>  		uintmax_t added =3D file->added;
>  		uintmax_t deleted =3D file->deleted;
> -		int name_len;
> +		int name_len, padding;

I had a look and `len` is also declard as an `int`.

>
>  		if (!file->is_interesting && (added + deleted =3D=3D 0))
>  			continue;
> @@ -2753,10 +2753,14 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
>  			if (slash)
>  				name =3D slash;
>  		}
> +		padding =3D len - utf8_strwidth(name);
> +		if (padding < 0)
> +			padding =3D 0;

I would have had a slight preference for something like this:

		int name_len =3D utf8_strwidth(name);
		int padding =3D name_len < len ? len - name_len : 0;

i.e. avoid the potentially negative difference. (Ideally, I would have
liked the type to be changed to `size_t`, but that is impractical due to
the variables' use in `%.*s` formats.)

But it is not worth a new iteration on its own, and I am very happy with
the current iteration.

Thanks!
Dscho
