Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19F4C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiDMTSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiDMTRz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:17:55 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DE21ADB1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:14:25 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id l6-20020a637006000000b003811a27370aso1567885pgc.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=6p7uLvwCvGwVWDrW9L2O7oRaf3+V1YXuxQ7Entvdic4=;
        b=hdUOlnXEPV0yw/GcvpJ3FImXB30VJsa7MEmvstWUn5tHSPe8bAhuSanJYoPuVP8phY
         qJVPCkz2ZJFnTagnXuCVXsJP247q8ST3DjHFeJvgG3FspWtAKCPkvbWKjcAFYjyKLWgr
         Kj+n8FRhDgdVnjdozAUBlum6MmAJdXjKfHH78RMs+J7LL+ddm43NPQjn06yTN0+3OQ7D
         kuN4Z2rtaL+vQt+yoTvPcaUPJUXkXC3rTaKTNYTFAynOCOXzfDZFZCYOQBuT/kwfgaEb
         AACnRhURWzA0w8RzdM5eneNn5rXpgoddZqgufmQ3/KDRPAX+CmI3EvVe5YyY9z0K5mKW
         isgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=6p7uLvwCvGwVWDrW9L2O7oRaf3+V1YXuxQ7Entvdic4=;
        b=i4FD0ffDTmNibG0gUzk1WG8RRHUUeHtQtfTNY7NU5U9Jyd1j2QOsKKeERkGBkpWJpb
         35dIeCJBOpnvqPDwqMQx2uF5UlZCTIg2HEOb8Afivk5S5OftwaX6vCAFpzgEit48QATO
         SwhHQGpiK7QdAO9sgHnov4EauVZt3swN7w0Fpu64jmJWgTQmRzIoyliOJ8XPkj/PHcmi
         fIJ2+l831/7KPj9asOjUfdHz01BgMJDOlCWFXzV0BMX0VmdF4QID8rgLhtU4AqmORLw8
         cEaH+jeqHSGR+PWlll0eXXtiZUokpTh1UnJxfAxjO5Fp95ZzlkuqHDHGt/UqlN5zqwuI
         BWEQ==
X-Gm-Message-State: AOAM531M8FHE04ImtPzzwBUoA4ScXXtZVR15WnmP7NVsFpV0NF6Xg9ci
        96Ma9NUb2UxF65cw0B3F3Fpmutqy4kd3fcpyZH0p
X-Google-Smtp-Source: ABdhPJzuuJycH5vvIMh0wk02WE4wqs48vcFiOh6VNsF22v4gwrdYl2lUzLlYf+cPihOy0NigX3hblSsqP89q2vSXaWJE
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:96db:0:b0:506:1fcc:75a8 with
 SMTP id h27-20020aa796db000000b005061fcc75a8mr4060041pfq.12.1649877265439;
 Wed, 13 Apr 2022 12:14:25 -0700 (PDT)
Date:   Wed, 13 Apr 2022 12:14:21 -0700
In-Reply-To: <220413.865yncg7et.gmgdl@evledraar.gmail.com>
Message-Id: <20220413191421.984299-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: Re: [PATCH v4 4/4] builtin/stash: provide a way to import stashes
 from a ref
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> On Wed, Apr 13 2022, brian m. carlson wrote:
>=20
> > [[PGP Signed Part:Undecided]]
> > On 2022-04-12 at 20:14:34, Jonathan Tan wrote:
> >> This seems like you're using the commit message as the reflog message =
-
> >> is this necessary? For what it's worth, all tests still pass if I
> >> replace "msg" with "NULL".
> >
> > I think that's what the existing stash code does, and so I did the same
> > here.  It's not strictly necessary, but it's a nice to have.
>=20
> In any case: Jonathan changed the code to omit the commit message & the
> tests still passed? Is that to do with:
>=20
>     We specifically rely on the fact that we'll produce identical stash
>     commits on both sides in our tests.
>=20
> I.e. that they're checking round-tripping, but not known correctness?

To clarify: I omitted something in the reflog message, not in any of the
commit messages. The round-tripping only checks commit messages (which I
agree is the important thing). I still do think that the correctness of
what's being exported is important, but brian has already said that he
can send a followup as part of a new series [1].

[1] https://lore.kernel.org/git/YlYjgLcnNH8V1yj0@camp.crustytoothpaste.net/
