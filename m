From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 24/25] upload-pack: make check_reachable_object()
 return unreachable list if asked
Date: Fri, 5 Feb 2016 00:41:17 -0500
Message-ID: <CAPig+cQhYrS0LY5uv3KWSn0JTO8XHD74iUmV2cvCHHBRQH6nKA@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-25-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 06:41:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRZ90-00038Q-Po
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 06:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbcBEFlT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 00:41:19 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33863 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbcBEFlS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 00:41:18 -0500
Received: by mail-vk0-f66.google.com with SMTP id e6so2231750vkh.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 21:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=1+mL+pl7KQTI2qwnGGuvGFF95GSsoiq74BcCxmtx3i0=;
        b=wx4BCa0f2uVI0j4Z86H052u/AyQ+YAARa03hSXvGHbWYnMGJFnY8GTzNU0WcURP84t
         lAEn7IuztzNV6ynSvM/pdRYRs318sXiNu6k8P18oyIFs6oGQlp0Ayf3TKtMfT8RnhAzR
         gJLqaa/56+EalDNFXz/b3mpO/Hn5pltZJYKtV9ECF7EdzPx6PcmtGdjMugWiUPhVzdgd
         uWaJk5f2oXVTgNkrrlFVsIl7AdpEsKIGCWRj1k66Tk8y0m/O991sjw1Sm6ud0QYweGxW
         E0MWCEJmLRYnGVEPMtf7y7JjpIlvsoI+z1rZSjmtDsb/DT6SV0jmwLfOHHQni4M1Cn7R
         AHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1+mL+pl7KQTI2qwnGGuvGFF95GSsoiq74BcCxmtx3i0=;
        b=NXVEihRuIfDplzCYP89AZpraV9VTZdOciv3pRtQGQGkplKniYzaCTD/pcACvtdEURY
         w5339EVc5OmlNQHOtilTjqMhUiE3PtSGFzSKbPjKw4543G2wWXxKTEWIRPeZReGysuCx
         Jayu0PlP6kPRag4XreNIDnA1kBrUOmJM94vo1N7utSGZrFCAkMJfl9Sc9kXur451ua/r
         2MtYneE4MACZZUWUUc5EsFy7mWdmBb03wEGCk4V9sAysz30B3bD7IFVn6BEzD18SFYy6
         R2kgjFuLgn7LfyBaKqwbhYWPvn+o45Mkm8bzXS9U25+ozM89HpKhVUZU2/pBiGwaHdon
         g1Sg==
X-Gm-Message-State: AG10YOSrukDmkS63qGg/7Z+6rOOyutZv4TGsYMmYemMIe3q3N2s9r+bTz5qfSvrg1uVcZEuGYmbMm41Ucp/3lw==
X-Received: by 10.31.150.76 with SMTP id y73mr8195380vkd.84.1454650877777;
 Thu, 04 Feb 2016 21:41:17 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 4 Feb 2016 21:41:17 -0800 (PST)
In-Reply-To: <1454576641-29615-25-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: Io0Gq11ChmwxlQo3LRwbLo4FAkE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285541>

On Thu, Feb 4, 2016 at 4:04 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/upload-pack.c b/upload-pack.c
> @@ -451,8 +451,16 @@ static int is_our_ref(struct object *o)
> -static int check_unreachable(struct object_array *src)
> +/*
> + * If reachable is NULL, return 1 if there is no unreachable object,
> + * zero otherwise.
> + *
> + * If reachable is not NULL, it's filled with reachable objects.
> + * Return value is irrelevant. The caller has to compare reachable a=
nd
> + * src to find out if there's any unreachable object.
> + */

This dual-purpose function serving up two entirely orthogonal modes
feel strange. Would it make sense to split this  into two functions,
one for each paragraph in the above documentation? (Of course, they
could share common implementation behind-the-scenes as needed.)

More below...

> +static int check_unreachable(struct object_array *reachable,
> +                            struct object_array *src)
>  {
>         static const char *argv[] =3D {
>                 "rev-list", "--stdin", NULL,
> @@ -507,9 +522,31 @@ static int check_unreachable(struct object_array=
 *src)
>          * The commits out of the rev-list are not ancestors of
>          * our ref.
>          */
> -       i =3D read_in_full(cmd.out, namebuf, 1);
> -       if (i)
> -               return 0;
> +       if (!reachable) {
> +               i =3D read_in_full(cmd.out, namebuf, 1);
> +               if (i)
> +                       return 0;
> +       } else {
> +               while ((i =3D read_in_full(cmd.out, namebuf, 41)) =3D=
=3D 41) {
> +                       struct object_id sha1;
> +
> +                       if (namebuf[40] !=3D '\n' || get_oid_hex(name=
buf, &sha1))
> +                               break;
> +
> +                       o =3D lookup_object(sha1.hash);
> +                       if (o && o->type =3D=3D OBJ_COMMIT) {
> +                               o->flags &=3D ~TMP_MARK;
> +                       }
> +               }
> +               for (i =3D get_max_object_index(); 0 < i; ) {
> +                       o =3D get_indexed_object(--i);

Perhaps code this as:

    for (i =3D get_max_object_index(); 0 < i; i--) {
        o =3D get_indexed_object(i - 1);

in order to keep the loop control within the 'for' itself?

> +                       if (o && o->type =3D=3D OBJ_COMMIT &&
> +                           (o->flags & TMP_MARK)) {
> +                               add_object_array(o, NULL, reachable);
> +                               o->flags &=3D ~TMP_MARK;
> +                       }
> +               }
> +       }
