Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A247120248
	for <e@80x24.org>; Tue,  9 Apr 2019 15:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDIPOo (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 11:14:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55425 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfDIPOo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 11:14:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so3992886wmf.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y5O9ZfZIjW+fsT9MFummQ2xS5Y4rTDVon7y4ARg7pXQ=;
        b=di5pYPjLOSWuhsyxNiaz/AA+AAzpk1I/JPziWAIWenLvl00JGpvjMuDXn897W1BMtY
         HJFJm1jmsqI2orzkhhU20da5v364Tv88Vy1TMmiq/57hYh6sztBDX5/bRis1P3IY64d7
         5aTSvXiOs+mMMiEC1f+MMHdvdfh/bX2vmJn5e15QEy7bJUruwa3RgYDmgui+VyWQYEi8
         nCA1RjYBccpB/0VfyKpOyhWg+mbTSIlaOQZj8du2lnSsXkUsd7/g3VvSUSpxovPvC9hm
         Mj4UrFcDJquZr96ZmlfH7PoO+K7MmrW+l5dN3YupMGwBF4QPGkwxQ2k4OaiZR1Ai8z8j
         93NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y5O9ZfZIjW+fsT9MFummQ2xS5Y4rTDVon7y4ARg7pXQ=;
        b=mklCTSHlrMFrjxD/Y5aVNDf/yBsgA3t7IWKvEA6/Gl31AM804zTV3578zoQ/zUeN+H
         bOqPvU3rk8oCgAfXaRoalDn2quaS8p4gaWcundQ2qrWk4vrET4j+RN8sHlj3O6nonm4a
         OGN0XkGpppgjfeKdnE6zghGuwo+NVxXrS97KRemdvtjfgwLnF/5sO8Wfit8jwp2ZqNkG
         nVuj1RR3jB0lcmHsUpfu5PjbzOTHTq+tngTIRS5iU2yJAaqqflf9Kj/SeDQGPXeygUbr
         8aSNdleOQvnUXtGs53MvpwWvjpjxhDzA91O+c80xgB08vi0e4wDMGyOxLiH9qShLMlql
         5nlQ==
X-Gm-Message-State: APjAAAV4fE2NiO9DlEbNAieyGFrU2kJfD7gFRvqjRvfHdE6QWAVzHEQI
        0qTuAABXTkotuaui6ZXY1lQ=
X-Google-Smtp-Source: APXvYqwufXmqBH0yo2XDeqR8Ayozr5/vlD/ZiHog/XwNGOCN6oXEqZHJwIMPNx8NbLOWpQV6fDlSzg==
X-Received: by 2002:a1c:cf83:: with SMTP id f125mr21705524wmg.96.1554822882312;
        Tue, 09 Apr 2019 08:14:42 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t81sm29340947wmb.5.2019.04.09.08.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 08:14:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3] rev-list: exclude promisor objects at walk time
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
        <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
Date:   Wed, 10 Apr 2019 00:14:41 +0900
In-Reply-To: <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 8 Apr 2019 14:06:04 -0700")
Message-ID: <xmqqo95f43dq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> For large repositories, enumerating the list of all promisor objects (in
> order to exclude them from a rev-list walk) can take a significant
> amount of time).
>
> When --exclude-promisor-objects is passed to rev-list, don't enumerate
> the promisor objects. Instead, filter them (and any children objects)
> during the actual graph walk.
>
> Remove the mark_uninteresting() function as it's not used anywhere else.
>
> When testing against a large repo [1], this patch reduces the
> connectivity check runtime from 3 minutes to ~7 seconds.
>
> [1]: https://android.googlesource.com/platform/frameworks/base/
>
> Helped-By: Jonathan Tan <jonathantanmy@google.com>
> Helped-By: Jeff King <peff@peff.net>
> Helped-By: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>

I've dealt with the stray double-sign-off locally, but is there
anything else planned for v4 or later?  Is this performance-only
change, or does it have an externally observable behaviour change
that we can easily add to our test suite?

>  list-objects.c | 20 ++++++++++++++++++++
>  revision.c     | 16 ----------------
>  2 files changed, 20 insertions(+), 16 deletions(-)

