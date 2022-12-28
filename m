Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A63C4708D
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 08:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiL1Inr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 03:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiL1InI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 03:43:08 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD42FCD4
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 00:42:16 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id tz12so36925007ejc.9
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 00:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQZo+Y62G211mBrVFX+zTVI0sLssMp3FccO/uVf01Ts=;
        b=SMxC4QLCnvvXh+7n6GFCP7Itd7yMSRZdo6AoQlobKuALer/HGYaDksJrFYAXHzKYGm
         rBSWaiw7ipZpftkF/BnWJmDDUZOcYQoXfGsySfC6DIo9r3kkWg+/FP4A7sU0YAPvaAAS
         YGgSfMNaF9wjE95hDhkb5kp/srhMzMpwuNU4SuMwPoojWd16FylNxlepXLSjnqkP+MZI
         7UPSA35jnJn7/Ev+hnf92FMTKun+shWsIdpf60oWWnUI4OpWEO7TdWGhfwsymT4AkCh4
         N5u+doZjt/nkhAYt+fIDWPt2+GVRx+ivMilADr7uY4jqX3jLo7K7NDnVGTyatKvmQPBZ
         6Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQZo+Y62G211mBrVFX+zTVI0sLssMp3FccO/uVf01Ts=;
        b=wMrKle57YSi6AzSGpJYCFBUkGMP5g9iBqjwoZbG8PhAu6krNLpyWisgED0tOR6mUY6
         L4mYNLH0yLrfN7SmZ70Y9Bm0qJnL4zqcSm1juJhVM0I7eNZwu3CB0q1lLKhWPvptP9+6
         4RsY5yIf9V4Ad4FPWWkIZn5iELL3Wf/nCCqOUvb3jV6fAGgRy39RVnsI3gw+nIl9Oda1
         sMJPWDJ+fMOqWqTIfbWv+933/+d5kc0BB11bhwYYVM9wq4P3nJEBYVgZ5YjfhD8uifxy
         coUHDw6OBd/iYwxO9a6YLRjpPA0+57+F3rLlFWe3a6hW8NdJeG1f0F4XRJFSIwdy9INM
         wxyg==
X-Gm-Message-State: AFqh2kphnrPtFmo6vNFZ3iwLb0ti5MqWwkxSKAcrYQmCzJPtgekZPhXX
        4YDsIrgsmfhBXLo+b+W3IfL5rmm0QnSL5Q==
X-Google-Smtp-Source: AMrXdXu1w8jNw924QnZpuxYUAD/L5W3Qs8STQf1uADByKFAQ4JhkxJybIqXeoHfjG6fOR1sw+Hqi4g==
X-Received: by 2002:a17:907:8b09:b0:7c1:bb5:5704 with SMTP id sz9-20020a1709078b0900b007c10bb55704mr21513525ejc.26.1672216935040;
        Wed, 28 Dec 2022 00:42:15 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b008448d273670sm385934eja.49.2022.12.28.00.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:42:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pAS0r-009XFr-2z;
        Wed, 28 Dec 2022 09:42:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: built-in-submodule & in-flight dependencies (was: What's cooking in
 git.git (Dec 2022, #07; Mon, 26))
Date:   Wed, 28 Dec 2022 09:36:43 +0100
References: <xmqqcz86n8bn.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqcz86n8bn.fsf@gitster.g>
Message-ID: <221228.864jtfvs0q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 26 2022, Junio C Hamano wrote:

> [...]
> [Cooking]
>
> * ab/no-more-git-global-super-prefix (2022-12-26) 9 commits
>  - read-tree: add "--super-prefix" option, eliminate global
>  - submodule--helper: convert "{update,clone}" to their own "--super-prefix"
>  - submodule--helper: convert "status" to its own "--super-prefix"
>  - submodule--helper: convert "sync" to its own "--super-prefix"
>  - submodule--helper: convert "foreach" to its own "--super-prefix"
>  - submodule--helper: don't use global --super-prefix in "absorbgitdirs"
>  - submodule.c & submodule--helper: pass along "super_prefix" param
>  - read-tree + fetch tests: test failing "--super-prefix" interaction
>  - submodule absorbgitdirs tests: add missing "Migrating git..." tests
>
>  Stop using "git --super-prefix" and narrow the scope of its use to
>  the submodule--helper.
>
>  Will merge to 'next'.
>  source: <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
> [...]
> * ab/config-multi-and-nonbool (2022-11-27) 9 commits
>  - for-each-repo: with bad config, don't conflate <path> and <cmd>
>  - config API: add "string" version of *_value_multi(), fix segfaults
>  - config API users: test for *_get_value_multi() segfaults
>  - for-each-repo: error on bad --config
>  - config API: have *_multi() return an "int" and take a "dest"
>  - versioncmp.c: refactor config reading next commit
>  - config tests: add "NULL" tests for *_get_value_multi()
>  - config tests: cover blind spots in git_die_config() tests
>  - for-each-repo tests: test bad --config keys
>
>  Assorted config API updates.
>
>  Waiting for review.
>  source: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>

I see that ab/no-more-git-global-super-prefix has landed in "next", I
was planning to submit the built-in submodule topic after it, i.e. the
change to get rid of git-submodule.sh.

But the post-cleanup in that topic of moving the relevant code from
builtin/submodule--helper.c to builtin/submodule.c would conflict with
ab/config-multi-and-nonbool, as some of it uses the *_multi() API.

Now, it would be relatively easy to solve those conflicts, but I'd also
like to make it easier for you, Junio.

So more reviews on that topic would be most welcome. It fixes quite a
few segfaults we currently have in-tree, so I'm a bit surprised at the
relative lack of interest.
