Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8A2C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 15:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbiCaPTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 11:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiCaPTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 11:19:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB81220B01
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 08:17:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bg10so44435ejb.4
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=m8VW1pTXQFDqtT+miECW5ScUdUfzpLn2JrwqKQcSXjw=;
        b=mp8Sc14XBx7vWkalC8V6XNY+uU4teLQgmVWSb2ZJnjXPvhItDW9kTl9vaPqcWRQAUm
         CjnzfVD3Vj67i43mHWmoBTBnkeJJjcZmQrLd6y0MltepmLIfuzMkxD/jM8CF98AK8Zid
         y+g+mJaaSBV+tYL2HfI9cZQaacxdJUF5TuG0S8lOMLWG190pKcpZxnk7TSh/lJzOECew
         kzse7ccBGI5Hv59QAEywrk7Gl3qq27QavINECtyoE7I6PHnt0Yr0oMSXIlRKwdZHcNE3
         xCnIO9SvIbp99DmwKSi4kMAW7gEf7relUpAx3eEtO7ReJKDFDYIcN3tF4JVwnkU7xp+5
         21SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=m8VW1pTXQFDqtT+miECW5ScUdUfzpLn2JrwqKQcSXjw=;
        b=xN6I7YFQv7bk3xQHAZxO40ZcPlXRcX4bJL1/zBeVxpHD9JtcynOhC/Nfohb25ZtVSB
         L9IU+sQ09edqstpdhZ2fLpqLBsABJiwXS/c6WkXRgS2xsFpibb1P444AtHLBSgIfSCbA
         FooN8iHuYbh7Uyt8vma/GmX87pzK22qqijAm3Hjq5OLX0qg1sHIBtUvK2c6HDIG4kvcN
         lZ6RlX4i9EyvbQWMZGY7IVGQLYPTfzrh1oqOf3xphTv4JcB4KLFlb3VeaKeh3cQ4fR0m
         NiwwqeJc0Kgo8XJ8x2RQuJpJ0OuOr7ZqUVEEtqkzMl7Jp56jDTy4pr+zbPibQoRKdLv3
         WZBg==
X-Gm-Message-State: AOAM533Et+GcvFavzaNOsaixF1MEmtJ0tMb2axMCOkiHsENRE5voT/9G
        uW3jvSpyDMNdvx9HQECSyOpDxODEg2lEWA==
X-Google-Smtp-Source: ABdhPJy3T5Y4WnyxXOeYte79Xu1wWSY9+XQ5fqZXbdgowqAaoW7OL+Swu+Nk6tvjUHF6FMBqyO8OWw==
X-Received: by 2002:a17:906:434e:b0:6d0:ed9c:68bc with SMTP id z14-20020a170906434e00b006d0ed9c68bcmr5349019ejm.70.1648739871818;
        Thu, 31 Mar 2022 08:17:51 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b006dfc0fe42b1sm9774762ejc.177.2022.03.31.08.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 08:17:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZwYY-000Vee-Ln;
        Thu, 31 Mar 2022 17:17:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v4 2/7] fetch-pack: add refetch
Date:   Thu, 31 Mar 2022 17:09:19 +0200
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
 <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
 <03f0de3d28c00cbfda73f31a21e0fa8f8fe51742.1648476132.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <03f0de3d28c00cbfda73f31a21e0fa8f8fe51742.1648476132.git.gitgitgadget@gmail.com>
Message-ID: <220331.86o81mp2w1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 28 2022, Robert Coup via GitGitGadget wrote:

> From: Robert Coup <robert@coup.net.nz>
>
> Allow a "refetch" where the contents of the local object store are
> ignored and a full fetch is performed, not attempting to find or
> negotiate common commits with the remote.
>
> A key use case is to apply a new partial clone blob/tree filter and
> refetch all the associated matching content, which would otherwise not
> be transferred when the commit objects are already present locally.

FWIW it's not clear to me re earlier comments on earlier iterations
whether the "noop fetch" is per-se wanted for this feature for some
reason, or if it's just much easier to implement than doing what I
suggested in:
https://lore.kernel.org/git/220228.86ee3m39jf.gmgdl@evledraar.gmail.com/

I don't think such a thing should hold this series up, but as it would
be a bit kinder to servers I think it's worth at least noting in the
commit message what's desired per-se here, v.s. what's just needed for
the convenience of implementation.

I.e. when this series was in an earlier iteration the scope was to
repair repository corruption, which I pointed out to you it really
couldn't do without more wider changes to the object store management,
and at that point having it be NOOP definitely makes sense. The object
lookups etc. take shortcuts that "fsck" wouldn't do, so we could be
negotiating on the basis of corrupt content.

But now that it's a "fetch what's missing" wouldn't it make more sense
to descend from our otherwise-negotiated tips, and find the OIDs that
are "complete", if any, and negotiate with those?

Which again, I think it's fine to say "yeah, that would be ideal, but
this is easier". I'm just checking if I'm missing some subtlety here...

> Signed-off-by: Robert Coup <robert@coup.net.nz>
> ---
>  fetch-pack.c | 46 +++++++++++++++++++++++++++++-----------------
>  fetch-pack.h |  1 +
>  2 files changed, 30 insertions(+), 17 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 87657907e78..4e1e88eea09 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -312,19 +312,21 @@ static int find_common(struct fetch_negotiator *negotiator,
>  		const char *remote_hex;
>  		struct object *o;
>  
> -		/*
> -		 * If that object is complete (i.e. it is an ancestor of a
> -		 * local ref), we tell them we have it but do not have to
> -		 * tell them about its ancestors, which they already know
> -		 * about.
> -		 *
> -		 * We use lookup_object here because we are only
> -		 * interested in the case we *know* the object is
> -		 * reachable and we have already scanned it.
> -		 */
> -		if (((o = lookup_object(the_repository, remote)) != NULL) &&
> -				(o->flags & COMPLETE)) {
> -			continue;
> +		if (!args->refetch) {
> +			/*
> +			* If that object is complete (i.e. it is an ancestor of a
> +			* local ref), we tell them we have it but do not have to
> +			* tell them about its ancestors, which they already know
> +			* about.
> +			*
> +			* We use lookup_object here because we are only
> +			* interested in the case we *know* the object is
> +			* reachable and we have already scanned it.
> +			*/
> +			if (((o = lookup_object(the_repository, remote)) != NULL) &&
> +					(o->flags & COMPLETE)) {
> +				continue;
> +			}

nit: remove the {} here
nit: this double-indented if can just be one if-statement
nit: don't compare against NULL, use ! instead.
>  		}
>  
>  		remote_hex = oid_to_hex(remote);
> @@ -692,6 +694,9 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  	int old_save_commit_buffer = save_commit_buffer;
>  	timestamp_t cutoff = 0;
>  
> +	if (args->refetch)
> +		return;
> +
>  	save_commit_buffer = 0;

nit: This function has only two callers, perhaps it's clearer to do do
this "early abort" in those calls?

>  	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
> @@ -1028,7 +1033,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  	struct fetch_negotiator *negotiator;
>  
>  	negotiator = &negotiator_alloc;
> -	fetch_negotiator_init(r, negotiator);
> +	if (args->refetch) {
> +		fetch_negotiator_init_noop(negotiator);
> +	} else {
> +		fetch_negotiator_init(r, negotiator);
> +	}

More needless {}

>  	sort_ref_list(&ref, ref_compare_name);
>  	QSORT(sought, nr_sought, cmp_ref_by_name);
> @@ -1121,7 +1130,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  
>  	mark_complete_and_common_ref(negotiator, args, &ref);
>  	filter_refs(args, &ref, sought, nr_sought);
> -	if (everything_local(args, &ref)) {
> +	if (!args->refetch && everything_local(args, &ref)) {
>  		packet_flush(fd[1]);
>  		goto all_done;
>  	}

Here everything_local() is doing what I suggested for
mark_complete_and_common_ref() above, i.e. we check args->refetch first.

> @@ -1587,7 +1596,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	struct strvec index_pack_args = STRVEC_INIT;
>  
>  	negotiator = &negotiator_alloc;
> -	fetch_negotiator_init(r, negotiator);
> +	if (args->refetch)
> +		fetch_negotiator_init_noop(negotiator);
> +	else
> +		fetch_negotiator_init(r, negotiator);

This one doesn't have braces (good), unlike do_fetch_pack()
