From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 3/3] convert: ce_compare_data() checks for a sha1 of a path
Date: Sun, 15 May 2016 02:52:50 -0400
Message-ID: <CAPig+cSYU-+G5p=SaYs=PvMkLiB745Nf7sY3sKe3aozfVvq+iQ@mail.gmail.com>
References: <20160513134953.GE2345@dinwoodie.org>
	<1463294299-20256-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 15 08:53:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1pvC-0007sI-Kk
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 08:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbcEOGww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 02:52:52 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36499 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbcEOGwv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2016 02:52:51 -0400
Received: by mail-io0-f181.google.com with SMTP id i75so172505638ioa.3
        for <git@vger.kernel.org>; Sat, 14 May 2016 23:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=6nSdKSB3R00j3BLK8ITRlBM5Q76RWy9iC4qGP1TlzH4=;
        b=mOIM1H5wJq9hOxo15SEDCnxmgvmQcA04VjA24Rk1rZIj7yQ+NOh5Ys4veg9VBh1YOe
         MeMfuk1ZW4Fb6TzUql15UcWXip+HteH2uUUmpBuU0QKmoB5xPv34TwPYI1VkqiWmE0Dd
         D4qtXvH61AyS9VVHxdxJZRp0dVbVc88QqeOewZaIksLePXLhBh2OBn3g5PUVYQ5GOB8f
         mBzgiJS10Jv4MG0S9X7MZr2p8JrEMEcUqbQd/nFo/+VCkmAVFNh+CcW58mVo9S2qS1Ym
         fhXipqY26mBXpmqvu8SB2aF9r8bRskJ2c3ds7heM4QUQB/v/O0r4GrZ2ercHjV9JmlA1
         3e4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=6nSdKSB3R00j3BLK8ITRlBM5Q76RWy9iC4qGP1TlzH4=;
        b=cr6Yq2gTamvZf1PPc2WKhk/HKWlwpMBYYi4e7WaqEUleJaefeouuYeCgaHZxGuGENN
         yB9MkeCg4VYcBKBsfMMX+WEKs5x4N/OkbHy1AlW5+qlLEBMuDQ14133Qtutfcdt4Cyku
         bCTHPIkK1WZmfw7F343FTbPWra4jN502XUlY7ktW4uM9JhjWn1zi5VZ1ahXlulyp1pUq
         PobmIAM0XaeDxmuxDDrWUfy591YljNEaSQWaWGdLY23lwHUt3LzA4GM1oVPLujxDMkiv
         Dq7iqIWz4FKdB7nnpz/3MhxmaoRcxoyaCtukc1g65qigylWwDMrI+P0L1XQ4nUo6AuNj
         eJxA==
X-Gm-Message-State: AOPr4FVHIcSSZq/jNre07rP1eqLv1L31Gcu9hLqAKdygKamXpQMHmYXamch50KWjgl+RD/LOb+tglQoEEsA64A==
X-Received: by 10.107.132.66 with SMTP id g63mr17711730iod.34.1463295170476;
 Sat, 14 May 2016 23:52:50 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sat, 14 May 2016 23:52:50 -0700 (PDT)
In-Reply-To: <1463294299-20256-1-git-send-email-tboegi@web.de>
X-Google-Sender-Auth: HuDGbxnVZFTQTlt1FE2CKmpMf0E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294645>

On Sun, May 15, 2016 at 2:38 AM,  <tboegi@web.de> wrote:
> To compare a file in working tree with the index, convert_to_git() is=
 used,
> the the result is hashed and the hash value compared with ce->sha1.
>
> Deep down would_convert_crlf_at_commit() is invoked, to check if CRLF
> are converted or not: When a CRLF had been in the index before, CRLF =
in
> the working tree are not converted.
>
> While in a merge, a file name in the working tree has different blobs
> in the index with different hash values.
> Forwarding ce->sha1 from ce_compare_data() into crlf_to_git() makes s=
ure
> the would_convert_crlf_at_commit() looks at the appropriate blob.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> diff --git a/convert.c b/convert.c
> @@ -217,21 +217,29 @@ static void check_safe_crlf(const char *path, e=
num crlf_action crlf_action,
> -static int has_cr_in_index(const char *path)
> +static int has_cr_in_index(const char *path, const unsigned char *sh=
a1)
>  {
>         unsigned long sz;
>         void *data;
>         int has_cr;
> -
> -       data =3D read_blob_data_from_cache(path, &sz);
> -       if (!data)
> +       enum object_type type;
> +       if (!sha1)
> +               sha1 =3D get_sha1_from_cache(path);
> +       if (!sha1)
> +               return 0;
> +       data =3D read_sha1_file(sha1, &type, &sz);
> +       if (!data || type !=3D OBJ_BLOB) {
> +               free(data);
>                 return 0;
> +       }
> +
>         has_cr =3D memchr(data, '\r', sz) !=3D NULL;
>         free(data);
>         return has_cr;
>  }

Possible rewrite which would make it harder to forget to free 'data':

    int has_cr =3D 0;
    ...
    data =3D read_sha1_file(...);
    if (data && type =3D=3D OBJ_BLOB)
        has_cr =3D memchr(...);
    free(data);
    return has_cr;
