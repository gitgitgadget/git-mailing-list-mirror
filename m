Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C79DC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiCAE1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiCAE1t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:27:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AE1506CE
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:27:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 11-20020a25030b000000b00628660166e7so2834710ybd.13
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jxN0hd4rmEvl9vT8Qi/LlM/+KZM677d9AQFg86orfN8=;
        b=pxVHZz6Jn1ob7w8WXYZw5wHzf3CSQJEMOmAGXGiBOYtjKQ+HKUDSnq1BuEPt8oUQL6
         bwxVJXZ7cw1VEMK8YMubv55xtub+yddV8o3ayK/ewpioSZELq7B24rIgTlumiw+zZavu
         K3r7Wa/a9ZpwkLFo14Y9Q0O2nwPvYash8BiFMe7+EPxLxbFHWTo1PuSeNUr/AMUrAA+G
         Ttp3moaL0T+1RY3vKmrFMwYT6t/JWvWkvbqgWADFUOA9UV1qaHeJJNVXmGNXiZcRnLt+
         S/6sxA+3FNW4UXQFabXMwC0TAnwrELv5YnmumlzeoX3OLwU4AV09KCi5DMijIq71aCQu
         DFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jxN0hd4rmEvl9vT8Qi/LlM/+KZM677d9AQFg86orfN8=;
        b=fsrmIfs8uZmX+Vxd36howYpLuWUDCM8+xy4KE9CUgnYPuFwXeAopDIYlB3jIWjtZi+
         hz/T6tP+V5BVGZYjz61vJKm7se6hCiGoAmE8LcQ3KyVaHmqRKKnNnaefeW+c5wvKCc3c
         doQ9RsMsNP9utA0ZSDd/PnWjovZX1ttiHWP8aSNKHlGknowaof4VfxabYjuh/BS3NQcP
         /LhfUVvyIWPZnuh9Waz8r8EomYWGgYv3dvldeIB6vgQ44hKBG7Zj3CP+fVbUwsowS82j
         La/kb9Ym/gDVUcnEbDtoVBjp+/ud8Mkq9pwel3Av6RKXsEH7mMYSs8wanAzX8X0bdSbn
         6sCg==
X-Gm-Message-State: AOAM531bbrf3aB6UPo0wK8bEpZPIZs9fjeRghWDP8pmbhToFYAWhjBFS
        IE3h6BrWfHNv3ZirjkfjFH43uk+o1fXNDQ==
X-Google-Smtp-Source: ABdhPJwOpm7Rc2knWg/Tm/vmDF87geyKY37SWxm4EAIUhhFsU/ZS15KQjzPSgtbyNnY9GgFdhgKIEoiEtlV7+w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a0d:c082:0:b0:2d0:cb2f:ae2e with SMTP id
 b124-20020a0dc082000000b002d0cb2fae2emr23654902ywd.226.1646108827701; Mon, 28
 Feb 2022 20:27:07 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:26:59 -0800
In-Reply-To: <xmqqilsywfsj.fsf@gitster.g>
Message-Id: <kl6ly21unvqk.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301000816.56177-7-chooglen@google.com>
 <xmqqilsywfsj.fsf@gitster.g>
Subject: Re: [PATCH 06/13] submodule--helper: get remote names from any repository
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> +	struct ref_store *store = get_main_ref_store(repo);
>> +	int ignore_errno;
>> +	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
>> +						      NULL, &ignore_errno);
>
> Given that 00/13 says this series is based on 715d08a9 (The eighth
> batch, 2022-02-25), which includes 03bdcfcc (Merge branch
> 'ab/no-errno-from-resolve-ref-unsafe', 2022-02-11), I think the
> above two lines are result of incorrect rebasing or something.
>
> Have you compiled after you rebased?

It turns out that I didn't.. I got complacent after doing this merge a
few times.

> It seems that after applying the band-aid below, t7406 seems to fail
> for two of its tests, too, but if this were not even compiled, that
> is to be expected X-<.

This is an even sillier mistake.. patch 12 accidentally includes some
tests from es/superproject-aware-submodules (probably a bad merge
conflict resolution).

>
>
>
>  builtin/submodule--helper.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git c/builtin/submodule--helper.c w/builtin/submodule--helper.c
> index ea88f39fb4..21401ad99e 100644
> --- c/builtin/submodule--helper.c
> +++ w/builtin/submodule--helper.c
> @@ -36,9 +36,7 @@ static char *repo_get_default_remote(struct repository *repo)
>  	char *dest = NULL, *ret;
>  	struct strbuf sb = STRBUF_INIT;
>  	struct ref_store *store = get_main_ref_store(repo);
> -	int ignore_errno;
> -	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
> -						      NULL, &ignore_errno);
> +	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL, NULL);
>  
>  	if (!refname)
>  		die(_("No such ref: %s"), "HEAD");
