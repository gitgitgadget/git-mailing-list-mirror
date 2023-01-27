Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94658C38142
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 17:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbjA0Rjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 12:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjA0Rja (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 12:39:30 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238D34498
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 09:39:30 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id cr11so2094682pfb.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 09:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgXApyKBjUt3sNBV3Z3bBHlOqjqOOXN+WKtyaxX37VM=;
        b=UIrnjrxIzxzb3BKAiE/tBuD/0iGhvzza8CVsw74Mf42G1rfUBU9yhAdwUHuq4PLjRz
         gisADWuK13dO0MaRtVe82dVi/QGcmvjgtZBdBd5HwUjaTozFhMXTGN0ZBbvycOmfNQtD
         N9kkm0RhI6twY3QZ4I8vWIk/lHRPct0lj6POj4wVoeGS/RC7t+msGxGzVtOhsdxggzJv
         qnzPVBgvmt3zgS8XKnsuGzkznK8/c0s1xikQtnTBZCKB8XIWqWJO87zWRyx+yqaO9Yas
         TgHCoWtmf8VOYVBP/BoSkgjfbldueFuDqXL9ObOZ2h0ltW8rmjk+y7Si86a9w7yx/Ul1
         Sr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XgXApyKBjUt3sNBV3Z3bBHlOqjqOOXN+WKtyaxX37VM=;
        b=HnbtIwA6etWZv5/A3L0z+IeJmaqE8qjfj02BXF1qH1y7LmYgfudr29RfrWsTYHLJjT
         JBMFdVKoSm4AjIzYjUlkxb26dxVQlwrXpxNiFFp/UT9dJdanmQRJhzqrGC/v4rQneeT6
         XEJcPl2sF1rPDucOOlLnWf9Sj827ErHIBvRzbS2JeUsTSWgB8qC7clVipnklKP1OX0cI
         EcIzzYmmG5qlqPQrawkvSwmGF6OM/rUW4tYNfkkCsli4xTOo5ITu5651bGwrRqoIQFdP
         NftYRrZ7oQlO1wKJX0+QdVO+tbcr96Aa0zx21OaykLD54Rk5wyvrqpjMqitHKI/il9N8
         /9iQ==
X-Gm-Message-State: AFqh2koe+HfbP7YoKZFxVyavLQvhv7SkVPN/keoaFm0JLWoWV8UqwnVm
        rvmomSzIPhTSt39qcxuabWw=
X-Google-Smtp-Source: AMrXdXskKYdlEn4PLPa4bKlv74ZFfyIr2cdbNgIavGP7UEsmN3LJYNEEup8avGn1qBGl6A28WaV24Q==
X-Received: by 2002:a05:6a00:7c4:b0:58a:f300:42c9 with SMTP id n4-20020a056a0007c400b0058af30042c9mr37214703pfu.22.1674841169467;
        Fri, 27 Jan 2023 09:39:29 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id d21-20020aa797b5000000b005821c109cebsm2870459pfq.199.2023.01.27.09.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:39:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
        <20230127154952.485913-1-minipli@grsecurity.net>
        <xmqqbkmk9bsn.fsf@gitster.g>
Date:   Fri, 27 Jan 2023 09:39:28 -0800
In-Reply-To: <xmqqbkmk9bsn.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        27 Jan 2023 08:34:16 -0800")
Message-ID: <xmqq1qnfancf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Yes, the "instead of failing hard, fall back" makes sense.  Just
> that I do not see why the runtime test is a good thing to have.  In
> short, we are not in the business of catching bugs in pcre2_jit
> implementations, so if they say they cannot compile the pattern (I
> would even say I doubt the point of checking the return code to
> ensure it is NOMEMORY), it would be fine to let the interpreter
> codepath to inspect the pattern and diagnose problems with it, or
> take the slow match without JIT.
>
> What am I missing?

Note that I've seen and recently re-read the discussion that leads to
https://lore.kernel.org/git/f680b274-fa85-6624-096a-7753a2671c15@grsecurity.net/

I suspect that this auto-probe is related to solving "the user
thinks JIT is in use but because of failing JIT the user's pattern
is getting horrible performance" somehow.  But I do not think a hard
failure is a good approach to help users in such a situation.

After such a failure, the user can prefix "(*NO_JIT)" to the pattern
and retry, or give up the operation altogether and not get a useful
result, but wouldn't it be far more helpful to just fallback as if
(*NO_JIT) was on from the beginning?

Also I notice that p->pcre2_jit_on is per "struct grep_pat", so it
is not like "once we see a pathological pattern, we turn off JIT
completely for other patterns", right?  That is, if you have

    git grep -P -e "$A" -e "$B"

and we fail to compile "$A" (for whatever reason), we could still
(attempt to) compile "$B".  Perhaps $A was too complex or was
incompatible with JIT combined with other options, but $B may be
easy enough to still be JITtable, in which case we would match with
the JITted version of $B with interpreted version of $A, instead of
failing, right?

THanks.
