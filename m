Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2692C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 04:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3420159AbiAYECY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 23:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3417394AbiAYCHw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 21:07:52 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5024EC04967B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 17:59:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id n10so44324998edv.2
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 17:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3vRNUhv6DOi6EnrDhUfDJNcqZ8oaayWJvRoHHiaWEtc=;
        b=YuRvLKb2J3yvTKXgCNFd7v/LRkuM2Quvs0NmMxwMLeojzJXII7lRVVWmu6Fr6AWCEt
         LbBnYD4wZeaagb+e5ba/ypgwjb+VToUcQOAZpplK0aJXSnU6vy0XJl9MGzVkT1m2gBZi
         qj5jM+pWhLzKxesRcsws+SSGPoMM1ZPXgo4VJKvChzf0tJXijYq/Ya5/5QSrCiV8yuLA
         0sjAT/RZ/RScXYJO925G/yvCnpfVGKbeV3TRLzWZxyPoG0n87Sdh/5JHQcO8NFdz3/gr
         ZsIRtXzX0Ch+3+hWjxs1n9DMgImTzjHvskffD8562Big3TVXvB2ZhhL/TltI+pXVKPmP
         I5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3vRNUhv6DOi6EnrDhUfDJNcqZ8oaayWJvRoHHiaWEtc=;
        b=QajRDG/EkyJU3ZxEvpsUwLj+Ud/QlT1g+yCD1Z/mR5hHEqw8RtHTHTnWhqS94KRrKg
         wCPOa8Vl15DUFl1CVYBJNsY0+4H5DHbqNmoxNrobj0DoAao7/cYHYyAMMfhHVbfvus4a
         g7D7J+Aozrg7/cWdT6MKlMD/I/sFkvraZzcqPG94xcMWWdfjQQSmchbHemDxLNRsGy8u
         +MsIi/xgXmzTO9WD3gKjIwFUU5MRX+gOqihnUVrUf3C8XdbUkayiXDDzfGcLBFvSW6k0
         Wjo2qHWIAxWAfrat2e3dbEoxYxYLvU29QyETudLPbg9f8OKLNfie39ZVd3cF/A6JpzJq
         +47g==
X-Gm-Message-State: AOAM533IvFkmVx+JdyPxBCveSHNs1QBIc2qqe8jGcIrzzJny9rIOm69R
        RH6NW5kYB14uihuNQYGb4MKa0CVR/IqApZI9oJsKjekcBKM=
X-Google-Smtp-Source: ABdhPJzjqjatUbzPEt+0lsNM4gdZjZk06sie2l/nKRdJbWI/YgzQyWSP+XcRq8hALaGS1AnDtpM9ZK9HppnJdUgXX+w=
X-Received: by 2002:a50:da48:: with SMTP id a8mr18107538edk.146.1643075968841;
 Mon, 24 Jan 2022 17:59:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <095aa266c2bfdda47ed722fbc5a0d9c94132fbf1.1642888562.git.gitgitgadget@gmail.com>
 <220124.86czkhihcu.gmgdl@evledraar.gmail.com>
In-Reply-To: <220124.86czkhihcu.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 24 Jan 2022 17:59:16 -0800
Message-ID: <CABPp-BFcFt2GqsGi57dn6vWNqdnF+_Rt0BgpAWgD=taXWAS9AA@mail.gmail.com>
Subject: Re: [PATCH 05/12] merge-ort: split out a separate display_update_messages()
 function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 2:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Jan 22 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> > [...]
> > +     /* Hack to pre-allocate olist to the desired size */
> > +     ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
> > +                olist.alloc);
>
> Perhaps just add a string_list_grow()? But I wonder if this is really
> needed v.s. just using the default growing pattern here.

A string_list_grow() would probably be helpful to add at some point;
then it could also be used in process_entries().

> > +
> > +     /* Put every entry from output into olist, then sort */
> > +     strmap_for_each_entry(&opti->output, &iter, e) {
> > +             string_list_append(&olist, e->key)->util =3D e->value;
> > +     }
> > +     string_list_sort(&olist);
> > +
> > +     /* Iterate over the items, printing them */
> > +     for (i =3D 0; i < olist.nr; ++i) {
> > +             struct strbuf *sb =3D olist.items[i].util;
> > +
> > +             printf("%s", sb->buf);
> > +     }
>
> Shorter/nicer:
>
>         for_each_string_list_item(item, &olist) {
>                 struct strbuf *sb =3D item->util;
>                 puts(sb->buf);
>         }

How did I not know about and not find for_each_string_list_item() when
I was writing this code a couple years ago?  (and still didn't learn
of it until now?)

Thanks for the pointer.  Won't change anything right now, though, since...

> > -     if (display_update_msgs) {
> > -             struct merge_options_internal *opti =3D result->priv;
> > -             struct hashmap_iter iter;
> > -             struct strmap_entry *e;
> > -             struct string_list olist =3D STRING_LIST_INIT_NODUP;
> > -             int i;
> > -
> > -             if (opt->record_conflict_msgs_as_headers)
> > -                     BUG("Either display conflict messages or record t=
hem as headers, not both");
> > -
> > -             trace2_region_enter("merge", "display messages", opt->rep=
o);
> > -
> > -             /* Hack to pre-allocate olist to the desired size */
> > -             ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
> > -                        olist.alloc);
> > -
> > -             /* Put every entry from output into olist, then sort */
> > -             strmap_for_each_entry(&opti->output, &iter, e) {
> > -                     string_list_append(&olist, e->key)->util =3D e->v=
alue;
> > -             }
> > -             string_list_sort(&olist);
> > -
> > -             /* Iterate over the items, printing them */
> > -             for (i =3D 0; i < olist.nr; ++i) {
> > -                     struct strbuf *sb =3D olist.items[i].util;
> > -
> > -                     printf("%s", sb->buf);
> > -             }
> > -             string_list_clear(&olist, 0);
>
> Ah, at this point I see you're just moving code around :) Sending this
> anyway in case it's useful :)

yep, so I won't change anything now, but yes th
for_each_string_list_item() tip is still useful as a heads up.
Thanks.
