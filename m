Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA777C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 18:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiLLSdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 13:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiLLScY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 13:32:24 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA3C18E38
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:30:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m18so30314320eji.5
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VsTup2/A4wkt4BvhUcqc84GzJZuk9fJrKwPLpFtVW5U=;
        b=NHwBeWv0dwfp9nyTzC0dwzz7Gi9bUNEygGRl+heWGcQH6GQ1NoHFG+qEpjXGHdorm9
         L10WmGim3I/kci3dtVduqgtBbDLggqaRrgRa1W0CmCfBTHhaoF0fS105jNCgcR39TC0k
         9U6xgDhRrlQ8/BekS3LX13PK+acbIA07KqCvhx/NzBxD+OroBVAm26kj15BX8kFM1f0R
         1H6JOoj6QmffiQZBpatD0I1QxkPd7nqCWzJdn73p0vUmZ1Ak6ZouBFlY+EhjsczxRwrP
         Zh1GUH5DfKils7vMw7fsW+NlA0nY1q6rxYd03RlU8JwXKT5FuGX6+ESjn8p1ujrk3j3H
         2Htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VsTup2/A4wkt4BvhUcqc84GzJZuk9fJrKwPLpFtVW5U=;
        b=iUO7wQ7eXnvJjXZAYgVBC2GFIe1SP30tdIO+ayNOfNUkR/HNQTET8Qz5WoznpT6euy
         6dolNcb6ekzSnfNR97O70+gVcnyQcEpoBwMl85hoSHSHazXY2zO9DViMiSYFduahdG83
         DjVVbzQCNktPtCgcdBDZkwMPm5irDzOZNcsVqYQGURmNfSXpmTyLdJf0TnT4VKMIdxZt
         uEQx5kYLubcmrF9pKacdXLP3fafM+yXtmyJ5+pSBMFTfiZWx9akEQz7UdO4F7LuGkLoI
         tCjKfziOx4g/f6y1ZFM3WFM/cGf0DqvggvzRX/nrzgJQlHMjHq+nLDIVFfSIYej8YRAl
         C1Kg==
X-Gm-Message-State: ANoB5plqmSoBzIKns4iyXPwMma6fThPMD/wwU9tg3UUN4+ub5IUHHTGh
        NXCre4XvdksVTxu1k0YZDbt0FzI/QvI=
X-Google-Smtp-Source: AA0mqf704YNPjhlouxrZoSaJRV345vWwqkjxALAuOUv5MHAd0XiwAMbdjH9KVRoQvWKGnqM9WpXQLw==
X-Received: by 2002:a17:906:b6c9:b0:7bc:9a78:bc3a with SMTP id ec9-20020a170906b6c900b007bc9a78bc3amr13877111ejb.68.1670869810582;
        Mon, 12 Dec 2022 10:30:10 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090671cb00b007c0c1e18e28sm3506493ejk.124.2022.12.12.10.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:30:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p4nZ3-005S5s-2C;
        Mon, 12 Dec 2022 19:30:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com
Subject: Re: [PATCH 4/4] features: feature.manyFiles implies fast index writes
Date:   Mon, 12 Dec 2022 19:27:01 +0100
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <77bf5d5ff27729a39ac00d52af3c09610d733b14.1670433958.git.gitgitgadget@gmail.com>
 <221207.86v8mm972z.gmgdl@evledraar.gmail.com>
 <1b2aa60c-633f-0a7f-e8e3-5d0f01ff94b6@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <1b2aa60c-633f-0a7f-e8e3-5d0f01ff94b6@github.com>
Message-ID: <221212.86v8mg4gr2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 12 2022, Derrick Stolee wrote:

> On 12/7/2022 5:30 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Dec 07 2022, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> From: Derrick Stolee <derrickstolee@github.com>
>>> [...]
>>> diff --git a/read-cache.c b/read-cache.c
>>> index fb4d6fb6387..1844953fba7 100644
>>> --- a/read-cache.c
>>> +++ b/read-cache.c
>>> @@ -2923,12 +2923,13 @@ static int do_write_index(struct index_state *i=
state, struct tempfile *tempfile,
>>>  	int ieot_entries =3D 1;
>>>  	struct index_entry_offset_table *ieot =3D NULL;
>>>  	int nr, nr_threads;
>>> -	int skip_hash;
>>>=20=20
>>>  	f =3D hashfd(tempfile->fd, tempfile->filename.buf);
>>>=20=20
>>> -	if (!git_config_get_maybe_bool("index.skiphash", &skip_hash))
>>> -		f->skip_hash =3D skip_hash;
>>> +	if (istate->repo) {
>>> +		prepare_repo_settings(istate->repo);
>>> +		f->skip_hash =3D istate->repo->settings.index_skip_hash;
>>> +	}
>>=20
>> Urm, are we ever going to find ourselves in a situation where:
>>=20
>>  * We have read the settings for the_repository
>>  * We have an index we're about to write out as our "main index", but
>>    the istate->repo *isn't* the_repository.
>>  * Even then, wouldn't the two copies of the repos have read the same
>>    repo settings?
>>=20
>> But maybe there's a really obvious submodule / worktree / whatever edge
>> case I'm missing.
>>=20
>> But if not, shouldn't we just always read/write this from
>> the_repository?
>
> I don't understand your concern. We call prepare_repo_settings(istate->re=
po)
> just before using these settings, so we are using whatever repository-loc=
al
> config we have available to us.
>
> If you're thinking that we could be writing an index but istate->repo is
> somehow the "wrong" repo, then that is a larger problem. This patch is
> doing the best thing it can with the information it is given.

It's not a concern, just confusion :)

In the preceding step (and this is still the case in your v2) we used
git_config_get_maybe_bool(), if we meant to use istate->repo shouldn't
we have used repo_config_get_maybe_bool() to begin with?

And will we ever get !istate->repo? If not should we BUG() here?
Otherwise the 4/4 changes this to a state where we'll no longer read the
index.skipHash setting if that "repo" is NULL, but our previous
the_repository was non-NULL...
