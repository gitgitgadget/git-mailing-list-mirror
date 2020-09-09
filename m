Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6F3C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E86421D46
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7+rHNYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIIRs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIIRsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 13:48:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F08FC061757
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 10:48:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b16so1712714pjp.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 10:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hR5XAN9mITz8/V9CtbLTBoQvte+cdht8ZNTerhNj9uM=;
        b=A7+rHNYneQ22fdOGFUoX67eCdisNvtLEMKGhtZlnbj/ww3H0eNoti/NsJ0QhIzTmE4
         HCVmUqDOcvsBehdwYizZnonK45mHEwevRlq4tjvMNMQCYSTGv16BLfbinye/MLNiLnBR
         +rjvAjr9uFmrZletc8278kTPvGbNC2VEx6+QtATW/0+T2kDfwf1IDKAsDP3XtEBFFnCz
         gASdSSySKXEMMx0rq+yV+W1a0euKB+WXCun6bY/c+iRyf1PYKudQs1KycCeL+aXJ5n7S
         Nevy0GLJ7HiF4jTM8LE1N7cGfMjNMyz8rzxqe+krSk3tPmrXjJj+ShaL9SYd5GZwIcRi
         XlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hR5XAN9mITz8/V9CtbLTBoQvte+cdht8ZNTerhNj9uM=;
        b=ZrjjIHf/P7iMOecp299gIXoKOatec5JdSHL3DrNkFxADgI2AOZ/7B6mPh70yM2mTLG
         40n+cWXnnoT2xfP+CMYgQTIxvfcRVYz1dO75J25E8Sks3eBOuC47QQRWemNjIJuBLatH
         ZdZGK4P4vRxcwaLBIjb5PY11TVIdrUUdgEosOkdVXWkFn2VQqud0c87cFLwIpfPnparp
         2VF2sJgJkfv56XQcwovLYn7PLWj2ltmyiFr+Pyk+8PdPEkV1AAe18ul+xmJMD2GhAw1b
         Wddi4+ojfVmp05Kobn2ftmn5ilkEiiK+rLC6HI9SxA/T3lgrJwILVxT+sxB193QFPE0q
         JXQg==
X-Gm-Message-State: AOAM533Ho5w5FjIbsLwcFASX+l/wi+/+4hkhHg3uOgFkSv6KTPqNZyd0
        U2st8cnXuhcFDb5R5CI+tDykWZL0i63R/FHz3u5qdtNHyc0t/g==
X-Google-Smtp-Source: ABdhPJwmVACer+cDvEMA1rEBUkWKQrnEoiEx27qjAAiymjLF4qvSeuE/q1IUFMLefxJ1QeK5E9NN4CoM8FqJ8EQLh78=
X-Received: by 2002:a17:90b:208:: with SMTP id fy8mr1766950pjb.153.1599673704588;
 Wed, 09 Sep 2020 10:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200907171639.766547-1-eantoranz@gmail.com> <ce94b41f-e829-d7ca-a5f5-e41748caea81@gmail.com>
 <20200909091149.GB2496536@coredump.intra.peff.net> <CAOc6etZS3mGxsPPh25XFi2-qR0TNzq0Gx1NrydgQwmHbsjxejA@mail.gmail.com>
In-Reply-To: <CAOc6etZS3mGxsPPh25XFi2-qR0TNzq0Gx1NrydgQwmHbsjxejA@mail.gmail.com>
From:   Jeff Smith <whydoubt@gmail.com>
Date:   Wed, 9 Sep 2020 12:48:13 -0500
Message-ID: <CAPX7N=5wRZbwWzzKmqyQGswJDFDf-DWq56pBPMSx4=fEuisskg@mail.gmail.com>
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I haven't had a chance to look at the cocci script, but I did have one
thought...

Derrick pointed out, 14438c4 added both oideq and hasheq.
It might be good to have a similar check for hasheq, if there is not
one already.

On Wed, Sep 9, 2020 at 9:01 AM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> On Wed, Sep 9, 2020 at 3:11 AM Jeff King <peff@peff.net> wrote:
> >
> > Yeah, it looks obviously correct. I am puzzled why "make coccicheck"
> > doesn't find this, though. +cc Ren=C3=A9, as my favorite target for
> > coccinelle nerd-snipes. :)
> >
>
> I added this to contrib/coccinelle/object_id.cocci in v2.27.0
>
> @@
> identifier f !=3D oideq;
> expression E1, E2;
> @@
> - !oidcmp(E1, E2)
> + oideq(E1, E2)
>
> And it found it:
>
> $ cat contrib/coccinelle/object_id.cocci.patch
> diff -u -p a/blame.c b/blame.c
> --- a/blame.c
> +++ b/blame.c
> @@ -1352,8 +1352,7 @@ static struct blame_origin *find_origin(
>        else {
>                int compute_diff =3D 1;
>                if (origin->commit->parents &&
> -                   !oidcmp(&parent->object.oid,
> -                           &origin->commit->parents->item->object.oid))
> +                   oideq(&parent->object.oid,
> &origin->commit->parents->item->object.oid))
>                        compute_diff =3D maybe_changed_path(r, origin, bd)=
;
>
>                if (compute_diff)
>
>
> Do I need to add more things into the coccinelle definition so that it
> is more restrictive in terms of the
> expression we are hunting down?
