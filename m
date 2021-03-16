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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39534C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 06:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CFD6521A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 06:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhCPGfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 02:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhCPGew (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 02:34:52 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9872BC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 23:34:51 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id j10-20020a4ad18a0000b02901b677a0ba98so3865733oor.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rQf7V4Q60GmtUO6RpoJbUaOHYxo+B0fUy/ynsiB7x44=;
        b=ZXO4VMBu2vCUJomJ9bJkYmhBr6Hi64qYQP6f5nhIR0PfhYyWJdLp18cWRaqnxJL8Hw
         GOvKLK6yg9rZNH/Bm03b7Jf8MCKWIPx85pJCN5HaSM8T2mGiTXcF9/NU2Qzcb/R64c75
         +cVJpH4mrp9gV+PKS5DZ8nMm+7tNjAaiiZjeLNE5gMC4SqO2Rcs8Os27bIvUtBwyU1CK
         cq51xnvOlXolTx0laBq8l7eqCHfGbGQrPwF6Y/pX3wGzbMzfWlYs8FxWD2hvJs5bXy3B
         LQVa2pZDPOvl30MMOmd25bc/URvVbSGqSaLaCjRJO+TE0/PhFqRbtFYVZeWRkdfcWdk0
         VWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rQf7V4Q60GmtUO6RpoJbUaOHYxo+B0fUy/ynsiB7x44=;
        b=DBF3levfQLMSnvHk1OtF8Kds1ZjbAMD8mCGVFbu2YmCe1m0QDuxQZn3H+sV7V4LKFg
         WtuFFVB4qnc/A9ppN6rV5X4vd2EXHMJEALZxZASP3v9k+PY5c4namqFTtR90oa59fD4X
         ZiK80XlS41yzgFmcjeOwIKcwP31FYS2k+ECF8QZzonXg9DckKUc9h4I18k6WCywl/YTH
         OzoX2yRDJmrQPU+IdG2X2RkdBgBP23Wwi89n0+BhM+SHxR0JCo1DbjK9fpDULHp61CVp
         Q8fVSuQTO5hn5WJ6VoCZBgGdYlNrhyV1LdWgJ0vXibmIrZ0rKyRqjkoMFuZg3j8x1etY
         Df1g==
X-Gm-Message-State: AOAM532ujiE2MQfHiLpaMpaJGba1ytgy+vf592knS6X//m6isXvwTPQC
        7BeCAyFUcK1xHXDjdNGPfkd3+En7DwQc1rPa818=
X-Google-Smtp-Source: ABdhPJwKiwuW1B1Zchl7wMQGQtBH+PprIdq1mHR8i9Y6CpBOZrulaeeSY4EWcxc60jMxRTDgqsCRsZH6ExX9SW5aDr0=
X-Received: by 2002:a4a:eb8a:: with SMTP id d10mr2418228ooj.32.1615876490887;
 Mon, 15 Mar 2021 23:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210308150650.18626-1-avarab@gmail.com> <20210316021312.13927-22-avarab@gmail.com>
In-Reply-To: <20210316021312.13927-22-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Mar 2021 23:34:39 -0700
Message-ID: <CABPp-BHT0O+o=V1CCgJYkdL7ZYYTpUbXZ6iKRCYoi402-3W9zw@mail.gmail.com>
Subject: Re: [PATCH v2 21/29] tree-walk.h API users: use "tmp" for mode in shift_tree_by()
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

On Mon, Mar 15, 2021 at 7:13 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

As with the previous round, why do you have the subject as "tree-walk:
..." instead of "match-trees: ..." ?

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
> index 0faacd8f4ae..e84f993a460 100644
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
> 2.31.0.rc2.211.g1d0b8788b3
>
