Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC7DC433DB
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C18E64F2D
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575694AbhCBPX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347474AbhCBESh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 23:18:37 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88C1C061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 20:17:56 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 19so980042pjk.7
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 20:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lqDaMV9C9u3tELNnWaVd8MKTQLAZ/XxNEueQ4k6ibew=;
        b=ACLEF2ZkAR9wrLBlUzAfdM7bGvTwjOOeo7aP1JjyPtb6qVdGBCmmZ0HaWmrqBGhqOq
         O4EwNCQzcgsSceFnQ1sAnCzw4vAXwdmgt/8d9Qpm4IhNwBe40Ab6VNvbEnv+aCA7XUhz
         MNBuli9RH1mnsiVw8oxL7v+c+cN4q31pUh8DCPqdJhUgjDH3QuHBFlsTQKybp9H2vGvi
         Qo61cub/82cO8qwCclEiyR9kJPYoCjb+6pPRToskouYbnnvE3tmGobszNqqeIzxQxKLE
         KZ5A/QcbJtP4SRklgZMcasYVxZ4YyFz5otQi2RvVmhTtM1Eo4Md6BmuGTHr8GJGxGueA
         a+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lqDaMV9C9u3tELNnWaVd8MKTQLAZ/XxNEueQ4k6ibew=;
        b=m/LuBFWkOpGBzHKXuRom4/izre9UWMCy+jbNhUrLprkizqtGUiTnA/8RdYykOPF0wv
         kR4cE1N43xS9gkiPCh0Co+eqHncBTZmRLSMt5MtDx710rHw9v8qKHM7ypQlg+kndUunY
         Q4yL8UOPjxHu1bMmOnHIq1SXk+snNrN+iL8DfpkVf+N8tGal+u5isIYY+wPcNHcOFw4/
         KdxM02zi3n4owvdDuz/3NBlUDsfJkdp7sUuR8jLfh0tPhXKeDmXFXer26KBtJn9ZCWAw
         95Qm0xggcyriOw9/0vwlXfBiqBcVm91wsvy3s1pmRQrvuk0rZevL33kQE3v6tIR7eVMy
         FENg==
X-Gm-Message-State: AOAM533NQESrO9vskvOLAdSpNOo46oBv7cdu8cAt1Ahcqq42vKrU9LS7
        ibIh//22dw8Ui1t5PDbeP3AfBLRis1DDH/Wy7wPE
X-Google-Smtp-Source: ABdhPJwvrPoZvDf/P/vfip2oAiOyqSp9rn1y+ouKH8y6geobloqv/QMv/+j+t6Zi2UBwjvP350Qxt/ovSU5Eibr5SFLQ
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:5464:: with SMTP id
 e36mr13652491pgm.223.1614658676238; Mon, 01 Mar 2021 20:17:56 -0800 (PST)
Date:   Mon,  1 Mar 2021 20:17:53 -0800
In-Reply-To: <223b89909416ec7c5505f9cedaa80bf86ecc7b2e.1614193703.git.me@ttaylorr.com>
Message-Id: <20210302041753.4037658-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <223b89909416ec7c5505f9cedaa80bf86ecc7b2e.1614193703.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v2 08/15] midx: allow marking a pack as preferred
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -589,12 +619,17 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
>  				nth_midxed_pack_midx_entry(m,
>  							   &entries_by_fanout[nr_fanout],
>  							   cur_object);
> +				if (nth_midxed_pack_int_id(m, cur_object) == preferred_pack)
> +					entries_by_fanout[nr_fanout].preferred = 1;
> +				else
> +					entries_by_fanout[nr_fanout].preferred = 0;
>  				nr_fanout++;
>  			}
>  		}
>  
>  		for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++) {
>  			uint32_t start = 0, end;
> +			int preferred = cur_pack == preferred_pack;
>  
>  			if (cur_fanout)
>  				start = get_pack_fanout(info[cur_pack].p, cur_fanout - 1);
> @@ -602,7 +637,11 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
>  
>  			for (cur_object = start; cur_object < end; cur_object++) {
>  				ALLOC_GROW(entries_by_fanout, nr_fanout + 1, alloc_fanout);
> -				fill_pack_entry(cur_pack, info[cur_pack].p, cur_object, &entries_by_fanout[nr_fanout]);
> +				fill_pack_entry(cur_pack,
> +						info[cur_pack].p,
> +						cur_object,
> +						&entries_by_fanout[nr_fanout],
> +						preferred);
>  				nr_fanout++;
>  			}
>  		}

I was initially confused that "preferred" was set twice, but this makes
sense - the first one is when an existing midx is reused, and the second
one is for objects in packs that the midx (if it exists) does not cover.

> @@ -828,7 +869,19 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
>  		goto cleanup;
>  
> -	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr);
> +	if (preferred_pack_name) {
> +		for (i = 0; i < ctx.nr; i++) {
> +			if (!cmp_idx_or_pack_name(preferred_pack_name,
> +						  ctx.info[i].pack_name)) {
> +				ctx.preferred_pack_idx = i;
> +				break;
> +			}
> +		}
> +	} else
> +		ctx.preferred_pack_idx = -1;

Looks safer to put "ctx.preferred_pack_idx = -1" before the "if", just
in case the given pack name does not exist?

> @@ -889,6 +942,31 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  			pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
>  	}
>  
> +	/*
> +	 * Recompute the preferred_pack_idx (if applicable) according to the
> +	 * permuted pack order.
> +	 */
> +	ctx.preferred_pack_idx = -1;
> +	if (preferred_pack_name) {
> +		ctx.preferred_pack_idx = lookup_idx_or_pack_name(ctx.info,
> +							     ctx.nr,
> +							     preferred_pack_name);
> +		if (ctx.preferred_pack_idx < 0)
> +			warning(_("unknown preferred pack: '%s'"),
> +				preferred_pack_name);
> +		else {
> +			uint32_t orig = ctx.info[ctx.preferred_pack_idx].orig_pack_int_id;
> +			uint32_t perm = ctx.pack_perm[orig];
> +
> +			if (perm == PACK_EXPIRED) {
> +				warning(_("preferred pack '%s' is expired"),
> +					preferred_pack_name);
> +				ctx.preferred_pack_idx = -1;
> +			} else
> +				ctx.preferred_pack_idx = perm;
> +		}
> +	}

I couldn't figure out why the preferred pack index needs to be
recalculated here, since the pack entries would have already been
sorted. Also, the tests still pass when I comment this part out. A
comment describing what's going on would be helpful.

All previous patches look good to me.
