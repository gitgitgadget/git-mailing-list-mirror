Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAA7C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 15:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E792078C
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 15:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgFHPUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:20:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42882 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgFHPUB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 11:20:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id p5so17812999wrw.9
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 08:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o44FQkfUSj0LZGGYwdF00PkrAgedCaY6nKGMNzII6jo=;
        b=QES6o+Ym8bVpDwUbLE6w0KHIs935iULg5/zg13UdPySit3E2c5r9IwkC8gEPzGYnHU
         qymhWjVKcroXa+49KJG/8UD5c/sc375Z2ulHKHPmstGQDXDkC58tBqZnTHepjMtNJHef
         tb1xftWN+KXLSifaSi+c6diwS6XfkhzwGJfFsRojbIpqkZoPYwPxB5j1uJ3hWMO2FyoP
         kkOtZN6FtrHk6YTzrZKDR3WCFsuh2vbYcMjqR+OhvMRnFoWKmEXNgythZp8ebXnAV9GU
         BSkyjHHtTYx90e7lDA7Kc07WQgedtZw3Ze2ca/rhp16Qew/wDRh4/xq3Vb+EIWtpka0r
         h99A==
X-Gm-Message-State: AOAM53075ut4PV5J73qp69XFcK8S0HSJ8RhvkA77hEFblHTOI6A4F5Zp
        r5TVF/0ug6m9H9+t5YotQoP2p6F2VDYGRrfUpm24Fdk4bdY=
X-Google-Smtp-Source: ABdhPJxsPKm8Xp8Rfs2BA6881HsrRko5H+rd0aLrNrF+HpU76z/JEdM1Luf0QenRYJ1+L6kfLlnu73jPG8U8HLF0eY8=
X-Received: by 2002:a5d:548c:: with SMTP id h12mr23842474wrv.120.1591629599360;
 Mon, 08 Jun 2020 08:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200608062356.40264-1-sunshine@sunshineco.com> <20200608062356.40264-9-sunshine@sunshineco.com>
In-Reply-To: <20200608062356.40264-9-sunshine@sunshineco.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 8 Jun 2020 11:19:48 -0400
Message-ID: <CAPig+cSzam0fTBrs=3MP6jieD4DBNCgx9kkrBm1+ahhmPWtrjA@mail.gmail.com>
Subject: Re: [PATCH 8/8] worktree: make "move" refuse to move atop missing
 registered worktree
To:     Git List <git@vger.kernel.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Jonathan_M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 8, 2020 at 2:25 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> "git worktree add" takes special care to avoid creating a new worktree
> at a location already registered to an existing worktree even if that
> worktree is missing (which can happen, for instance, if the worktree
> resides on removable media). "git worktree move", however, is not so
> careful when validating the destination location and will happily move
> the source worktree atop the location of a missing worktree. This leads
> to the anomalous situation of multiple worktrees being associated with
> the same path, which is expressively forbidden by design. For example:

s/expressively/expressly/
