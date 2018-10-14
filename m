Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D003C1F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 23:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbeJOG6K (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 02:58:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43108 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeJOG6K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 02:58:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so19125906wrt.10
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=j/E0B8VzafKFen3v4NE9qgAzvGa/s2d6ZL7iU+73SgU=;
        b=tFYwIPGoA9r8u+lOtzCjT9u5DFEmi4xMSPZHVoxCfm4UDsd/2GOzBtIZga6hF9F+pE
         EFlTVDbPuM+NgKti005CfcDr9m2Mn9TnBLwxJetFA1R/TC4VqhAYC4EYvyoS1Y5MPBd9
         TebWehBTZaezHXco8stvjPPuV5XCNPHTEMjh7627ebQw4V/OY2PKXEMwuqihmYDqu/r7
         V/V5bU9FEBL+Cce5FFvxpan+r9zj+lwJNpuR21MDmokQfXvqeAjzUZb+W7bmE4Pz0Jxt
         ZIS6zx8M4WzIRB8Wj22bUgRHl+c2qcOdFhtsc0KRc/p37fLoZ25i2o03li5hC6xL7TBB
         CHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=j/E0B8VzafKFen3v4NE9qgAzvGa/s2d6ZL7iU+73SgU=;
        b=Q4o31ITFyud+14P2eRA9t/cQgWyFsLG3aOhRIy3Kwqz1ym9p3ioc5oK5dEz4PTHf2q
         a2uskH19qr9dfwsbL3j1LVQNhmDSCcR4oueX+RpuqXSP9sXzgrUDB6S6cXL52SK9G4kw
         NwWlw1us7IaDo/DpR5KEPb2TuvLzkSnNy2vQ7VFrCUS7Ienm9H/b9dtA9eZcTEvkUiJP
         OSH2HOnES5B1U3tEMplOplg6/yy0Xxyiic7cCF1NsX3ulnOPgPYHHry1MWA8WsSpxhPS
         Hk5cmFx5msb8bIu6NBHmW4aN2yiY+7TO4bCIu/0xNScsG2W3N0I57g6pPub5o60DgiHL
         KDOQ==
X-Gm-Message-State: ABuFfog1qU3+WFDDnHpKmvScFDxlF1MKiVI4aVTafe2N9g9sTaq3rozC
        zH+Z3bDDoK5K4Np2pVgY0wk=
X-Google-Smtp-Source: ACcGV60paVM6YecNx9F9+FNnkq5w68XwBKO0ASmRjQemw0lRifM8UGPa4uyptkE4Tif6UueTpIPs3A==
X-Received: by 2002:adf:be07:: with SMTP id n7-v6mr11742792wrh.267.1539558931425;
        Sun, 14 Oct 2018 16:15:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6876900wmm.25.2018.10.14.16.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 16:15:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [RFC PATCH 1/3] list-objects: support for skipping tree traversal
References: <cover.1539298957.git.matvore@google.com>
        <fe4cf0841d500a46ad8f10c00818b467023d0ffc.1539298957.git.matvore@google.com>
Date:   Mon, 15 Oct 2018 08:15:29 +0900
In-Reply-To: <fe4cf0841d500a46ad8f10c00818b467023d0ffc.1539298957.git.matvore@google.com>
        (Matthew DeVore's message of "Thu, 11 Oct 2018 16:09:00 -0700")
Message-ID: <xmqqa7ng86i6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> The tree:0 filter does not need to traverse the trees that it has
> filtered out, so optimize list-objects and list-objects-filter to skip
> traversing the trees entirely. Before this patch, we iterated over all
> children of the tree, and did nothing for all of them, which was
> wasteful.
>
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>  list-objects-filter.c               | 11 +++++++++--
>  list-objects-filter.h               |  6 ++++++
>  list-objects.c                      |  5 ++++-
>  t/t6112-rev-list-filters-objects.sh | 10 ++++++++++
>  4 files changed, 29 insertions(+), 3 deletions(-)

This step looks more like "ow, we could have done the tree:0 support
that is in 'next' better" than a part of "here is a series to do
tree:N for non zero value of N".

If that is the case, I'd prefer to see this step polished enough
before [2-3/3] of this RFC is worked on, so that we can merge the
tree:0 (but not yet tree:N) support that is solid down to 'master'
soonish.

> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index 09b2b05d5..37fba456d 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -102,9 +102,16 @@ static enum list_objects_filter_result filter_trees_none(
>  
>  	case LOFS_BEGIN_TREE:
>  	case LOFS_BLOB:
> -		if (filter_data->omits)
> +		if (filter_data->omits) {
>  			oidset_insert(filter_data->omits, &obj->oid);
> -		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
> +			/* _MARK_SEEN but not _DO_SHOW (hard omit) */
> +			return LOFR_MARK_SEEN;
> +		}
> +		else
> +			/*
> +			 * Not collecting omits so no need to to traverse tree.
> +			 */
> +			return LOFR_SKIP_TREE | LOFR_MARK_SEEN;

OK, so "not collecting omits" is synonymous to "N==0, we aren't
doing tree at any level", and at this point in the series before the
support for N>0 is introduced, we'd always take this "else" clause
because tree:0 is the only thing we support?

Style: our modern style is to use {} around the body which is a
single statement on the else clause when the body of the
corresponding if clause needs {} around (and vice versa), so

	if (filter_data->omits) {
		oidset_isnert(...);
		return ...;
	} else {
		return ...;
	}

> diff --git a/list-objects-filter.h b/list-objects-filter.h
> index a6f6b4990..52b4a84da 100644
> --- a/list-objects-filter.h
> +++ b/list-objects-filter.h
> @@ -24,6 +24,11 @@ struct oidset;
>   *              In general, objects should only be shown once, but
>   *              this result DOES NOT imply that we mark it SEEN.
>   *
> + * _SKIP_TREE : Used in LOFS_BEGIN_TREE situation - indicates that
> + *              the tree's children should not be iterated over. This
> + *              is used as an optimization when all children will
> + *              definitely be ignored.
> + *
>   * Most of the time, you want the combination (_MARK_SEEN | _DO_SHOW)
>   * but they can be used independently, such as when sparse-checkout
>   * pattern matching is being applied.
> @@ -45,6 +50,7 @@ enum list_objects_filter_result {
>  	LOFR_ZERO      = 0,
>  	LOFR_MARK_SEEN = 1<<0,
>  	LOFR_DO_SHOW   = 1<<1,
> +	LOFR_SKIP_TREE = 1<<2,
>  };
>  
>  enum list_objects_filter_situation {
> diff --git a/list-objects.c b/list-objects.c
> index 7a1a0929d..d1e3d217c 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -11,6 +11,7 @@
>  #include "list-objects-filter-options.h"
>  #include "packfile.h"
>  #include "object-store.h"
> +#include "trace.h"
>  
>  struct traversal_context {
>  	struct rev_info *revs;
> @@ -184,7 +185,9 @@ static void process_tree(struct traversal_context *ctx,
>  	if (base->len)
>  		strbuf_addch(base, '/');
>  
> -	if (!failed_parse)
> +	if (r & LOFR_SKIP_TREE)
> +		trace_printf("Skipping contents of tree %s...\n", base->buf);
> +	else if (!failed_parse)
>  		process_tree_contents(ctx, tree, base);

Even when failed_parse==true, i.e. we found that the tree object's
data cannot be understood, if we have skip-tree bit set, that means
we do not care---we won't be descending into its children anyway.

Makes sense.

> diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
> index 08e0c7db6..efb1bee2e 100755
> --- a/t/t6112-rev-list-filters-objects.sh
> +++ b/t/t6112-rev-list-filters-objects.sh
> @@ -244,6 +244,16 @@ test_expect_success 'verify tree:0 includes trees in "filtered" output' '
>  	test_cmp expected filtered_types
>  '
>  
> +# Make sure tree:0 does not iterate through any trees.
> +
> +test_expect_success 'filter a GIANT tree through tree:0' '
> +	GIT_TRACE=1 git -C r3 rev-list \
> +		--objects --filter=tree:0 HEAD 2>filter_trace &&
> +	grep "Skipping contents of tree [.][.][.]" filter_trace >actual &&

Here you are not jus tmaking sure SKIP_TREE bit is set for some
tree, but it is set when base->buf is an empty string (i.e. the top
level tree)?  Which makes sense, and the next text makes sure that
between the two commits, the number of total "top level" trees is 2,
but I wonder if it is more direct to also make sure that the code is
not even seeing or skipping any tree inside these top level trees
(i.e. the same message but for ""!=base->buf should never appear in
the trace).

> +	# One line for each commit traversed.
> +	test_line_count = 2 actual
> +'
> +
>  # Delete some loose objects and use rev-list, but WITHOUT any filtering.
>  # This models previously omitted objects that we did not receive.

Thanks.
