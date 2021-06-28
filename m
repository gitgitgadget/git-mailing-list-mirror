Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD1C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 15:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275B1619F1
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 15:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhF1P6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 11:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbhF1P6I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 11:58:08 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE59C061767
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 08:55:14 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id v3so22740246ioq.9
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ea5R9PtqcuU4yK/hU0qDv/3quYFEioR0hkc8uYEFnoU=;
        b=ew5kncU38G0Ix7YY8DglFLvtqZPexRAPLEGnZtFBBvKHZ2rvbrrciLpAbRINJklzpi
         8zwAu9KfpNTfXyACd4SgFlwGAtP5VbPQ7QieeaSMbrLFX6dYryN48tQnz8kM+hZJk6r4
         UXkruOc6ALXPgBMkQBKEtFSWlrvE+tux5Q2k15qJJCyP6/eTlne1326rYEHDq+KE2nfD
         A2S2wRggx2J0vvZezi6pEID6vmXsXeFskIMKqv0pljA2EtHnVbpoBJmwzZoyy/Zu7LaP
         HNRxoREAK/GYOOp7z3Uyokz7dBRNkmZo77sN1uFaIxQFIxG1eXZUlhG00MtyQ5b17zX3
         SE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ea5R9PtqcuU4yK/hU0qDv/3quYFEioR0hkc8uYEFnoU=;
        b=ebx+x1GIIEJSK8M1KypTqt1YTgYEsC5BZ3CCuqlxd2Rz7y+jAEAWiYiJZeE75IaRVc
         nj40HEw5yyJQ+lZbQV93zCySBN++Tgnhw67HLgTaZz726H2DeqarbnRoGeFibuW6O/jU
         soZNFzMYcJ8MSFB9XnozsgjSn42rdw8Db/NWjuzsBagK+0Yp7yrQ1UuBGsw9HhbuIgxq
         z+qZhOhFmrkR6o+FieiaBFpe+JnoV/xg9YLAoQD4G+AWx83fGFZZTTNTUFOYtkdZ6s6t
         Hmh5fWTpWistjwAJgGqoysSAm7oXjvai6ncPY5aYum2HMdXSZgRXB/F9ruI4xL5SFT2M
         Z3iA==
X-Gm-Message-State: AOAM531YOIuagfFhCAjX7MB64p7GHp9S7nXzjDA504wo3/zHOkc5BQQ8
        SPCg7yxG1CpC292dAczMxJvh0mv7PQeJtp5zTmg=
X-Google-Smtp-Source: ABdhPJyze9HS0LaPrf82CKKyY1IymD9u+VdhgOH+uoxPyCL8kGw1qxHnHSWQ6MYOBX232fp5LvtIZp25sfHpcnD21eA=
X-Received: by 2002:a05:6602:25da:: with SMTP id d26mr119740iop.106.1624895713958;
 Mon, 28 Jun 2021 08:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TLhL3MNnkB7s1J4hAQmovaUPoeydn8kepzFOT_UL83_Q@mail.gmail.com>
 <CAP8UFD0dDeL6crqqXPRd+564Z8n_EX3ctzRxKyGZFBp2SjbXEQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0dDeL6crqqXPRd+564Z8n_EX3ctzRxKyGZFBp2SjbXEQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 28 Jun 2021 23:55:01 +0800
Message-ID: <CAOLTT8SFmPVm3SAt=QO9VVAZ=2EYUBb3TToe3tv=kuQTBrXq2w@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 6
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=8828=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=885:53=E5=86=99=E9=81=93=
=EF=BC=9A
>
> > * Using Google's `gperftools`:
>
> [...]
>
> > Ignore `write`, `inflate` and `000055d9164cdc36`, the execution time of=
 `memcmp`
> > and `memmove` is very large.
> >
> > However, whether it is `git cat-file` before or after re-using the
> > `ref-filter` logic,
> > the functions they call take up similar proportions of time.
>
> Yeah, it's not clear what is causing performance issues from this. It
> may be that the issue is that with the ref-filter code more objects
> need to be fully read. I wonder if there is a way to count that.
>

Yes, maybe we need more precise time, and if it can locate the function
in git will be better.

> > * Using `perf`:
> > `perf top -p <git-pid>`
> >
> > ```
> > 12.72% libc-2.33.so [.] __memmove_avx_unaligned_erms
> > 7.39% libz.so.1.2.11 [.] inflate
> > 5.56% libz.so.1.2.11 [.] 0x00000000000088ba
> > 5.27% libz.so.1.2.11 [.] adler32_z
> > 3.46% git [.] patch_delta
> > ```
> > We can see that `memmove` is still the part that accounts for the
> > largest proportion of time.
>
> Yeah. Do you think that the code is calling memmove directly or
> through another function? And anyway which part of the code is
> responsible for these calls?
>

There is no clear conclusion yet. But it is likely to be xmemdupz, xstrdup.


> Flame graphs (http://www.brendangregg.com/flamegraphs.html) might help
> get a better idea of what happens.
>

Thanks, I will check if we can take use of it.

> > We can already come to a conclusion: A lot of the time of `cat-file
> > --batch` is used for data copy,
> > this may be the focus of our later performance optimization.
>
> Thanks!

Thanks.
--
ZheNing Hu
