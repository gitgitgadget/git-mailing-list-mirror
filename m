Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF2DC64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 07:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5024822206
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 07:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgLBHOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 02:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgLBHOm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 02:14:42 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BE4C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 23:14:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n186so718120ybg.17
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 23:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=42hfIrC9qC6VYRKBZqprDuy6ndPHXVBfiTBUZdN6LWg=;
        b=FV0zV8AuNZfPbx6JAAMmC76bt2s3THDZ6HrFEdB+v80fHszebZxWO1JGblbNg8FYdi
         mm6KfpsbfnsyxFFRNxvtmR9qWtAmNXJaO726Y2qHaTUbZexA1rVevCD/BZRnUu9KqIr+
         mdIwvt4EwYGQqd3DVOgos86hZn8nZQt3xPK9XZT5QTjUpEhlUBGpEGIOq3qxqIy6HrDW
         Jgm3V3JGEaKm17FuCxucWdcnKxIXtPIY2poqcjWLHlHyco9dv+eMqglvmxgdd1kixuyt
         l2Xr/EwQlf4PwQ0q6TkYULg6VyX1S4sHtPr8q+l9k49UBqhhHxnCn5Eet9th2fFMlH19
         nAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=42hfIrC9qC6VYRKBZqprDuy6ndPHXVBfiTBUZdN6LWg=;
        b=LJSmBSyEzJ6KQUE7XobmPnzalhV9xymXSClVIN7oKlb+SIaP9fNdW0dlIAb8MxIDJJ
         1tygzkvRVAYsSk1Bkrn84nyCiR9Ep1w1p/eJ8K1sxO8wHIryQvxgCRVwrc8R0QHh39iF
         lYdUejyv4S/Naf3NodlIDlgFi4HhifVMRC8pm6DoPcUaBQAwwf/yB/GYyYn3R2597+uK
         Ae2FyjCoVLrJLvmF4bjbUDblVrR3ECTKiuKJvuvbhQuHMHLs93Zaxmd5ksGs9VhnPvXy
         ec4D5NY9KEq0axlIoUJr/eGzCjwXM9t0MRz5aUNvBiEVEzNz9zkB53qzSIUt/XtseZmf
         rCHQ==
X-Gm-Message-State: AOAM530+gMC/dccBw0Gsd8XpyyLdYMDmXGPVMf35UN9Rwcsm6458RY4f
        uT0sGD7QDMczC1C0eksqiCVzJO9zAAI9yVs6akR4
X-Google-Smtp-Source: ABdhPJzEER9uBZY649m5WrV0W/gntQ8G0bBs+322j8tV+Cmst5UpvaNGg5yd6pyVJk9wSEXiR3AdPXo+7BucoXPkopOm
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2694:: with SMTP id
 m142mr1413938ybm.383.1606893241811; Tue, 01 Dec 2020 23:14:01 -0800 (PST)
Date:   Tue,  1 Dec 2020 23:13:59 -0800
In-Reply-To: <a206f486140097c1554ce92ebcfa7190554dd19f.1605649533.git.me@ttaylorr.com>
Message-Id: <20201202071359.3466347-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <a206f486140097c1554ce92ebcfa7190554dd19f.1605649533.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 19/24] pack-bitmap-write: ignore BITMAP_FLAG_REUSE
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Just because a commit happened to be bitmapped last time does not make
> it a good candidate for having a bitmap this time. In particular, we may
> choose bitmaps based on how recent they are in history, or whether a ref
> tip points to them, and those things will change. We're better off
> re-considering fresh which commits are good candidates.
> 
> Reusing the existing bitmap _is_ a reasonable thing to do to save
> computation. But only reusing exact bitmaps is a weak form of this. If
> we have an old bitmap for A and now want a new bitmap for its child, we
> should be able to compute that only by looking at trees and that are new
> to the child. But this code would consider only exact reuse (which is
> perhaps why it was eager to select those commits in the first place).

Makes sense.

> -int rebuild_existing_bitmaps(struct bitmap_index *bitmap_git,
> -			     struct packing_data *mapping,
> -			     kh_oid_map_t *reused_bitmaps,
> -			     int show_progress)
> +uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
> +				struct packing_data *mapping)

[snip body of function]

Here, a lot of the function is deleted, and only the part that creates
the mapping from old indices to new indices remains - hence, the
renaming of the function. OK.

Overall this looks good. I was wondering if there would be any functions
now unused, but looking at the deleted lines, that doesn't seem to be
the case.
