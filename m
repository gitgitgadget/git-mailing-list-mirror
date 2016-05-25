From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 09/26] upload-pack: move rev-list code out of check_non_tip()
Date: Wed, 25 May 2016 03:36:49 -0400
Message-ID: <CAPig+cRM_6Yj0=ZOwf8xq9fipCVOFVVLeh5yOpqTxrq4r314iw@mail.gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
	<1460552110-5554-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 09:36:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5TN9-0003sR-FB
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 09:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbcEYHgv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2016 03:36:51 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36625 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbcEYHgu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2016 03:36:50 -0400
Received: by mail-io0-f193.google.com with SMTP id m17so3662965ioi.3
        for <git@vger.kernel.org>; Wed, 25 May 2016 00:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=SYByHVWmImYGWOhY4zh7Wx2oGnYXW9loHJWAOOfgdrY=;
        b=Nm/YrWtWsp8mHF5XOsivHzMzlVKgyDOL38aIkGZDXgvUxPeHv9RSp0kjjl6qecGkFU
         R7OFijocCu05RiKSKO3rjvZHS7MaoIobsWQnDF+R6bibLzsfu3Ne67R8KZJ5Nq1mlSMI
         qSj/oy1kHEePOZFznnF28PNHtTUe+vmUVgwp9Vx5OnyYiS0D2Jw8PSKUn9ING2P5+lr1
         7nwUOvomNFXVKlncIGd6W5aklJ3FQPPuWM3QepQ2KLmkEZjXtPiNG1+aR7VgErB0NnZt
         fxGomN1jA3G29iIJUUTtyvenlxPThPZqdsC+0SyHsGsHiSyt6FMlI93znwCaYEUmf9wV
         F4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=SYByHVWmImYGWOhY4zh7Wx2oGnYXW9loHJWAOOfgdrY=;
        b=YeYUb++ZOOr2zP/7EfDNI94s91FaSnKrG9bErwzrpNBlaU292LRWCaR18ExeBA/J7B
         SCVt1wp0yDhvS4QayyyOwQNaHb1/aCwg0teWKBWpLNYF/3RGYemW0+ISOqDN/hiFWt4Y
         yY0HLWenuPtNKQpCiYKgYuABBX43glU2gQxkw0FkzBBvv3MGZ8bjwcf/JFOb8a7hX3qP
         YIpWCYX/Ra9pOHat4+eeZ/mQSkrIxXJg/VUb9sWKnxs25Ilhk7cy+rslb11IZmzzWNOV
         dYO9mJLkbMTr+40xcpcMMAnE461FHWJTgU4wXf9cIFGMbp2FuHWcagf5PYj6RRyiSHj/
         b23A==
X-Gm-Message-State: ALyK8tKi2ZY15E0vpgcLHIchmkUUBMJ1gD+KkeaA1dVz8CnY94e2dxL9A94nxv9OR2r8YdyYiBzah9MDGZbQmg==
X-Received: by 10.107.47.37 with SMTP id j37mr2403663ioo.168.1464161809697;
 Wed, 25 May 2016 00:36:49 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Wed, 25 May 2016 00:36:49 -0700 (PDT)
In-Reply-To: <1460552110-5554-10-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: KaIkLwIujWCcI5E3tmwzMEX3E5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295566>

On Wed, Apr 13, 2016 at 8:54 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/upload-pack.c b/upload-pack.c
> @@ -451,7 +451,7 @@ static int is_our_ref(struct object *o)
> -static void check_non_tip(void)
> +static int check_unreachable(struct object_array *src)
> @@ -461,14 +461,6 @@ static void check_non_tip(void)
> -       /*
> -        * In the normal in-process case without
> -        * uploadpack.allowReachableSHA1InWant,
> -        * non-tip requests can never happen.
> -        */
> -       if (!stateless_rpc && !(allow_unadvertised_object_request & A=
LLOW_REACHABLE_SHA1))
> -               goto error;
> -
> @@ -476,7 +468,7 @@ static void check_non_tip(void)
>         if (start_command(&cmd))
> -               goto error;
> +               return 0;
> @@ -495,16 +487,16 @@ static void check_non_tip(void)
>                 if (write_in_full(cmd.in, namebuf, 42) < 0)
> -                       goto error;
> +                       return 0;
> [...]
> +       for (i =3D 0; i < src->nr; i++) {
> +               o =3D src->objects[i].item;
>                 if (is_our_ref(o))
>                         continue;
>                 memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
>                 if (write_in_full(cmd.in, namebuf, 41) < 0)
> -                       goto error;
> +                       return 0;
>         }
>         close(cmd.in);

It's a little bit ugly how this close() becomes disconnected after the
refactoring. In the original code, due to the consistent application
of 'goto error', it's reasonably obvious that skipping the close() is
not harmful since the error case die()'s unconditionally (according to
the comment). However, after the refactoring, the function simply
returns without invoking close(), so there's a disconnect, and it's
not obvious without looking at the caller that the program will die().

Also, if this function later gets a new caller, is that caller going
to need intimate knowledge about this potential descriptor leak?

> @@ -516,7 +508,7 @@ static void check_non_tip(void)
>          */
>         i =3D read_in_full(cmd.out, namebuf, 1);
>         if (i)
> -               goto error;
> +               return 0;
>         close(cmd.out);

Same observation.

It might be clearer if you retained the 'error' label and used it to
ensure that the descriptors get closed:

    cmd.in =3D -1;
    cmd.out =3D -1;
    ...
    if (...)
        goto error;
    ...
    /* All the non-tip ... */
    return 1;

error:
    if (cmd.in >=3D 0)
        close(cmd.in);
    if (cmd.out >=3D 0)
        close(cmd.out);
    return 0;

>         /*
> @@ -525,15 +517,29 @@ static void check_non_tip(void)
>          * even when it showed no commit.
>          */
>         if (finish_command(&cmd))
> -               goto error;
> +               return 0;

Here too. Does 'cmd' need to be cleaned up if the function bails
before finish_command()?

>         /* All the non-tip ones are ancestors of what we advertised *=
/
> -       return;
> +       return 1;
> +}
> +
> +static void check_non_tip(void)
> +{
> +       int i;
> +
> +       /*
> +        * In the normal in-process case without
> +        * uploadpack.allowReachableSHA1InWant,
> +        * non-tip requests can never happen.
> +        */
> +       if (!stateless_rpc && !(allow_unadvertised_object_request & A=
LLOW_REACHABLE_SHA1))
> +               ;               /* error */
> +       else if (check_unreachable(&want_obj))
> +               return;

With the loss of the 'error' label (below), this logic becomes a bit
more difficult to follow. I wonder if it would help to invert the
sense of the conditional...

    if (stateless_rpc || ...)
        if (check_unreachable(...))
            return;

Or, perhaps, retain the 'error' label:

    if (!stateless_rpc && ...)
        goto error:
    if (check_unreachable(...))
        return;

error:
    /* Pick one ... */

I think I might find the latter a bit clearer, but it's highly subjecti=
ve.

> -error:
>         /* Pick one of them (we know there at least is one) */
>         for (i =3D 0; i < want_obj.nr; i++) {
> -               o =3D want_obj.objects[i].item;
> +               struct object *o =3D want_obj.objects[i].item;
>                 if (!is_our_ref(o))
>                         die("git upload-pack: not our ref %s",
>                             oid_to_hex(&o->oid));
