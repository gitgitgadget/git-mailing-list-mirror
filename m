Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28873C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FD960F57
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbhHMQyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbhHMQyN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 12:54:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D4FC0617AD
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:53:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p71-20020a25424a0000b029056092741626so9659783yba.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QMg0Uw6a0SsI2DSf8JuByAcBuZF1Mh+fGGNopq7uilg=;
        b=Vrkdjj9a7Rd76U8kIuxLkLkyFv3KwE/gYN7z9fI6Px92gKgWhNNe8G51u1LjpwbRYa
         YXLJUYNZssFybwOgJa+4QiijlbOYD0T78L4wkhrxbJgXge4dYxKAa1MUehjb8GAu2R2p
         l/E+pVM8jL4ya8o8AnDgvFNM8xFJEhCk4jTk2aG3hHksC63kuUEnK8oLmRERyQHi43Sx
         lx59fsiV34CFSevp14Z9r5cCQjH+rs4PxJd37s3fqH0p+Hbp6vwjssGKdgzXoIwHQkGv
         56Y8WawSZWR0XLZMMkOXnEj5wcoUYasl1rdQrDNTvAXfNJVTVRMg1Od/Xqse1qi65Kyz
         HXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QMg0Uw6a0SsI2DSf8JuByAcBuZF1Mh+fGGNopq7uilg=;
        b=WuB/9oBu4diSkq58PzHmqJH3v0caqIqftY6+3BaOhZ1Axzvohd5M3xihG3NvK8Mjrb
         Nkjb4pAiNjFug4r2pvx9Ynr50qM0xLHwQgYarkJ9N49flr8ZhzBnQ9s3G4zk1YVkCsSg
         W1r6QHGIMJ3x5AR2ndeE81J8CD6HVhycBHaIIco/TT2h8gAZY1prjaQEmhjwW3IPfEAF
         pBSpc4cnP0Ei4SHQxu8vkg91bux14/dLXjYdZQAGPoYqMxUok7Sw0TEjW1J/f4F4dHPY
         a/3gtviYZEaFisc49O69Ond43GWAq1EXILXnGgSMyO/wBXaJPSw00EomKKH57mJWeb0C
         PR9g==
X-Gm-Message-State: AOAM532HF/rBKRYwEzDHD5VBl3rO0T1xS0wsQiBseRgk1b8zQ+wY0Eqn
        /b1eQjNxmyO+5ZbaYmbTak57JGaKo2Wd/XXLWA2M
X-Google-Smtp-Source: ABdhPJx6OfIWEc903ihFGCSTQ7YS2gjOSAgTim5bbkwOq9jplXOAJeCkY03tmssQq1kUqanuYzJy8+TZ9LaAwJSSRuNh
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:aad2:: with SMTP id
 t76mr3985010ybi.18.1628873625364; Fri, 13 Aug 2021 09:53:45 -0700 (PDT)
Date:   Fri, 13 Aug 2021 09:53:43 -0700
In-Reply-To: <xmqqtujxc8a3.fsf@gitster.g>
Message-Id: <20210813165343.3225573-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqtujxc8a3.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH 1/7] submodule: lazily add submodule ODBs as alternates
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +static struct string_list added_submodule_odb_paths = STRING_LIST_INIT_NODUP;
> > +
> 
> I see 2/7 allows callers to add paths for submodule odb to this
> list.

Yes, and as you said below, add_submodule_odb() has been modified to add
to this list too.

> The "pretend as if objects in submodule odb are locally available",
> even though it may have been useful, was an ugly hack invented
> before we started adding the "access more than one repository at the
> time with the 'repo' arg" extended API.  It is pleasing to see this
> step shows an approach to incrementally migrate the users of the
> hack.

Thanks.
