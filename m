Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292C7C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07B064EE7
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhBBCVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhBBCVH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:21:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59BBC061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:20:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w4so10329170ybc.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3Ui0M0JFtZGpC3Lc97nLx7XOC0ITN0udRl312ON4RxU=;
        b=viFe7LsrxwsDg9nUoBm/Ch/FxONxU+U+q/Ux4u7jHoZMF8/s21w85/QzKfzkswbDlR
         76ZvU+vhPhVtyBsIB9lqmINnM9cZd0lhE1PjzL8qKa3AbisWkHOb19k05rBQhhLinFP9
         qxCFvQAJLF7xt/A1siczPrX0AtpHUaRoDsgHBXgbA1O+Y1Bym+yPfaqi9cQ5CBOr0j/e
         H5Sqt9Y0RXLAijykZAsPCJXhBT/86prH5oZTiuapw9ozBBOyqYZqzF9GHXtEClhbR7Y+
         hB07rNbYhi9X7bgywkl+/X6uRYxMfzZVzdywMs0kVYU0t1NiZ9BUt7BMj7Cyl/gQvLwh
         g2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3Ui0M0JFtZGpC3Lc97nLx7XOC0ITN0udRl312ON4RxU=;
        b=eI6O+DZO8+rFmYNf7tLzhquSqsfCR/Z6dx54GgFVyTOH9Ck8zltdSZ6OcxcEjsODAe
         kuqJ+OQOMqE9mMY3g7utmmgYaQB2/EWGN/+XnfUjvjT3YBnM/Vgj1MrEqv61pnzOUB5X
         F51cZ6MPu+27kCrwGzmhWhlfQ8/6IhNVJ4+StLQKnzQqNrHjM4N4YAOJ6tiNwlxddHIU
         otLQS9xcM/VaymJr9ZBIIIuNZmFAKli+jL7872j+RGfEDv6+k+6+H0FxBGkidlnpwxeZ
         ZW0EgYELBirghQWD/tGWW8gKlckWJXyvkphA0rNWg2yJ7Y9GquXstxYiPxOuP47nDlxE
         iQ/w==
X-Gm-Message-State: AOAM530AfwGW3ZVzGmg8i8e66h8N/O9pgjXed5VrWuZHa2BEwc+sPoX+
        SFw062LHTCQMj0HK9Hsu1zZNqUS9NBp1AJldxy8I
X-Google-Smtp-Source: ABdhPJw/wfzsGPD6wMrie6psoAHHq7chYZXcZ0al7/Db9RU6fmloYzDESA6SR3LJz/z5soKhmsvHJBDa0PPnmlLb8xrY
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:c553:: with SMTP id
 v80mr13929551ybe.422.1612232426835; Mon, 01 Feb 2021 18:20:26 -0800 (PST)
Date:   Mon,  1 Feb 2021 18:20:24 -0800
In-Reply-To: <xmqqtuqzs8m5.fsf@gitster.c.googlers.com>
Message-Id: <20210202022024.1791749-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqtuqzs8m5.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v5 1/3] ls-refs: report unborn targets of symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> So a dangling symref, e.g. "refs/remotes/origin/HEAD -> trunk" when
> no "refs/remotes/origin/trunk" exists, is not reported to send_ref()
> in the same way as an unborn "HEAD"?

I've tried it, and yes, for_each_namespaced_ref() will not report it.
Looking at the code, I think it is packed_ref_iterator_advance() which
checks for broken objects and skips over them.

> I would have expected that we'd
> report where it points at, and for that to work, you'd have to use
> not just the vanilla send_ref() as the callback, but something that
> knows how to do "are we expected to send unborn symrefs" logic, like
> send_possibly_unborn_head does.
> 
> That "changed to tolerate ... should work" worries me.
> 
> If "for_each_namespaced_ref(send_ref, &data)" will never call send_ref()
> with NULL (as in (void *)0) oid, then that would be OK,

If it called send_ref() with (void *)0 OID, it would segfault with the
current code, which calls oid_to_hex() on the OID unconditionally.

> but if it
> ends up calling with NULL somehow, it is responsible to ensure that
> data->symrefs is true and flag has REF_ISSYMREF set, or send_ref()
> would misbehave, (see the first part of your message, which I am
> responding to), no?

If it did, then yes.
