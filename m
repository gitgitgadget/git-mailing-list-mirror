Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E537C433FE
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 04:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S249068AbiAYEDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 23:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1325482AbiAYDhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 22:37:25 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78139C08ED73
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 14:55:34 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id r14so2074857qtt.5
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 14:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/AWteWNxCjPTSW+/YkpD5gFNyTDZ1i9k7lvUz+eJsw=;
        b=n1LLbD6eaeasU3A8Fga21ol/FEXujNZHnaJSaXmMhmBjfB0vqwqJgCWxyQ/vLrLO7t
         HXeW7J6PLu6OgQkM+9erNk+EY5cRoN51U48R6OmnJjWmzP5QSfUozTJIXmEUvzYxCC1p
         aTHOL8ZxoR2RX3Ah7tqDG/xqU5CtmvlQjBlYxSx32apOB37G9iTpX0mUp+Y874I3MiuU
         Vqg+srjoXgtl0DBXZgbcc9FN7QU7p9MofzmoGqcxxNAIB3MITBE0aNC3VPNB9Wp3P+0T
         b7jWKxwwLIXdxi3hOyltOVylOGN2w5gJu8iAH6J5qj7sJq1bZzoZyb4skKxfqNnd3Uc6
         Z53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/AWteWNxCjPTSW+/YkpD5gFNyTDZ1i9k7lvUz+eJsw=;
        b=3Z5uaJdBCXAvB2i40V1YxGqepXHdIf61KLqL7VwUASQsjxiRgxwlk47olcwxR73rqv
         80kBAtSakxrUZY3dwRkd9s+Ybuc/Cixoxx8yVxoZld/A8vqBHIYJsD95qW4zmozXUUeq
         A9O8/DoLMpVvz+H0miWy94qUTgkSLZ7vS0M4i8T6MYPVSHHfhHaEAdUlR15MV6VR4E3+
         MerSfeIx3jTBI822KMr71QnRdGUJ1551bhZzvo9e0g9j/XY3T1MSfMdT89GIO9IDO8Q9
         Rwa8xuoVFhv/f98jf5Z032q3w8eRoktualR3Sliky//7JVFrGG5NrQImpw7kVfmwwoBe
         Ti2g==
X-Gm-Message-State: AOAM533Lv+vyapy8xeCKXK2x0g9JlMx3nvFsXeA85RZZR/JphHdqGInI
        ILJmePQsbCcudtopzxZAcnc=
X-Google-Smtp-Source: ABdhPJzSeFS9U5lVP3hoHE7MFgOcT80vhEoL8vYwNvfVkTOWvA7YJGUZSAlsZR9upRXQnPkKnlQ2+A==
X-Received: by 2002:ac8:7f01:: with SMTP id f1mr14428358qtk.189.1643064933566;
        Mon, 24 Jan 2022 14:55:33 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id t11sm7998208qkm.77.2022.01.24.14.55.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jan 2022 14:55:33 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] promisor-remote.c: use oidset for deduplication
Date:   Mon, 24 Jan 2022 17:55:32 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <E5AD42A3-AEAC-44F8-B223-90E2ACAEFCB0@gmail.com>
In-Reply-To: <220114.86wnj2se41.gmgdl@evledraar.gmail.com>
References: <pull.1187.git.git.1642105926064.gitgitgadget@gmail.com>
 <220114.86wnj2se41.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14 Jan 2022, at 7:11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Jan 13 2022, John Cai via GitGitGadget wrote:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> swap out oid_array for oidset in promisor-remote.c since we get
>> a deduplicated set of oids to operate on.
>>
>> swap our calls for oid_array for oidset in callers of
>> promisor_remote_get_direct().
>>
>> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> FWIW we had an off-list discussion about oidset v.s. a custom hashmap t=
o
> do the same off-list, not about s/oid_array/oidset/ in this area.
>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>     promisor-remote.c: use oidset for deduplication
>>
>>
>
> Extra \n between $subject and $body.
>
>>     swap out oid_array for oidset in promisor-remote.c since we get a
>
> Nit: s/swap/Swap/, i.e. start the sentence with a capital letter...
>
>>     deduplicated set of oids to operate on. Any direct fetch we can sa=
ve
>>     will be well worth it.
>>
>>     oidset does use a slightly larger memory footprint than oid_array,=
 so
>>     this change is a tradeoff between memory footprint and network cal=
ls.
>>
>>     What I'm not sure about is if it's worth swapping out all the call=
s of
>>     oid_array for oidset in callers of promisor_remote_get_direct().
>
> From what I understand of GGG I think you updated only the summary on
> the PR but not the commit itself, the latter is what would go into
> git.git. Here the commit should be updated so we get this message.
>
> The part after the "---" is usually just used in this project for ad-ho=
c
> list-only comment.
>
>>  builtin/index-pack.c   |  9 +++---
>>  builtin/pack-objects.c |  9 +++---
>>  diff.c                 | 13 +++-----
>>  diffcore-rename.c      | 12 +++----
>>  diffcore.h             |  3 +-
>>  merge-ort.c            |  8 ++---
>>  object-file.c          |  4 ++-
>>  promisor-remote.c      | 72 ++++++++++++++---------------------------=
-
>>  promisor-remote.h      |  6 ++--
>>  read-cache.c           |  9 +++---
>>  10 files changed, 57 insertions(+), 88 deletions(-)
>
> Rather than inline comments, a comment that applies to all of these:
>
> The difference between these two APIs is thaht oidset is hash-backed,
> and you'd insert into it and we de-duplicate any duplicate OIDs on-the-=
fly.
>
> The oid_array is just an realloc()'d "struct object_id *oid". On
> insertion you can insert duplicates, but it has the ability to track
> "I've sorted these", and "let's iterate over this sorted, and de-dup an=
y
> duplicates".
>
> We have the two APIs for a reason, but I don't know in any of these
> cases whether this change is safe.

To reduce the footprint of this change, maybe we can just keep oid_array =
and sort it
in diff.c before passing it off to promisor_remote_get_direct(), in which=
 we then iterate
over unique entries.
>
> Does e.g. index-pack.c always receive de-duplicated OIDs and we were
> wasting CPU cycles using an oidset?

Good question. In fact a more immediate question is how often does diff.c=
 receive dupe oids,
which was the original motivation for the change. cc=E2=80=99ing Jonathan=
 as he was involved with
95acf11a that added the NEEDSWORK block.

Jonathan, how often do we expect diff to pass duplicate oids to promisor_=
remote_get_direct()?
>
> Do some of these like pack-objects.c receive de-duplicated OIDs from
> e.g. "git repack" *now*, but we just lack test coverage to see that
> they're happy to get duplicate OIDs on stdin (e.g. manually from a
> user), and this would introduce a bug?
>
> But most importantly is it worth it? What's the rationale for the
> change? Less CPU/memory use? Getting e.g. "hyperfine" or "/usr/bin/time=

> -v" output for those (if so) would be valuable.

I agree this would be very valuable, but I=E2=80=99m thinking more so onc=
e I get a better idea of
what kind of situations would lead to duplicate oids in diff.c
