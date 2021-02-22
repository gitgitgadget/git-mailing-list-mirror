Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4502C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 20:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD5C164E32
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 20:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhBVUCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 15:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhBVUCa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 15:02:30 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C8C061786
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 12:01:49 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id v16so8669055pgl.23
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 12:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KhefMflxfwbb7+KZR9yrjeOMVedPl14/Jjij0fcerqU=;
        b=SchL6MuEz4wwq1h4q996SrBqW6wh3LXPiNhFp6omE3g0p+Z10r/U8lQIr33aYtQhIO
         rth+6WDXpJbq42WdOiIy7J+vmZS5gHTuLTSUWMw2BC5aDrsmSj/28cq48Izz4J1oWwQ9
         3cb3rUAVOBBxeKamo8DJltZGyVoqYEAGtq+sdN+zvWmbHgj0FVeR5YJGN8YlvvzSjhGS
         wBLqePkwbm8d9pNKoYw7VwqWzMvIeX7+PCYgHwSQB8pi3IJH1RmPOziNMib4WiOsJeYY
         tmxIhEUmlBh/NtMoHBZH87vMKhRYUcKNH02Ywg3P9Kg6muhL/fd/sK3cga5O1zVH1Ccu
         pqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KhefMflxfwbb7+KZR9yrjeOMVedPl14/Jjij0fcerqU=;
        b=b8ylT9THmBH1EFkrQAYZlZ76KMPzJ1aW4gou2NzIsKOorX90xyU/0oEqGMZ2VLHByP
         BJKkEQbT2Vw8YvAT5a3V9F4kijiNsJChqla9jiqztOV9DKL/l8X4C0yIbzLj+FmPbFQr
         yCx76SzXdFg6rkY9ei9Vn3t/18wzj21SZ64eswKlPGWkrV0OkmRO0p+PNgyikkqDXtN2
         rDDTGhGFwlW+nq3H40oDCrDtS7u/+S3Jx5SqLtjegijAwwrpl+hcYwn+rZetUx+93dsQ
         oryySW0mEGcHlNU1Ejb8gYOEnWUJeJrIJwPLmGLeGhkOA9zcUbQRGO/2SPtN6mkFkMAB
         ktyQ==
X-Gm-Message-State: AOAM530RqJ6rI+N3F6q1hLZzQMeN2rIOsRvrKvUOFT8X5vqLz3V3LBYL
        qzSkuTxRH7QSfWARCFMrORFw1tfkrLiL7ssJ/7vN
X-Google-Smtp-Source: ABdhPJzF+HtYI5zekxt3RqM/tLfYuXcl0UfUaKAKDOICNHuoTTNDtL1+gFBehlNYb3ZkGiBzxsIxx0QH6H6fcgmelu5y
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:9e9:: with SMTP id
 96mr24768229pjo.80.1614024109143; Mon, 22 Feb 2021 12:01:49 -0800 (PST)
Date:   Mon, 22 Feb 2021 12:01:46 -0800
In-Reply-To: <xmqqzgzza0a1.fsf@gitster.g>
Message-Id: <20210222200146.1393467-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqzgzza0a1.fsf@gitster.g>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: Re: [RFC PATCH] push: perform negotiation before sending packfile
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> For a real implementation, I think we'd want to do the negotiation
> >> inside the conversation between send-pack and receive-pack, so that
> >> what is agreed to be common between two parties will not shift in
> >> the middle (in the same spirit that upload-pack grabs all the
> >> relevant refs first, advertises them, negotiates what is common and
> >> creates a pack, all using the same worldview of where the tips of
> >> refs are throughout the process, even if some refs change in the
> >> meantime).
> >
> > Upload-pack does that for protocol v0 ssh:// and git:// but not
> > http(s)://, and does not do that for protocol v2, I believe.
> >
> > If we were to do that, I don't think it would work for the transports
> > that have are stateless (e.g. HTTP).
> 
> Yeah, I consider it a bug in the "stateless" hack, though, and v2
> somehow chose to take the common denominator to propagate the same
> bug to protocols that are otherwise capable of being stateful.
> 
> In any case, I think I heard in another response from you that you
> plan to do only v2, and I think that is OK.  Perhaps we can have a
> separate service (like 'ls-refs' is a service that can be used
> independent of the 'fetch' service in v2, and can be used by
> somebody trying to 'push') 'negotiate' that can become a separate
> thing, so that "fetch<->upload-pack" conversation would become
> ls-refs plus negotiate plus fetch,

That does make sense conceptually, although the fact that every
negotiate step could potentially also include a packfile (when fetching,
as we do today) makes things more complicated. (Besides the fact that we
would be making another change in the protocol.)

> while "push<->receive-pack"
> conversation would become ls-refs plus negotiate plus push?
> 
> Thanks.

I guess the idea is to have a push that does not start with a ref
advertisement, therefore making everything more modular? That sounds
reasonable (and does mean that if we ever decide that pushes with
negotiate don't need ref advertisement at all, we can just remove the
ls-refs part), but this sounds like it would require some sort of v2 for
push - which is another discussion topic.
