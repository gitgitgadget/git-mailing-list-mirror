Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C56CC433E0
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 22:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6512207A5
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 22:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbhABWKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 17:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbhABWKF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 17:10:05 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F95C061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 14:09:25 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id a109so22673119otc.1
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 14:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=DJK6zSXkPyDw86KxIhd+mtT9blNdcY4EuZrGAuA9iwc=;
        b=LOOZhDG0Xm2RKULg35sh0UXTaZOFY+aO2lFxZLk0M2Qw3P0P7Em4H+NYKtXkDZZv1d
         Roto4YldSwCVjjyAE0vDNrJRKnbm4cOx+SigcFJX/nkEPCs4UyKbzTAaZdTBSOsGefGP
         bcIbbrJr6UueYaq9qEzGUN8tDN5J25FoGVt9Ekperzk4Jrm3tQS/KgPWS/yhJCgsq9yZ
         hjEN9m1mxACJPuifTVnUOXOCfzkFLegAgVwLLpPjdN5i0a868m57SbTIA7YsYj58Viwq
         p7xX9QlYyFMnRJk7u9Y4Q9i706cfQrzzQqKZx8QTYpJnhjhM884+p3CvrR2UUr0EoRel
         Xwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=DJK6zSXkPyDw86KxIhd+mtT9blNdcY4EuZrGAuA9iwc=;
        b=QRS+5gMnixkolJZ8yY4gLRNFzNbUrUoAi4aEYZGoxhw7feNqLIo3Wl3w0BdQx2pq2H
         IPbeZBQfKolB2JPSpnlr7xmPWALKBfaj/1XLa0jlaHHp9WPSyCjv6w2TFr6bLsWsv6Hq
         QnOMpkKfJOocXi+sec6AX8sts4XdeHtEoiSZcKtJR3EZ+TQ7B7Ey0NQ27ghxPU1WTGdB
         QgKGwhMUnKYV7JffmaCtkIIW0m9zhzxJJDnhNq4t32kTUjrzGj+WzHQgLrFmbCOPcEnd
         P6pyPgduqj+feoYl5q9wcXKaFLTu6Qj0SmPlmzfaJn4cWiJGkuCNrKZ/8iGLL6VwjvYx
         hDzw==
X-Gm-Message-State: AOAM530XcVmWOo16okusN5FcEuFvhPKFUBBtroXuQYiqVz7Ju3gUgfCe
        SZJV6OUbCIcs/8+MWye6sbc=
X-Google-Smtp-Source: ABdhPJy0L8/AN8cqWmYnS+1KxsU3XaViv/2Ii7WgfYo3iCeDMO/OIjL6csdYFZ3uCUUStBR6AULIXA==
X-Received: by 2002:a05:6830:403a:: with SMTP id i26mr47645857ots.111.1609625364801;
        Sat, 02 Jan 2021 14:09:24 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id w129sm8269199oig.23.2021.01.02.14.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 14:09:24 -0800 (PST)
Date:   Sat, 02 Jan 2021 16:09:23 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Gustaf Hendeby <hendeby@isy.liu.se>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <5ff0ef1332a66_a76d2086d@natae.notmuch>
In-Reply-To: <CAN0heSqC3K6pJOr2ztz56+ZpKaMomA28rc4W5x8n0cC3K-rVgQ@mail.gmail.com>
References: <pull.942.git.git.1609616245412.gitgitgadget@gmail.com>
 <CAN0heSqC3K6pJOr2ztz56+ZpKaMomA28rc4W5x8n0cC3K-rVgQ@mail.gmail.com>
Subject: Re: [PATCH] gitmodules.txt: fix 'GIT_WORK_TREE' variable name
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> On Sat, 2 Jan 2021 at 20:39, Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Philippe Blain <levraiphilippeblain@gmail.com>
> >
> > 'gitmodules.txt' is a guide about the '.gitmodules' file that describ=
es
> > submodules properties, and that file must exist at the root of the
> > repository. This was clarified in e5b5c1d2cf (Document clarification:=

> > gitmodules, gitattributes, 2008-08-31).
> >
> > However, that commit mistakenly uses the non-existing environment
> > variable 'GIT_WORK_DIR' to refer to the root of the repository.
> =

> Good catch! I wonder what we should conclude from this having gone
> unreported for so long.

That perhaps not that many people actually read the official
documentation?

I've noticed the common response RTFM is not that common anymore. A lot
of people seem to rely on Stack Overflow, blogs, and some semi-official
documentation (GitHub, Atlassian, etc.).

Cheers.

-- =

Felipe Contreras=
