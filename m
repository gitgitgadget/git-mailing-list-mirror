Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C624DC433E2
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A4B20771
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YK7EQSvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbgGUXUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgGUXUk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 19:20:40 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E195C061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 16:20:40 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id r12so355699pfr.16
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/3op9JVCJuaQ/gthrV0yndxiJ8BTN0To2fBtyMbUhxY=;
        b=YK7EQSvlx/kIq7ynmDtzz3uIHjhYbpK4T2gEujcm6O6dYr3IuSX8oYmLB8J+szous3
         xv/cWn0WlwpMYQQW6qe0diq5UDZ1GCFBs+EzPGXg5QuuJW/ApU7bMil4jLHRLu0MJQK4
         4Z8MInK1Juixrd55TRbEAuAKWzLkQK7reOGs21yBIHXbW3dexVqY6yhu9Q1k/5/rkrwh
         aOEvNbrGDi8dO/AIRtoCgo9Pegg+vaeTlZc80hjrXKXEwt6Vgw9lF0dPHtfhnvMvjv6B
         BP4MI5ky9dcXx2DLlJqMg4vGl/5tOiMGwar/PoWuugifsWRvexyzK2K4u4WWI67oc98w
         Pf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/3op9JVCJuaQ/gthrV0yndxiJ8BTN0To2fBtyMbUhxY=;
        b=lPbxKFQK7bkAk3dnJYizyaoMkztePE8JZ7BRXrOMzsL6KZ9kELnsphVFdbvJzzO0/g
         J5gyIwMedXhtlChJFokHht3FQvSjd4kF6kiO175mN3vzSEtuCHyfIeWUgD317UStDzsv
         fsM3Wd0K8EsVc3dW5sPc/nQqZTYf6WStlmD+kvgl34uoykBzvy7n+ZS4xhmHdKYgXlQD
         EjcSYyfzTgebuXiSE0Z16ViNgi4uvTA2Nvc0jDxyrYdc0RiiMZX5JmU98eGzHtE1gVfC
         lqkcyWUkqp5mJyNEynatDD4lL23TOQGZ9aEYECwPNxzWyil9WV/wiG56Wts7VRR+7JAR
         dy4w==
X-Gm-Message-State: AOAM530YpwpgnaN1RnEKjP9k5g6+mz0IdJlbfHe8BBJLTT56iQ8tYRaD
        NCK+r8dLWNeY1IWGM8jXlos5qwFZqYhtnyijHUTS
X-Google-Smtp-Source: ABdhPJwbCARLYoQA3Kvmn1n6HVgjbgcLMgs1XvxnsziO51UYyi5JlpNQPJl7MCuum5Q6OAE3MgNA9FQECzJG8tLJbLdW
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr756921pjz.1.1595373639404;
 Tue, 21 Jul 2020 16:20:39 -0700 (PDT)
Date:   Tue, 21 Jul 2020 16:20:36 -0700
In-Reply-To: <xmqq5zag8yg5.fsf@gitster.c.googlers.com>
Message-Id: <20200721232036.1358644-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq5zag8yg5.fsf@gitster.c.googlers.com>
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
> >> +	if (has_promisor_remote())
> >> +		prefetch_to_pack(0);
> >> +
> >> 	for (i = 0; i < to_pack.nr_objects; i++) {
> >> 
> >> 
> >> Was the patch done this way because scanning the entire array twice
> >> is expensive?
> >
> > Yes. If we called prefetch_to_pack(0) first (as you suggest), this first
> > scan involves checking the existence of all objects in the array, so I
> > thought it would be expensive. (Checking the existence of an object
> > probably brings the corresponding pack index into disk cache on
> > platforms like Linux, so 2 object reads might not take much more time
> > than 1 object read, but I didn't want to rely on this when I could just
> > avoid the extra read.)
> >
> >> The optimization makes sense to me if certain
> >> conditions are met, like...
> >> 
> >>  - Most of the time there is no missing object due to promisor, even
> >>    if has_promissor_to_remote() is true;
> >
> > I think that optimizing for this condition makes sense - most pushes (I
> > would think) are pushes of objects we create locally, and thus no
> > objects are missing.
> >
> >>  - When there are missing objects due to promisor, pack_offset_sort
> >>    will keep them near the end of the array; and
> 
> I do not see this one got answered, but it is crucial if you want to
> argue that the "lazy decision to prefetch at the last moment" is a
> good optimization.  If an object in the early part of to_pack array
> is missing, you'd end up doing the same amount of work as the
> simpler "if promissor is there, prefetch what is missing".

My argument is that typically *no* objects are missing, so we should
delay the prefetch as much as possible in the hope that we don't need it
at all. I admit that if some objects are missing, I don't know where
they will be in the to_pack list.

> >>  - Given the oid, oid_object_info_extended() on it with
> >>    OBJECT_INFO_FOR_PREFETCH is expensive.
> >
> > I see this as expensive since it involves checking of object existence.
> 
> But doesn't the "prefetch before starting the main loop" change the
> equation? If we prefetch, we can mark the objects to be prefetched
> in prefetch_to_pack() so that the main loop do not even have to
> check, so the non-lazy loop taken outside the check_object() and
> placed before the main loop would have to run .nr_objects times, in
> addition to the main loop that runs .nr_objects times, but you won't
> have to call oid_object_info_extended() twice on the same object?

The main loop (in get_object_details()) calls check_object() for each
iteration, and check_object() calls oid_object_info_extended()
(oid_object_info() before patch 1 of this series) in order to get the
object's type. I don't see how the prefetch oid_object_info_extended()
(in order to check existence) would eliminate the need for the main-loop
oid_object_info_extended() (which obtains the object type), unless we
record the type somewhere during the prefetch - but that would make
things more complicated than they are now, I think.

> >> Only when all these conditions are met, it would avoid unnecessary
> >> overhead by scanning only a very later part of the array by delaying
> >> the point in the array where prefetch_to_pack() starts scanning.
> >
> > Yes (and when there are no missing objects at all, there is no
> > double-scanning).
> 
> In any case, the design choice needs to be justified in the log
> message.  I am not sure if the lazy decision to prefetch at the last
> moment is really worth the code smell.  Perhaps it is, if there is a
> reason to believe that it would save extra work compared to the more
> naive "if we have promissor remote, prefetch what is missing", but I
> do not think I've heard that reason yet.

I still think that there is a reason (the extra existence check), but if
we think that the extra existence check is fast enough (compared to the
other operations in pack-objects) or that there is a way to avoid
calling oid_object_info_extended() twice for the same object (even with
moving the prefetch loop to the beginning), then I agree that we don't
need the lazy decision. (Or if we want to write the simpler code now and
only improve the performance if we need it later, that's fine with me
too.)
