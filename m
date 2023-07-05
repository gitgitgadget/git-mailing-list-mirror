Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CB0EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjGEGQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGEGQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:16:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC45910CF
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:16:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc0981755so71529425e9.1
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688537803; x=1691129803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtJ6CLADYHI2PhLZMT3tR5sJ8P7rIZZWA8vhlm8aEVE=;
        b=LG5iY+oyljL9qA3LUW7OeXEBdMweLsmetZ9T2cK3GPP4qdC23VBH8eiPyumA6B62XX
         VKDifRQDvNR8UxB4YIKHRSF8ZiRBBXa+WIBDo36K5oQ6q9dmg1u89E2ylp1d8rsjJuKj
         iWdJ5fry9ifnEmrj5vPDymQ/judm2+BZ47tNokcnJoQ2RUJVCqCAuUc/+QhMkTHAHWp9
         odLcBc3aJhSy6/ReRZ3n/kwguAYPxNwdAUBwTN5VQUxfuH/NSB4FtsVChoPDWFR+C/lk
         3S76ar3dg0sQB3qnd0ExTe7JDFtScesOzyiJE8DpUTwJrDNe7TjpnO5PeJSMV2918H0D
         ua3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537803; x=1691129803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtJ6CLADYHI2PhLZMT3tR5sJ8P7rIZZWA8vhlm8aEVE=;
        b=TokWP3wV3SC8prNDhciTjoj/vV+ZuP5yXGbUazWTFEasMhRDNYiTnNAsgQLwOOCYo9
         AmMrTRFKpew/d5EOvZf7a0feldKtca5kvlp057FZgiqpLETm91OZgvdi6U+ZZW46C/gY
         2TROCymtMqx0jZOWzusmGCDs/p3UN/86KWXSqYrd4Ygj6W6WPQhn0pXIE0CNnQc/9HkO
         ++CNH4+8bUSZbIiDMXBsCDf74qBSk4muN/hjmCVXGtjw+7V36YCUlNZkDItCueLIrooy
         UvEM/R+n8OYKqLO98ClexlfZJQYtGFZivwn583rbL5hqCG+shdvtztk1AKZ80o9KLFLy
         yJ/w==
X-Gm-Message-State: ABy/qLb07gyTfm5ChWNyhK+Y7B/6RZtsKoEl8R15znQyMc1o/4OC+9YC
        sS9smkwi1DF5DOxSyTReyoWZ7L1qtN6bIqC78Iw=
X-Google-Smtp-Source: APBJJlEwMHvG0AaNS6YjeDsw2IHjkFDOEEYcCOTOBQB+dvcgWarEAmtecX19/+kY6waBz3MO4F9yCXbrsURQc+7BY+A=
X-Received: by 2002:a05:600c:21d1:b0:3fb:e200:b2b3 with SMTP id
 x17-20020a05600c21d100b003fbe200b2b3mr3425675wmj.37.1688537803148; Tue, 04
 Jul 2023 23:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-2-christian.couder@gmail.com> <ZJLVzaQKBrgCARAG@nand.local>
In-Reply-To: <ZJLVzaQKBrgCARAG@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 5 Jul 2023 08:16:31 +0200
Message-ID: <CAP8UFD2=7AJfw4hyhFttqDOFQ+1TxRq5JpUNEpKsGk4b3VJ+HQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] pack-objects: allow `--filter` without `--stdout`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 12:49=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> On Wed, Jun 14, 2023 at 09:25:33PM +0200, Christian Couder wrote:
> > 9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
> > taught `git pack-objects` to use `--filter`, but required the use of
> > `--stdout` since a partial clone mechanism was not yet in place to
> > handle missing objects. Since then, changes like 9e27beaa23
> > (promisor-remote: implement promisor_remote_get_direct(), 2019-06-25)
> > and others added support to dynamically fetch objects that were missing=
.
> >
> > Even without a promisor remote, filtering out objects can also be usefu=
l
> > if we can put the filtered out objects in a separate pack, and in this
> > case it also makes sense for pack-objects to write the packfile directl=
y
> > to an actual file rather than on stdout.
> >
> > Remove the `--stdout` requirement when using `--filter`, so that in a
> > follow-up commit, repack can pass `--filter` to pack-objects to omit
> > certain objects from the resulting packfile.
>
> Makes sense.
>
> Is there any situation in which using --stdout with --filter would be a
> potential foot-gun? I am not as familiar with the partial clone
> mechanism as others CC'd, so I have no idea one way or the other.

This patch allows `--filter` without `--stdout`, so `--stdout` with
`--filter` was already allowed before this patch and is still allowed
after it.

Besides, using `--stdout` or not using it is just a convenience. It
doesn't change much what users can do with `git pack-objects`.

> If it is unsafe in certain situations (or, at the very least, could
> produce surprising behavior), it may be worthwhile to only allow
> `--filter=3D<filter> --stdout` with some kind of
> `--filter-to-stdout-is-ok` flag to indicate that the caller knows what
> they are doing.

`git pack-objects` with `--filter` can be unsafe in some cases if
users do stupid things with packfiles afterwards, but allowing it to
run without --stdout doesn't significantly change that. In any case by
itself it doesn't delete any data. It just creates a pack containing
fewer objects.

Anyway I added a small test that checks that --filter can be used
without --stdout.
