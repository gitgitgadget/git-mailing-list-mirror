Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5C5C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4274204EC
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3EZ9tI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgHQWaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgHQWaF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 18:30:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBA7C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 15:30:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m22so19219278ljj.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PtEe7NIUIWaP68ym3BWa6W/ViLHexp268h75PRvAZwM=;
        b=C3EZ9tI3NbTkkiMwTEXl4ZDWUcqF6kTaZIvEjnDv1silyIgdQWaDVX47Xy9fzMzn7/
         WdgPsEYvjKIGuGrMqIUPwrf+hX/7Ryfwz3odeHiqUqvcaxIdcykyrRun39ipkxCrL27F
         ma6+xdCq7GgVAS2vzK3NEUcl5CH4NVrD9iUZCYTRlAxEWNKqMpC523fOKWGVpYDzGUut
         jK+thEBkF59t9HZ+4o3V4TI/FOtb58GPHlj1fLVSuv3HMSIQrJkqeHMaxWpR81frDmoM
         W5n3be2+JlF62MQq7vVFho5hme9Gc1bN5NrR3XpdBZo9OW2pI0anHTw2kvElA7Nd+ohj
         6ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=PtEe7NIUIWaP68ym3BWa6W/ViLHexp268h75PRvAZwM=;
        b=JzXfo/LKG6UBonOZJKYXzJBIJM6U3YcYZwE0yOpEyNXAaSM8OVB1fdOv5aq4Y3SAvK
         5MGo0CyFPTAiUOZIjLwkOmndvK5KBV/89P13/GyGlmpP51pv/FVaboQHen/w+rOVlygC
         ongkUzaNyJqDTK9xsWS/OhdAcpducbpSM2v9x1KVx4iY1OI33tXrDW5cnSxHDUgWNFqQ
         BH1uISH0Wvj9eLv39mu/K5vFdLPZRfh4EM6H3BZktBfM0GkflApCY60Luep5uLiDFctm
         yFWnIiDVLctQ90/wXgHhSRwJExBihoCVYFmVlYln0OXlDbx/t1WALFD9g1Q+rnH/AxVW
         5xNA==
X-Gm-Message-State: AOAM531sVj2uLA7SDloNqHSZB4ENhvuLzN1+oc+KR1EWZ3itFHlpLPM+
        zPhIsNDaDdVvuI3EqPM8sQs=
X-Google-Smtp-Source: ABdhPJwCHfLHn8EL3ZlvJUkplLdPXFanr//uGlKX9CDnE10yKIgGeolQvb3CLskdxUKuS3OEMMgObQ==
X-Received: by 2002:a2e:8059:: with SMTP id p25mr7521873ljg.219.1597703402782;
        Mon, 17 Aug 2020 15:30:02 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id l26sm5314905ljc.133.2020.08.17.15.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 15:30:01 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v3 01/11] commit-graph: fix regression when computing bloom filter
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <c6b7ade7af92b6faf365a5609748f6d024ea0408.1597509583.git.gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 00:30:01 +0200
In-Reply-To: <c6b7ade7af92b6faf365a5609748f6d024ea0408.1597509583.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Sat, 15 Aug 2020 16:39:33
        +0000")
Message-ID: <85r1s4ykgm.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: [PATCH v3 01/11] commit-graph: fix regression when computing blo=
om filter

s/bloom filter/Bloom filters/

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> commit_gen_cmp is used when writing a commit-graph to sort commits in
> generation order before computing Bloom filters. Since c49c82aa (commit:
> move members graph_pos, generation to a slab, 2020-06-17) made it so
> that 'commit_graph_generation()' returns 'GENERATION_NUMBER_INFINITY'
> during writing, we cannot call it within this function. Instead, access
> the generation number directly through the slab (i.e., by calling
> 'commit_graph_data_at(c)->generation') in order to access it while
> writing.

Two things that might not be obvious from the commit message:

- Is commit_gen_cmp in commit-graph.c used by anything but writing
  Bloom filters for changed paths?

- That the generation number is computed during `commit-graph write`
  before computing Bloom filters.

Also, after this series 'generation' would be generation number v2, that
is corrected commit date, and not v1, that is topological levels.  We
should check, just in case, that it does not lead to significant
performance regression for `git commit-graph write --reachable <...>`
case (the one that uses commit_gen_cmp sort).

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index e51c91dd5b..ace7400a1a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -144,8 +144,8 @@ static int commit_gen_cmp(const void *va, const void =
*vb)
>  	const struct commit *a =3D *(const struct commit **)va;
>  	const struct commit *b =3D *(const struct commit **)vb;
>
> -	uint32_t generation_a =3D commit_graph_generation(a);
> -	uint32_t generation_b =3D commit_graph_generation(b);
> +	uint32_t generation_a =3D commit_graph_data_at(a)->generation;
> +	uint32_t generation_b =3D commit_graph_data_at(b)->generation;

Nice and easy.

>  	/* lower generation commits first */
>  	if (generation_a < generation_b)
>  		return -1;

Best,
--=20
Jakub Nar=C4=99bski
