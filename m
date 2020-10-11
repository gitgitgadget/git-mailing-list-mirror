Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27981C433E7
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 06:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA72C207FB
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 06:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgJKGe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 02:34:57 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:39247 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgJKGe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 02:34:56 -0400
Received: by mail-ej1-f67.google.com with SMTP id lw21so18836496ejb.6
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 23:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gk22aza004EAj01yViuQYyftyoODvNGFl+dHeMR0PIY=;
        b=hAimweBqdVtmI9aGUmQ2X69+lVdaXOP5qglmOw8LyZAtR9nkFLTSTG8IuAHkLRyoXX
         jRf07wIPA5wNRQWRawwogs/Ga7haFA8UFvMIX/QghtwrmAsQoOuqN5LU//2YnDMLX7PQ
         NTmDE1g2PSuKcr8hNMSG+Y6PQqlfQW92v7dCl8YgYm0pobdWQD5cuP1vxEDn3NqLa6vY
         7CPs9vdcafJ6dRQstM7/IUdilaM3sQgaNw3S2vTaJndx+slNxPWVu/DRDAiQ/QDnK25Z
         1JwcunOQiUBzWoma2LibuxpT6B8A1OcUmmnXpPl8vKDXOY2j+U6BLE6o9lsrZXcXjw2S
         WzUg==
X-Gm-Message-State: AOAM532LUpS7u0FaMxD4HNFkDb8kKoA52vkGhpkYvxB+A5/AEgcJ4A0Q
        ciA+kVLRGDzGlEOVRXqC9ZIt5fi9m1k06DvJYzc=
X-Google-Smtp-Source: ABdhPJwOQFtiY2zNCzhmbfWUKLsQX0nxdfg4sXfEL+4KgVUremIv8jZ9nXY6eARi5GBE9+IZgz22/CjO4Y/U5F0lIOE=
X-Received: by 2002:a17:906:358a:: with SMTP id o10mr23063518ejb.371.1602398093778;
 Sat, 10 Oct 2020 23:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
 <20201010185521.23032-1-rafaeloliveira.cs@gmail.com> <20201010185521.23032-2-rafaeloliveira.cs@gmail.com>
 <CAPig+cTq5tz8m0bCJ3GtCa9yzOMNvd7j4fSJNwO9xjqkfK+YOg@mail.gmail.com>
In-Reply-To: <CAPig+cTq5tz8m0bCJ3GtCa9yzOMNvd7j4fSJNwO9xjqkfK+YOg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 11 Oct 2020 02:34:42 -0400
Message-ID: <CAPig+cQENxQ7nWwMOdd_Tw=LU=+d_r7n9rqAbjbYyCC7av+gHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] worktree: teach `list` to annotate locked worktree
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 11, 2020 at 2:26 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Third, this is checking only that the first character following the
> path component is a hex digit but then accepts _anything_ before
> "locked". The regex can be tightened to allow only hex digits:
>
>     grep "/locked  *[0-9a-f][0-9a-f]* locked$" out &&
>     ! grep "/unlocked  *[0-9a-f][0-9a-f]* locked$" out

Nevermind this last point. I see that there is other gunk after the
hex string but before the `locked` annotation, so this suggestion
breaks the test. The other two points -- (1) mandatory whitespace
following the path component, and (2) anchoring the pattern -- would
be welcome.
