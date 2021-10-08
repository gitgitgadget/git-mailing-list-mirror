Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5BBC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5244610E5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhJHUVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhJHUVG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:21:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3E7C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 13:19:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so14053579yba.11
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WGkLO9J6iU+sQy44FnsGWMCSfUpJIeeUfT6AelnHVJY=;
        b=hdZXMw8aZnl6RwEpJ6SPe7ZMD/P3HAGgebs4qpjWFRF2uPVeAPIkSa22hlwzRIBJLe
         zvA//eVmSAyL4CQheHrBjhD5MlKeYbKJ0NVKAFSxYdTOKXPWybwXeDk51h6W5yge+iQm
         s7Dq/qP6RarTPJnPox9FtaBppndbfFKCChHmG2E8iVwKtfWuQgImmr0HP+G8yu6nQPvD
         +VfO4haEqDP2HHuGUHFuKuqDfSfafBpYRosmZ5+5oDHBH/QQB0HO/Tt71/NiOn2npTl7
         wSt6wXe287pNk2z6Av7awuiL3EsMzKoaNjlODq5aGfVUZ6yl/4lUDVjfTwuB5kL6YCGG
         W9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WGkLO9J6iU+sQy44FnsGWMCSfUpJIeeUfT6AelnHVJY=;
        b=OsQdXgOKhpWVNyVzGcGT0zBoDdC0o/YcHlcTd5wur8GNwzD44ZuqoPdNC8V1Ludo/t
         GBZAKspiH9BOLZc+p7KIO7NWkxL7MDw40rMsQegx6pr7OmJOD40YT8ZiM4sy1lKJz860
         4LQfXGHWjNlkQ3raXmZxLpvdPjGNOXPZP3PVZVy7ELxAkN7B1s8HV+L0qxBlffARHPqx
         CmHlwtQNSCasxqZBY4W7gbNNtI8cUMqXKEPcv8dUbmEQqlJ3rNm4DWErV9unUTyXWdsY
         oL1Nx8YUyircf/FEnWxXiJxPWT1GH4TNr6v5GV6puPcbYE4DFKHe9Ps/u/5DMRgBAlj4
         MVnw==
X-Gm-Message-State: AOAM530RibSLc/6dXP+HZnv/J5j26KUBTIogacLmTfuQs5kJFsAO/Lgo
        B0GTpBG4SoheohgqNT/amK96Q0bsx1d9V9wQgndV
X-Google-Smtp-Source: ABdhPJw95YJIRXuUEhKZr5d5nZiBZLw0G8ksOMUHhotr8XLQYwzcF0KzNBp5E1QHdArXNzNsAbJ/ptrMXQcahuZP0P0u
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:bb49:: with SMTP id
 b9mr6049977ybk.362.1633724350320; Fri, 08 Oct 2021 13:19:10 -0700 (PDT)
Date:   Fri,  8 Oct 2021 13:19:08 -0700
In-Reply-To: <YV89pOZh+qj/oplL@google.com>
Message-Id: <20211008201908.1325631-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YV89pOZh+qj/oplL@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: Re: [PATCH v3 4/7] merge-{ort,recursive}: remove add_submodule_odb()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
> > +			      int abbrev_len)
> > +{
> > +	strbuf_repo_add_unique_abbrev(sb, the_repository, oid, abbrev_len);
> > +}
> > +
> 
> Should strbuf_add_unique_abbrev() be inlined and moved to the header?

I felt that it wasn't worth writing '#include "repository.h"' in
strbuf.h just so that I could inline it. (The function signature just
uses "struct repository" opaquely so "struct repository;" is fine, but
the function definition itself will require full information about
the_repository so we would need to include the file.)
