Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E7C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 03:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B2561175
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 03:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhKJEC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 23:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhKJEC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 23:02:26 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A4BC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 19:59:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c8so4905300ede.13
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 19:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RD6DMZfXjHEJ/LJUBYg/X7wL3Ktge5Qyok3wukiP+YE=;
        b=eM1XlMayPZwgRyph4HU6b9Muj4LN9c125qFeanu0ZACC7ZGDlI5xwQbAWzUdu8Ezj+
         1cMA8QGM8H4Ryqq4TrJRWcyUt1Oib7JHTBt9yjFHsUIV7K9VTogutkEaMOKztW1S8QBH
         OoKJVTJcs9ZYcahzAGxIsO0Ngkz+R2D+V8Am5HS0YQ7PpPMdSPde0RIDHnPRT7uoeMde
         jpIhmcLXclV9Jm4eaavmYwt1JlXEyKZ7USO7GhGsAPQruvpEtKV7t2WI415LzwOdKJFJ
         ScFsL+vEZ7XHmlKIKOQ9K3Ev7fQNtCRRjkxGWy197/BzfkpicA+IK0h+qMkVWFApnYgN
         aqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RD6DMZfXjHEJ/LJUBYg/X7wL3Ktge5Qyok3wukiP+YE=;
        b=tR505Ik8ohid4tkrQ7nss2DSj12MK35z8CJldpVI1BngfxYHSWjW0kc3kImy/FinBi
         bE2NJ1m3Le2kGCDXAkILSa7TaW5aZvoRer55Myj9H8RNVxWQcEzP16r+g7B7UxEgt6WJ
         uA3LHsXqNDkYjb2hvCtfRPN4Yl4VUKAKeSeitqPC3mbteaRipQ8oCjULBXD7QwM99NiI
         00I/FlWh3XsuSZohYFyIzTYwSFfOrLdrR25euH/q6WLgyarkIuygaxPdZpGTiFtMBgaW
         mPlVT7KP+s5gVUEnppt2H02+FL+E8jalrmM9qAwYnDbgt2eIPDzJIKiwJRjRHYZ6vp2J
         w6Jg==
X-Gm-Message-State: AOAM530drtivm60Q466VNBgpqoKz78H6jzTWdAwFnVyaGPWEvaDX0tcr
        qE0276n2zD/HWX/svod0qHs=
X-Google-Smtp-Source: ABdhPJxXeA0KHnInjl4EvHpPmWvdwnSz+2PG6vCcxjXb/LqvGaG6emiZoqeo2b198kcJpf+YbCvzOw==
X-Received: by 2002:a17:907:c0c:: with SMTP id ga12mr17771645ejc.417.1636516777998;
        Tue, 09 Nov 2021 19:59:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id da7sm3722557edb.82.2021.11.09.19.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 19:59:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkels-000nLE-Qj;
        Wed, 10 Nov 2021 04:59:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v5 2/4] receive-pack: Clean dead code from
 update_worktree()
Date:   Wed, 10 Nov 2021 04:57:40 +0100
References: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu>
 <20211109230941.2518143-1-andersk@mit.edu>
 <20211109230941.2518143-2-andersk@mit.edu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211109230941.2518143-2-andersk@mit.edu>
Message-ID: <211110.86y25wirtj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 09 2021, Anders Kaseorg wrote:

> +	if (!worktree || !worktree->path)
> +		BUG("worktree->path must be non-NULL");

Perhaps a metter of taste, but I think BUG() should really be used for
things that need a custom message over and beyond what assert() gives
us.

In this case using BUG() gives you a worse message, if you do:

    assert(worktree && worktree->path)

You'll get a sensible message from any modern compiler quotign the
variable etc, all of which says the same thing as that BUG() message,
just with less verbosity.
