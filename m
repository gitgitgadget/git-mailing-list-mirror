Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C11C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FBD650E5
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhCIRsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 12:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCIRr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 12:47:57 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F68C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 09:47:57 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id u62so50401oib.6
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 09:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZAwGFWSo3qheBss59SIZDurAPLUnNX5PzigIIT2ELRQ=;
        b=dVW+ryovgws2fyUkAmCgxmRwcNlEVYdg919VX5xho+iwcOw3sGbS+FebFLECzGYyL5
         i+iSMVNAUBCHH6EoqxxI1DA+y+IwDpNxaCqvf0pe0eydo2mwed04MiHS17Y5tjjJA1D/
         y3G7Wi79RoLEOPPDuBXH8cfKRANS7jtZO/j2VX7AjLxNfWH7nA3uaFHTBioDNBOlxhuk
         bqSwpRO/k21Gv0ukK+RJwdp/SJ8jj/Y8bA6ftj+67rvwJmj8aZZxGhuclLD1dttAgsDX
         hyQrs9V+nkERQ+fZsCawJLt/hjMQM18yu3EyjCF8dPB0oMxZ7wSkBfVhiVcWHYPOXZZ9
         b1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZAwGFWSo3qheBss59SIZDurAPLUnNX5PzigIIT2ELRQ=;
        b=a0yQ4D5/EB4GhXUsBDBjDvY+MMH0ksYxynpk8F7xs5SOSfYb6NPtZMS+hmr9DzbCw6
         9HwASyQzEJ3Dpz3X0PiQ80k9hI+CYwM4iEdJkuhAHTd+Q3KTkBlo6Yiq53/T4qVwTGbP
         Ommc7FwWB+jtRbUZIuZRM9iZTPVrRxZZLIngywf/sRCdrwiew1Nj4n3Cn8DviKdCeMrI
         VAuhfX4taeOkk0bCnaRYy3Ssbh2Q18ddDtLePTzwIns5oO68I6/B+EUbTle0H3QbLwD3
         o7eS0cLY2v7MPeh2CCOKzmXVOF80ms+VLtHs1HZNzGz445dZ1DXaLjfHCnsGcKFiqUmw
         WZhA==
X-Gm-Message-State: AOAM533F/MEy3u26kuvccnV9vpOd9H9njkF8Vui/KTQTGsy9d8FpFs+t
        qDNDPc5qyWHyVj3p1FDCFROiU+lkbNvuYGE15hKwoPchLCE=
X-Google-Smtp-Source: ABdhPJyvH5MfwlstFuH/smPwKsQVC4B2/gJj9zGbiDL43sX5ktlHgf60GouDq611gmIrjRZKgpFh3EnU/rSv/mst+8E=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr3643169oij.167.1615312076928;
 Tue, 09 Mar 2021 09:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-22-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-22-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 09:47:45 -0800
Message-ID: <CABPp-BE+wdDK3OSWooUKLBVZA=bfRm3P6XWWTEFSSXj=yk0ZLg@mail.gmail.com>
Subject: Re: [PATCH 21/30] tree-walk.h API users: use "tmp" for mode in shift_tree_by()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:

Since there's only one API user, shouldn't the subject be
"match-trees: use tmp..." instead of "tree-walk.h API users: use
tmp..." ?

>
> Refactor code added in 85e51b783c3 (Make "subtree" part more
> orthogonal to the rest of merge-recursive., 2008-06-30) to make it
> obvious that we don't care about the "mode" here outside of the if
> statement it appears in.
>
> That's opposed to the sub1 & sub2 variables, where we use the two
> object ids later in this function.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  match-trees.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/match-trees.c b/match-trees.c
> index ba4aabf39d1..4f02768c01e 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -317,17 +317,17 @@ void shift_tree_by(struct repository *r,
>                    const char *shift_prefix)
>  {
>         struct object_id sub1, sub2;
> -       unsigned short mode1, mode2;
> +       unsigned short tmp;
>         unsigned candidate =3D 0;
>
>         /* Can hash2 be a tree at shift_prefix in tree hash1? */
> -       if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &mode1) &=
&
> -           S_ISDIR(mode1))
> +       if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &tmp) &&
> +           S_ISDIR(tmp))
>                 candidate |=3D 1;
>
>         /* Can hash1 be a tree at shift_prefix in tree hash2? */
> -       if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &mode2) &=
&
> -           S_ISDIR(mode2))
> +       if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &tmp) &&
> +           S_ISDIR(tmp))
>                 candidate |=3D 2;
>
>         if (candidate =3D=3D 3) {
> --
> 2.31.0.rc0.126.g04f22c5b82
