Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3678BC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 22:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA74610A3
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 22:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFTWTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 18:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFTWTC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 18:19:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D672C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 15:16:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id og14so25442951ejc.5
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 15:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=htOjNSx4GjKiziwMh+3ltrSB8ALm75kEhq8fpe7z8Ss=;
        b=lhhYZqEp+uLty3EpVjnV6uqtCkzbNuwQlVzpIU73xs5Csa3CNyMHxES0xhlQZ7Fq/U
         zsyYZgrur7x4FT6ST7CmjqUwRUL3hinTKVKctztw/B7kwGJO07fT/bkBv7c3Djf4VNnB
         Q+RqWvsngAszlG0zNAdoIK7Jx/Cy3kTKmCiRmCogGFc3jBMc92xm7xU5GMx8ZI0ADtcj
         tFlpW1Tr/eWsUMN1MU6A28Yi4J76o3PFaP0sK6mJkOLzji7ZIinA0iGbNOeQVWXrisTF
         Qro2uMxIy1wgLDCzZfRO/SOqWvC38l6/HAHYI5fTKYfYfFw7giTXl0f4fo7be/p8Lj39
         raEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=htOjNSx4GjKiziwMh+3ltrSB8ALm75kEhq8fpe7z8Ss=;
        b=EQSHtEQT/2S+1+Fhmg4nZTRIRVunxlVGLj9ZL5ktrLWqo/AHLwSj45fIHUOT7a11xD
         26MGx1nIByR44R/zFHhJbBdhro2EXwVwTKs1GHgk6QcqilrwyoaxrV0r8qQxTewD9Rn0
         iWouAnSQQi3OIWzVyf3LftTwmddHEu3IWFu2yuyfRqA46Irry+620R9pG/vKcT7go5VJ
         k5bMRPCm4XcAizVBJxbiMSNG1B+ncQj0VBzoqgg6VxX2+kFVUnMMXA8j0lkO3Owi9QPK
         145nQ8uFRmu4HyZdg56xjcQ7Cz/p60JBOCXuvzFT7rSAaQ2Py+EgIRj4UhMVNgxh+mw4
         Dh0g==
X-Gm-Message-State: AOAM530MJHpNQA8h/hgLuk5SX1cCCvwVAWLfhCFE240jOorWPJH2M3g3
        JfHfEczoGpP8U2xeBbF82gU=
X-Google-Smtp-Source: ABdhPJyqdmUCborYGt3ARY7vO0ies0c7M3qInp4BCFUuPPIaWJVauQb2PktT0XJFxIFkFwfKEbEA4A==
X-Received: by 2002:a17:906:52d6:: with SMTP id w22mr7820516ejn.512.1624227406623;
        Sun, 20 Jun 2021 15:16:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e8sm3379490ejl.74.2021.06.20.15.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 15:16:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 4/7] commit-graph: fix bogus counter in "Scanning merged
 commits" progress line
Date:   Mon, 21 Jun 2021 00:13:59 +0200
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-5-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210620200303.2328957-5-szeder.dev@gmail.com>
Message-ID: <87a6nk41wy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 20 2021, SZEDER G=C3=A1bor wrote:

> The final value of the counter of the "Scanning merged commits"
> progress line is always one less than its expected total, e.g.:
>
>   Scanning merged commits:  83% (5/6), done.
>
> This happens because while iterating over an array the loop variable
> is passed to display_progress() as-is, but while C arrays (and thus
> the loop variable) start at 0 and end at N-1, the progress counter
> must end at N.  This causes the failures of the tests
> 'fetch.writeCommitGraph' and 'fetch.writeCommitGraph with submodules'
> in 't5510-fetch.sh' when run with GIT_TEST_CHECK_PROGRESS=3D1.
>
> Fix this by passing 'i + 1' to display_progress(), like most other
> callsites do.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  commit-graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 2bcb4e0f89..3181906368 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2096,7 +2096,7 @@ static void sort_and_scan_merged_commits(struct wri=
te_commit_graph_context *ctx)
>=20=20
>  	ctx->num_extra_edges =3D 0;
>  	for (i =3D 0; i < ctx->commits.nr; i++) {
> -		display_progress(ctx->progress, i);
> +		display_progress(ctx->progress, i + 1);
>=20=20
>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>  			  &ctx->commits.list[i]->object.oid)) {

I think this fix makes sense, but FWIW there's a large thread starting
at [1] where Ren=C3=A9 disagrees with me, and thinks the fix for this sort =
of
thing would be to display_progress(..., i + 1) at the end of that
for-loop, or just before the stop_progress().

I don't agree, but just noting the disagreement, and that if that
argument wins then a patch like this would involve changing the other
20-some calls to display_progress() in commit-graph.c to work
differently (and to be more complex, we'd need to deal with loop
break/continue etc.).

1. https://lore.kernel.org/git/patch-2.2-042f598826-20210607T144206Z-avarab=
@gmail.com/=20
