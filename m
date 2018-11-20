Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A09E1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 16:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeKUDHq (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 22:07:46 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36474 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeKUDHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 22:07:46 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so4512267itj.1
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysT5R2egfi7b5E/EdSSKjqvmK0bNzoYyJhcXDht0keQ=;
        b=ZqyCG7ZmCyl+wUeplWLqZZGlzv72fCw1sgsDK+F0YHepx/KbVTnZPocC5WQgUEyofR
         VrJ20gdsrErXk9neGsurqKhbsyZSsduF6YaOEs0sURScaAEPnEv/Q2qxxfMO9+OarNvA
         BQwQR1zUnZYhz9U+5FYm6lmGNIbdhXhVGK2UeCUlj6OmtVUEkKlwSdCQWD2iBJDFOgu8
         0H4A0yYdbBS48pqLFFPbKY4bXQ1t6n5cu6732RQ71GkJjf8soJRCQlBymBQ+9GZBhjdY
         l7IU7aHOdenFwu62exACJiztw6yJJVG6d1vmJaHLy0M5Gz5k2CPI6NdO4+MKo7FzMkh1
         6LEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysT5R2egfi7b5E/EdSSKjqvmK0bNzoYyJhcXDht0keQ=;
        b=EjuFdx+QzNfXK7FCGdaXbw5mmi4xOO1xHFip7hwczeJxdpR4qz0MCyMjRi/QuVKDm4
         PQb/bsMggAKDVgQlPC1MZd91TOh0gQN9Ttteo5BK+bQpSe6NIcOPYIoqVEqtEuecLb67
         9DeyHXWy16V1j3zvwPvdLLlAZOUEK7MVQZ5ydFzK7nouhcZfXUIfTjbomfhIMoEGU6Ud
         gdWD6ItGAy+Yv9mxso1R+21Bl5W/75qF2qhCdYsmucsyP/WfiA52rdS1uGZSJLThVTj8
         NdvDUTCmqPJbzp/sPzmlEss8Ai52SJ7Yrf111GMGUgGmElys+a4xmGRbm7GKfW6vkUw3
         pcXw==
X-Gm-Message-State: AGRZ1gKsd//W6ZTNLzPp70l/6SyyAG3S0OBNZPfsUaLFvFnbQAjLzMnR
        zoqPDIpJrFYRvQPslXPz55WEsc61+qTGDgTKAV4=
X-Google-Smtp-Source: AJdET5dK40d92Z2MwDaiR5O6ywNv+gzf1ly0M+vuvOehEIfoFTFLnqfOjRuMb+LaJbx+KSlX7TsjPZ19bpvSlCDqfEs=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr2748387itk.70.1542731864427;
 Tue, 20 Nov 2018 08:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20181120094451.GA21725@sigill.intra.peff.net> <20181120094638.GA22742@sigill.intra.peff.net>
In-Reply-To: <20181120094638.GA22742@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 20 Nov 2018 17:37:18 +0100
Message-ID: <CACsJy8AETNxNnEq-8ROrQTkjy-_9mtoprmc=BQ554f7QECajPw@mail.gmail.com>
Subject: Re: [PATCH 1/3] pack-objects: fix tree_depth and layer invariants
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 11:04 AM Jeff King <peff@peff.net> wrote:
>
> Commit 108f530385 (pack-objects: move tree_depth into 'struct
> packing_data', 2018-08-16) dynamically manages a tree_depth array in
> packing_data that maintains one of these invariants:
>
>   1. tree_depth is NULL (i.e., the requested options don't require us to
>      track tree depths)
>
>   2. tree_depth is non-NULL and has as many entries as the "objects"
>      array
>
> We maintain (2) by:
>
>   a. When the objects array grows, grow tree_depth to the same size
>      (unless it's NULL, in which case we can leave it).
>
>   b. When a caller asks to set a depth via oe_set_tree_depth(), if
>      tree_depth is NULL we allocate it.
>
> But in (b), we use the number of stored objects, _not_ the allocated
> size of the objects array. So we can run into a situation like this:
>
>   1. packlist_alloc() needs to store the Nth object, so it grows the
>      objects array to M, where M > N.
>
>   2. oe_set_tree_depth() wants to store a depth, so it allocates an
>      array of length N. Now we've violated our invariant.
>
>   3. packlist_alloc() needs to store the N+1th object. But it _doesn't_
>      grow the objects array, since N <= M still holds. We try to assign
>      to tree_depth[N+1], which is out of bounds.

Do you think if this splitting data to packing_data is too fragile
that we should just scrape the whole thing and move all data back to
object_entry[]? We would use more memory of course but higher memory
usage is still better than more bugs (if these are likely to show up
again).
-- 
Duy
