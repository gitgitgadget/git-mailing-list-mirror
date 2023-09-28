Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44382E743C6
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 21:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjI1VrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 17:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjI1VrS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 17:47:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BB319D
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 14:47:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81503de9c9so21557044276.3
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695937636; x=1696542436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0+Hw6GucHMsA6iPg0FIN18mc/wmn8+6t8J68Z4QdmUQ=;
        b=iGcgFvn4I1bZF5Su8z9PnUFuiKJ+K45UW3q1gnhW/E9z5vvslLevvhOx4G6YD5/+sj
         QvTu89MLyP3+3nfcxZ1gPg7qDTwuTmcYwk9H/K7AHbAixbK1wIITxdtCrRwv/zcZh875
         WMfI8eL+JhRotHMuHVZ1TY60M8hHNRZ5C+3hYLNeWEnQFXhCWHJnzaUxSi0Ai0fvoG6O
         1pVhkX4dpkr0FcI0SKm2rNlwCX8Og8dE/cyzxlr8O9ArgdVzQwHms8+ksCubjmIL55Pk
         nITJZUxIuvtuneT/8G5hcTHkp8MHTELu/TfOL7Fidt4dkphb8b97tSaoXmNPS5XkfUa3
         dFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695937636; x=1696542436;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+Hw6GucHMsA6iPg0FIN18mc/wmn8+6t8J68Z4QdmUQ=;
        b=FwUnCzNx2BcrNDhbJvjoZOAZcpMs+bU3wuCv9V1mQJuRSVhyXPfh833rGOD+JDfHx+
         8X6Oi1FrcjI7XuKq8w0DWfq5Y241tsJHuGLxt7c2FsldfhZKcNqsdnaueh8aPCeuxPOG
         Hp9kEHaP5paEr6MPin2iWQehtoJx3dySf0uPcF+Gl1EMVdkoO5LFxsV1A/befAtlj30g
         IbIp0xwG8Whgetuvd0NW6qvgAKgcHvFaXa2puJrE9UUx8fapABVUFsMoeYh74lUHJAHd
         JIfXQGrt/StutYehN4Ab8wKvBwou1SFw7asuYTp/puqj2Q+mwap8+W9DUw7aBAOTjBiX
         qn7A==
X-Gm-Message-State: AOJu0YywCrTuELaMV92gCZ6zbMSAB2icW2ELzJlfM3uGjSBxf3+Wjw5N
        f3/KP83Q+yqi0acoztvpw22SyMyy0gnp6ClxIzUx
X-Google-Smtp-Source: AGHT+IFei0mDbm5s0pbRvyJ6hx3ZQzH/JI86HDzM8tx8MeQ+Le16YNY1NK7G573ESVfQXqKXAMkCnZT6nlpV4Z9WqkZJ
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:4882:f963:8bc4:1871])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ad50:0:b0:d0e:e780:81b3 with
 SMTP id l16-20020a25ad50000000b00d0ee78081b3mr32261ybe.2.1695937635895; Thu,
 28 Sep 2023 14:47:15 -0700 (PDT)
Date:   Thu, 28 Sep 2023 14:47:13 -0700
In-Reply-To: <CAP8UFD0FLsEV4y4W8Vkr5PP_7F4x-nLdHUVx5WRP8BuJnW869A@mail.gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928214713.3504919-1-jonathantanmy@google.com>
Subject: Re: [silly] loose, pack, and another thing?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:
> > The contents will be stored verbatim without compression and without
> > any object header (i.e., the usual "<type> <length>\0") and the file
> > could be "ln"ed (or "cow"ed if the underlying filesystem allows it)
> > to materialize it in the working tree if needed.
> >
> > "fsck" needs to be told about how to verify them.  Create the object
> > header in-core and hash that, followed by the contents of that file,
> > and make sure the result matches the <hex-object-name> part of the
> > filename, or something like that.
> 
> What happens when they are transferred? Should the remote unpack them
> into the same kind of verbatim object?

I think that the design space is vast and needs to be discussed, perhaps
independently of the local repo case (in which for a start, we could
just detect large blobs being added to the index and put them in our
new object store instead of loose/packed storage, and make sure that we
never repack them). Some concerns during fetch:

- Servers would probably want to serve the large blobs via CDN, so we
probably need something similar to packfile-uris. Would servers also
want to inline these blobs? (If not, we don't need to design this part.)

- Would servers be willing to zlib-compress large blobs (into packfile
format) if the client doesn't support verbatim objects?

And during push:

- Clients probably want to be able to inline large blobs when pushing.
Should it also be possible to specify the large blob via URI, and if
yes, how does the server tell the client what URIs are acceptable?
