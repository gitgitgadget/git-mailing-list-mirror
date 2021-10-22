Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC339C433FE
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C0C6101C
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhJVOXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhJVOXa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 10:23:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534CFC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:21:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e19so3753741edy.0
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4KLojU6Pe2RID1Tufx9WShVhVurC039BcwuJvS75cYE=;
        b=EAu4Pj/mrWr8XXNyxNMfuQQBXV/6G2MNFpfS+VlC+B0BDejWjyTBuIiE+s/JufU5zq
         xwso4ZrYKGmlEOeQE7lbxcWC+GdjCbKb8ZZ7JXHs/UbksE3NnD44zmEa97p33Ul9QKB8
         xLiPSEANjpB//RDkw71QEjkWyuY7NCe39q9Fh1mSpi44Fr3ISHbwGF/WZWHgj3u64b82
         iaxUksf6V4xaaRNvSghMMnG8MZLxVS3jhLhDFXxLY8c1jQ+vkyrq27DT4Id9r6FhddL+
         KH5V0n8uqZvzw1azcc63ddt6JOJBoI9Zo1d57r3WZQPm3S57+n02Xo9Nc4h90Muspck8
         4W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4KLojU6Pe2RID1Tufx9WShVhVurC039BcwuJvS75cYE=;
        b=Kd88LLpWzk8e4NggcUlPv64OgyfeTuQ1ANmb9Kmv3JuujWHOwcTffzPZQ605TO53dT
         LMcXhunXGxvkPoDkpIx15Milwqs0usr69GMhNfCiQtiRq3pVAZxLNG3qH54GKmlxuKtK
         jkaR9tY2r4kiuq+89rp++k6wLwGSrMjrS1702gBKnDZvQR1HrROpE0mZt74t1p0yJ30E
         i38WY3ndQpKs7epGid0J5jPn3mNEH7ITpDayY0Fd6/TBKrniMTjkf+Mp7qUOg9HYT/YZ
         PxC2b6rqSgZUUwdPvJDgly/VmOBR0du8v0jnK0NiHAFYnY0BAzPh0ltFb8wSzMSrFF1N
         5IIg==
X-Gm-Message-State: AOAM530ldGoQ9pkIU4lx/oF+baEo7Wkvezh4Gb6CzkYIJgMkytEetS0m
        vcX6Uk3QHtS7qs31o5xLL4c=
X-Google-Smtp-Source: ABdhPJytRJMfib5e7/XhEFTqCSWRayPj5a3WDhkr6fXLz+8GG0d0gVUHQNVW2YHZmsZs/ikrbIPMsA==
X-Received: by 2002:aa7:de09:: with SMTP id h9mr399123edv.152.1634912470719;
        Fri, 22 Oct 2021 07:21:10 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n24sm4574560edb.28.2021.10.22.07.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:21:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdvPx-001ECo-NS;
        Fri, 22 Oct 2021 16:21:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 03/10] progress.c tests: make start/stop verbs on stdin
Date:   Fri, 22 Oct 2021 16:18:16 +0200
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-03.10-045d58d8201-20211013T222329Z-avarab@gmail.com>
 <20211021223044.GA3615@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211021223044.GA3615@szeder.dev>
Message-ID: <211022.864k99kune.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, SZEDER G=C3=A1bor wrote:

> On Thu, Oct 14, 2021 at 12:28:19AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Subject: [PATCH v3 03/10] progress.c tests: make start/stop verbs on std=
in
>
> s/verbs/commands/ or instructions.
>
> Please call them what they are in the context of Git in general, or in
> a test script in particular, instead of what part of speech they would
> be if they were to appear in a sentence.

*nod*, although barring further issues I don't think I'll re-roll with
just that commit message adjustment...

>>  	progress_testing =3D 1;
>> -	progress =3D start_progress(title, total);
>>  	while (strbuf_getline(&line, stdin) !=3D EOF) {
>>  		char *end;
>>=20=20
>> -		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
>> +		if (skip_prefix(line.buf, "start ", (const char **) &end)) {
>> +			uint64_t total =3D strtoull(end, &end, 10);
>> +			if (*end =3D=3D '\0') {
>> +				progress =3D start_progress(default_title, total);
>> +			} else if (*end =3D=3D ' ') {
>> +				item =3D string_list_insert(&list, end + 1);
>> +				progress =3D start_progress(item->string, total);
>
> Why is it necessary to use a string_list here?  This is the only place
> where it is used, so I don't understand why we should store anything
> in it.

The progress.c API doesn't xstrdup() the title you give it, so you can't
free() it after while it's alive.

Here we're re-setting the same strbuf in a loop, so if we hand a "title"
to progress.c we need to keep it around, when we later add a BUG
assertion in 10/10:

+	if (global_progress)
+		BUG("'%s' progress still active when trying to start '%s'",
+		    global_progress->title, progress->title);
+	global_progress =3D progress;

The "old" title would point to already-free'd or to a nonsensical value
if we didn't do that.
