Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D399C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 06:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EE361019
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 06:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244935AbhIQGCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 02:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244928AbhIQGB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 02:01:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0234FC061764
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 23:00:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c22so25725840edn.12
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 23:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xWd6VVDeP2sMO4nh1nzGkCXF9SrZgxrd9lQqYZt9zVk=;
        b=Gj1TT7hvIVWfVzLphWMvkc9kMkSvtiKa3RH8W21wBQsjxuG1Tk0MwQmu/l+Q35MuZv
         UQ1uXjnmbqODNEbmK7e+ExqVuaOsSGLAJokHaAFwGEcXzjz5LUNnuo5ctey5Dbo/YHE9
         F4FnNBQvFwlrXKAq2olrnD4lGoJXKd2N4G5+P4LNpfmcpGw9T5aKSNJlzm51/OrvxK7q
         51+uagYcCASIi1h1vVXAEcxXzJ7o8D3rKfsMoq7dDVkcDAjblEtC6HLLnqQARt/4PU/U
         1VQV71h4EJ6usmCSe5vY1YIAiaINNpFvm6sxB7iAemJ4ncSCu6Jd+S88VrankHRr0gVf
         BHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xWd6VVDeP2sMO4nh1nzGkCXF9SrZgxrd9lQqYZt9zVk=;
        b=w+ThVcObkNxlSFlWSvDqB6qSSbf6wO4bHBo5SnBcqjNiHkJMmwp5cCRQJmx0cbxsaX
         A5doQdvRxI1XjUyuIYHPTRKABYt+mYCBSmfYbwbp0mGWjgr9+p8MKXHpxTqCSM1jhh/U
         CWJMduQ4PMaUEc51hbrCrhrlpJkgqAHYOH2qb08Jdwkq+OtcZNxjC+ljUaRpN/QowwHU
         mDzrPHGzRMQjqSlNWE99OiLuKIet0SCkfiWWSYrscmXZro+zeboNLYqVB1Qj4rutGpeG
         dlQtHq9/w7rchQHJF8tb9sgPsVW8H+vORIjS8oCLlvPvaRhXv4t9k+JLb6XCtZokMSWk
         EqxQ==
X-Gm-Message-State: AOAM5308JNEnUWZ0njJVes636RxwFCDJyad8t6mH91aIbwmGJW9nLb3c
        aQCXPo5Zw5fbDxLcjcvws30=
X-Google-Smtp-Source: ABdhPJwYrCsyGftSIWFlsuGRVT3vrlzkD8pvayIbVxHvLVoNFMdTMOgN23r6Ucptl4CFhkSauMeZuw==
X-Received: by 2002:a17:906:7792:: with SMTP id s18mr9977783ejm.492.1631858436496;
        Thu, 16 Sep 2021 23:00:36 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o3sm1890663eju.123.2021.09.16.23.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 23:00:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 11/25] pack-bitmap-write.c: add a missing stop_progress()
Date:   Fri, 17 Sep 2021 07:56:48 +0200
References: <YNKWsTsQgB2Ijxu7@nand.local>
 <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
 <patch-11.25-7f5b71fe1be-20210623T155626Z-avarab@gmail.com>
 <20210917051448.GB2118053@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210917051448.GB2118053@szeder.dev>
Message-ID: <8735q3g2rg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 17 2021, SZEDER G=C3=A1bor wrote:

> On Wed, Jun 23, 2021 at 07:48:11PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
>> bitmap writing, 2013-12-21), we did not call stop_progress() if we
>> reached the early exit in this function. This will matter in a
>> subsequent commit where we BUG(...) out if this happens, and matters
>> now e.g. because we don't have a corresponding "region_end" for the
>> progress trace2 event.
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
>
> When I found this bug I fixed it differently: with your patch there

Is that patch on-list somewhere or something you have locally?

> are no display() calls at all between start_progress() and this new
> stop_progress(), indicating that a stop_progress() is not missing but
> rather the start_progress is in the wrong place:

*Nod*, I'll see about fixing it differenty depending on the above / any
other comments.

Note that while this comment is current to
https://lore.kernel.org/git/patch-7.8-eb63b4ba6a-20210722T125012Z-avarab@gm=
ail.com/
as well, as noted in
https://lore.kernel.org/git/877dffg37n.fsf@evledraar.gmail.com/ you've
had several comments on the 25 patch series not currently queued in
"seen".

Still very useful as I'd had some of it planned for after that 8-patch
series, just noting it for context.
