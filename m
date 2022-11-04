Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E20C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 01:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKDBoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 21:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKDBoS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 21:44:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D272317E
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 18:44:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f7so5647650edc.6
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 18:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ptYaZ9Q5n1FSxsF2ySKZAQA05261/o4ma9OvI2BGWts=;
        b=fTUeVFW0WGMVQBe8gHDKXZBeuwMV5ht72mVjP0yo26769wkzpwn5BQ7w+X92LM6RWa
         JD4935Rb4HppYW7t362sR0+teo6oQkdsV0LOMYntLkNfawxWYzrxt1SY6kmbEpTKleRT
         hXv8/xJy2Rf0FOL4Lr3QedppHkCD5XTF3BbCbOLGpjU8cexOJwye+BHjs4fTI9dSconL
         skgxxJUL4NaqQVWv3bOHArrObq+WXYbaKG2srJ692/aESG8rPR0rB2n4Xb7Sj6iiz/Z6
         N5FOccSO4E5wlSglVd9bYSCIgP63Vn3HhGRllgjYcFnojdkzctyEQGO5xOjyj57n3wuE
         kx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptYaZ9Q5n1FSxsF2ySKZAQA05261/o4ma9OvI2BGWts=;
        b=orm8JhNz3qiwoOsaMM9m1eNwvr6qG3OSZ5gA3D1/znjg5yqmH8y6donN2lC6FNo841
         Maw6FB8zC3gIiOoOhnQuqoR5RN+wuAQeIqUystDGO2M2vOii1qRLTutDUR8XqCHzQy8x
         kz4yHC/HtA0opmLvcMYP4pWiOqx+/gijRd/et5CJ8oDDKXJTbGJO+eumUugRpuBv5BkI
         EuZFyF8rT6t0jaOQMdxrjKpWiwwzEqlF6uX6t9vRyK93LQC7axMsXkh+bOs4ed3RyTdm
         BFrCl/6yLFrt/PqleCwIw7UY8LvXzvDGNzIXqi4xP4zb3yHoQ1LUr2JCmEAPHVOG+n0w
         BnBg==
X-Gm-Message-State: ACrzQf0xB4xtBJah5TwU4t48J5AFqzj3iXy27pLEWUPsGJEbAeUK2/Iw
        AJ4dteze+sqtBKR1jP5fYQoKQI8FoMaxRw==
X-Google-Smtp-Source: AMsMyM5+CeZSGIw1v8REueTzm4DLSzfNtjeLBNNZVnJmLqCSiv8gerR5IV5plCaHxoFUpVUaSK+YsQ==
X-Received: by 2002:a05:6402:1bda:b0:464:4eb2:8c25 with SMTP id ch26-20020a0564021bda00b004644eb28c25mr3945025edb.278.1667526255564;
        Thu, 03 Nov 2022 18:44:15 -0700 (PDT)
Received: from gmgdl (j84064.upc-j.chello.nl. [24.132.84.64])
        by smtp.gmail.com with ESMTPSA id t24-20020aa7d4d8000000b00461a98a2128sm1227504edr.26.2022.11.03.18.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 18:44:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqlkk-00D239-2E;
        Fri, 04 Nov 2022 02:44:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 5/8] submodule API & "absorbgitdirs": remove
 "----recursive" option
Date:   Fri, 04 Nov 2022 02:42:59 +0100
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
 <patch-5.8-2b8afd73b9b-20221102T074148Z-avarab@gmail.com>
 <kl6la657odjz.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6la657odjz.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221104.86fsezze6p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Remove the "----recursive" option to "git submodule--helper
>> absorbgitdirs" (yes, with 4 dashes, not 2).
>
> o.O
>
> At least this makes it pretty easy to grep for usage, and it makes sense
> that we've never used it (otherwise this would've been caught).
>
>> diff --git a/submodule.c b/submodule.c
>> index fe1e3f03905..8fa2ad457b2 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -2332,8 +2331,7 @@ static void absorb_git_dir_into_superproject_recur=
se(const char *path)
>>   * having its git directory within the working tree to the git dir nest=
ed
>>   * in its superprojects git dir under modules/.
>>   */
>> -void absorb_git_dir_into_superproject(const char *path,
>> -				      unsigned flags)
>> +void absorb_git_dir_into_superproject(const char *path)
>>  {
>>  	int err_code;
>>  	const char *sub_git_dir;
>> @@ -2382,12 +2380,7 @@ void absorb_git_dir_into_superproject(const char =
*path,
>>  	}
>>  	strbuf_release(&gitdir);
>>=20=20
>> -	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
>> -		if (flags & ~ABSORB_GITDIR_RECURSE_SUBMODULES)
>> -			BUG("we don't know how to pass the flags down?");
>> -
>> -		absorb_git_dir_into_superproject_recurse(path);
>> -	}
>> +	absorb_git_dir_into_superproject_recurse(path);
>>  }
>
> Maybe I'm misreading, but I don't follow this change.
>
> Before, we recursed into the submodule only if the
> ABSORB_GITDIR_RECURSE_SUBMODULES flag is set (which we now know is
> never), but now we unconditionally recurse into the submodule.

No, it's always set. I.e. ----recursive did nothing, but the default was
to always set ABSORB_GITDIR_RECURSE_SUBMODULES, so it was never not-set
(and there was no --no---recursive user).

So we should be unconditionally going on this recursive path.

