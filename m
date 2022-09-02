Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE1FC38145
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 09:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiIBJj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 05:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiIBJj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 05:39:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9C2AA34B
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662111562;
        bh=j/9HT9pn5ft8AMVtDywSUJZJZdMAenbkKZrwxE0EOng=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SfUdgJeT+ZPb/ASlpcMod7hvGGqnU1NJhclvkVmORK3uYT0caX05/oSCub3yEg+bn
         ReMkxmpsbQQ8Xvuq5ApI6QWubSY0Udt+GXwLvENV6/EXMqOULR4AHgmp7zXeiLTpau
         6RgaaIbeEWmT1jOL+jvvykbgVWU71weIbQKbEqaM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGRz-1okCxD0A0r-00PfQt; Fri, 02
 Sep 2022 11:39:22 +0200
Date:   Fri, 2 Sep 2022 11:39:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, alexander.s.m@gmail.com
Subject: Re: [PATCH v3 1/2] diff.c: When appropriate, use utf8_strwidth(),
 part1
In-Reply-To: <20220902042133.13883-1-tboegi@web.de>
Message-ID: <9o5o2rqs-r7q4-p22r-0oss-1n09por2n248@tzk.qr>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com> <20220902042133.13883-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FwwEWnpoI3lSSKIUnwzxg7zP94KTzmqFf+h9jn20z4SzsAt7Jpw
 nM3KAsPxjW+bFOvtKSX/dY3LEUtj5h/AxZxdbjX/L/AkUgLD+zwRyGepdH0Igqg6jsfP34N
 OnTJE6g4WiTozzwowapqjMdyDMLmZuhmKGlcXdmb5024CNHBn+tzlOzBlahMdP81623+prg
 eDmnqESTLskfVfQhZ+1Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wK9ZZAPrjkc=:/Z/3E/yu+4oqAjEbuR7dHf
 dmginY+/zOvlEy5Zmc3sN5nHEjtEpNxOGtVX8Y52+weZ6RTUnhH49ueMIAds6bHqO8QUlRC+u
 vReUrm0FG9IEitnhv6SU431OyG9V4RJ2bwdRWFQXuNdVtlaTTamAqathsicApiodbPbCWXWk/
 BZUpKjPKvuqytM2nJN3Wr2MT8fco0JJYPtP/iJy/7fqrJwm2rsUyIueBY0+mrA8wC62LsMQ9N
 kNEjBE6z7SOH36z1jm634CjgmhN/TT9jCqtICZwZ/25x32rIJSgv0l6dCY6lglVrict19vnqa
 39jb5EBxXYBzb3YVoqfEWAsnNTLkQAdn36WSqMCMP3zI32zD8ZCS42V3v9z2QawRnbkjS5L12
 8lg3CzRhKLnZlIC+dYidRQeghOeFihj8Qp2ghnCDdhqE5VpZYFa4Psunk5/Veorh06xZWSWA+
 XS/9wjKNyMcKtdTxLlaHjbfyYrvl/I2sE7RRVpdXSWPRIFyWyncRn84jpMQ4/nXxrxkp534yq
 EmfactvUoOffAMLlvs3uyVNfQavu1rcsdlliRf5dFUe69jP54TzniGtNQGElpP4KWks3i/2H7
 /OPksou1PeswhFq4luhSmVuj9PpD9DjSd0MvSYtTLb4c0yAjcE/v65AjAitxMkWcNGNMyAKqP
 1rmMsc8zB9JVG+MO/B/CkeGfnLfHB7EERkjRlU7AWry6xaKlW3dQxnuQ3DZXAO4O9EHscbMS1
 n6ND18jpcQfgW7ORvCLb2ZUu1Z7PjoByX9qki5CvtKzVQ6iKY8up7nyu4vwF9vWJYcOXXs/LE
 7nfpZ+NVKz/DZzcuDcrTUfeLYJMRavT3Y0vDR2C6/1ubdEslAPBILGDLuTQLhvwMHw2Uj+SkT
 gA/wanp3rOHttydWfpo1s0olvn5x1iT5xA+z+fJ191GeRuWUmXA2k0u7SlK2512Il0kfPYMJq
 B7Pu9Y1t9O0quzRTSZDQhiGAzPds4YljAGVZ40iSZwtLLAHvKIxW1ce1sfyEJtWChJOKTVqS4
 V0PfeqLtAUOci5btCzx9TulQNHlP+Pg0kkOrL4ONQ4W3IHXCJsjyKIczbYBeoVcupce/wkLdW
 1kKm7rj/x+iCEcwhEPNTD5upC2b7HPKfOqMq9RlI16u1UGD8ZzNehHuY1VC5rASKTWLvQiFv4
 LYQf6dvNm4F5dqpiEejQvWpLJV
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten,

On Fri, 2 Sep 2022, tboegi@web.de wrote:

> diff --git a/diff.c b/diff.c
> index 974626a621..b5df464de5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2620,7 +2620,7 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
>  			continue;
>  		}
>  		fill_print_name(file);
> -		len =3D strlen(file->print_name);
> +		len =3D utf8_strwidth(file->print_name);

So this is no longer a length (in bytes) but a width (in columns).

In 2/2, a similar change incurs renaming `max_len` to `max_width`.

I would prefer for 1/2 and 2/2 to be on the same page here: either they
both rename variables that have `len` in their name but are actually about
a width (in columns), or neither of the patches rename these variables.

Thanks,
Dscho

>  		if (max_len < len)
>  			max_len =3D len;
>
> @@ -2743,7 +2743,7 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
>  		 * "scale" the filename
>  		 */
>  		len =3D name_width;
> -		name_len =3D strlen(name);
> +		name_len =3D utf8_strwidth(name);
>  		if (name_width < name_len) {
>  			char *slash;
>  			prefix =3D "...";
> --
> 2.34.0
>
>
