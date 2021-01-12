Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABF0C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005BF23134
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391411AbhALPfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390169AbhALPfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:35:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA553C061794
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:34:40 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d26so2902108wrb.12
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bmj4EoCVrKgtpr5RfIdJj903YiZVbgyZ0fasmFMqVig=;
        b=MG2/ITZ7xKLuYE1DwXvtAwcM8vbXPKarUptXkRAvsc90rHHf143WctkYi0Smb1u74g
         2Mo0Bz4oHy44HfvmnmXEFAF9SBC3tQlFeLTM7QrMg6Ta6SaGhv6rrfdovkcU/bQLsBJO
         gCgN54EYwgoBbsLtruM41PkSCpK46390Nm5FJ6ByP20X0evGwt7HsxY9rl+WF755XS4w
         4Jt4KdmuPtXWrH0rEzf64uMypjn091FxrgoC6aXH56QAsCI4OOrEAUUjKdX2z4/AwdBE
         meyXRuX7zYQXfXXvGEwqAyY1kRVcOkFINad1WNqVGNyFuCz10DYtO/BQYqr7TxvSQHKf
         9eoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bmj4EoCVrKgtpr5RfIdJj903YiZVbgyZ0fasmFMqVig=;
        b=m2mqkmDbfac0ml+brF4bWs5fCyYZAS5SD3yPsx9gp3FiyjTUjfhYCqO30gI7YYax3f
         xnjhKQePxB4BOEmkQrau4Wz76f6YmifAXCfAa8Cf7eGdf2SXzX+HOOXUQvCm5Tb2k62s
         okMa3zQYwTA7RAEphpmpCAseRLGeakBLGTYRU17t4cb6w8J7XS5kON5If0Rb4gZmPDry
         /+8dFjy5jNbMMYhUsDtHNLeeSY6CtsNxolHEnrN77B356lyQUfn72JUUbE04g6i5gBEe
         6B1oKPyEhW3b2FjC/H1aCZmtHAZJoWhpO+76ElQ5XbGHeIlRI7YVaTtEThD3T0ZsovEf
         MBuQ==
X-Gm-Message-State: AOAM531KPo28IRvKTuAwQDxlvP4l/sbZRiK+UV9Cn7mvOSMAw06zhhqj
        QCggYRVlXGVD3AVCNKZoCg==
X-Google-Smtp-Source: ABdhPJyTCGS0vrHbSNUc3K4mSmJRtLsCdgUrSC8gwi0dhb/vM5NcYdKmPiP1BcXELMrzZvOCPywNOw==
X-Received: by 2002:adf:fb52:: with SMTP id c18mr4880500wrs.186.1610465679676;
        Tue, 12 Jan 2021 07:34:39 -0800 (PST)
Received: from sync (90.ip-167-114-239.eu. [167.114.239.90])
        by smtp.gmail.com with ESMTPSA id v7sm4383409wma.26.2021.01.12.07.34.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jan 2021 07:34:39 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:34:38 +0000
From:   Arnaud Morin <arnaud.morin@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: rev-list with multiple commits sharing same patch-id
Message-ID: <20210112153438.GC32482@sync>
References: <20210109162440.GM31701@sync>
 <X/2vgbnxWSmst5yB@coredump.intra.peff.net>
 <X/28IXBpse2dNZQH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/28IXBpse2dNZQH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So instead of:
id = has_commit_patch_id(commit, &ids);

We should use some sort of iterator, in order to call:
id->commit->object.flags |= cherry_flag;

for all commits which are related to this patch?



-- 
Arnaud Morin

On 12.01.21 - 10:11, Jeff King wrote:
> On Tue, Jan 12, 2021 at 09:17:37AM -0500, Jeff King wrote:
> 
> > It looks like this was broken in v2.10.0, via dfb7a1b4d0 (patch-ids:
> > stop using a hand-rolled hashmap implementation, 2016-07-29).
> > 
> > I think the issue is that it is allowing duplicate entries in the
> > hashmap. The algorithm is something like:
> > 
> >   - iterate over left-hand commits, inserting patch-id for each into
> >     hashmap
> > 
> >   - iterate over right-hand commits, seeing if any are present in
> >     hashmap. If so, we exclude the commit _and_ mark the patch-id as
> >     "seen"
> > 
> >   - iterate again over left-hand commits, omitting any whose patch-ids
> >     are marked as "seen"
> > 
> > So if two commits on the left-hand side have the same patch-id, if we
> > insert two entries into the hashmap, then only one of them is going to
> > get its "seen" flag marked in the middle step.
> 
> Yeah, that's definitely it. Here's what the fix would look like directly
> on top of dfb7a1b4d0:
> 
> diff --git a/patch-ids.c b/patch-ids.c
> index db31fa647a..a8ed4f0872 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -66,12 +66,24 @@ struct patch_id *add_commit_patch_id(struct commit *commit,
>  				     struct patch_ids *ids)
>  {
>  	struct patch_id *key = xcalloc(1, sizeof(*key));
> +	struct patch_id *old;
>  
>  	if (init_patch_id_entry(key, commit, ids)) {
>  		free(key);
>  		return NULL;
>  	}
>  
> +	/*
> +	 * Don't allow duplicates. Note that we can't use hashmap_put here; we
> +	 * must retain the _old_ struct, because some commit->util is pointing
> +	 * to it.
> +	 */
> +	old = hashmap_get(&ids->patches, key, ids);
> +	if (old) {
> +		free(key);
> +		return old;
> +	}
> +
>  	hashmap_add(&ids->patches, key);
>  	return key;
>  }
> diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
> index 28d4f6b259..0c5f1dcc54 100755
> --- a/t/t6007-rev-list-cherry-pick-file.sh
> +++ b/t/t6007-rev-list-cherry-pick-file.sh
> @@ -207,4 +207,16 @@ test_expect_success '--count --left-right' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--cherry-pick with duplicates on each side' '
> +	git checkout -b dup-orig &&
> +	test_commit dup-base &&
> +	git revert dup-base &&
> +	git cherry-pick dup-base &&
> +	git checkout -b dup-side HEAD~3 &&
> +	test_tick &&
> +	git cherry-pick -3 dup-orig &&
> +	git rev-list --cherry-pick dup-orig...dup-side >actual &&
> +	test_must_be_empty actual
> +'
> +
>  test_done
> 
> 
> Unfortunately we can't do the same thing now. The "seen" flag went away
> in 683f17ec44 (patch-ids: replace the seen indicator with a commit
> pointer, 2016-07-29), in favor of having each patch_id struct point to a
> "struct commit". We could revert that, or turn that pointer into a list,
> but it gets worse. Later, b3dfeebb92 (rebase: avoid computing
> unnecessary patch IDs, 2016-07-29) built on that by lazily computing the
> patch-ids. So each patch_id struct must point to exactly one commit!
> 
> We'll have to either:
> 
>   - split them apart into two structs at the time of the lazy computation
> 
> or
> 
>   - accept having duplicate patch_ids, but on lookup make sure we find
>     _all_ matches, not just the first one.
> 
> Hmm, that last one might not be too bad, since we have
> hashmap_get_next() (it does mean iterating over a chained bucket
> linearly, but that's already the worst-case for a hash lookup).
> 
> -Peff
