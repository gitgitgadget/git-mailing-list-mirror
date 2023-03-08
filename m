Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB9BC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 10:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCHK4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 05:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCHK4N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 05:56:13 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE3A149A1
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 02:56:09 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o12so63952267edb.9
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 02:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678272968;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LkrMaNYY6u75jHAP5zfVy4t6eyetfa/Z1tCDz0XkAc=;
        b=h74ZcfeeoEx8rPlKuXlikUcI89qTZ/eHwuK8J4OvL/c7BB43gf/OdjIlMmgogtFP41
         7UKOvXFnCkurrWd2KASh7P/Rr7esworSvTEwBzpqceALt2KQ3SnTYL9sCrqo0HbuRPUj
         zfP7GqXLZuZYBvKN9Nhq1y6Dcc0jgDGy2pGFPo8vQw537z/6mY3/2lbZskVRCH6XTMvF
         /fMy2vZs3e3scKC1pEjoTz49Criae1oYqLRD9febvZtuBQGa2DiKyqDaW054+5z8Gcyk
         Rt/ONDb1//bBoHlfQcQ7drdBpl3JP+6R5RaquOB2jCtchFwvJlZIZ6wEP3ZGKogeNPvl
         VWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272968;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LkrMaNYY6u75jHAP5zfVy4t6eyetfa/Z1tCDz0XkAc=;
        b=TJc6WGcTwybxEz1J7hdRWkDt07qxNr84o3dgCd7VWqpDcf3kR9egVxdPkLeHNMaGN8
         pSrQoDGwlWV+QeSB4m2he78Osu/jM4NPQnkVQ4m0rDLIwbcyEqT9rAd3ttEQyc6AQOEe
         1udLXl8vBLCbsFJvEvf0hPxfLWdjuGLsVUbh1cPh+FgVq1E5NjlzJeQcrFYUxj7kCUi2
         UhVItwFqa+98YDBamsSVRVOwxLX7iZ5FSGI888q3IU60CH20k5KEu85CfJPXm4kJwdeX
         fnH9HEtxKsWi1vJFErs4K1F4HqsVUJoGthc3UrjFXwH4JJR7JAJ4VEzVTn/Wh5gdbSTz
         G+Uw==
X-Gm-Message-State: AO0yUKWY7dpXZNZCLKWR9jaSarZ4bezY6LHxAB0rLlSNyZFNwmpCFqn8
        5UwwvyfCeYXYySjZLmKaudc=
X-Google-Smtp-Source: AK7set8PZvnaSDrEY5UZ4d5svn4NMaNLqivEpZYcoJBEjLn5PFTh6lhMNy5mI6tSGPezITqQHYQDvw==
X-Received: by 2002:a05:6402:382:b0:4ad:152b:8f69 with SMTP id o2-20020a056402038200b004ad152b8f69mr16795662edv.17.1678272968331;
        Wed, 08 Mar 2023 02:56:08 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id k26-20020a508ada000000b004af6b93f00asm7934610edk.23.2023.03.08.02.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:56:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZrSp-000vFr-0l;
        Wed, 08 Mar 2023 11:56:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Glen Choo <chooglen@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/6] [RFC] config.c: use struct for config reading state
Date:   Wed, 08 Mar 2023 11:32:16 +0100
References: <kl6l356heeqb.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20230306223804.3414251-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230306223804.3414251-1-jonathantanmy@google.com>
Message-ID: <230308.86y1o7y0jc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 06 2023, Jonathan Tan wrote:

> Glen Choo <chooglen@google.com> writes:
>> By configset interface, I believe you mean the O(1) lookup functions
>> like git_config_get_int() (which rely on the value being cached, but
>> don't necessarily accept "struct config_set" as an arg)? I think that
>> makes sense both from a performance and maintenance perspective.
>
> Ah, yes. (More precisely, not the one where you call something like
> repo_config(), passing a callback function that.)
>
>> Given how painful it is to change the config_fn_t signature, I think it
>> is important to get as right as possible the first time. After I sent
>> this out, I thought of yet another possible config_fn_t signature
>> (since most callbacks only need diagnostic information, we could pass
>> "struct key_value_info" instead of the more privileged "struct
>> config_reader"), but given how many functions we'd have to change, it
>> seemed extremely difficult to even begin experimenting with this
>> different signature.
>
> Yeah, the first change is the hardest. I think passing it a single
> struct (so, instead of key, value, data, reader, and then any future
> fields we would need) to which we can add fields later would mean that
> we wouldn't need any changes beyond the first, though.

The more I've looked at this the more I'm convinced this is the wrong
direction.

For the configset API users we already have the line number, source
etc. in the "util" member, i.e. when we have an error in any API user
that uses the configset they can error about the specific line that
config came from.

I think this may have been conflated because e.g. for the configset to
get the "scope" we need to go from do_git_config_sequence(), which will
currently set "current_parsing_scope", all the way down to
configset_add_value(), and there we'll make use of the
"config_set_callback", which is a config_fn_t.

But that's all internal "static" functions, except
git_config_from_file() and git_config_from_file_with_options(), but
those have only a handful of callers.

But that's *different* than the user callbacks, which will be invoked
through a loop in configset_iter(), i.e. *after* we've parsed the
config, and are just getting the line number, scope etc. from the
configset.

There's other edge cases, e.g. current_config_line() will access the
global, but it only has two callers (one if we exclude the test
helper). But I think the answer there is to change the
config_read_push_default() code, not to give every current "config_fn_t"
implementation an extra parameter.
