Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA42620248
	for <e@80x24.org>; Mon, 18 Mar 2019 15:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfCRPxf (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 11:53:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42584 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfCRPxe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 11:53:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id j89so13953650edb.9
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=SncnPP1jZUksniiz/twxK59fkjM+viBUCqU8Lt7JJo4=;
        b=HEroxjskBxp9sNXjgHJzcHMTpuH3cL3oFY1UeoFSGwkZv3LyY8L3PeYmT1pFpb/Fkc
         3y06fgMHFP9VN+oFAinVuh2dJ4jQOL+INWwoJ3X7KnyfpG6FaF5lXEa2JG1pW/QKW8SM
         4v/6n4PjnfrCAHbcJAMv8pHOucrnkgVOef/93PYoN+t/+ZJobhzd99LCzTYGw1GZbeHg
         EeF8i50dp9+M9+b3nOVmK04sltJfhTBoVWh7y41N8zFiKMSBNzY8J6Sql/rZZkG9rivJ
         N0Jc6p4SC4uOHTEwUUD6l8Bu8AiD5Qvx8FYSg/rK+AETred1BdhMTuuQeQLv4Sv2xfbT
         nDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=SncnPP1jZUksniiz/twxK59fkjM+viBUCqU8Lt7JJo4=;
        b=AuMMntg1Qer4QUnrPPqHYYkyidXn90fJRPm6QeLiIyRL0sjEuOsoATNV+Op/Qdj7So
         FPeGdhZmzt6jwW2Rx+5t56v4EbVwvl+elnCXQRv2H8v7DUZN3N2T6x3SWgS5Hd2L33cP
         fJC5xnoaLd4Ym3jNWpnJexJzH2iYYGiNql17TojRol0OCRGNWmlBECD4amaIkC4i5fjM
         0BHNWtXMTEgObjUAF+CSYo3g8R7i5Ny9v+Nwthy+Y6SuR6CFdMeBisX4VzvnwSllz5EW
         JmDjI1HEfIc0nbIHlsVfbqq+d5l8ErB7Bt12oFs4ZmtbpHiVEtFIWjMRHVwGvLnoofnO
         DkCQ==
X-Gm-Message-State: APjAAAVzm8hInqCWjTX02C/7gvLAH14PijVMNql4DIGOkpJ6geXygyAU
        yOti53LULL1Ezg48ZG1ZfHM=
X-Google-Smtp-Source: APXvYqw+wXqxUWTFvzCrQSg4sYxcEHzMICLYcr0QY+Xn+hdAk7OG1NGuC5JmFVqEkC6+J1oUj6WxXQ==
X-Received: by 2002:a17:906:1dd7:: with SMTP id v23mr11208354ejh.164.1552924412108;
        Mon, 18 Mar 2019 08:53:32 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id z3sm3285905edh.74.2019.03.18.08.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 08:53:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/3] midx: verify: group objects by packfile to speed up object verification
References: <pull.166.git.gitgitgadget@gmail.com> <86f6b0325821a9e1742a28895f9c9b712a1fdec4.1552919394.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <86f6b0325821a9e1742a28895f9c9b712a1fdec4.1552919394.git.gitgitgadget@gmail.com>
Date:   Mon, 18 Mar 2019 16:53:30 +0100
Message-ID: <87pnqodvr9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 18 2019, Jeff Hostetler via GitGitGadget wrote:

> +static int compare_pair_pos_vs_id(const void *_a, const void *_b)
> +{
> +	struct pair_pos_vs_id *a = (struct pair_pos_vs_id *)_a;
> +	struct pair_pos_vs_id *b = (struct pair_pos_vs_id *)_b;
> +
> +	if (a->pack_int_id < b->pack_int_id)
> +		return -1;
> +	if (a->pack_int_id > b->pack_int_id)
> +		return 1;
> +
> +	return 0;
> +}

Not a suggestion for a change, just a note that this sent me down the
rabbit hole of looking at the different idioms we use for QSORT() in
different places. Some use this form, some a ternary nest, and some the
succinct subtraction idiom of e.g. (in this case):

    return b->pack_int_id - a->pack_int_id;

> +
>  int verify_midx_file(const char *object_dir)
>  {
> -	uint32_t i;
> +	struct pair_pos_vs_id *pairs = NULL;
> +	uint32_t i, k;
>  	struct progress *progress;
>  	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
>  	verify_midx_error = 0;
> @@ -997,15 +1017,36 @@ int verify_midx_file(const char *object_dir)
>  	}
>
>  	progress = start_progress(_("Verifying object offsets"), m->num_objects);
> +
> +	/*
> +	 * Create an array mapping each object to its packfile id.  Sort it
> +	 * to group the objects by packfile.  Use this permutation to visit
> +	 * each of the objects and only require 1 packfile to be open at a
> +	 * time.
> +	 */
> +	ALLOC_ARRAY(pairs, m->num_objects);
>  	for (i = 0; i < m->num_objects; i++) {
> +		pairs[i].pos = i;
> +		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
> +	}
> +	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
> +
> +	for (k = 0; k < m->num_objects; k++) {
> [...]

I have not tested this (or midx in general), but isn't this new QSORT()
introducing the same sort of progress stalling that I fixed for
commit-graph in 890226ccb57 ("commit-graph write: add itermediate
progress", 2019-01-19)? I.e. something you can work around with a
"display_progress(progress, 0)" before the QSORT().
