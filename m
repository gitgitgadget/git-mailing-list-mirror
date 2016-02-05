From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 20/25] upload-pack: support define shallow boundary by
 excluding revisions
Date: Fri, 5 Feb 2016 00:03:03 -0500
Message-ID: <CAPig+cQ2thjGWxar3BSJBU_O1WBsD0FHjv8i_sSMQKh+wO7bjQ@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-21-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 06:03:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRYY2-0007hc-LG
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 06:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbcBEFDG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 00:03:06 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34310 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbcBEFDE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 00:03:04 -0500
Received: by mail-vk0-f66.google.com with SMTP id e6so2214681vkh.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 21:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=5Erut80buBjqYdIX4+Iotz8mbUjeUZWcjT5LfRu8c2k=;
        b=h3oY3DOj428y2yOj/G/CGPnfFQ+Wd8DQ5t0SVDomDd4aDLTSVEt+11yOMuPT21Ht0i
         5vfvSBMwe3Uxh+/+vmfE/MIVT+8akhrcGNABjCt0JtFm72O73GGgNjBps4+pD5qyK/yM
         Rr/3n1Cizu4vBfbuCO028srQ0ATOAspJS1zqvCHtkej/0LgsC6ZnWo2tlBxkkokW12OJ
         qTsfJ/9be5W6Z4wA99rzsT+AtjWucCs1FdcyB18phEKOC/6WgRjprKyitEWpQbaJz9IG
         Me6vlf5gpbToQiC9FBzxHGUGatc4VBCkQRP3K0gpUmFYjBD3iM2o4CvW1qucsaptcHSr
         Lqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Erut80buBjqYdIX4+Iotz8mbUjeUZWcjT5LfRu8c2k=;
        b=cz7WpPViWX0PZ17IKlE5fvqZ8larGYXNYc5uv34oPN7RF2pCp+V0xkGf41NGM62NMZ
         dJObs4nwTa+UwSlBUGULuDE5fwfRYrv9vycxb+5tNaT8GUsGk6MxgZ0l8qxvIEpdnAYp
         OyehVfxuL09v5g19TK/MhF2yQ2171iOYHaS4TLRBhF23917BCD+G0u/j1qG0yCkXhW3v
         dcLQFcIbAE6YuQg7D6e+gKTeIhqWB/PyvJTnco06sWlpwcrJ9LRGE045JCl9EK98D6eH
         Ann869u9kapcqlgU4/D6WWNz0o2PiTzKuQAAH8NjGBYnzLJx34+I5TBOfR1r34SXvNaV
         zeXg==
X-Gm-Message-State: AG10YOQOkSpocxlP5zXgN1PzxxIb5Zb7juGrYNBsQuh1/bRgnK5SJnwgeBrqSivFKYbKWrykW1mmf++QtCNHpg==
X-Received: by 10.31.146.71 with SMTP id u68mr7194444vkd.19.1454648583317;
 Thu, 04 Feb 2016 21:03:03 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 4 Feb 2016 21:03:03 -0800 (PST)
In-Reply-To: <1454576641-29615-21-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: z7YLdf3FMW2rOWEDvJsfpJlphgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285538>

On Thu, Feb 4, 2016 at 4:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> This should allow the user to say "create a shallow clone of this bra=
nch
> after version <some-tag>".
>
> deepen-not cannot be used with deepen the same way deepen-since canno=
t
> be used with deepen.

As written, this is a bit of a brain twister and required several
re-reads to digest. Perhaps it might be clearer if rephrased like
this:

    Like deepen-since, deepen-not cannot be used with deepen.

or:

    Like deepen-since, deepen-not is incompatible with deepen.

> But deepen-not can be mixed with deepen-since. The
> result is exactly how you do the command "git rev-list --since=3D... =
--not
> ref".
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Docu=
mentation/technical/protocol-capabilities.txt
> @@ -188,6 +188,15 @@ specific time, instead of depth. Internally it's=
 equivalent of doing
> +deepen-not
> +----------
> +
> +This capability adds "deepen-not" command to fetch-pack/upload-pack
> +protocol so the client can request shallow clones that are cut at a
> +specific revision, instead of depth. Internally it's equivalent of
> +doing "rev-list --not <rev>" on the server side. "deepen-not"
> +cannot be used with "deepen", but can be used with "deepen-since".

This description, on the other hand, is easy to grasp.

> diff --git a/upload-pack.c b/upload-pack.c
> @@ -678,6 +679,16 @@ static void receive_needs(void)
> +               if (skip_prefix(line, "deepen-not ", &arg)) {
> +                       char *ref =3D NULL;
> +                       unsigned char sha1[20];
> +                       if (expand_ref(arg, strlen(arg), sha1, &ref) =
!=3D 1)
> +                               die("Ambiguous deepen-not: %s", line)=
;

With just a few exceptions, die() invocations in upload-pack.c prefix
the message with "git upload-pack:" and start the actual diagnostic
with lowercase, so perhaps:

    die("git upload-pack: ambiguous deepen-not: %s", line);

> +                       string_list_append(&deepen_not, ref);
> +                       free(ref);
> +                       deepen_rev_list =3D 1;
> +                       continue;
> +               }
> @@ -746,6 +757,13 @@ static void receive_needs(void)
>                         struct object *o =3D want_obj.objects[i].item=
;
>                         argv_array_push(&av, oid_to_hex(&o->oid));
>                 }
> +               if (deepen_not.nr) {
> +                       argv_array_push(&av, "--not");
> +                       for (i =3D 0; i < deepen_not.nr; i++) {
> +                               struct string_list_item *s =3D deepen=
_not.items + i;
> +                               argv_array_push(&av, s->string);
> +                       }

The documentation for rev-list --not says it "Reverses the meaning ...
up to the next --not", so would it make sense to add a final:

    argv_array_push(&av, "--not");

here to future-proof against some change pushing more arguments onto
'av' following this code?

> +               }
>                 deepen_by_rev_list(av.argc, av.argv, &shallows);
>                 argv_array_clear(&av);
>         }
