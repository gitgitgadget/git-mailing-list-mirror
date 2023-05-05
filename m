Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59693C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 18:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjEESNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 14:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjEESNs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 14:13:48 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6236118DF1
        for <git@vger.kernel.org>; Fri,  5 May 2023 11:13:47 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-55a26b46003so30579957b3.1
        for <git@vger.kernel.org>; Fri, 05 May 2023 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683310426; x=1685902426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjUkkbR5blxRcM4BBlER6pzTZkXrl1kHlsgPNSiunA4=;
        b=ehEDbmjDNSdhBt1LGjXbZsNTRFTwowu8EdlUHBxr4VUGmOu9QWYDkVCsnHPfT8yrLa
         5BSKXgKHKZeTzAXxAO4Ak9j6z6spY5mR5Cx1rzjhcwrMQGcwIaVTUBBRsmR2kB5FnNHK
         ew59OuUXOVK24SxnocJC3ugyUebyBW9kcOo1ghUf3eESvGd77pyOe+SqklbGPd9NLQiS
         7/QueI6djmIjfN+1ax8QPU4tPsCbzEIaXYkYCbrgw7kkPmXlgP2+teQwGcOTzYiD6zg3
         cTpMgucYwUU3RHL370d9HfSjlLc7N7OL8egjOV5XHpA2zaWArtWFqSP6PSKaPo7My/EX
         EL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683310426; x=1685902426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjUkkbR5blxRcM4BBlER6pzTZkXrl1kHlsgPNSiunA4=;
        b=TdVepyEu7g084QAeNABRSEb2PPLCUlW43Z2K5GscQ2EmpuLCZZipydewSIDpgpERtC
         yl+X61xQYBVTChnRgtEfR2NJ/8MeY9xhw3zzmjnzXKnC6Yw00+5vn0UeIhDXmGmuFwYN
         Nr+9JVxDFfW2gdrPo/IR/mtPzMthjDKjRqtLiUvmUGv5rsoSibCnYFxNMbkNmuytYIs+
         dMtPks05bqV0upmFXkyROxnd9vlqtJ5KBGDOUTJ/Efz63356x9RpH1SLgB5a+F4QrS1v
         /A72lIqcaBRSMY1hOSSHshatb1nGAmQ2eafa6aeFLiUtRgsxT4hLJvnfLnhHgMKUkmiO
         B73w==
X-Gm-Message-State: AC+VfDyINSM3jrHQF7hq2eEyfdH1o0xOBRtVn5tOhM4llor810AbO+mz
        h9tHVe7C4DaFOrAs4pLlqiy5I9eoxIV1d0Nx4Q==
X-Google-Smtp-Source: ACHHUZ6NLHx6jOCqxN0cKgE8fAzpxfu+ZoJ6K7o60oxDHcnAHdEMZtRHw/68E7pALrwLvhzBOnDYug==
X-Received: by 2002:a0d:df11:0:b0:55c:9348:2b67 with SMTP id i17-20020a0ddf11000000b0055c93482b67mr2580881ywe.44.1683310426530;
        Fri, 05 May 2023 11:13:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fcac:2b0b:1f40:7f1a? ([2600:1700:e72:80a0:fcac:2b0b:1f40:7f1a])
        by smtp.gmail.com with ESMTPSA id h126-20020a815384000000b00556aa81f615sm609041ywb.68.2023.05.05.11.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 11:13:46 -0700 (PDT)
Message-ID: <e6e2401a-519a-4859-d20b-6b947e94e1ec@github.com>
Date:   Fri, 5 May 2023 14:13:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/2] pack-bitmap.c: use commit boundary during bitmap
 traversal
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683307620.git.me@ttaylorr.com>
 <1993af00cba3af83755da557816c1c7a8b52c844.1683307620.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <1993af00cba3af83755da557816c1c7a8b52c844.1683307620.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/5/2023 1:27 PM, Taylor Blau wrote:

> +static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
> +					    struct rev_info *revs,
> +					    struct object_list *roots)
> +{
> +	struct bitmap_boundary_cb cb = { .bitmap_git = bitmap_git };
> +	unsigned int i;
> +	unsigned int tmp_blobs, tmp_trees, tmp_tags;
> +	int any_missing = 0;
> +
> +	revs->ignore_missing_links = 1;
> +
> +	/*
> +	 * OR in any existing reachability bitmaps among `roots` into `base`.
> +	 */
> +	while (roots) {
> +		struct object *object = roots->item;
> +		roots = roots->next;
> +
> +		if (object->type == OBJ_COMMIT &&
> +		    !obj_in_bitmap(bitmap_git, object, cb.base) &&
> +		    add_commit_to_bitmap(bitmap_git, &cb.base,
> +					 (struct commit *)object)) {
> +			object->flags |= SEEN;
> +			continue;
> +		}
> +
> +		any_missing = 1;
> +	}
> +
> +	if (!any_missing)
> +		goto cleanup;

Here, we check if the list of roots are completely covered by existing
bitmaps. This prevents doing the commit-only walk as well as the boundary
checks.

There's another confusing bit here: if we have a bitmap for the commit,
then we mark it as SEEN. Does that mean that the later commit walk will
skip walking its history? Would we then get a boundary that is actually
further in history than necessary? ("A --not B C" would walk all of
B..A if C has a bitmap, even if a lot of that region is reachable from C.)

My initial thought here was that this is an unlikely case, so the
optimization isn't worth the code complexity. But now, I'm a little
concerned that it actually hurts the later walk in the case of multiple
roots.

> +	tmp_blobs = revs->blob_objects;
> +	tmp_trees = revs->tree_objects;
> +	tmp_tags = revs->blob_objects;
> +	revs->blob_objects = 0;
> +	revs->tree_objects = 0;
> +	revs->tag_objects = 0;
> +
> +	/*
> +	 * We didn't have complete coverage of the roots. First setup a
> +	 * revision walk to (a) OR in any bitmaps that are UNINTERESTING
> +	 * between the tips and boundary, and (b) record the boundary.
> +	 */
> +	trace2_region_enter("pack-bitmap", "boundary-prepare", the_repository);
> +	if (prepare_revision_walk(revs))
> +		die("revision walk setup failed");
> +	trace2_region_leave("pack-bitmap", "boundary-prepare", the_repository);
> +
> +	trace2_region_enter("pack-bitmap", "boundary-traverse", the_repository);
> +	revs->boundary = 1;
> +	traverse_commit_list_filtered(revs,
> +				      show_boundary_commit,
> +				      show_boundary_object,
> +				      &cb, NULL);

Looks good. Callbacks were clear when I read them.

> +	revs->boundary = 0;
> +	revs->blob_objects = tmp_blobs;
> +	revs->tree_objects = tmp_trees;
> +	revs->tag_objects = tmp_tags;

These would seem more natural if they were after the trace2_region_leave().

> +	reset_revision_walk();
> +	clear_object_flags(UNINTERESTING);
> +	trace2_region_leave("pack-bitmap", "boundary-traverse", the_repository);
> +
> +	/*
> +	 * Then add the boundary commit(s) as fill-in traversal tips.
> +	 */
> +	trace2_region_enter("pack-bitmap", "boundary-fill-in", the_repository);
> +	if (cb.boundary.nr) {

Making this an if block does help keep its variables more local. It does
make me think about whether the trace2 regions should be within the block,
but it's easier to analyze things when the regions are expected to be present.

> +		struct object *obj;
> +		int needs_walk = 0;
> +
> +		for (i = 0; i < cb.boundary.nr; i++) {
> +			obj = cb.boundary.objects[i].item;
> +
> +			if (obj_in_bitmap(bitmap_git, obj, cb.base)) {
> +				obj->flags |= SEEN;

This SEEN makes sense: we want to terminate the walk here as everything
reachable is already in the bitmap.

> +			} else {
> +				add_pending_object(revs, obj, "");
> +				needs_walk = 1;
> +			}
> +		}
> +
> +		if (needs_walk)
> +			cb.base = fill_in_bitmap(bitmap_git, revs, cb.base, NULL);

I wonder if fill_in_bitmap() already does "the right thing" when there
are no pending objects or when all pending objects are already in the
bitmap. Do we need to do these checks, or should we just put all boundary
commits in the pending set?

> +	}
> +	trace2_region_leave("pack-bitmap", "boundary-fill-in", the_repository);
> +
> +

nit: extra empty line

> +cleanup:
> +	revs->ignore_missing_links = 0;
> +
> +	return cb.base;

Do we need to clean up the cb.boundary object array?

> +}
> +

...

> @@ -1605,18 +1728,15 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
>  	if (load_bitmap(revs->repo, bitmap_git) < 0)
>  		goto cleanup;
>  
> -	object_array_clear(&revs->pending);
> -
>  	if (haves) {
> -		revs->ignore_missing_links = 1;
> -		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
> -		reset_revision_walk();
> -		revs->ignore_missing_links = 0;
> -
> +		haves_bitmap = find_boundary_objects(bitmap_git, revs, haves);
>  		if (!haves_bitmap)
>  			BUG("failed to perform bitmap walk");
>  	}

I mentioned in reply to the cover letter that deleting this older algorithm
is likely premature at this point, and we might want to keep it in general
as an option.

> +	object_array_clear(&revs->pending);
> +	reset_revision_walk();
> +

Thanks,
-Stolee
