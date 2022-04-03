Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30866C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 14:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358433AbiDCOIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 10:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiDCOIl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 10:08:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0421FA61
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 07:06:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qh7so4966053ejb.11
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=tJpok2MjE9MOgX/avA7kSt/UVeg76qVj1fzcO88kuMA=;
        b=N1yK57s6rJnoBnNy9PkCMeabZV367vmiNRlAlUsjW7jlWkDOF8OSDZYP6v5dCXPW2T
         gtS/4oVu6GDaM2ReKDz2GimXKGqwyjwWUOBAOE5mXDu4LO3y68nVRzFR8uPm5yNwUNwM
         0k9f5viI85J7i7OKmKPabOHedCv4J9fPpn7BWzQ/lLPAZz89kaz4mZ2hoxfAIjNrxf9A
         MExJjP8BKMz523ZIUVYZXsCoxU4AcA9/K3JxV8FF8qPCnndsi4kIjB17I7v9ng7i8cGl
         mTw6JQpdU4s9fL5wAga5IsdzyYf8zuYvCd7G3LqGGfiouBRNeXQS/Q+YP4mm7/0J95j6
         PT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=tJpok2MjE9MOgX/avA7kSt/UVeg76qVj1fzcO88kuMA=;
        b=jC9oNb6ZFhvEbXg1+DuefZeN8hNZ6fOycv5UHfq5U+LEHX1MS9CzPFH1xmf3HjFxJa
         MCVxfMdfq/pi39kqISbOZJK1zrBJmHUV7KPhxTDgNMeZlJr8X3B4QFY/f2FHDtB8DYRs
         atuSGCy7Iq7mBtqmac62LqhYSkozJ8iUINb4YKEfI5VvBwiqM5rtMGQRWh+IhT8ZLVsq
         DReSs33PE/KvXeX+byVjlD9ROzACdbK4wEuk1rRknNztnh3gPg0TNh4M61IbMmJeZmwN
         bpuT2ZGpt3rrHck0CC7y9SHBwX3LGiSCDJ/ImHVIbQr3FKYr/4kln5xt7+7Hz78eCvzz
         G50w==
X-Gm-Message-State: AOAM530M4eTC970vbEiv7XnrD8Yu4gdWEA0hKJuuvE6yH485rVR3C19q
        mR95AQkvHvyS38d7Kxrjr9wnvMwHiZY=
X-Google-Smtp-Source: ABdhPJyoM7ZIhQ59EwROWKJTWyMD8ibLUzN3+OQBcAaTNuSZqBo99eAA3KVXxkWR3PSvFD5h8bFUvw==
X-Received: by 2002:a17:906:9b89:b0:6da:ac6b:e785 with SMTP id dd9-20020a1709069b8900b006daac6be785mr7308733ejc.295.1648994805625;
        Sun, 03 Apr 2022 07:06:45 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709063a0500b006da8fa9526esm3299639eje.178.2022.04.03.07.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:06:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nb0sO-002Dza-2b;
        Sun, 03 Apr 2022 16:06:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5 24/27] revisions API: call diff_free(&revs->pruning)
 in revisions_release()
Date:   Sun, 03 Apr 2022 16:04:42 +0200
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <patch-v5-24.27-c7f3e92a8d1-20220402T102002Z-avarab@gmail.com>
 <5b93870c-39eb-39eb-e6a5-92b4e1cf8f12@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <5b93870c-39eb-39eb-e6a5-92b4e1cf8f12@gmail.com>
Message-ID: <220403.86a6d2mfbf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 03 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 02/04/2022 11:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Call diff_free() on the "pruning" member of "struct rev_info".  Doing
>> so makes several tests pass under SANITIZE=3Dleak.
>> This was also the last missing piece that allows us to remove the
>> UNLEAK() in "cmd_diff" and "cmd_diff_index", which allows us to use
>> those commands as a canary for general leaks in the revisions API. See
>> [1] for further rationale, and 886e1084d78 (builtin/: add UNLEAKs,
>> 2017-10-01) for the commit that added the UNLEAK() there.
>
> Oh is the the answer to my confusion about patch 14? I wonder if the
> change could come earlier so we can remove the UNLEAK()s all at once?

As noted in <220403.86mth2mfrh.gmgdl@evledraar.gmail.com> (where I meant
to say "series") It's this specific change that will free enough things
for the tests to pass without these UNLEAK()s.

And no, it can't come earlier beacuse just "pruning" or any other member
isn't sufficient, this is just the last straw.

IOW the API callers weren't calling UNLEAK() on specific members of
"rev", but the whole struct. So we needed to fix a lot of leaks before
we colud remove these.
