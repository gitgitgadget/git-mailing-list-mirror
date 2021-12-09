Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AF9C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 22:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhLIWjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhLIWjk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:39:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57A1C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 14:36:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so13175436ybj.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 14:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=idUirAVprEMppRL4n8Kd51dndLXLX6PWjACRtSiZPzk=;
        b=lKiHGpV7yCpD4GNaughdKStL9Qtc/aE4J/iRmRI5N49cxtCeg0gssbQ9mQD0jpzFn0
         DtljMIrVXz7GrmXIYX00qxZcIQKzfolhIdanLBwOCsCzoARWc+0yQXXsDs7kkx4iddjh
         3RS2OF2H6tAQFOCuiaFakCy1csIf0ws8tZAHvklRFpgP9i82CYoPHiiY21E6/RbqPQqe
         uGi26ce45au2mqr9zTMHWoRpPzGqm1JicRWFHdJylEyqYl0tQbqSkmTj9Wa48arQtLqK
         8AtJ44KyPWq+uf89Z6mOVEQrhJ1ZFGA87IgI7EHrPY+BGfu1ZCvrQkAOWaZTvcEWiToO
         UsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=idUirAVprEMppRL4n8Kd51dndLXLX6PWjACRtSiZPzk=;
        b=5LNxlTMcmFm86H0e1dt5ZcqmjeEg1D9YmYV7kqPDVI/lL6IRrobskjmGAp7LJcGLB2
         EQOrczCw6KllGytsObXrw4v90hqD6ozmP+4q+o9FTjAvf2vQz3nBbd4Yd7Pz5TpaSDwS
         dt6JhSjiRDJWZtMqmn5zYu35QXOgHrvwZJqqL4jpvcBVsYEkQyZ0dAZuWDi8luEYCXzk
         3rVWGXxbEeE9dZ1OEj4Qotp0HiS/lPPXNG2/1zr8n2AHI8n0Mg+WpXbvyMKGqqlcXnag
         KK2Tk6WjaIXCT/xskRb+D53TW3Sn2reVylWuJ9m9RnXKDD8QKQ98ghCdzguSW3Ke+m66
         j2bQ==
X-Gm-Message-State: AOAM530eSRJ3ALMDPENQu+1s9gYFRZEH1muzMaSXbyT54nl71PVd2/X1
        b/OH5COZB+x2TLlU2hBAaHgSLxGIW+Aw1w==
X-Google-Smtp-Source: ABdhPJzSm7Bsk2kOwwBORF49P48GL9EMGzuCEF0HBkpIlyYvcG9R7SVHFwSd2y70I0LvvBsrjut8GN3q/gxhcw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:ae12:: with SMTP id
 a18mr9560185ybj.286.1639089365960; Thu, 09 Dec 2021 14:36:05 -0800 (PST)
Date:   Thu, 09 Dec 2021 14:36:04 -0800
In-Reply-To: <20211209221250.508257-1-jonathantanmy@google.com>
Message-Id: <kl6lbl1p9zjf.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211207192925.67680-1-chooglen@google.com> <20211209221250.508257-1-jonathantanmy@google.com>
Subject: Re: [PATCH] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> `git fetch --negotiate-only` does not fetch objects and thus, it should
>> not perform certain auxiliary tasks like updating submodules, updating
>> the commit graph, or running gc. Although send_pack() invokes `git fetch
>> --negotiate-only` correctly, cmd_fetch() also reads config variables,
>> leading to undesirable behavior, like updating submodules if
>> `submodule.recurse=true`.
>> 
>> Make cmd_fetch() return early if --negotiate-only was specified so that
>> these auxiliary tasks are skipped.
>> 
>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>> `git fetch --negotiate-only` is used during push negotiation to
>> determine the reachability of commits. As its name implies, only
>> negotiation is performed, not the actual fetching of objects. However,
>> cmd_fetch() performs certain tasks with the assumption that objects are
>> fetched:
>> 
>> * Submodules are updated if enabled by recurse.submodules=true, but
>>   negotiation fetch doesn't actually update the repo, so this doesn't
>>   make sense (introduced in [1]).
>> * Commit graphs will be written if enabled by
>>   fetch.writeCommitGraph=true. But according to
>>   Documentation/config/fetch.txt [2], this should only be done if a
>>   pack-file is downloaded
>> * gc is run, but according to [3], we only do this because we expect
>>   `git fetch` to introduce objects
>> 
>> Instead of disabling these tasks piecemeal, let's just make cmd_fetch()
>> return early if --negotiate-only was given. To accommodate possible
>> future options that don't fetch objects, I opted to introduce another
>> `if` statement instead of putting the early return in the existing
>> `if (negotiate_only)` block.
>
> Some of this probably should be in the commit message too.

I suppose you mean the explanation of why the tasks are irrelevant to
negotiation fetch? i.e. 

   * Submodules are updated if enabled by recurse.submodules=true...
   * Commit graphs will be written if enabled by...
   * gc is run, but according to [3]...

>> +	if (negotiate_only) {
>> +		/*
>> +		 * --negotiate-only should never recurse into
>> +		 * submodules, so there is no need to read .gitmodules.
>> +		 */
>> +		recurse_submodules = RECURSE_SUBMODULES_OFF;
>> +		if (!negotiation_tip.nr)
>> +			die(_("--negotiate-only needs one or more --negotiate-tip=*"));
>> +	}
>
> Maybe add a check here that --recurse-submodules was not explicitly
> given.

Hm, that's not a bad idea, but it's not so easy because we don't have
RECURSE_SUBMODULES_EXPLICIT so it's not easy to tell whether or not
submodule recursion was enabled by CLI option or config.

This is the exact same use case I encountered with "branch
--recurse-submodules" [1]. I think this means that we should consider
standardizing the parsing of submodule.recurse + --recurse-submodules. I
haven't done it yet because it's a little tricky and hard to review.

So I'll punt on this check until we get RECURSE_SUBMODULES_EXPLICIT.

>
>> +	/* skip irrelevant tasks if objects were not fetched  */
>> +	if (negotiate_only)
>> +		return result;
>
> There are other reasons too why objects were not fetched (e.g. if we
> already have all of them). Maybe add a NEEDSWORK explaining this.

Good point, the comment doesn't distinguish between cases where we know
that objects won't be fetched beforehand vs cases where we found out
that objects weren't fetched after the fact. I'll add the NEEDSWORK.

[1] https://lore.kernel.org/git/20211209184928.71413-5-chooglen@google.com
