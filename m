Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD88EC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 17:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjHHRm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjHHRlb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 13:41:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18880238D8
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:18:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5234f2c6c1dso47857a12.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691511461; x=1692116261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6w6o9zMfLYVgyAlpfsQI1MZYWPaS+t1e34IEfNsna8=;
        b=Hdr+wg4hBSdXi1eA8dZr1tPCti+foc7hOeCiKruFpu86klqmTbvsFtMvc14hhWSWsy
         pbeqX+tYxVwXOHyQXct/Vkl0CcamcIaLo9HAJy9rt99QTDsNDvnN9qXgi4LWHcZ3RNV9
         hpCfJnN6Hsz7YJktDyj8PFMKBW3hccyl3xWeaUObcF/HRg7mbp83ZVWrXH8AX2jVEvGN
         CNBuzX//DZIvFgMvdpwqpdKxkSuN7k9ZoeyZcaP1vhh/7Z8oUf0+3u3RjAKbG8/W2w3/
         lzBY+ICtXAngGBiv1Yx+BGxJev4VAQqtPbR5VH8qJdBv+fs5sdK+I16FDLiYNb/E+R7N
         QOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511461; x=1692116261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6w6o9zMfLYVgyAlpfsQI1MZYWPaS+t1e34IEfNsna8=;
        b=HvQ9q+xdg0tGt/qZpPxq2tUnqkSpn4z8pIEZysUnO9FC9ynDcM55P1yMByjMOELkTS
         Ji/tus5AJKxhbmznJq0ruY73WyreQva+dsKln6cwchwWk8yxPB/K3WhwbHp0Iaox34Dl
         MBkkMkr1EsGfeuwKkR1ON+3gEenOcACN2OSrT068YQiCStnEHeckccVGgfRZMtyr18yr
         bPvXjL9o7DPogUnHgQblQhuptyZZNpTGLYbBL6n+sKgcW5KWCR7Qf0kCkPrdWd0L6oh7
         VuhUiKuhmt0/8ds2YBe4InBD41ChEEj3PuCqKnznU3YNIIZ/SDKn8B0VFpnA0SR5cNq5
         x5jw==
X-Gm-Message-State: AOJu0YwmFlPhcectb+G0QjlOfG6e1ik1kdD0uzj1/ynmqQ0MeIsu9RjF
        Hu3ClY2sbPXjgftzN0xjr8ERPNjqFvLn2PFhmUv7TxTqv98=
X-Google-Smtp-Source: AGHT+IHQiio2p7Ylfm0uAMOKBfRaps34kpuRdJ+/99SxrjnWno6k3yoF161nDtKTkbqlcC9eLiR+64JvJ2tAvhU1a3k=
X-Received: by 2002:a17:906:3050:b0:99c:6692:7f76 with SMTP id
 d16-20020a170906305000b0099c66927f76mr11244456ejd.16.1691484360806; Tue, 08
 Aug 2023 01:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com> <20230705060812.2865188-6-christian.couder@gmail.com>
 <xmqqh6qi1byn.fsf@gitster.g> <CAP8UFD0aa+EZQ2Q=C2WjWrNL9desg-KLLjOKS8BUBR4DS1ytsQ@mail.gmail.com>
 <xmqqila9p3j8.fsf@gitster.g> <CAP8UFD3b6gCog5P7WKzTuPQV2Lhf51=xO7ys+W7o0pGewJMcFg@mail.gmail.com>
 <xmqqcz0fnbs8.fsf@gitster.g> <xmqqo7jzh9mh.fsf@gitster.g>
In-Reply-To: <xmqqo7jzh9mh.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 8 Aug 2023 10:45:48 +0200
Message-ID: <CAP8UFD1eX8JMd91Say_sC7h_V08oRq32Wu9RM+SFtAQnhRPO2w@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] repack: add `--filter=<filter-spec>` option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2023 at 1:09=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Thanks for walking through the codepaths involved.  We are good
> > then.
>
> Sorry, but not so fast.
>
> https://github.com/git/git/actions/runs/5661445152 (seen with this topic)
> https://github.com/git/git/actions/runs/5662517690 (seen w/o this topic)
>
> The former fails t7700 in the linux-TEST-vars job, while the latter
> passes the same job.

I think this was because I added the following test:

+test_expect_success '--filter fails with --write-bitmap-index' '
+    test_must_fail git -C bare.git repack -a -d --write-bitmap-index \
+        --filter=3Dblob:none &&
+
+    git -C bare.git repack -a -d --no-write-bitmap-index \
+        --filter=3Dblob:none
+'

which fails because in the linux-TEST-vars job the
GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP env variable is set to 1 and
this counteracts the `--write-bitmap-index` option.

I have tried to fix it like this:

+test_expect_success '--filter fails with --write-bitmap-index' '
+    GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=3D0 test_must_fail git -C
bare.git repack \
+        -a -d --write-bitmap-index --filter=3Dblob:none
+'

but I haven't been able to check that this works on CI as all the job
seems to fail these days before they even start:

https://github.com/chriscool/git/actions/runs/5791544404/job/15696524676

Thanks!
