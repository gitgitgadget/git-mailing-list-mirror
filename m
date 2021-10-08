Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD8EC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 12:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0656C60F5C
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 12:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbhJHMRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 08:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241077AbhJHMRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 08:17:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64C7C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 05:15:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b8so35583747edk.2
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 05:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zcT6UTzE6h327bUobXvlJxfBR+ooVjRMAwBLHpxt5vM=;
        b=jPdRj1yeM0OlC/qxdUy8u+dizidosLflC/pPMv6PbMBVmVTN/FrWO6C6D0SryGBOqT
         Qx5MdPvWEITHkJcLTwswc1i2WlLKuhDjNVHfJV7YFGSZhDD8Yw0TNoS8I2lvTo4aiNc6
         S4I0x8gm8N6kz14xjnsrvGKVLTykWiXUiIH7IxjPyUFC3B74p4sPL4sxbUfAK8lFdD4l
         TEw13BO+zYq412Jztx+S7Z+wq/85+t9F8qSzMzxSAzPogFEqEJB4rd3zNIGYRZBgFzOe
         UbDUt7WpO0f0yH8hsl6B14j2AcQH71KG/+GeOMKmv5iBl8vBmjJY1io5stWSxOQNQDfJ
         rGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zcT6UTzE6h327bUobXvlJxfBR+ooVjRMAwBLHpxt5vM=;
        b=b67hfj5eFOoTp8ZU0w97phCtynx64Jp9ypZ3XddkL/InnTcyrU6LUren7vKJ+4aMjK
         z1kKg4qbX8KZcj7Q10DXOYYjVZ/9cip7gbeBgzyFpCoJXYiJvKOc4j4jcdhaXYVtd9p/
         RbZYepHNIvRv6Zdn1yOuWrG8tK5d/NI6fyYqkFjKpWsvVLzUahYmGTSFkGVxIwIm4uI/
         4CNemkAv5/VHzLkR7GsFSpCmfr8u+pHEvHCDkYVK+FkkB7arTvw0ZULOv9uTkegaH0te
         zswUdCn9P9eKEJgDIzCW2icXHLMLlBwxOFIpB6Iw289ofcHzN9i3eC4kqdGFfGNdj1g7
         nVDw==
X-Gm-Message-State: AOAM5323lP/YlfxEcWjHQ53kuv+zS1dRIJE3jtaIFmwK+jth6G7fRzx7
        l3VLRKiSpHqgzjqHPTVeh7w=
X-Google-Smtp-Source: ABdhPJzE+WjVB0/LY+J/NZf4cUafYxGUU/D9jb6QsEZCWnsMNy6gK0nSFVRhDROQtSuAvuoFLGDgRA==
X-Received: by 2002:a17:906:9546:: with SMTP id g6mr3794963ejy.448.1633695312193;
        Fri, 08 Oct 2021 05:15:12 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l19sm966389edb.65.2021.10.08.05.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 05:15:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 7/8] pack-bitmap-write.c: add a missing stop_progress()
Date:   Fri, 08 Oct 2021 14:14:43 +0200
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <patch-v2-7.8-a3f133ca7ad-20210920T225701Z-avarab@gmail.com>
 <YV/DV95BkT85a2xl@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YV/DV95BkT85a2xl@google.com>
Message-ID: <87czofogq9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 07 2021, Emily Shaffer wrote:

> On Tue, Sep 21, 2021 at 01:09:28AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
>> bitmap writing, 2013-12-21), we did not call stop_progress() if we
>> reached the early exit in this function. This will matter in a
>> subsequent commit where we BUG(...) out if this happens, and matters
>> now e.g. because we don't have a corresponding "region_end" for the
>> progress trace2 event.
>
> Sounds like this was the only place we were calling start_progress()
> without a stop_progress(), then? Or at least the only place that is
> exercised by the test suite. Wow. I'm proud of Git contributor base :)
>
> Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

Yes! Will clarify that, there were some fixes to other bugs in the area,
but this one was the last one. Might squash it actually...

>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  pack-bitmap-write.c | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
>> index 88d9e696a54..6e110e41ea4 100644
>> --- a/pack-bitmap-write.c
>> +++ b/pack-bitmap-write.c
>> @@ -550,6 +550,7 @@ void bitmap_writer_select_commits(struct commit **in=
dexed_commits,
>>  	if (indexed_commits_nr < 100) {
>>  		for (i =3D 0; i < indexed_commits_nr; ++i)
>>  			push_bitmapped_commit(indexed_commits[i]);
>> +		stop_progress(&writer.progress);
>>  		return;
>>  	}
>>=20=20
>> --=20
>> 2.33.0.1098.gf02a64c1a2d
>>=20

