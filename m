Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409D4C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbiBWOSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbiBWOSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:18:36 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFF8B0D0D
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:18:08 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so13344707oot.11
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TpaLrSdblp80m6ZBzqFJ3n+cvsszq+9mAGRYOVV5g9M=;
        b=Fwg305W21ysX43dkWxzYNU8KhBfp7evPOe2jx9I6+pYiuSEUpfWe20JUoj1JdEZEwn
         vpDV7d9CVyamvznV/HuKF7QesmM9X7Aa3c9HQWS92FLpZLDg8JjVHQlOefqgesu+mxYx
         cWeLQwQdCgQoXCO9oGoOKra1hUm2pVFbU5bnRcHnnp8zoNZNYuYxR2xquP38gugKaAAv
         mpkL3HnYDR93jT1maR/1Vv/qz1gCoyRE7eH0gT2tJBklYTgCAeBxmInJG2RduwMzTSw+
         +MmSCVBNmnglhU19/5fDkwx4xDKvaLuNOhy8ePwnT+hQzzYLiVAgq8kKHznPZellp94i
         TpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TpaLrSdblp80m6ZBzqFJ3n+cvsszq+9mAGRYOVV5g9M=;
        b=jEA2GHYMucOv3TPGcENHs9QhKC6nGp3sT+kLSzuU5yap8iVuxQyFihQgumZwyTrKN/
         jokdfUaTV576CCPP/W9qSqDIa5Dp21eMRqc3PRzg0G0stg1TdQHSa4YKJD7B/8h+1CIM
         XIE4xUY3PpPFTiyp6E+Ovz0bUTP9JIJAcdgwVQQRLr9DKyUx8QqyZ7zkJsscZxPOtxMR
         KiQzg8fAsRdA2/uUYqWC8uP26h34YrLlGkGf5JmgJRWNnXoAdA4bwZE4q2nfwdD+KxHf
         o08WWiYyxkd+15fzRYQMVOi6aGkBEjJ4HaxYF6kHQt/gR4ZWt69uQ5iWOdG+qS0rLahk
         LteQ==
X-Gm-Message-State: AOAM533Kavjk3UEY54jPtu29bBJRor2P2iYw83cNeccSKmFl9NyImh88
        q1GFVzbAuJJRmCb4PdNTbsvR
X-Google-Smtp-Source: ABdhPJzlYtZ8L8RWR0cjq3Hjl+LcJj17avNLtjoby0VQPTeomdmEa4WCcknbFF/a5tGDFBW3QBJokg==
X-Received: by 2002:a05:6870:6249:b0:c4:7dc0:d71e with SMTP id r9-20020a056870624900b000c47dc0d71emr3783425oak.241.1645625887940;
        Wed, 23 Feb 2022 06:18:07 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u2sm6240581ots.15.2022.02.23.06.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 06:18:07 -0800 (PST)
Message-ID: <33154b3c-1316-aab3-46a1-a0fbd87293de@github.com>
Date:   Wed, 23 Feb 2022 09:18:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/5] fetch: avoid lookup of commits when not appending to
 FETCH_HEAD
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1645619224.git.ps@pks.im>
 <80f993dddd521133154a751aeaab86adee409eea.1645619224.git.ps@pks.im>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <80f993dddd521133154a751aeaab86adee409eea.1645619224.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2022 7:35 AM, Patrick Steinhardt wrote:
> When fetching from a remote repository we will by default write what has
> been fetched into the special FETCH_HEAD reference. The order in which
> references are written depends on whether the reference is for merge or
> not, which, despite some other conditions, is also determined based on
> whether the old object ID the reference is being updated from actually
> exists in the repository.
> 
> To write FETCH_HEAD we thus loop through all references thrice: once for
> the references that are about to be merged, once for the references that
> are not for merge, and finally for all references that are ignored. For
> every iteration, we then look up the old object ID to determine whether
> the referenced object exists so that we can label it as "not-for-merge"
> if it doesn't exist. It goes without saying that this can be expensive
> in case where we are fetching a lot of references.
> 
> While this is hard to avoid in the case where we're writing FETCH_HEAD,
> users can in fact ask us to skip this work via `--no-write-fetch-head`.
> In that case, we do not care for the result of those lookups at all
> because we don't have to order writes to FETCH_HEAD in the first place.
> 
> Skip this busywork in case we're not writing to FETCH_HEAD. The
> following benchmark performs a mirror-fetch in a repository with about
> two million references:
> 
>     Benchmark 1: git fetch --prune --no-write-fetch-head +refs/*:refs/* (HEAD~)
>       Time (mean ± σ):     75.388 s ±  1.942 s    [User: 71.103 s, System: 8.953 s]
>       Range (min … max):   73.184 s … 76.845 s    3 runs
> 
>     Benchmark 2: git fetch --prune --no-write-fetch-head +refs/*:refs/* (HEAD)
>       Time (mean ± σ):     69.486 s ±  1.016 s    [User: 65.941 s, System: 8.806 s]
>       Range (min … max):   68.864 s … 70.659 s    3 runs
> 
>     Summary
>       'git fetch --prune --no-write-fetch-head +refs/*:refs/* (HEAD)' ran
>         1.08 ± 0.03 times faster than 'git fetch --prune --no-write-fetch-head +refs/*:refs/* (HEAD~)'

I have a super-small nitpick here.

I see that you are using '-n' to name your experiments. These names
are a bit long, especially since they are the same Git command but
built at different commits. It would be enough to say the command
you are testing before the stats and leave the names as "HEAD" and
"HEAD~" (or, I typically use "new" and "old", respectively).

>  			/*
> -			 * References in "refs/tags/" are often going to point
> -			 * to annotated tags, which are not part of the
> -			 * commit-graph. We thus only try to look up refs in
> -			 * the graph which are not in that namespace to not
> -			 * regress performance in repositories with many
> -			 * annotated tags.
> +			 * When writing FETCH_HEAD we need to determine whether
> +			 * we already have the commit or not. If not, then the
> +			 * reference is not for merge and needs to be written
> +			 * to the reflog after other commits which we already
> +			 * have. We're not interested in this property though
> +			 * in case FETCH_HEAD is not to be updated, so we can
> +			 * skip the classification in that case.
>  			 */
> -			if (!starts_with(rm->name, "refs/tags/"))
> -				commit = lookup_commit_in_graph(the_repository, &rm->old_oid);
> -			if (!commit) {
> -				commit = lookup_commit_reference_gently(the_repository,
> -									&rm->old_oid,
> -									1);
> -				if (!commit)
> -					rm->fetch_head_status = FETCH_HEAD_NOT_FOR_MERGE;
> +			if (fetch_head->fp) {
> +				struct commit *commit = NULL;
> +
> +				/*
> +				 * References in "refs/tags/" are often going to point
> +				 * to annotated tags, which are not part of the
> +				 * commit-graph. We thus only try to look up refs in
> +				 * the graph which are not in that namespace to not
> +				 * regress performance in repositories with many
> +				 * annotated tags.
> +				 */
> +				if (!starts_with(rm->name, "refs/tags/"))
> +					commit = lookup_commit_in_graph(the_repository, &rm->old_oid);
> +				if (!commit) {
> +					commit = lookup_commit_reference_gently(the_repository,
> +										&rm->old_oid,
> +										1);
> +					if (!commit)
> +						rm->fetch_head_status = FETCH_HEAD_NOT_FOR_MERGE;
> +				}
>  			}
Looks good. Most of the diff is whitespace.

Thanks,
-Stolee
