Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E45C46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 23:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjASX6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjASX6n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 18:58:43 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B95A19B9
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 15:58:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 12so1104234plo.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 15:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Mm+selwD2zSmMEI4NVLHkr6pgOd+mimqKzelm+kJcI=;
        b=CNasxzxY3ZpPfg94WXg4/F8UYCAqnYLgqCeXFxbFyG58l+z4lwUYYU6ko2f/IY5uJI
         FTPm7kcbdMuslnYnTKJIZ25c6XvRQgbfIL+H1szRzvGvLUxoYB1suo3Qbg0f3IpZ/d46
         fk6TPUAw7xmHL8HxyR8mrpZmi8XKb0wdQEPaOSwQ0ocjYQQK+AxYsO/BAMFOFfqHncPt
         j6pBzwjfaFTYbiFtV7dAk1Ua2DbTulw4/fYSBhsdZYPCjSdapY9rJqY/FkNfnGV1u1mk
         jH3VpzM2HetCQM194iibOrVv1Sfr73w9MzUVGx3KqfAGBP/LBW5InBJb6WpSqNTTleOq
         BWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Mm+selwD2zSmMEI4NVLHkr6pgOd+mimqKzelm+kJcI=;
        b=lavamM7Mjtm6MaSkzJ8DAuqa4eP7bo6YIvbyyKNQ7ai0tHBpbJJd5UAh+fENAD1fhl
         0ta15QpdfgxNLTxB2lMbHfCIlxIJBWsOEWNMTsRk7TyaSt1uF+5+5/whUmHTf2apq2OG
         5NpfY6ewUdMSCHv89KOfJzTQEV+um931zLTAWI++U2+idm3+KZEXVnZZqX003zycv5l9
         uF0xgNU3qO5ZOuxinUFzZLuMbH130FrUZxGIuEuQbcQTDZaHoVvDodyPrz3mHzqzdhq0
         u05fY5sfIkCMc0jiBHPe6FBGShAGd8lOo70/Rg6Xl3799bGCBQ8oypVc/Tu3md/EcUrw
         lk5g==
X-Gm-Message-State: AFqh2kqlOXAJRGr1EXZaqciMcNvr8K9429HQ/o4RrCOYfqZU7owFBnYT
        FNKAmzuEdFwXZ7/ksvAtq8aiBDXb9R4=
X-Google-Smtp-Source: AMrXdXshMVXj3pe0h6jgDR18xpqEVEwyV5S56fyKiPsVTNKzuRNpbRJfvNXHV6rv7xlNjsSn6DEbxg==
X-Received: by 2002:a17:90a:950c:b0:228:d353:9612 with SMTP id t12-20020a17090a950c00b00228d3539612mr13268564pjo.31.1674172714025;
        Thu, 19 Jan 2023 15:58:34 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a65c800b002294615bf59sm220676pjs.18.2023.01.19.15.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 7/6] fsck: do not assume NUL-termination of buffers
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
        <Y8ifa7hyqxSbL92U@coredump.intra.peff.net>
        <Y8nOmZHv7T843uBn@coredump.intra.peff.net>
Date:   Thu, 19 Jan 2023 15:58:33 -0800
In-Reply-To: <Y8nOmZHv7T843uBn@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 19 Jan 2023 18:13:29 -0500")
Message-ID: <xmqq358613h2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So here's the result of my digging on this. The good news is that this
> one commit on top of the rest of the series should make everything safe.
> I'm sorry the explanation is a bit long, but I wanted to capture a bit
> of the history, the subtle assumptions, and how I approached analyzing
> and fixing it.
>
> There are a few paths forward here:
>
>   - apply this on top of the earlier 6 patches. This is the simplest
>     thing, and my preference. It does mean that t3800 temporarily has a
>     read-one-char-past-buffer bug that is detected by ASan after patch 6
>     but before this patch is applied.

That sounds reasonable, even though purist among us may find it
slightly disturbing that it breaks "bisectability".

> Anyway, here's the patch. I'm happy to repost the whole 7-patch series,
> too, but since the earlier ones didn't change in my preferred path
> forward, this seemed easier for now. ;)

Thanks.  Will queue.

