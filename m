Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6093C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 19:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24AF613D5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 19:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhJETRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 15:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbhJETRt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 15:17:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CA7C061753
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 12:15:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id d8so601273edx.9
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Vf01i9kN4Kdc4lPcA25hf7b4CzZxrkRLkIXdOpzRKk4=;
        b=GE2frtmZr2XUZM/fNlg8bEDFKpd48jt04E8loL1FBMRDF8d44c6nV4I6EsCCit25rC
         ApibMjwrs0959yNKDo8YcKlce8q3awe7hxBU3HIt/lDalEMkrEX8facu/RUZ5ssXXJPk
         D/wSLeJ/Q/5XXTvn3zRvUFEQfnAJHpIjnI6z1ugOayj3V0FJKRkGeZ8cgqu/No6QcTd9
         /M4tNTmAS68K/V4XBJBaKiu6YSI8kgbQMXdC1oEr1kBUvhq3jJUOA2SxYxJ+hz7+Ox8K
         TZXzIyytJJaE+59YodqWTX8LUwbmEyy0W7GiGTda10m7H5DN4bTn9oQjGqszgzv+CA3Q
         JrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Vf01i9kN4Kdc4lPcA25hf7b4CzZxrkRLkIXdOpzRKk4=;
        b=QYjOBMqIKfpV9Z7/5nE7xkW18C9tR6M6gDYR7Zzdo7d4U0bLP56kB9FwgF7mFA3Jo8
         EZfNKBsYv0Q8/I4S03zx67G2TI8FsKz0J8hJkPzrs8LO3PytB2rgf8i0YGDr2W6/MiOC
         jqxDx1+20/SS/PVHlMAkzw36pTQDCyGDX5BmI19SeSSWbN0prm0BGUR775D59o1y1z52
         ffX4hKeLuC5pMCdvzYIIQ3d7PwguW7Yih0ce9CdQHFaigMCAs3yXKhtjZIWOtq9s5QUZ
         UzUDJwBtCJn4MSQCtepTZ71meAf58yXqxMwZXsrSxuZx6jNSYO+3vPt8/FMKjrPZLtQ/
         kyww==
X-Gm-Message-State: AOAM531FnO3I/6qzoIWIMuRgbR48KSUh8bGoK2Hs+HxIlz+nPCvdjZA8
        CteIMbXz2ggjiSPQeTyQirOtgM02tmCo5g==
X-Google-Smtp-Source: ABdhPJwr+N/kobz0wSdbnmr/VGwa3r8ASGc45WqDkPkHT2WvCn3dr2E239O9nJEo0yh2y4loF+DPWw==
X-Received: by 2002:a05:6402:2787:: with SMTP id b7mr12885766ede.285.1633461356273;
        Tue, 05 Oct 2021 12:15:56 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r10sm3964099edh.61.2021.10.05.12.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 12:15:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 0/3] Use default values from settings instead of config
Date:   Tue, 05 Oct 2021 21:10:06 +0200
References: <20210917225459.68086-1-chooglen@google.com>
 <20211005001931.13932-1-chooglen@google.com>
 <87lf37ll4k.fsf@evledraar.gmail.com>
 <70aca052-716f-40ed-47c4-1882fdbd221e@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <70aca052-716f-40ed-47c4-1882fdbd221e@gmail.com>
Message-ID: <87ilybjn9x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 05 2021, Derrick Stolee wrote:

> On 10/5/2021 7:57 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Subject: [PATCH] WIP gc/maintenance: just call prepare_repo_settings() e=
arlier
>>=20
>> Consolidate the various calls to prepare_repo_settings() to happen at
>> the start of cmd_maintenance() (TODO: and cmd_gc()). This WIP commit
>> intentionally breaks things, we seem to be lacking test coverage for
>> cmd_gc(), perhaps since 31b1de6a09b (commit-graph: turn on
>> commit-graph by default, 2019-08-13)?
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/gc.c            | 5 +----
>>  t/t5318-commit-graph.sh | 2 +-
>>  2 files changed, 2 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index 26709311601..f59dbedc1fe 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -695,7 +695,6 @@ int cmd_gc(int argc, const char **argv, const char *=
prefix)
>>  		clean_pack_garbage();
>>  	}
>>=20=20
>> -	prepare_repo_settings(the_repository);
>>  	if (the_repository->settings.gc_write_commit_graph =3D=3D 1)
>
> I think that removing these calls is dangerous. prepare_repo_settings()
> already returns immediately if the repository already has its settings
> populated. The pattern of "call prepare before using a setting" is a
> safe way to future-proof the check from a movement of the call.
>
> Putting that potential-future-problem aside, I don't see how this
> change is a _benefit_ other than fewer lines of code, which is not a
> quality measure in itself.

Very dangerous, yes :) As I noted this hunk intentionaly breaks the "git
gc" command. Search for "I wondered if we could just call
prepare_repo_settings[...]" upthread.

I.e. I was commenting on how Glen's patch makes an attempt to test this
tri-state config for some cases, but not others, and that in this case
we can break "git gc" without any existing test catching it.

Which as noted might have started happening when you flipped the
core.commitGraph default, but I didn't test or confirm that, it just
seemed the most likely place to start digging from a quick "git log
-G...".

Anyway, as also noted I think this series is fine as-is, just some
feedback in case Glen or anyone would be interested in either doing a v4
or a follow-up, i.e. when I tested this I found that some code/tests in
this area were (probably) either fragile or already broken.
