Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC8FC433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 20:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7EA64F0E
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 20:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBZUzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhBZUzo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 15:55:44 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D57C061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 12:55:03 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id h126so8480490qkd.4
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 12:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=u1eNxswhdNlZGdM6+gLUrkE3RfVOBb0PG+Z9RuA11kk=;
        b=F74Hh9TzlDAcmBUjd1JpLqYMbQ2B2ubQ0iF5uWlGQeae7V+vugFvtmFESvY7HdhbYn
         GcJi6VvmMCIjUCGOH005T4rryWGbtIhylqVa3H7CDPO3uADcBWNocC928F5V06NJIMmn
         Cnl/lcJymkxr4N/O4eDTvB0HFRe4s6kvdNcGXnMWFyL+LlCj881R6/W6trRg+vlllQt2
         teUNpU/wmjDrIpVor7XF7wvvAH4FrSv92xnrJGNPOY2IL8M6v43vqzK4BqOlbmJJyPKd
         BqRoeZlP4SuIhEXZEnRf5E35lExZTsEngM5I671GBJuh0ybuccoRe9Jm47SIT/EYMPfX
         I6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u1eNxswhdNlZGdM6+gLUrkE3RfVOBb0PG+Z9RuA11kk=;
        b=EzcyRYfVJEOA7wv+1X0wvYWb4eXZbSAQCOtXtaBFzzzpL1sMoWzP6ei4/IaSc1nliM
         sJDSaTHbF3PL+lOgGMPmINA84tY7t987q3N0cYV/z12Os3WiKjGgSZaMuTM29wkYSMT6
         +FVFaIZv8EmSTo7jkNdxos3FRN0PDQDb06/c2JyugDqcEHND3JkH+WD5ymZVL7N3Gmii
         TTqV/g4o3n3+i0n7r5jRJHVXaXvkpZY6PWD43glMkwOmaAUe4qvl/6MP1HOc4PvEecF0
         +V8SpI+q1DxcbDTjeGLXQ147Wx1EF7IZoC7SKbGciCijP7AP6u+0lOjhsJez1MGx9JxK
         FVMg==
X-Gm-Message-State: AOAM530aYrLeT/X8kCEP6fH3zkN+XZVtKSGe/8wu5w1znIoKwAoF8Ovq
        +kuJ+bYbgEjkIstUPXD+g6J5D7xCGslRGp1uqixs
X-Google-Smtp-Source: ABdhPJyYM2QArq+Q67nRiZe+rhodDiq72keWxf7KYiARBk5rvH6p7kxU5w/+VC7yJaepP58+k67ah/X0ULCgAI1/rJBJ
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:5ce8:: with SMTP id
 iv8mr4558315qvb.16.1614372902740; Fri, 26 Feb 2021 12:55:02 -0800 (PST)
Date:   Fri, 26 Feb 2021 12:54:58 -0800
In-Reply-To: <CAFLLRpJgfseK5P8ZJm7iEW1onf7ROVSkyeuPfh1+qoHHjsC8uw@mail.gmail.com>
Message-Id: <20210226205458.2909811-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAFLLRpJgfseK5P8ZJm7iEW1onf7ROVSkyeuPfh1+qoHHjsC8uw@mail.gmail.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: partial clone: promisor fetch during push (pack-objects)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     robert.coup@koordinates.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> For a partially-cloned repository, push (pack-objects) does a fetch
> for missing objects to do delta compression with.
> 
> Test-case to reproduce, with annotated output:
> https://gist.github.com/rcoup/5593a0627cca52f226580c72743d8e33
> (git v2.30.1.602.g966e671106)

I found it difficult to understand the gist (there were what I think
are unrelated packings and unpackagings of objects, for example), but
what I gleaned is that you did a bare partial clone (thus, no checkout,
so no blobs get fetched at all), wrote a new blob to the repo, manually
created a tree with the ID of that blob and the IDs of some missing
blobs taken from the current HEAD tree, committed, and then pushed that
commit.

> My use case is partially-cloning some large repositories with the
> majority of the blobs not fetched locally, writing some blobs to
> replace some specific paths I don't currently have cloned, committing
> & pushing (while leaving most trees as-is). I didn't expect git to
> attempt promisor fetches during a push :)
> 
> I happened to see it because allowAnySha1InWant wasn't enabled, so it
> printed errors but happily continued and completed the push (after a
> fetch attempt for each object).
> 
> My current workaround is setting `pack.window=0` during push. Looks
> from builtin/pack_objects.c:prepare_pack() that `pack.depth=0` should
> skip it too, but that didn't seem to work.

Ah, thanks for this. So the cause is not that we are unnecessarily
pushing the missing objects, but because they appear in the window when
we do delta compression (just like you said at the start).

> Invoking pack-objects directly with any --missing= value still tries
> to fetch. And regardless, it carries on if the fetches fail. The
> fetches happen at the end of builtin/pack_objects.c:check_object().

To clarify, the "end" here is the call to prefetch_to_pack(), which
indeed bypasses fetch_if_missing (set by some --missing= arguments).

> 1. Feels to me that fetching from a promisor remote is never going to
> be quicker than skipping delta compression during a push. Maybe
> there's a case for doing it during other pack invocations to minimise
> size though?

It makes sense to me that we shouldn't fetch in this situation.

> 2. Seems like a bug that check_object() doesn't honour
> fetch_if_missing and skip the call to prefetch_to_pack().

We do need to fetch if we're trying to pack a missing object. I think
the real bug here is that we shouldn't prefetch if the to_pack entry has
preferred_base set (which means that it will not go into the final
packfile and is just available for delta compression).

> 3. But push doesn't pass --missing= to pack-objects anyway, so that
> wouldn't actually solve the original issue. Should it?

If we fix the bug I described above, I think it's still OK if push
doesn't pass --missing=.
