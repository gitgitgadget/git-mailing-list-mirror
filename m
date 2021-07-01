Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA4FC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEF361410
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhGAWzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhGAWzS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 18:55:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAA2C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 15:52:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x12so10660190eds.5
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 15:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rMVDzHg80kgB1AAiy0By4BLRwd3CAXB+2QLIlWi7EVo=;
        b=ScNRd45Sut/XRnyW/XDf06vjRCZFsvxlMKy1fnBkdzt/yLHY9aw1ArSJfc0pOUflXW
         xCE80xZ2KWzqnXaC66Yft9Pr/tN/VyM8b/yoGB71SotS5yfs4/Bdf3yjPdmfH9nn0s1h
         IaPRHzIGaXGSl75n7fHLPbevjJKakSBJExpT0FwK/swnCqQQz4ZgFeTz9g8Zc7Nx5TSh
         s3AtHQWE+P2mpVoy5N3w+sdzSBhd9Kjy3xqO212f+E8TSmGYKlo5iE0CJ1bc7s3RPkkN
         Xgtn6MueZxZETERuBEEaDbECM0gyHgaxuipp/i5kpfLjVtBWfO7R6lm7Mke/bWLxVi8P
         0a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rMVDzHg80kgB1AAiy0By4BLRwd3CAXB+2QLIlWi7EVo=;
        b=XBfQVNM6l2ym5o9gvfhLibcYQPnForxq+ykyMk5iLoA2AMSLH0PoapQFG+SwnbEe5n
         EXQ7Z0ESEvg7PuaBUpjJ+wajeEhLPYITS3yq0UiIp+S+MYqJ0jhG/hGVZGw8nMdjWBTI
         LB75WgkdQWXuVs8YVlGQZyn+1xI7QOUwaEJZlLXVAPhyEs2DvUojYB5ZnrIip8DdEK4M
         XnGOBriL/MEGyDpBoCbJvw8f+St6oovwNIgrxv8gJ5+OYdAQbEk1ODX3tSBXz//ehIhs
         WAfbKMrMgHfQ49zHUF8eU1xFTFCZpTAxvbns6CMknHjSNfOEL0sK9SF3SuscEplg3llp
         FGqw==
X-Gm-Message-State: AOAM533Tuu5p1diadGWNkl8auWTnSGnOlqe+e43dSrSN+mpEzWYMtmim
        fSCeYl6bQDwKZqL/aSEWaYS0ykEjlwFWtg==
X-Google-Smtp-Source: ABdhPJwxdxrsx41fS2M+zAZDVK4K9X3T1OEhdOx/gZCZ5Co8ykPZMUWVbNUGx8bJsS1edN6voqgodg==
X-Received: by 2002:a05:6402:1d11:: with SMTP id dg17mr2908689edb.30.1625179965811;
        Thu, 01 Jul 2021 15:52:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n13sm383319ejk.97.2021.07.01.15.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 15:52:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 12/34] fsmonitor-fs-listen-macos: stub in backend for
 MacOS
Date:   Fri, 02 Jul 2021 00:49:26 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <587580489473a7a2ad665bdf3c482ea5d2c54f61.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <587580489473a7a2ad665bdf3c482ea5d2c54f61.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <87sg0xbq9v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Stub in empty implementation of fsmonitor--daemon
> backend for MacOS.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  compat/fsmonitor/fsmonitor-fs-listen-macos.c | 20 ++++++++++++++++++++
>  config.mak.uname                             |  2 ++
>  contrib/buildsystems/CMakeLists.txt          |  3 +++
>  3 files changed, 25 insertions(+)
>  create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-macos.c
>
> diff --git a/compat/fsmonitor/fsmonitor-fs-listen-macos.c b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
> new file mode 100644
> index 00000000000..b91058d1c4f
> --- /dev/null
> +++ b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
> @@ -0,0 +1,20 @@
> +#include "cache.h"
> +#include "fsmonitor.h"
> +#include "fsmonitor-fs-listen.h"
> +
> +int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
> +{
> +	return -1;
> +}
> +
> +void fsmonitor_fs_listen__dtor(struct fsmonitor_daemon_state *state)
> +{
> +}
> +
> +void fsmonitor_fs_listen__stop_async(struct fsmonitor_daemon_state *state)
> +{
> +}
> +
> +void fsmonitor_fs_listen__loop(struct fsmonitor_daemon_state *state)
> +{
> +}
> diff --git a/config.mak.uname b/config.mak.uname
> index fcd88b60b14..394355463e1 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -147,6 +147,8 @@ ifeq ($(uname_S),Darwin)
>  			MSGFMT = /usr/local/opt/gettext/bin/msgfmt
>  		endif
>  	endif
> +	FSMONITOR_DAEMON_BACKEND = macos

A rather trivial point, but can't we pick one of "macos" or "darwin"
(I'd think going with the existing uname is better) and name the file
after the uname (or lower-case thereof)?

Makes these make rules more consistent too, we could just set this to
"YesPlease" here, and then lower case the uname for the file
compilation/include.
