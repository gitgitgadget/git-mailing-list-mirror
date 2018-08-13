Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96F11F404
	for <e@80x24.org>; Mon, 13 Aug 2018 15:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbeHMSbq (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:31:46 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33813 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbeHMSbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:31:46 -0400
Received: by mail-ua1-f67.google.com with SMTP id r15-v6so9692508uao.1
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I1szbdTQ0Dd2ZNSphNG9I4puFbuHP6k8zvGkaVIU0Hk=;
        b=nQWhAgCZP0VRCMH34ZfYMX0pRdA5Z3e4acLAfOxUgsrGiHhJ2yG2iq/HwzHlNX2fmK
         5UVJwzX8xKAEDgfo64ohn/gNyKOYAUm4ZchKImu0rN+jJgSFfcIuFtC5W6vrmnegS8yh
         BJj5RNpcHok9Wt0E+uKjaCa8e/6/3sBSkCPT7xU5UvR1H+2T/hkwC2BIhmDYyogMq6AW
         ptzt/hu/9mkVejkY8TxA8Rt3dBGO2wBnhhxI7B7Z+ZwAyuILf8mFRwc1KEPd4Laaaf7C
         ep1jNiMvbhyxomsk1qnRgTu1YEEoHQS+/yJvTuIk/zEKRJeJ3eoKswRxeQk0gzEgiOHU
         gPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I1szbdTQ0Dd2ZNSphNG9I4puFbuHP6k8zvGkaVIU0Hk=;
        b=OtVe8i90VLZEGS33EcpE/QHZMS2dl2cvsbHKhFYrnl19tnxdcQlg6FqlVFtG9ZkY7y
         G/Mm8+vAxFoJ/+Oi1JUUVy71pCkTE6pb9SWNHRH0pqLfdgFvghWsX8IopCPcK8wMI81T
         9nj4QezUzY83q/08OhGaBuuyz05ofv1Vk8CQtjoSHp5/SG+ExO/LU4RFzRTRCNWDHALo
         VkYh4pLWatD8ZOBzJC7eYNiTCa/fqg5nmHzehDMt6Sbv2F9kWE+5Qsri7xosJZOmbm6t
         FlbFJAayTxuCL9E40VbQJy38LGYS4QlKMM1BvRcQeLyvgx6MRP+OfArvBgu8TKPmiyY2
         Fl/w==
X-Gm-Message-State: AOUpUlFzdDqmEvH7hpr2NNuKzIkWjvJYIfACwi+STT0j7aj4zBUmo17B
        8InwQtQD5n6ADlrribSTuDl9eBF0vCIasYekosM=
X-Google-Smtp-Source: AA+uWPzzTOjmtD+lJarxWlxSHdwIszrCoGW0fuWOkO2LqmsEzGgNSblTglGFDPWWivDx3Lx1WeZ32pm8/qYFkxNik54=
X-Received: by 2002:a1f:8c2:: with SMTP id 185-v6mr11383136vki.51.1534175337630;
 Mon, 13 Aug 2018 08:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180804053723.4695-1-pclouds@gmail.com> <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-6-pclouds@gmail.com>
In-Reply-To: <20180812081551.27927-6-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Aug 2018 08:48:45 -0700
Message-ID: <CABPp-BEDQfzyZjD0CuZKhvj3iUi0H6Ar0Fgm2UhehjP1pnWKgA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] unpack-trees: reuse (still valid) cache-tree from src_index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 12, 2018 at 1:16 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> We do n-way merge by walking the source index and n trees at the same
> time and add merge results to a new temporary index called o->result.
> The merge result for any given path could be either
>
> - keep_entry(): same old index entry in o->src_index is reused
> - merged_entry(): either a new entry is added, or an existing one updated
> - deleted_entry(): one entry from o->src_index is removed
>
> For some reason [1] we keep making sure that the source index's
> cache-tree is still valid if used by o->result: for all those
> merged/deleted entries, we invalidate the same path in o->src_index,
> so only cache-trees covering the "keep_entry" parts remain good.
>
> Because of this, the cache-tree from o->src_index can be perfectly
> reused in o->result. And in fact we already rely on this logic to
> reuse untracked cache in edf3b90553 (unpack-trees: preserve index
> extensions - 2017-05-08). Move the cache-tree to o->result before
> doing cache_tree_update() to reduce hashing cost.
>
> Since cache_tree_update() has risen up as one of the most expensive
> parts in unpack_trees() after the last few patches. This does help
> reduce unpack_trees() time significantly (on webkit.git):
>
>     before       after
>   --------------------------------------------------------------------
>     0.080394752  0.051258167 s:  read cache .git/index
>     0.216010838  0.212106298 s:  preload index
>     0.008534301  0.280521764 s:  refresh index
>     0.251992198  0.218160442 s:   traverse_trees
>     0.377031383  0.374948191 s:   check_updates
>     0.372768105  0.037040114 s:   cache_tree_update
>     1.045887251  0.672031609 s:  unpack_trees

Cool, nice drop in both cache_tree_update() and unpack_trees().  But
why did refresh_index() go up so much?  That should have been
unaffected by this patch to, so it seems like something odd is going
on.  Any ideas?
