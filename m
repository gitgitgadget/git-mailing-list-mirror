Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C0EC433E0
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A16022B43
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JV0c4x9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgGVVaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgGVVay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 17:30:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159EC0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 14:30:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k75so3912129ybf.19
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tCsiORbAxFjt/8Q7hDkNv8+0WSAIraEmQObLFr233To=;
        b=JV0c4x9yZkuTWPHBu4Pmc/s9H1UK9cV1vO+fK6yFK06R8LrXWQdlSno7PR4DxxuqzQ
         Xaxb5HqkLVwl6qwmoXzP946WKKZZghFIrERscNOG0HzK0GIaD5GE6LoaBSXbCA7fXQD4
         x8n6ZKwWCEfZFsqjw/K/9B4IOAD9CD41u7FFdhaJ7CaierbT2ulhwXHs9GWBtcvvJDe3
         nr8dyRt5KRIoJ041T3fXSE1LRhWDsmOjF2lNouh41cp0JawRLqCAFEvFmn467AUeaygk
         ksGjeOUwjJcpEjjPI6mqR1+2FzgES5R13mS5T9VEPqO6JVllngmqGeWToj3g+l8tO5ZC
         v+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tCsiORbAxFjt/8Q7hDkNv8+0WSAIraEmQObLFr233To=;
        b=Pa9PkoJ1liP8/ee25gs1HzULrlhrF/z/oLUPtcglMPlIaDEqmXjGpXa7bYL5GYhVc7
         0yWpXEeUyWZ40rg/wt4NEUKruELEZbXYSsgvo+S6bu1J+abVfIxzZftyGsrN1tJEU9ev
         HIPJYECjSrtuwYBvpD40UVerRDqszk6jSzdXQIIus441G1SsD8GHoMmnPZA+GgWeoqX2
         XbAV2LIDv1qPDUN8mnKj0Tp767DP61yAyDTthlQPpbMVP+rLjL29BC/llu2tESF/vrcq
         klmnjmzOu6Vzb4NsVK1rG8f1eGhyfMK7QN4GV+6VHzixU+clR0qBL3Slecf7ne/iJpLb
         o2Rg==
X-Gm-Message-State: AOAM530VEKt2gIZ1eLz6ZHeloq8KWWf705/Ha7tfiwVbex+a+ZUh3Bgk
        wg42s2W0OlmI8gs7Xmcea+SS2o5WDasoRLfrXhtp
X-Google-Smtp-Source: ABdhPJzAw0L3yLsJUy/TQZ3BM1GMN0k5qdVFUOhgYkyJOOgZHImqJxkMF72TE+xSXy6CwA4TsjGQfC3DbWBu/7iYymKe
X-Received: by 2002:a25:cfd7:: with SMTP id f206mr1984714ybg.289.1595453453891;
 Wed, 22 Jul 2020 14:30:53 -0700 (PDT)
Date:   Wed, 22 Jul 2020 14:30:48 -0700
In-Reply-To: <xmqqzh7s5sv4.fsf@gitster.c.googlers.com>
Message-Id: <20200722213048.1581991-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqzh7s5sv4.fsf@gitster.c.googlers.com>
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

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > My argument is that typically *no* objects are missing, so we should
> > delay the prefetch as much as possible in the hope that we don't need it
> > at all. I admit that if some objects are missing, I don't know where
> > they will be in the to_pack list.
> 
> OK, if the common case we optimize for is where there is no object
> missing, then of course "prefetch missing ones upfront" will spend
> cycles to ensure all objects we will pack exist before going into
> the main loop, so the "delay as much as possible" optimization makes
> sense.

OK.

> >> In any case, the design choice needs to be justified in the log
> >> message.  I am not sure if the lazy decision to prefetch at the last
> >> moment is really worth the code smell.  Perhaps it is, if there is a
> >> reason to believe that it would save extra work compared to the more
> >> naive "if we have promissor remote, prefetch what is missing", but I
> >> do not think I've heard that reason yet.
> >
> > I still think that there is a reason (the extra existence check), but if
> > we think that the extra existence check is fast enough (compared to the
> > other operations in pack-objects) or that there is a way to avoid
> > calling oid_object_info_extended() twice for the same object (even with
> > moving the prefetch loop to the beginning), then I agree that we don't
> > need the lazy decision. (Or if we want to write the simpler code now and
> > only improve the performance if we need it later, that's fine with me
> > too.)
> 
> Now I finally have, I think, heard some of the reasoning behind the
> design decision made before this patch was written.  That should be
> written in the proposed log message.
> 
> Thanks.

OK - how about:

[start]
When an object to be packed is noticed to be missing, prefetch all
to-be-packed objects in one batch.

Most of the time (typically, when serving a fetch or when pushing),
packs consist only of objects that the repo has. To maintain the
performance in this case, the existing object type read is made to also
serve as the object existence check: if the read fails, then we do the
prefetch.

An alternative design is to loop over all the entries in to_pack,
checking the existence of each object, and prefetching if we notice any
missing. This would result in clearer code, but would incur some
performance degradation in the aforementioned most common case due to
the additional object existence checks.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
[end]

The first paragraph is already in the original, and the rest are
additions.
