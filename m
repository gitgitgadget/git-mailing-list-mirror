Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC60C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 10:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhLRKAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 05:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhLRKAd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 05:00:33 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5118C061574
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 02:00:32 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id e3so17308601edu.4
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 02:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LwXVniIKztpgLhuKc3vj/r4516FhxN8AGboPzFUCTDo=;
        b=GM/7kVdnrSe33zdiFYSI8Da01HJrDRaIZ7LavjNgM7y0djtlOm0ctcGNdMMQppBGJB
         44WsZGYASzVZglbZI8BBbLpKc46MdlBQAOP84tCpJfqY05AlQO4sL8p1DjPabOSt+GHz
         FaFx/yJDWvarRCAF4+GhiNGYVr7i66WPosWMskE6BOUW/1EdUg4qxF3Vt6t2jLsX1Gex
         XEQ2ILtVC71AVd3lTPgyvc+yloF7PRdPfi+7Jm60sfj9vw3wzvkWnXJIyEPaFrEDxiBN
         4sOS7E7JmgzFvichLQdXYgMjNtCde0ZZ9lzmHsXQsgOSwK3zQtt/P2QRf+dFTNf9objx
         8N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LwXVniIKztpgLhuKc3vj/r4516FhxN8AGboPzFUCTDo=;
        b=UIPwxHo+vFuVFmTiyHorMUpiPLIvKXBvO8l2K/oMMOHZoyuCkmbOMtkc3wi1yrkek+
         RTmZQeYb3yXuMn+IMljFKtUztwX56R6//KqJZYFcmVdeExpvlT4krWXnqb9I3yMh3oFr
         6uvKaTfuvBRHJIxJx5ypk/HFVL6A5q5VUbr9sIKIBx73XKNVnf9KPEQX2jmaR3X0yfjn
         ZySIuVt+bEGwpXunT45+d1tKVy40dtbFt1RC0kHjuGL6V6XJybZLxOG48n19sP1rE3xO
         qliir+wtwlzeuEbLBMapCtxyVB6gQkX/FGn0iNExiHVctL5tJutk37QA1CC1YoQdrLXN
         +yXw==
X-Gm-Message-State: AOAM530bN2vzGtDkyYkRbQS39WuLqZDw06PwP9bg7z/x3VMtlef6d0qG
        j3Ae2ipFCE8wj5yBS9/2DpA=
X-Google-Smtp-Source: ABdhPJySJfzubL7xvW5uadtePOpvJdALAB/iTuaJ+8Z9TzZLMpFvhRVws2KWJ0mvd29YzeiMIUK6oQ==
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr5282745ejs.146.1639821631128;
        Sat, 18 Dec 2021 02:00:31 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x7sm4679428edd.28.2021.12.18.02.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 02:00:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1myWVy-000GvR-1j;
        Sat, 18 Dec 2021 11:00:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] repack: respect kept objects with '--write-midx -b'
Date:   Sat, 18 Dec 2021 10:58:01 +0100
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
 <1ed91f6d255b76bdbdcccea7e1effcebbb263ced.1639758526.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <1ed91f6d255b76bdbdcccea7e1effcebbb263ced.1639758526.git.gitgitgadget@gmail.com>
Message-ID: <211218.86wnk2w7uq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 17 2021, Derrick Stolee via GitGitGadget wrote:

> +test_expect_success '--write-midx -b packs non-kept objects' '
> +	git init midx-kept &&
> +	test_when_finished "rm -fr midx-kept" &&

Nit: Better the other way around, so we'll clean up things if "git init"
dies midway, but unlikely to ever happen here.

> +	(
> +		cd midx-kept &&
> +		test_commit_bulk 100 &&
> +		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
> +			git repack --write-midx -a -b &&
> +		cat trace.txt | \
> +			grep \"event\":\"start\" | \

The "cat" here should go in favor of "grep <pat> trace.txt", and can't
this all be on one grep line with "." between the relevant parts you're
extracting out?
