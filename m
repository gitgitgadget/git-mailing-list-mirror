Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B05BC433E4
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 16:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7361620720
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 16:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TT6OxIIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgGUQhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgGUQhk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 12:37:40 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D9C061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 09:37:40 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id o10so12846837plk.12
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=saz8TJHK+HQ3MHXzS3nsqr1qll1cUSa8sizXjipCN04=;
        b=TT6OxIIrHQ329FyBJBrIweSQWYNmq2kaKW/643X/AYHoWgyt4x0Uli1WZpGo6tXkTJ
         fF/TnBM+LWFgogyueGj8wAXMZ0R37cQiZXJRumj7E0Cqc5BUVMocoIjsqlyb24puFzf2
         gS5IprQPSRpYW/f/7xCxxBmYUGXQVppyxrGMbtge+V4QZg1y5qpqle4PDuesL4dt9M4d
         SyzaftV5Knt8zU1p/c+y1JfI7sHhVz4X5hsdPYofK4FxpYuLSvvrwrg2+QRfJXbBmZrs
         mcw0j4G0JcmfxObnMWrcVaugbx08xbjYgCzQUsLUVdGTMsVf2IEw7b3POfVchC0C+JDs
         MXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=saz8TJHK+HQ3MHXzS3nsqr1qll1cUSa8sizXjipCN04=;
        b=GM1YZKGHW/q8OSCnOVKzc2yiXm4cNpbPGDI+rZ3c8FaQ1vsxK+FIy4FOS9VI1VyUiM
         ReUZXjjWSFKlmpr2o3pa59BYPPq+F9f5dQ19mBopJbZh2RTuG6o0vej1cKimoPprGWGR
         DL4JWUY0S+8LbWUjsDIXBgVBIoGoDI+MEL+bi4TWv+6bUwBUnbZ6QmxIJsUXUPo6hOi7
         RqitnlokPbzvaFuXf7V8Rrq/5CVbutThkl/fdVlFnvORyJr5hJRVyUR67SKKMKRiP9zz
         CZieksF4josd3rT7FmXiBb1Hc2chmhTKi5hBpN2T39jbTLcpQ4XXofynBRBPrJu3QEWt
         NAGg==
X-Gm-Message-State: AOAM5311A47HtSY8z36oDaMhczSRfLo0L4PrzvdxiHgI9rYxY5QyMp+H
        0UZLkIRcCxq+S9cqZcRAi9hDkkMwNRerdPoaEulH
X-Google-Smtp-Source: ABdhPJz1XtgZHbMO6eDFAYblKZ0bav92LBvRJriauTThwV+Mt+gyLQpBXBkEMriIxJ+9o7neVSVpoPzHGsWTrdOhbsHW
X-Received: by 2002:a62:1b8d:: with SMTP id b135mr25204113pfb.248.1595349459382;
 Tue, 21 Jul 2020 09:37:39 -0700 (PDT)
Date:   Tue, 21 Jul 2020 09:37:36 -0700
In-Reply-To: <xmqqd04p8ywt.fsf@gitster.c.googlers.com>
Message-Id: <20200721163736.69610-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqd04p8ywt.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: Re: [PATCH 2/2] pack-objects: prefetch objects to be packed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, sluongng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hmph, the resulting codeflow structure feels somewhat iffy.  Perhaps
> I am not reading the code correctly, but
> 
>  * There is a loop that scans from 0..to_pack.nr_objects and calls
>    check_object() for each and every one of them;
> 
>  * The called check_object(), when it notices that a missing and
>    promised (i.e. to be lazily fetched) object is in the to_pack
>    array, asks prefetch_to_pack() to scan from that point to the end
>    of that array and grabs all of them that are missing.
> 
> It almost feels a lot cleaner to see what is going on in the
> resulting code, instead of the way the new "loop" was added, if a
> new loop is added _before_ the loop to call check_object() on all
> objects in to_pack array as a pre-processing phase when there is a
> promisor remote.  That is, after reverting all the change this patch
> makes to check_object(), add a new loop in get_object_details() that
> looks more or less like so:
> 
> 	QSORT(sorted_by_offset, to_pack.nr_objects, pack_offset_sort);
> 
> +	if (has_promisor_remote())
> +		prefetch_to_pack(0);
> +
> 	for (i = 0; i < to_pack.nr_objects; i++) {
> 
> 
> Was the patch done this way because scanning the entire array twice
> is expensive?

Yes. If we called prefetch_to_pack(0) first (as you suggest), this first
scan involves checking the existence of all objects in the array, so I
thought it would be expensive. (Checking the existence of an object
probably brings the corresponding pack index into disk cache on
platforms like Linux, so 2 object reads might not take much more time
than 1 object read, but I didn't want to rely on this when I could just
avoid the extra read.)

> The optimization makes sense to me if certain
> conditions are met, like...
> 
>  - Most of the time there is no missing object due to promisor, even
>    if has_promissor_to_remote() is true;

I think that optimizing for this condition makes sense - most pushes (I
would think) are pushes of objects we create locally, and thus no
objects are missing.

>  - When there are missing objects due to promisor, pack_offset_sort
>    will keep them near the end of the array; and
> 
>  - Given the oid, oid_object_info_extended() on it with
>    OBJECT_INFO_FOR_PREFETCH is expensive.

I see this as expensive since it involves checking of object existence.

> Only when all these conditions are met, it would avoid unnecessary
> overhead by scanning only a very later part of the array by delaying
> the point in the array where prefetch_to_pack() starts scanning.

Yes (and when there are no missing objects at all, there is no
double-scanning).
