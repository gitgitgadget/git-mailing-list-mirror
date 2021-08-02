Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EF8C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 06:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E15461042
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 06:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhHBGZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhHBGZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 02:25:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7387C06175F
        for <git@vger.kernel.org>; Sun,  1 Aug 2021 23:25:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id nd39so29129170ejc.5
        for <git@vger.kernel.org>; Sun, 01 Aug 2021 23:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNutrbJV482QZPi3KeDs9r6UV4ho/TxxWWd3yqeY2fs=;
        b=SEpRYBVp269cYoNVFlp4jsp+kfxSiJ15xFDZzudJwso+ZS16KP/GD2uxkovOvAupk3
         IS/qEVbX1SIPkuMwvP8omIbGhT+dUQ+8UdHQ0wcQ1dIDIkvS6s1T4YnqA6z0JUwSy/hj
         Xbt+3Z1OmJsnfqY/uYhxd6qL7F/iLR1BLfJHKTiSacmMfii+7Uj86ddaZJH5vdI0/j+2
         rM31Jk8aM138rMJYXJ87RlRqGJk6l88PcHKN9yHWmL08XzKKdWMH4OXx/Dau5Nr3uY6Y
         UwyPKhT3et8A9EEiT+aUo+rhvrhVs5bgbP9cfe356+VdJJztYlFRMxS/3mo6h+KFUijj
         7MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNutrbJV482QZPi3KeDs9r6UV4ho/TxxWWd3yqeY2fs=;
        b=VykxEXgVeL90hcIxPHSC2IdXRE25iiaFs/CanjDfpc73BCeBOopyPqIv6I+zu3UDc3
         15vJR7XtkN6Ixe+bwuWWO3dtopYqgD+pwQvtnIZ/nDyd4BSK2PDEKrIiivI8eespJzUi
         oOalMSJP3JypuyvJ/HAFS1ohBAM5m74V26JyZpns47d2NutzHd/RPeijrh1CKJYfEp5V
         idx5F38fiSmRcbbNCWm8rAXTC4g+G7cWXiE8a4uCMHOEIZbzWgwBnvVubmR6B9FS25Rs
         ScZYRwIT3ohdorxtOSCqcpd9scfAVh0kdqNRlgFfzm7PyfK7kbEN0i6nuW8ZLEl47IpU
         NLOQ==
X-Gm-Message-State: AOAM533Q/MfOk5VLvKbP6Ahtqgv6vDGQbgY6I8f3IPbJFaWdY/w1IyHf
        jS6UfyxzOEJ6tO1gZyK1L/bUUsi8Kjsv1SI8zdY=
X-Google-Smtp-Source: ABdhPJw8Tacz/Mvosz3uWcTRhfkWZdkAFQjYLcin/+18sztt0QRNIB54jiW3zm4pgl4KXGcMSxHIlPAGw6r/hieb2fc=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr5160136eje.341.1627885546394;
 Sun, 01 Aug 2021 23:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RwwMF07f=XxWN=zGsPU0VQ8FqPVdyepQp78Ei8WZpSrw@mail.gmail.com>
In-Reply-To: <CAOLTT8RwwMF07f=XxWN=zGsPU0VQ8FqPVdyepQp78Ei8WZpSrw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 2 Aug 2021 08:25:35 +0200
Message-ID: <CAP8UFD16pqERdF4Mdq=_ktvFB1rcXwB9PRy8TjNq=ThH5HbeqA@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 11
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 1, 2021 at 8:45 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> My eleventh week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Blog-11/

Great, thanks!

> ### Attempt to optimize performance
>
> This week, at the prompt of my mentor Christian, I used `gprof` for some
> performance tests about `git cat-file --batch`:
> [Re: [GSOC] How to improve the performance of git cat-file --batch]
> (https://lore.kernel.org/git/CAOLTT8TdL7UhfVSOzbpmo-WFNrcKwmy=E720tNt4KM9o_p=keg@mail.gmail.com/)

[...]

> Here is an amazing fact:
>
> The number of calls to `lookup_object()` before and after using my
> patch are 0 and
> 522709 respectively. Therefore, I am very surprised, why do we have
> these additional calls?

> After printing the call stack of `lookup_object()`, we can know that
> the `parse_buffer()`
> is calling them.

s/the `parse_buffer()`/`parse_buffer()`/

or

s/the `parse_buffer()`/the `parse_buffer()` function/

Also: s/them/it/

> A very straightforward idea, can we avoid calling
> this function?
>
> In `parse_object_buffer()`, `parse_blob_buffer()`, ``parse_tree_buffer()`,
> `parse_commit_buffer()`, and `parse_tag_buffer()` parse the object

s/parse/we parse/

> data, and then store
> it in `struct object *obj`, finally return it to the caller.

Maybe: s/finally/and finally/

> `get_object()` will feed the `obj` to `grab_values()`, and then
> `grab_values()` will feed the
> `obj` to `grab_tag_values()`, `grab_commit_values()`, which can fill
> the object info in `obj` to
> implement some atom, e.g. `%(tag)`, `%(type)`, `%(object)`, `%(tree)`,
> `%(numparent)`,`%(parent)`.
> It is worth noting that `%(objectname)`, `%(objecttype)`,
> `%(objectsize)`, `%(deltabase)`, `%(rest)`,
> `%(raw)` are did not appear in them, this means that we can avoid

s/are did not/don't/

> parsing object buffer when we
> don't use those atoms which require `obj`'s information!
>
> After some processing and adaptation, I made the patch which can skip

s/the patch/a patch/

> `parse_object_buffer()`
> in some cases, this is the result of the performance test of
> `t/perf/p1006-cat-file.sh`:
>
> ```
> Test                                        HEAD~             HEAD
> ------------------------------------------------------------------------------------
> 1006.2: cat-file --batch-check              0.10(0.09+0.00)
> 0.11(0.10+0.00) +10.0%
> 1006.3: cat-file --batch-check with atoms   0.09(0.08+0.01)
> 0.09(0.06+0.03) +0.0%
> 1006.4: cat-file --batch                    0.62(0.58+0.04)
> 0.57(0.54+0.03) -8.1%
> 1006.5: cat-file --batch with atoms         0.63(0.60+0.02)
> 0.52(0.49+0.02) -17.5%
> ```
>
> We can see that the performance of `git cat-file --batch` has been a
> certain improvement!

Yeah, sure -8.1% or -17.5% is really nice! But why +10.0% for
`cat-file --batch-check`?

> Tell a joke: removing 1984531500 if checking can reduce the startup
> time of GTA5 by 70%. :-D

s/if checking/checks/

As this joke refers to:

https://rockstarintel.com/a-fan-reduces-gta-online-loading-times-by-70

it might be nice to add a link to help people like me who didn't know
about this and had to google it.

> Currently the patch has not been submitted to the mailing list, let us
> wait a bit...

Looking forward to it...
