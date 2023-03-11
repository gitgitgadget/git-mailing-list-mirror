Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B75C6FA99
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 02:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCKC7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 21:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCKC7O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 21:59:14 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA463F5A82
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 18:59:12 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n203-20020a25dad4000000b0091231592671so7651335ybf.1
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 18:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678503552;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zDspiub3J1yLrYsH6GaFu1vrV/18THJHkUiSGQOqOuk=;
        b=tJxbbGP4XHO/TWZCUyZQAGzKOMP7js5TIcNb3JHnrnqP8GaAKT0/KKM9inQX7yGiwO
         gCSX4KGFVWVvRHVAP9ThqkQOmHyQMYcWu9Q70zHs7SAiUCJvtbgVfa0ib/iOa1aYWIZr
         203oQixaM4y8H20HKsiUNTuEFdKQVyrMkD6zoPRekDrTvmJfACWTKIf+q4wcPwH7+foy
         sDT8j5BNMS0G33jO9HzVPxA4lVarbHvjM3uWi/xsrX8pTgo7nfS79d6OgNXDhaOCslMe
         oTrE/S6JR9pfCeH1v9rRWwBfishOkwOxArGene10QeQlWxrao8oVS5q1v0iLp1Vtzmd7
         5i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678503552;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDspiub3J1yLrYsH6GaFu1vrV/18THJHkUiSGQOqOuk=;
        b=JzSj7D510225TsNTtX5BPWHeFZeL51oc5m4ALPaQfCYUQIBmU9LR9zs+RpJW6VvJDD
         pHqC9wL7s6QVb96k35VbCcmqLQ5vYLVT3PsjfptLvvoiYpwnrEWfHjawyzhIa4lCIAh4
         gHJRTiAnmFbH8Z6R0To6wOL11RKxFhwZkMeKgVBWLdfOkADDowYwb6Lg4JAmpClfEPYZ
         foAHCpyDcO3GrtWn7URyDqRySyobobQ55mrCseFWyhODy3puq+Nspe0zTGycAERky7Dp
         npVdD1lVfa5ykJi2IcdMXdV9ERsduuxqNRIhkOrRbgAGTaSxlCrPDdX2uLGX0A132DI7
         SlyQ==
X-Gm-Message-State: AO0yUKWjvIL40O361eyMH/9q5ibjpkCFx57iYvDSOw0bVYt7IG+sZ/IT
        SM7o9vJA/GY28gMpJHCp4WCszS08TfHQdgq5ShFB
X-Google-Smtp-Source: AK7set/DYnFV1nfVNY49oowhK7jAAKesMLyZW9Pgn5BOVR3lK25jIl7OLRK0WIvHMNyeO9I9Xb3kdOo8OULwGMxbrMfI
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:f63:e36e:a446:b3ac])
 (user=jonathantanmy job=sendgmr) by 2002:a0d:ee43:0:b0:536:35d8:17d5 with
 SMTP id x64-20020a0dee43000000b0053635d817d5mr5ywe.228.1678503551857; Fri, 10
 Mar 2023 18:59:11 -0800 (PST)
Date:   Fri, 10 Mar 2023 18:59:06 -0800
In-Reply-To: <xmqqttys4746.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311025906.4170554-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2] index-pack: remove fetch_if_missing=0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Do we have other uses of fetch_if_missing (i.e. disable lazy
> fetching)?
> 
>     $ git grep -l fetch_if_missing
>     Documentation/technical/partial-clone.txt
>     builtin/fetch-pack.c
>     builtin/fsck.c
>     builtin/pack-objects.c
>     builtin/prune.c
>     builtin/rev-list.c
>     cache.h
>     midx.c
>     object-file.c
>     revision.c
> 
> As the default is 1, all these hits (outside the header, doc, and
> object-file.c) are to disable lazy fetching.  Judging from the list
> of "family" that want tighter control over what gets fetched, I have
> a feeling that pack-index may want to stay to be in the family.

I think this "family" concept is a good way to think of it. I did
use to think that it would be better to be consistent throughout Git
and choose one world-view, and if I had to choose, it would be the one
without fetch_if_missing=0. But now it does make sense to me to have
two families:

 (a) The more low-level code that the lazy fetching itself relies on
     (and maybe things like builtin/fsck.c as well) where we really need
     to be careful about what we fetch, and it would be better to err
     on the side of not fetching. The test cases for these would need to
     cover both the partial clone cases and the regular cases.

     For these cases, the consequence of lazy-fetching when we shouldn't
     might be as bad as an infinite loop, so it makes sense to default
     not lazy-fetching here.

 (b) The more high-level code, in which I think that it is better to err
     on the side of fetching. The test cases would generally not need to
     cover the partial clone cases (except when there are specific
     optimizations needed, such as in checkout where we bulk prefetch
     missing objects).

     For these cases, the consequences of lazy-fetching when we shouldn't
     are generally performance-related, so it might not be so bad to let
     development happen in these areas of code without great
     consideration to whether a lazy-fetch would happen if an object
     didn't exist. (I do think it would be ideal for all new code to pay
     attention to when they read objects, which would help not only in
     partial clone but also in a potential future in which we have non-
     disk object stores, but we're probably not there yet as a project.)

And indeed, pack-index would go in (a).
