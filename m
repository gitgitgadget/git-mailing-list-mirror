Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70548C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 13:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiLSNQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 08:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiLSNQc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 08:16:32 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA5260D
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 05:16:31 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so5291912oto.6
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 05:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agfAIqekB+IIxVZw+RKuBN1fcQxXri9KHycDGXFkJq4=;
        b=Gy1mL4A1qCUSnsiJnKVKlBxwe1WqWmL+BwMKboT6CKkPGt4tMvGJJAKVBzhvzpWLiy
         REmBVTnMNBN6wE6mxtk8Pz8CE5VUOO6aGcdgfBiEObaPr1Wo+3eECxpiZT3SkDLlA5j4
         xnyJG66gAN1ooC76ODqHRuNRXlwfKPf0+O/3MegFs4cyHSVYf+2ueQR0kQD45Sta+9tt
         3Sa+dEJDracEif9GtZdlI3ZHr3hBKqW7EbHwflMqoh2LtuwD6UpNYsJu2Kz95NT96zLa
         q9F3aEoo7t+iyntm8sQ3Hih4P+9Pm8zsdUrFcTpmR8eEcISoJH45tPrN8rtwiF/vf3yi
         y4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agfAIqekB+IIxVZw+RKuBN1fcQxXri9KHycDGXFkJq4=;
        b=Hyrn+MwHDc41aN84A8EoPjfLELSQonT3LJ3KecnYmI94BRMThFII3jyVu4/dcoOWCY
         4vfHQIQSKeOouGbe1/7+HcXlScC2G4KnZbV9AVY9Cyrw7qEy//u8hd4jjaFzGNA7d6XC
         SwRYTRBJoByFhq5BcljqoBpk5wypeOW28pAGpAf6xkpHYNq/IKipMdpc0wl6yZcrOlOp
         Dn+EmdIM59Vy3cR0Dustrwj7KQpd7w8BbUgqg1TvPjAsjcCmEgemGYDQyOkTQ74S+TOn
         nv6jzwzvWyaQvcolXUy3/PQcw+vhc47TSRsqhUVs2hrGdfIFYpDkRdQtaesxzroa0mDl
         R5RQ==
X-Gm-Message-State: ANoB5pmfyoKhSiIbAq6i+JCCHK/yDokPr6Fc4b3WEldnFePp213p+us9
        nhaZE0RdAh+xq1lUO7X4ZqyN9VW8gH5Oi9faNz8ADI/kAccsRg==
X-Google-Smtp-Source: AA0mqf62PGKGgZb0Piq3jlAgfEN6a7FVdwj7dJ82cN7PlUYGerL4XtH1xtVbuIM/1x66uQVxmTlEFg3Oqr08vrgeeiU=
X-Received: by 2002:a9d:550d:0:b0:66d:6909:e477 with SMTP id
 l13-20020a9d550d000000b0066d6909e477mr49937882oth.114.1671455790660; Mon, 19
 Dec 2022 05:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20221216093552.3171319-1-karthik.188@gmail.com> <221219.86359b20bc.gmgdl@evledraar.gmail.com>
In-Reply-To: <221219.86359b20bc.gmgdl@evledraar.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Mon, 19 Dec 2022 14:16:04 +0100
Message-ID: <CAOLa=ZScE7ifK2K=8RYLwdwdXafH05j7ONU1CT1rjPWgYXRZVA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] check-attr: add support to work with revisions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2022 at 10:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Dec 16 2022, Karthik Nayak wrote:
>
> > v1: https://lore.kernel.org/git/20221206103736.53909-1-karthik.188@gmai=
l.com/
> > v2: https://lore.kernel.org/git/CAOLa=3DZSsFGBw3ta1jWN8cmUch2ca=3DzTEjp=
1xMA6Linafx9W53g@mail.gmail.com/T/#t
> >
> > Given a pathname, git-check-attr(1) will list the attributes which appl=
y to that
> > pathname by reading all relevant gitattributes files. Currently there i=
s no way
> > to specify a revision to read the gitattributes from.
> >
> > This is specifically useful in bare repositories wherein the gitattribu=
tes are
> > only present in the git working tree but not available directly on the
> > filesystem.
> >
> > This series aims to add a new flag `-r|--revisions` to git-check-attr(1=
) which
> > allows us to read gitattributes from the specified revision.
> >
> > Changes since version 2:
> > - Changes to the commit message [1/2] to use more specific terms and to
> >   be more descriptive.
> > - Moved the flag's position in the documentation to be before the unbou=
nd
> >   list of non-options.
>
> Aside from the UX concerns with this series, this segfaults with it, but
> not on "master":
>
>         ./git check-attr diff git-send-email.perl foo.perl git-send-email=
.perl
>         AddressSanitizer:DEADLYSIGNAL
>         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         =3D=3D1828755=3D=3DERROR: AddressSanitizer: SEGV on unknown addre=
ss (pc 0x0000008ee4a8 bp 0x7fffe4cef820 sp 0x7fffe4cef800 T0)
>         =3D=3D1828755=3D=3DThe signal is caused by a READ memory access.
>         =3D=3D1828755=3D=3DHint: this fault was caused by a dereference o=
f a high value address (see register values below).  Disassemble the provid=
ed pc to learn which register was used.
>             #0 0x8ee4a8 in hasheq_algop hash.h:236
>             #1 0x8ee632 in oideq hash.h:253
>             #2 0x8ee657 in is_null_oid hash.h:258
>             #3 0x8f79e2 in do_oid_object_info_extended object-file.c:1550
>             #4 0x8f8206 in oid_object_info_extended object-file.c:1640
>             #5 0x8f860c in read_object object-file.c:1672
>             #6 0x8f8a8a in read_object_file_extended object-file.c:1715
>             #7 0x8f01ef in repo_read_object_file object-store.h:253
>             #8 0x8f8e37 in read_object_with_reference object-file.c:1756
>             #9 0xafb411 in get_tree_entry tree-walk.c:612
>             #10 0x6d1975 in read_attr_from_blob attr.c:776
>             #11 0x6d1b80 in read_attr attr.c:826
>             #12 0x6d1f35 in bootstrap_attr_stack attr.c:912
>             #13 0x6d2173 in prepare_attr_stack attr.c:948
>             #14 0x6d3285 in collect_some_attrs attr.c:1143
>             #15 0x6d33e1 in git_check_attr attr.c:1157
>             #16 0x453581 in check_attr builtin/check-attr.c:72
>             #17 0x453f1f in cmd_check_attr builtin/check-attr.c:190
>             #18 0x40b63d in run_builtin git.c:466
>             #19 0x40bf7f in handle_builtin git.c:721
>             #20 0x40c686 in run_argv git.c:788
>             #21 0x40d42f in cmd_main git.c:926
>             #22 0x6885b5 in main common-main.c:57
>             #23 0x7f96725a8189 in __libc_start_call_main ../sysdeps/nptl/=
libc_start_call_main.h:58
>             #24 0x7f96725a8244 in __libc_start_main_impl ../csu/libc-star=
t.c:381
>             #25 0x407230 in _start (git+0x407230)
>
>         AddressSanitizer can not provide additional info.
>         SUMMARY: AddressSanitizer: SEGV hash.h:236 in hasheq_algop
>         =3D=3D1828755=3D=3DABORTING
>         Aborted
>
> If the tests are still passing for you (I didn't check) then we probably
> have a bad test blind spot with kthat we should start by addressing
> before adding the new feature.

This seems to be what Junio mentioned here:
https://lore.kernel.org/git/xmqqcz8ikgxs.fsf@gitster.g/
Should be fixed in v4!

--=20
- Karthik
