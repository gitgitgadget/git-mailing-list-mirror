Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329DEC433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 23:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbiECXal (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 19:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244261AbiECXah (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 19:30:37 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12EB42EC0
        for <git@vger.kernel.org>; Tue,  3 May 2022 16:27:03 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id y14-20020a1709027c8e00b0015906c1ea31so7271311pll.20
        for <git@vger.kernel.org>; Tue, 03 May 2022 16:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=ODLcYFBLVT0GLQHQdayH1y0XvjbFi66K3njmSDJPby0=;
        b=r7s8ddXVQt8oc4EzUswupBoqBtGtssn/boWrwucHQ38mgjxuUt3urtFL5Mx41VGw+q
         82Z2+9jYWqe547VDuqH6N8EqU31MLOi7ouG339hIecFLd95+QS49Kz940tkPU6UYvAzr
         R9FWCZHY5HabQN7B+E+ENjkcHYoRgBvCNMXpOgZnpUpqKekRywdSGZl9VliQlukVlOXv
         ROeWz/Xtuqx9hO1LYSNX5bzfhn5ExTJrLDkhf08Uj3ifZpKRpUBDagienwZ1wrZ9zwbD
         mXKu2Tq9BzC+G5FaN/bA23FA75/vg+Pry3K5Lsed9a9PLQcxW6OkCJTv57staTTI7yCI
         +r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=ODLcYFBLVT0GLQHQdayH1y0XvjbFi66K3njmSDJPby0=;
        b=sgIR8x+pcpMFuBIqVC78OZRE7sBlDK+cPITTienJRxzRI2RrWCayIyKmcb/+W2CvFU
         rzCOZ7q1u3Xoy0M19ZYW6WFJa6lvJF8doW+rm1vItLgVH8dSmhXhoAKj0EzHBsw6QYh9
         +dzUjl4lv7jFSC7DMg/iklgJC5DJy9DFkwS07G66yC8LvOpViP/mizkzPGg2gN1YYB44
         MX3K6UpUrtbjk1kjk9iWxD42jc5Z2YVVxC/e3g/HqX5VY5VNfl+UzYreIXqjdvJZDVY9
         DnhAILZrStv39ibZlLm5+SselGlwOZBymuVR2+JsThzCLk7UYBj+L4o0bcQQXF6uKJ28
         gXtg==
X-Gm-Message-State: AOAM533HpJFsACgXwyWvZjeT+NTs/YxzRiNDLvOH3SoeMdpPFMXO4F2G
        QRkjs8OtH2V5DkmnqOkPX4tdFVojlxEh4ACc0zSL
X-Google-Smtp-Source: ABdhPJypPB1lhGw+Bk561/tT7/CPzFWqL/GR/XirMM/Yhojs+RympgEgWkGojDNuwfgPaLzMwL7tj39d5ucikvJfbyUJ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:6b83:b0:15d:1ea2:4f80 with
 SMTP id p3-20020a1709026b8300b0015d1ea24f80mr18566271plk.41.1651620423210;
 Tue, 03 May 2022 16:27:03 -0700 (PDT)
Date:   Tue,  3 May 2022 16:27:01 -0700
In-Reply-To: <20220502170904.2770649-7-calvinwan@google.com>
Message-Id: <20220503232701.4173948-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: Re: [PATCH v4 6/8] transport: add object-info fallback to fetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, philipoakley@iee.email, johncai86@gmail.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> If a v2 server does not support object-info or if the client requests
> information that isn't supported by object-info, fetch the objects as if
> it were a standard v2 fetch (however without changing any refs).

What do you mean by "however without changing any refs"? (I would have
expected that no refs would be changed, so this, to me, implies that we
would expect some refs to be changed.)

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 506ca28e05..938d082b80 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1639,6 +1639,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	if (args->depth > 0 || args->deepen_since || args->deepen_not)
>  		args->deepen = 1;
>  
> +	if (args->object_info)
> +		state = FETCH_SEND_REQUEST;
> +
>  	while (state != FETCH_DONE) {
>  		switch (state) {
>  		case FETCH_CHECK_LOCAL:
> @@ -1648,7 +1651,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  			/* Filter 'ref' by 'sought' and those that aren't local */
>  			mark_complete_and_common_ref(negotiator, args, &ref);
>  			filter_refs(args, &ref, sought, nr_sought);
> -			if (!args->refetch && everything_local(args, &ref))
> +			if (!args->refetch && !args->object_info && everything_local(args, &ref))
>  				state = FETCH_DONE;
>  			else
>  				state = FETCH_SEND_REQUEST;

I think that the purpose of all these changes is to skip certain steps
when we know that we're fetching as a fallback for object-info, but I
don't think they're necessary - it's fine to not fetch certain objects
if we have them present.

> @@ -2035,6 +2038,15 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
>  		args->connectivity_checked = 1;
>  	}
>  
> +	if (args->object_info) {
> +		struct ref *ref_cpy_reader = ref_cpy;
> +		int i = 0;
> +		while (ref_cpy_reader) {
> +			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid, &(*args->object_info_data)[i], OBJECT_INFO_LOOKUP_REPLACE);
> +			ref_cpy_reader = ref_cpy_reader->next;
> +			i++;
> +		}
> +	}

Could this part be done in the same function that falls back
(fetch_refs_via_pack(), I believe)? That would make the code easier to
understand - here, we don't know why we would need to copy the OIDs, but
in the function that falls back, we can look up and see that this is
done because we couldn't do something else.

> diff --git a/transport.c b/transport.c
> index 08c505e1d0..b85e52d9a8 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -436,10 +436,12 @@ static int fetch_refs_via_pack(struct transport *transport,
>  			       int nr_heads, struct ref **to_fetch)
>  {
>  	int ret = 0;
> +	size_t i;
>  	struct git_transport_data *data = transport->data;
>  	struct ref *refs = NULL;
>  	struct fetch_pack_args args;
>  	struct ref *refs_tmp = NULL;
> +	struct ref *wanted_refs = xcalloc(1, sizeof (struct ref));

If you only need these new variables in a block, declare them there (and
free them at the end of that block).

> @@ -489,7 +500,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	else if (data->version <= protocol_v1)
>  		die_if_server_options(transport);
>  
> -	if (data->options.acked_commits) {
> +	if (data->options.acked_commits && !transport->smart_options->object_info) {
>  		if (data->version < protocol_v2) {
>  			warning(_("--negotiate-only requires protocol v2"));
>  			ret = -1;

Is this addition necessary? --negotiate-only and object-info do not work
together.
