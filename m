Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CD0C433EF
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 00:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiFDA6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 20:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiFDA6I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 20:58:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7853205A
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 17:58:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v25so12169559eda.6
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 17:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2IxWhRH+YDzWMAnfiZ2z8HDI9U2ZP/NpKOcca3gcvLQ=;
        b=nZjp2pGbvPGjg2gs0cZLyCjfxT8xHyNaOgxqCb/5TGM9ry+2wfpQPEFsTO+Wp9fjoY
         mPvg/9jbf3oXe3F7w4U+vPhDS4Zej0x7OWiCIAFdEyx8FaYfk202ROEer1NuUe8gXNd0
         2xbdumtu5BZqcO+2kD6oQg4FrdA0ZO3qumNh2fkFzKB5pnTSjI0hgBvNfX0ILS3MBSeb
         c3QXJebUCBJAZ+vb//H01QLJIq/baPsTC8Y+pRtfUifXj3mdR2ZTlF6N4ukrBmQvyg8S
         IJBIraNIgqXgEEvnD9KEuQNCLOAAtZPG6cND6K/JlBMxGme46R6FX1+QTtg1JDKP07Jo
         qhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2IxWhRH+YDzWMAnfiZ2z8HDI9U2ZP/NpKOcca3gcvLQ=;
        b=RriKBruL2te45LuN+vsm5BsjxhVJyiv5Sk8LwlY/eKuutUbnMT2WSQaWIZEIG4BhO9
         /Gwj70u7WW8lZ424fD37ECvT2A2VBvSMGl7SUA/bdJeo62dCidx+NcwjacVi2r8QcE6f
         o2lOM++bThakfzvvg+a0Q8PKAOS26xS3NZQSTQLRRVEzlOf0HUBKjT2WLtc73BzZLPu4
         3spU4IXELWic1Ljlo61hc4c1ml6I/z4QKygIbZUS+skxUulBbdB4hFs8/eNDBHnxZX4v
         VIMAjkilbq5wTfKdcgD+BkfJvccuAS9/XFjjqqj7HLwda+VmG1BL7dqNVnvDP1u55X3D
         RJEA==
X-Gm-Message-State: AOAM533UANXc58sMVOTUQ0uB4hMuVzSiVohrtCvGivBsYg31KQDrfke1
        BwoFs2mr83Um4XJTyQbAFlY=
X-Google-Smtp-Source: ABdhPJw87jCW6hsMKAouyXr51XElChaicpDf8tGSpgl4vtO+qV2WL8txKpiS1vWNPcqvrAIaPo50eQ==
X-Received: by 2002:a05:6402:e9f:b0:41c:df21:b113 with SMTP id h31-20020a0564020e9f00b0041cdf21b113mr13768287eda.217.1654304285146;
        Fri, 03 Jun 2022 17:58:05 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r7-20020aa7d147000000b0042dd792b3e8sm4737171edo.50.2022.06.03.17.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 17:58:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nxI79-001xSs-Tw;
        Sat, 04 Jun 2022 02:58:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 03/15] reftable: don't memset() a NULL from failed
 malloc()
Date:   Sat, 04 Jun 2022 02:54:00 +0200
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-03.15-0b570d112fc-20220603T183608Z-avarab@gmail.com>
 <693ed3c3-535e-9eae-9fd7-ca612ebf6943@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <693ed3c3-535e-9eae-9fd7-ca612ebf6943@web.de>
Message-ID: <220604.86pmjpw8h0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 04 2022, Ren=C3=A9 Scharfe wrote:

> Am 03.06.22 um 20:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Return NULL instead of possibly feeding a NULL to memset() in
>> reftable_calloc(). This issue was noted by GCC 12's -fanalyzer:
>>
>> 	reftable/publicbasics.c: In function =E2=80=98reftable_calloc=E2=80=99:
>> 	reftable/publicbasics.c:43:9: error: use of possibly-NULL =E2=80=98p=E2=
=80=99 where non-null expected [CWE-690] [-Werror=3Danalyzer-possible-null-=
argument]
>> 	   43 |         memset(p, 0, sz);
>> 	      |         ^~~~~~~~~~~~~~~~
>> 	[...]
>>
>> This bug has been with us ever since this code was added in
>> ef8a6c62687 (reftable: utility functions, 2021-10-07).
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  reftable/publicbasics.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
>> index 0ad7d5c0ff2..a18167f5ab7 100644
>> --- a/reftable/publicbasics.c
>> +++ b/reftable/publicbasics.c
>> @@ -40,6 +40,8 @@ void reftable_free(void *p)
>>  void *reftable_calloc(size_t sz)
>>  {
>>  	void *p =3D reftable_malloc(sz);
>> +	if (!p)
>> +		return NULL;
>>  	memset(p, 0, sz);
>>  	return p;
>>  }
>
> We discussed this before, in
> https://lore.kernel.org/git/RFC-patch-2.2-364d1194a95-20220415T101740Z-av=
arab@gmail.com/
>
> If this code was actually used by Git and still not handling allocation
> failures then I'd propose something like the below instead.
>
> Next I'd probably try to convert reftable_calloc() calls to a variant
> that takes size and count separately -- like calloc(3) does -- to avoid
> unchecked multiplication.
>
> --- >8 ---
> Subject: [PATCH] reftable: remove reftable_set_alloc()

I think this is a much better direction than my more narrow fix, and
would be happy to see it queued up.

To your comment here & some others (e.g. FREE_AND_NULL()): I was really
trying to focus on narrowly addressing these -fanalyzer issues without
digressing into the larger topics "what is this code *really* doing, and
does it make sense?". It was pretty unavoidable in 13/15 though.

Which isn't to say that I shouldn't fix some of it, e.g. your
s/return/BUG()/ suggestion, but I think it's best to view these patches
with an eye towards us already having these issues, and in most cases
making -fanalyzer happy is a small cost.

And by doing so and getting a "clean build" we'll be able to turn it on
in CI, and thus notice when we run into new -fanalyzer issues.
