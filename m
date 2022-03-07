Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00941C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 15:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbiCGPsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiCGPsq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:48:46 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E621F6462
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 07:47:50 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qx21so32846797ejb.13
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 07:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0SawmOa8pckKTkrqgrJ4Bp9e0/I1z8oqAUdd4ocfoDw=;
        b=ptPrqXiQ+4iwtVbTlfS4KHiVb7s4I+Vw2kdhNrIzliP4sOm8PcvEwdNiSBy+SGEg7b
         5FpGdZp7dUDIdcvjQpngjzaMshi+Hj2nOYX7NxUq5F2pqJyG7c33T7r7Qpr7DPj1TZDQ
         4q8fJEh5Xo41aZFZkIPrWGKoR5AseLYnxS03wf8IRsVe4JW8BVaQy0Hwj1vixyCkGB5T
         cytNjQKKvda8JzIj+btC4dN1xTX3uvqpijefP+qYLst1RMVKXpulYiYj9bd1B6fBDzQc
         NMZ/CMmv+0kbBCvE3jbu++zRXJsLxbmHHnyZQuvHRppZr18h21/byZ6rfQ+VQb8n+8+C
         FRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0SawmOa8pckKTkrqgrJ4Bp9e0/I1z8oqAUdd4ocfoDw=;
        b=CE62nHy3xv7pTlMO/3f/0eLRURvYrczc4/0TORGQm4Q4nUTcLynleShMAP8STTbQWP
         0abLX7ib2iQJHj2p1uOyi2mOLLT0rw6urIR0dtP/2uTdgx31+FHQTFG4BRIDe1Yhxfte
         FMa5gT5GpRtvsCIwge8fxhfG4k+qTP1jKXHSjw2CB2K5E0e9FaoYi28h8SLSR+sHIYUb
         AlFG47Zs3iXMmLXBL6orxw6mLBM2OYiOgjCtxt3M7AFdNogRGBpnDaWU+cYMlbQT/Z5E
         Pk5liUYHHn0lsfgF69jSM7kJ2wWIhIBbgzEayWDYjTm5vOGurJOmwMOieIDaqzMbIZ+Q
         pYsg==
X-Gm-Message-State: AOAM5328pot6aOJs71T5SwbO9AREEbjGIEIbGdjDpbTU8hA2i8rw24OP
        3qFncXtRmjjj9Ppv84qIQ5BlNj9EWKg5KA==
X-Google-Smtp-Source: ABdhPJwn9cngF5HS/VhNC2RDTLB309HQFRjOT+YeppNbVS9ATM2nxNYbXS3i+Rm/HqBlC29tDIC+ww==
X-Received: by 2002:a17:907:2d11:b0:6da:924b:748f with SMTP id gs17-20020a1709072d1100b006da924b748fmr9300285ejc.584.1646668068878;
        Mon, 07 Mar 2022 07:47:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm6300856edb.14.2022.03.07.07.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:47:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRFaN-001a7v-Py;
        Mon, 07 Mar 2022 16:47:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 11/11] bundle: unbundle promisor packs
Date:   Mon, 07 Mar 2022 16:47:04 +0100
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
Message-ID: <220307.8635jtzrvg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> In order to have a valid pack-file after unbundling a bundle that has
> the 'filter' capability, we need to generate a .promisor file. The
> bundle does not promise _where_ the objects can be found, but we can
> expect that these bundles will be unbundled in repositories with
> appropriate promisor remotes that can find those missing objects.
>
> Use the 'git index-pack --promisor=<message>' option to create this
> .promisor file. Add "from-bundle" as the message to help anyone diagnose
> issues with these promisor packs.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle.c               | 4 ++++
>  t/t6020-bundle-misc.sh | 8 +++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/bundle.c b/bundle.c
> index e284ef63062..3d97de40ef0 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -631,6 +631,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
>  	struct child_process ip = CHILD_PROCESS_INIT;
>  	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
>  
> +	/* If there is a filter, then we need to create the promisor pack. */
> +	if (header->filter)
> +		strvec_push(&ip.args, "--promisor=from-bundle");
> +
>  	if (extra_index_pack_args) {
>  		strvec_pushv(&ip.args, extra_index_pack_args->v);
>  		strvec_clear(extra_index_pack_args);
> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> index 39cfefafb65..344af34db1e 100755
> --- a/t/t6020-bundle-misc.sh
> +++ b/t/t6020-bundle-misc.sh
> @@ -513,7 +513,13 @@ do
>  		The bundle uses this filter: $filter
>  		The bundle records a complete history.
>  		EOF
> -		test_cmp expect actual
> +		test_cmp expect actual &&
> +
> +		# This creates the first pack-file in the
> +		# .git/objects/pack directory. Look for a .promisor.
> +		git bundle unbundle partial.bdl &&
> +		ls .git/objects/pack/pack-*.promisor >promisor &&
> +		test_line_count = 1 promisor
>  	'
>  done

Aside from what Junio mentioned, the preceding commit seems to be
incomplete here. I.e. I'd expect to see this replace a case where we
died or whatever before. What happened if we invoked "unbundle" before?
