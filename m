Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF7CC4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 04:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiKWEAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 23:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiKWEAm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 23:00:42 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5A6E2229
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 20:00:42 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so783431pjs.5
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 20:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tv9ZwrGoTtWMsalZD06/8pS8FLeJUdilqWdFoWGEmqU=;
        b=GpVxmQ48Jafhbq6u43jVuIICIGWZsg3f9W74svP1Ybkg29JEwOJXhFwkvJ8S06CO5x
         8zYsskCHtjBiOI+mB2li4gevKyHNLcNNASClhcUaawCzX+I6fcL81KCn8onqWKbBIfyX
         2DA/h3z27Dn2V7ogPFhrIy57n8biQw4nnIL5vQLUAXisdZBfco3ZrBJIOIHire4gzx6E
         kpXnusuYzJjSjpQfU/tprkmRroKKOTt7QKgUSvghqjOQ+pyxPuLkUXZAP8D7wqEDXJld
         H/EJb/RC8Vjow3iBuQszJg1lYiYSIG/wraI6OPEiutENkn15Jbq2HzUiuKSICVhdTful
         sTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tv9ZwrGoTtWMsalZD06/8pS8FLeJUdilqWdFoWGEmqU=;
        b=oO33Arz1AAK4znRjxU1weES6fV442SxwsLylx1qRR0864ET0EXlYVntvjyfS271THs
         kEagGevMgRtvJog+slOvUqXFKXDID/urzsT/b6kuM+qe2V/jgmSj7M1vN61XbAoG2fPQ
         +EMbl9mcQYlq4mr/Pg3ZMI8IWDsIvsI3r5Gf/qKZ4N+AMSZ7wFEzuEiAUdUvYmT/3khm
         NeLXjb5ui0zs++wxX3WW8zQyZseTbE3nyc/5FegsJlY6sbbCyNExgPYGzCk5CCW+zekp
         Ncm38FO69yugWguLQ8Ip6Y6inAJKhjlb/v10L4+ueYYrer/E5q0bto3wia6EF6vWLiAo
         CUGg==
X-Gm-Message-State: ANoB5pmxwmg1G5iyUMfMKIndAkVFAvwZYcwuOnkkVDjNbrmnSXIouuXr
        4Ac7blQGhQ+P+lvn+rY6n4k=
X-Google-Smtp-Source: AA0mqf67dN/y5erkP48i2egPGgaJsP74t3HUFmLZj2PJJAj/rcP3Ke0rSrBRWMKQwS4QkXV6/BQclQ==
X-Received: by 2002:a17:90a:ad4c:b0:212:d3ec:632f with SMTP id w12-20020a17090aad4c00b00212d3ec632fmr7178387pjv.43.1669176041665;
        Tue, 22 Nov 2022 20:00:41 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902c60b00b00188b63f0773sm12614938plr.289.2022.11.22.20.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 20:00:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Glen Choo <chooglen@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 8/8] clone, submodule update: create and check out
 branches
References: <20221123013319.1597025-1-jonathantanmy@google.com>
Date:   Wed, 23 Nov 2022 13:00:40 +0900
In-Reply-To: <20221123013319.1597025-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 22 Nov 2022 17:33:19 -0800")
Message-ID: <xmqqbkoynwuv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> ... My
> concern is to avoid doing something in a patch set that we will later need to
> undo; I think that we are indeed avoiding it here (we're doing A but we will
> still need it in the future, so there is no undoing of A needed).
>
> So overall, after this discussion, this patch set looks good to me, except for
> the minor points that I have commented on in my previous emails.

Thanks for a summary.
