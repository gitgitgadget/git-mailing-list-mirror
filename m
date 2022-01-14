Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A378EC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 12:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240922AbiANMUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 07:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiANMUe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 07:20:34 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D71C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 04:20:34 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a18so34332220edj.7
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 04:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1l8xN+q+KsrMOQRcsz4MPmFVoG7xstMTApqOvHDmmQM=;
        b=L8yA0Wq2biBNKQDdfVmM1zKYMq8lbJOLUHI/BesdERD0XyKtgwNE4PRuC5gB22mqhl
         4FMlYERXQ7B+2YKsxKe8F2oAlRaYBMFCP6cq5eKFz+fbW39VIy2csXqBFao7rD7dGTqu
         t9BdeqS7kpfgXMyBNXSrWvMEjb+qNfFjVqstObce8yt+EIW0GoQ1lvAN6K9avs99nB56
         7w5X4D/zIJ8l4I+LtS/VbRE3WrXCT3dn6aofuGDcGDmVqxwvrWgXsvkCesDpKSHe/cI8
         VKoVQOkbtLnrKuyhNy/oZkFjkISzl1oqvg7YRN0UUwwhYiHzHAcQeDsc0rl1z7i13ODd
         JU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1l8xN+q+KsrMOQRcsz4MPmFVoG7xstMTApqOvHDmmQM=;
        b=I5+iQrHtilYzu4oJuuU6XcRK1DsbVCMLTGolddy8FIqafuUTAoe4W+PpMscfGiamSo
         eMr6L47/ROJB9uDmAkwxhjDMU8E4M7YJTnvSHmm6OkXk9HoDNYxSQB25L3Fx6PL8ceM9
         ZCN2zhp7yp0pdPPtBuS30TiVgbrp6dguk+0T75W+l+BuMndE8mGAiXDVpnl9YqcG+wiB
         6PNuLtAMqS/gfiYYQUn42OlSCxNiOvADsEiaraQJtE+81HMOlCMan5sCL2QZrSxLOyAI
         okCJnaN2cyAFFsTi7kG6gIowDkzPyrvrG6LMXZMcurt1nuJr6h+31iFdPg+fAFX5GUBt
         8YoQ==
X-Gm-Message-State: AOAM531QMK97IX6olBviR+ki+a4BFG0nBIS6BWkfVf/8dWyze7SHG5dh
        yU1qzRU0OO0udnfvJ3bqDjbl62Yjj7Q=
X-Google-Smtp-Source: ABdhPJy0lowEbLcF2YlCX0nUISshpxEap8GsSn6RpWkmbTDzN62WUDu81NkRbqaY/5QoOoiEHDXNpg==
X-Received: by 2002:a17:907:1c91:: with SMTP id nb17mr7007114ejc.712.1642162832318;
        Fri, 14 Jan 2022 04:20:32 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 20sm1793750ejy.105.2022.01.14.04.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 04:20:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8LZH-0015hs-4V;
        Fri, 14 Jan 2022 13:20:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] promisor-remote.c: use oidset for deduplication
Date:   Fri, 14 Jan 2022 13:11:57 +0100
References: <pull.1187.git.git.1642105926064.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1187.git.git.1642105926064.gitgitgadget@gmail.com>
Message-ID: <220114.86wnj2se41.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> swap out oid_array for oidset in promisor-remote.c since we get
> a deduplicated set of oids to operate on.
>
> swap our calls for oid_array for oidset in callers of
> promisor_remote_get_direct().
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

FWIW we had an off-list discussion about oidset v.s. a custom hashmap to
do the same off-list, not about s/oid_array/oidset/ in this area.

> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>     promisor-remote.c: use oidset for deduplication
>=20=20=20=20=20
>=20=20=20=20=20

Extra \n between $subject and $body.

>     swap out oid_array for oidset in promisor-remote.c since we get a

Nit: s/swap/Swap/, i.e. start the sentence with a capital letter...

>     deduplicated set of oids to operate on. Any direct fetch we can save
>     will be well worth it.
>=20=20=20=20=20
>     oidset does use a slightly larger memory footprint than oid_array, so
>     this change is a tradeoff between memory footprint and network calls.
>=20=20=20=20=20
>     What I'm not sure about is if it's worth swapping out all the calls of
>     oid_array for oidset in callers of promisor_remote_get_direct().

From what I understand of GGG I think you updated only the summary on
the PR but not the commit itself, the latter is what would go into
git.git. Here the commit should be updated so we get this message.

The part after the "---" is usually just used in this project for ad-hoc
list-only comment.

>  builtin/index-pack.c   |  9 +++---
>  builtin/pack-objects.c |  9 +++---
>  diff.c                 | 13 +++-----
>  diffcore-rename.c      | 12 +++----
>  diffcore.h             |  3 +-
>  merge-ort.c            |  8 ++---
>  object-file.c          |  4 ++-
>  promisor-remote.c      | 72 ++++++++++++++----------------------------
>  promisor-remote.h      |  6 ++--
>  read-cache.c           |  9 +++---
>  10 files changed, 57 insertions(+), 88 deletions(-)

Rather than inline comments, a comment that applies to all of these:

The difference between these two APIs is thaht oidset is hash-backed,
and you'd insert into it and we de-duplicate any duplicate OIDs on-the-fly.

The oid_array is just an realloc()'d "struct object_id *oid". On
insertion you can insert duplicates, but it has the ability to track
"I've sorted these", and "let's iterate over this sorted, and de-dup any
duplicates".

We have the two APIs for a reason, but I don't know in any of these
cases whether this change is safe.

Does e.g. index-pack.c always receive de-duplicated OIDs and we were
wasting CPU cycles using an oidset?

Do some of these like pack-objects.c receive de-duplicated OIDs from
e.g. "git repack" *now*, but we just lack test coverage to see that
they're happy to get duplicate OIDs on stdin (e.g. manually from a
user), and this would introduce a bug?

But most importantly is it worth it? What's the rationale for the
change? Less CPU/memory use? Getting e.g. "hyperfine" or "/usr/bin/time
-v" output for those (if so) would be valuable.
