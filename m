Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1838C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871DF2311B
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404403AbhALQv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbhALQv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 11:51:26 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF4BC061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:50:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h16so3060807edt.7
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rh9RkHRYQ6CTuZbNfypFWp/UcC1XVgAUR3FsTQYnPRQ=;
        b=tML9aCbMZCWshsnNbkNroNLU7F9JY0wCBN1Rz1uNB5aOfnkC5II+EYPHRtYxktsdvW
         qHb3IFNuTW+W3vh2J/tVxL5+akfeIIlqK6G44LMnW5HwoAAxWhh7WnnHMXHsNilY8slM
         RSoWJaCgY7pGMl/i510vsL4bMgQhCgzVCKzgZrT1OoWiKCGkwMuogtipQhm5Ln0iSyAi
         gg48KNe+auBAr4EXuwBUemYtzhjCQgoTFCAReJsyPqESXrkYlb8JxfOPM3zZ6t48hWQB
         +FkQKI7goOKf/w9At/vup+/mlKHiWvF7PvvZgGfFynHfDQyyXmS/54Ia2xNz2Sg9XWKd
         mpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rh9RkHRYQ6CTuZbNfypFWp/UcC1XVgAUR3FsTQYnPRQ=;
        b=rR08gqRhdBjqqn7LefZZebYui+3Lkd2rU0ldCQRXYZXD4vykVwlv2xa26QOhjAI2Yp
         8Lsw6NRImWg/1frnIBzf2gnI+9IebNM1Q2R8hAe0d+flPPHIYoZSRrM46CXIzI3jlLcK
         6KNqrt1eDHQz/eBY56AxR5TyKt3y8Ykmu1R/hBTL3+iEuFi5gQlbCeevtGYsNs2zq3KR
         t+Gf356ZV4CRGQfmXrwbCZKGQL2k0zYAjxQhaqALsVkO+VL8Q18ctW+Ne/bEfk16Rezz
         5z61Sx/qoXMltaWPWK3Ta1AVs2HFwENMyxBPB7stIJggX3xRcF8dfsLldx0eczJA4vDl
         nDyg==
X-Gm-Message-State: AOAM531pSGOjul5rkt6X4WMYlZOx2sBV/QGfbFUAIAS5D5VPZXOsIUw8
        TJkXnTChhyUs5GXOToLvxsmu7EbWdmI=
X-Google-Smtp-Source: ABdhPJwgk9XdVH4vXnRjDR+K2oqgocRcW9DQtcqo3VVi6M3s7/dCOpzm9FoSOLMYfK1zXiY5F3NXng==
X-Received: by 2002:a05:6402:11d3:: with SMTP id j19mr47268edw.314.1610470244800;
        Tue, 12 Jan 2021 08:50:44 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id h16sm532852edw.34.2021.01.12.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:50:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 00/10] [RFC] Simple IPC Mechanism
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <pull.766.git.1610465492.gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 17:50:42 +0100
Message-ID: <87bldu5cbh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 12 2021, Jeff Hostetler via GitGitGadget wrote:

> This series introduces a multi-threaded IPC mechanism called "Simple IPC".
> This is a library-layer feature to make it easy to create very long running
> daemon/service applications and for unrelated Git commands to communicate
> with them. Communication uses pkt-line messaging over a Windows named pipe
> or Unix domain socket.
>
> On the server side, Simple IPC implements a (platform-specific) connection
> listener and worker thread-pool to accept and handle a series of client
> connections. The server functionality is completely hidden behind the
> ipc_server_run() and ipc_server_run_async() APIs. The daemon/service
> application only needs to define an application-specific callback to handle
> client requests.
>
> Note that Simple IPC is completely unrelated to the long running process
> feature (described in sub-process.h) where the lifetime of a "sub-process"
> child is bound to that of the invoking parent process and communication
> occurs over the child's stdin/stdout.
>
> Simple IPC will serve as a basis for a future builtin FSMonitor daemon
> feature.

I only skimmed this so far. In the past we had a git-read-cache--daemon
-> git-index-helper[1] -> watchman. The last iteration of that seems to
be the [3] re-roll from Ben Peart in 2017. I used/tested that for a
while and had some near-production use-cases of it.

How does this new series relate to that past work (if at all), and (not
having re-read the old threads) were there reasons those old patch
serieses weren't merged in that are addressed here, mitigated etc?

1. https://lore.kernel.org/git/1402406665-27988-1-git-send-email-pclouds@gmail.com/
2. https://lore.kernel.org/git/1457548582-28302-1-git-send-email-dturner@twopensource.com/
3. https://lore.kernel.org/git/20170518201333.13088-1-benpeart@microsoft.com/
4. https://lore.kernel.org/git/87bmhfwmqa.fsf@evledraar.gmail.com/
