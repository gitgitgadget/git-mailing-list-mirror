Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184A3C64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 07:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9957206C0
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 07:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbgLBHSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 02:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgLBHSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 02:18:36 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F59C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 23:17:56 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 141so533550qkh.18
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 23:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MoF7mmCQ62zoW1iF7XUudQPd6k0pSbwbUK9dfJzz458=;
        b=OUjf9Rx3nCJopwHoIHWzUNoZ84eKMOsjY0tSwrtQ3IsIhMp4jIZLDGVQuFvwSzfdKs
         wMyBq9l72YTChxXD6FPaYERc7FtrJufCU6WZ4kmAKoS2pimUQ5c08UcUu+94SNcMb7s7
         FilbUt/VVWOuG1nvCy1ymogofYnbqjYwaHENuDcP9nf9MtUObAvxR5kX96d2jCelAOI+
         k/eE+I0x7oE9UJRWdueQH+fH+mR1ClNAhU0gGAWOQNmUneFn66zcxaOJPzO3gu4rwu5R
         85wv9i3jFrFli8kv1b4WTqlghonyMQ86Qdhi6tEFFiR/bYms0fyzWtYo7A3CkJaWDT6k
         UoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MoF7mmCQ62zoW1iF7XUudQPd6k0pSbwbUK9dfJzz458=;
        b=HposKs/lQBTFAXgizkGWmlGv+T+TJyLYZNTERcYnlzF0BNkW9JLvF6AB99BaV8ypBU
         9uMQtGl9tF7BYAD8zlGyC2RBJTYt5wQn9HjbiMMYN01pejsFxUV5bu9Us0EAVqTd15z4
         71vtLCyNS3fk31qQWuYixonas/SA70J7LeYFGhyMZinLFIU6zH2MF5SWRN03M1CWr0NM
         lu+RMUM9jNrnLLNhzEqSWmclEOKN396W2OJFt6k4t3s7ynY7QyZp5Mc0f+mK9CXVt0m4
         b4luK0Vs3i8OucVYgSsTw4MGuVape4fhL+Hr+kN4q3SyVI4Tbv3AqmpYf2diws7i6GNs
         8fJw==
X-Gm-Message-State: AOAM530ip9hJS7A1ar6GeyUZrxg7igd/voeoUmofzIRShNQYTfdSHIkZ
        /Ssf6JPMitHkwvnEbrMBYTpjhYATD8N6GhmL69Ec
X-Google-Smtp-Source: ABdhPJwqxAHPSJPADeU8lrohwfEVH+/iL41LALFpqMH6uPNt9jR8u2oBbEkGV2lmgUrn+gRkeKhW1+Zh5GNiWHnN1dpD
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:366:: with SMTP id
 t6mr1270345qvu.58.1606893475301; Tue, 01 Dec 2020 23:17:55 -0800 (PST)
Date:   Tue,  1 Dec 2020 23:17:53 -0800
In-Reply-To: <9928b3c7da33edd8d4beae006a74dd682daf5fa5.1605649533.git.me@ttaylorr.com>
Message-Id: <20201202071753.3468604-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <9928b3c7da33edd8d4beae006a74dd682daf5fa5.1605649533.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 20/24] pack-bitmap: factor out 'bitmap_for_commit()'
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
> +				      struct commit *commit)
> +{
> +	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
> +					   commit->object.oid);
> +	if (hash_pos >= kh_end(bitmap_git->bitmaps))
> +		return NULL;
> +	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
> +}

The new function.

>  static int add_to_include_set(struct bitmap_index *bitmap_git,
>  			      struct include_data *data,
> -			      const struct object_id *oid,
> +			      struct commit *commit,
>  			      int bitmap_pos)
>  {
> -	khiter_t hash_pos;
> +	struct ewah_bitmap *partial;
>  
>  	if (data->seen && bitmap_get(data->seen, bitmap_pos))
>  		return 0;
> @@ -476,10 +486,9 @@ static int add_to_include_set(struct bitmap_index *bitmap_git,
>  	if (bitmap_get(data->base, bitmap_pos))
>  		return 0;
>  
> -	hash_pos = kh_get_oid_map(bitmap_git->bitmaps, *oid);
> -	if (hash_pos < kh_end(bitmap_git->bitmaps)) {
> -		struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, hash_pos);
> -		bitmap_or_ewah(data->base, lookup_stored_bitmap(st));
> +	partial = bitmap_for_commit(bitmap_git, commit);
> +	if (partial) {
> +		bitmap_or_ewah(data->base, partial);
>  		return 0;
>  	}

A straightforward mechanical change. The function invocation replaces
conversion from commit to oid (which is why add_to_include_set() now
takes a struct commit * instead of a struct object_id *) and all the
other deleted lines here.

> @@ -1297,12 +1305,9 @@ void test_bitmap_walk(struct rev_info *revs)
>  		bitmap_git->version, bitmap_git->entry_count);
>  
>  	root = revs->pending.objects[0].item;
> -	pos = kh_get_oid_map(bitmap_git->bitmaps, root->oid);
> -
> -	if (pos < kh_end(bitmap_git->bitmaps)) {
> -		struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
> -		struct ewah_bitmap *bm = lookup_stored_bitmap(st);
> +	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
>  
> +	if (bm) {
>  		fprintf(stderr, "Found bitmap for %s. %d bits / %08x checksum\n",
>  			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
>  

Same here. LGTM.
