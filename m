Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C93C636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A7E613BA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhGORTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhGORTO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:19:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBCAC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:16:21 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so7012572otl.0
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=eK6PACu0W+W26iKTcYX5LBvLpMBxSXQCCsUby6YNNWQ=;
        b=doArfd7EXJK06w1V9spb9WuDOgMfYqkZVPvpXkJNOdDPE3aAu26lWDFObydafOxhPP
         DWLYW16nsAHrKYJ5FUjDAFyTQm05fDxNd9ghsNBqiKjenlI1DZxmuzMNSA07gSAWnwbQ
         UW/VLtvXpMS6smtYwFkGMsTCLDYcJRqbBMABXMkzZDzdA8btYYAqjWZKChuLH/3PUJwq
         gCqBN5ChqUApAapkJ0+jn+9cLa8tWxgPcAn6rqWyX/9liQca0Bw2SvQIuC+kNen9Kszi
         pY6cODSi0syI/jJFbRwMNtOs7HX8sE0FMzBAJMrcygQHwn1AzOZuJtnWusRT38LtkSS2
         ZRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=eK6PACu0W+W26iKTcYX5LBvLpMBxSXQCCsUby6YNNWQ=;
        b=czf04Va1YUfJhSYgOUHEnRr8dFyfLR8bryPR1G1XJOyCJEtc1wRAaGOVCa60P2gkxM
         2TTVUypQ1ouXIkoYVy97tpDiNhCzFlhUqw3sQQ4ohD1+ywGPipDj8+UX8UdUhq2Wg9FL
         0MXAjmt4991d5KAJV6xeCw3ElueTlP7zoUmjNrI/p0YObBAw6xdRhuyKYl4vBNOUyYEz
         ujZea+ATXH4PY5t/BZnWIIpnuAOLtkAf/GWFCkNrJFK+m05/xdpgBslu/kkb3G2ZGb5a
         6D/RcqaXNgxy7rKTZgYOnb4yPsowpxI6bqFZlhGyEg9YyVUIL4/1hcUQqnyQaeY/8+Cu
         Ni2A==
X-Gm-Message-State: AOAM530Wl/b2WPkJii7GYdWc27TP5W52oaMFAikzPEtUf2TFFj+6SaV0
        axe0U9Dvca/5eYrYXFYjfns=
X-Google-Smtp-Source: ABdhPJxYM7LGm313HEj2PUkLZu05A7B+doDA8MiDJzKblbY0D18rNN7sMpa84ViCfhPPMi8e7ZYqzg==
X-Received: by 2002:a05:6830:2a08:: with SMTP id y8mr215464otu.61.1626369380854;
        Thu, 15 Jul 2021 10:16:20 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id i188sm1376103oih.7.2021.07.15.10.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 10:16:20 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:16:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bwilliamseng@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <60f06d62868db_4b6820816@natae.notmuch>
In-Reply-To: <8735sfzgkg.fsf@evledraar.gmail.com>
References: <pull.996.git.1626353925051.gitgitgadget@gmail.com>
 <8735sfzgkg.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] parse-options: don't complete option aliases by default
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Jul 15 2021, Philippe Blain via GitGitGadget wrote:

> I'm a bit biased here since I like --recursive better, but let's not
> drag that whole argument up again. I don't find the argument in
> bb62e0a99fc (clone: teach --recurse-submodules to optionally take a
> pathspec, 2017-03-17) convincing enough to have moved such a prominent
> use-case to a longer option name.

I agree.

> But, water under the bridge. Aside from that:
> =

> For me a Google search for "git clone --recursive" is ~40k results, but=

> "git clone --recurse-submodules". The former links to various
> discussions/docs/stackoverflow answers, often --recurse-submodules isn'=
t
> mentioned at all or as an aside.

It would be nice if facts could be used as evidence of a UI mistake, but
alas in my experience that has never been the case.

> I think it's unfortunate that we:
> =

>  1. Conflate whether something shows up in completion v.s. the
>     help. Given its prominence and that "git clone -h" is ~50 lines why=

>     not note --recursive there.

Agreed.

>  2. Don't have the completion aware of these aliases, i.e. "git clone
>     --rec<TAB>" before your chance offers a completion of both, that su=
cks,
>     we should fully complete the non-alias instead.

Yes, that's what would happen with the patch.

>  3. Making it PARSE_OPT_HIDDEN "solves" #2 at the cost of hiding it in
>     "git help -h", and now this won't work, but did before:
> =

>         git clone --recursi<TAB>
> =

>     I.e. even if we didn't want to do #2 *and* wanted to hide it in the=

>     usage output surely completing an unmbigous prefix is better, even
>     if it's a hidden option?

This is something that could be done in zsh, but not in bash (at least
not easily).

> E.g. the user has used --recursive for years, but can't even find it in=

> -h (I also think it's a mistake to have entirely removed it from the
> docs, even if one agrees with its "deprecation" I'd say we should keep
> some "used to be called --recursive" note there).

But that is not a problem of this patch. If users can't find --recursive
and complain about it, then that's actually a good thing, because now
the facts about --recursive vs. --recurse-submodules are not needed
anymore, and we could just fix the interface.

-- =

Felipe Contreras=
