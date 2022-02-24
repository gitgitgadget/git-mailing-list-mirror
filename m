Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813AAC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 06:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiBXGJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 01:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiBXGJY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 01:09:24 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C1A268379
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 22:08:54 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id i11so2119015lfu.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 22:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NlXYS1/sLIg94Ywx2eiw6xTs1hCXbv2lftqTnoD5dk8=;
        b=XoEIJaXLinS9yCvrd/OkVl3m8qrKi1T8EvSRMNBl1faWNVPHRiIKpjneO0580bRl6e
         sJsugjqVDwlrm6Hj2zIvVB7a1vtZrl4Rfg68rZEyiALDe0m82MMrVRn9hMRLUqFvNdAk
         KI9paEM29+quhXgSgjEpqiplQTDl2NWeeyBCJ12IvKQstculxmJrOEXwOeAlEbRnheTx
         eKqNTwxgi9+3T21FJOquHYeA/KyBHqAINJqc2hX5qoHWyuFjk3g1m0hnI09Rdh4fhoLd
         JqAth7sMpurh+tomS1NYsuYYbY/xSwNUI2nppsk9fkd9P+1ArJ4jvxYbaKkXLmj7NMjn
         d2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NlXYS1/sLIg94Ywx2eiw6xTs1hCXbv2lftqTnoD5dk8=;
        b=6graukEe38OcC7l4xPvuyVBLEBSlHcBm7fod79PNWh0L9hzkxIjy6NXExFoBJjJjFA
         u7ElauZW0D+b72sIu2QhWmcNMvVfr9KKEzCz5QTbzWU121OA6ItchCLR8QsClkhbbiEP
         bnEDtwID+S2uOw1IWNA898FuBtYgGTmUmBNCFyQOeufBqhp9rYsxlC/V5/mCPZ3lTGbz
         B0H/ZHYX4hit6VOXZZP3XSaycLfCpBNhO5iEFjx7yI/wmxSqQihqw/vaMP+j+rQDM/3R
         3/P4AcIf4bqWpRrsf92fZr2Ei/kaGuzsQk7/uwCk7woTi21c1wQXau1yi0RCZGMh0Amx
         CXXQ==
X-Gm-Message-State: AOAM533+6yQ4HPSlcznF771nUEXn3DtopfZbLH8Hh8cZQ5yGil7O38TK
        7Z7MUMKdsi14MWuOdjG8Izk4MLvvFVjxbfa4sqI=
X-Google-Smtp-Source: ABdhPJxX2YSNLwyUihXg0v5Saxu/F1hH8US7nZWEgU5zRyjw074ZdbAUb6ZJ+JpvHRMw+IzxmhWvbjxzFjVb75nMTj4=
X-Received: by 2002:a05:6512:3f94:b0:443:5d1d:55a2 with SMTP id
 x20-20020a0565123f9400b004435d1d55a2mr863034lfa.213.1645682932082; Wed, 23
 Feb 2022 22:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20220223073125.640133-1-alexhenrie24@gmail.com>
 <xmqqwnhlp4h1.fsf@gitster.g> <CAMMLpeQWjs0C4VwfpzOhZvY0Tm2YTnC74tyUeBG9bBzsNA42_w@mail.gmail.com>
 <220224.861qztazyi.gmgdl@evledraar.gmail.com>
In-Reply-To: <220224.861qztazyi.gmgdl@evledraar.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 23 Feb 2022 23:08:41 -0700
Message-ID: <CAMMLpeRuRABj5014rZ00yXnenky_SYWjqgM0WTvxaqLz=10XTQ@mail.gmail.com>
Subject: Re: [PATCH] switch: mention the --detach option when dying due to
 lack of a branch
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 5:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> I think another thing that needs updating here is the
> Documentation/config/advise.txt.
>
> I.e. it explicitly says this is advice we emit *after* we've switched to
> a detached head, instructing you how to proceed.
>
> But here you're adding another message guarded by that
> ADVICE_DETACHED_HEAD which doesn't fit that description, but is rather
> suggesting that you may want to use the --detach option.
>
> After you use the --detach option you'll get the existing (and described
> by the docs) ADVICE_DETACHED_HEAD message.
>
> The two things we could do is to adjust the docs and use
> ADVICE_DETACHED_HEAD for both, or to add a new
> ADVICE_SUGGEST_DETACHED_HEAD category with a new
> advice.suggestDetachedHead config.

Of those two options, I'm guessing that creating a new config option
is going to be more acceptable. I'll do that in v2.

> Also, you say "doesn't work", so is this about to die() after this
> advice is printed? What does the complete output look like then? Usually
> we'd emit the "die" message before the advice message
>
> *reads the surrounding code a bit*
>
> Ah, so yes, we'd do that in that order now.
>
> I think we'd like to instead use die_message(), followed by an optional
> advise(), followed by exit(). Maybe like this?:
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index d9b31bbb6d6..22cf9d6ad1b 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1397,23 +1397,32 @@ static void die_expecting_a_branch(const struct b=
ranch_info *branch_info)
>  {
>         struct object_id oid;
>         char *to_free;
> +       int code;
>
>         if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, =
&to_free, 0) =3D=3D 1) {
>                 const char *ref =3D to_free;
>
> -               if (skip_prefix(ref, "refs/tags/", &ref))
> -                       die(_("a branch is expected, got tag '%s'"), ref)=
;
> -               if (skip_prefix(ref, "refs/remotes/", &ref))
> -                       die(_("a branch is expected, got remote branch '%=
s'"), ref);
> -               die(_("a branch is expected, got '%s'"), ref);
> +               if (skip_prefix(ref, "refs/tags/", &ref)) {
> +                       code =3D die_message(_("a branch is expected, got=
 tag '%s'"),
> +                                          ref);
> +                       goto out;
> +               }
> +               if (skip_prefix(ref, "refs/remotes/", &ref)) {
> +                       code =3D die_message(_("a branch is expected, got=
 remote branch '%s'"),
> +                                          ref);
> +               }
> +               code =3D die_message(_("a branch is expected, got '%s'"),=
 ref);
> +               goto out;
>         }
> -       if (branch_info->commit)
> -               die(_("a branch is expected, got commit '%s'"), branch_in=
fo->name);
> -       /*
> -        * This case should never happen because we already die() on
> -        * non-commit, but just in case.
> -        */
> -       die(_("a branch is expected, got '%s'"), branch_info->name);
> +       if (branch_info->commit) {
> +               code =3D die_message(_("a branch is expected, got commit =
'%s'"),
> +                                  branch_info->name);
> +               goto out;
> +       }
> +       BUG("unreachable with '%s'", branch_info->name);
> +out:
> +       /* advice here */
> +       exit(code);
>  }
>
>  static void die_if_some_operation_in_progress(void)
>
> But that's probably a lot less nasty if die_expecting_a_branch() is made
> to call a helper that just does a "return die_message()" with a "return
> 0" fallback, and on "0" we call BUG(...).

The same thing can also be accomplished with "else if" instead of
"goto". I'll move the advice to after the error message in v2.

Thanks for the feedback!

-Alex
