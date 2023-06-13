Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA83BEB64D8
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 22:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjFMWml (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjFMWmj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 18:42:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762DFB5
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 15:42:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7359a3b78so42275e9.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 15:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686696157; x=1689288157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aq3sc31okM8ZnAln+lk1zotJ80TO8OmDPYGqgwrHe7g=;
        b=uhqQpHyw5MACnmrA+C7oNqHhyE0bcHq4XxRgVK3dVVeafxc83Q34ueZ5ZJle/J5tWW
         lNr5tOxT/RvkPPbxt8jGKTftyNz2zz4UTrckggwAbwlkS3lViU7U346GTzSxduhirOtZ
         o/qut6KhOqeFbP1vB6Nu7eIpH8EMtthVtkJ0t/iaG+aXkWIBskWtF0CiPO27qlj7hE8v
         7LNh+n6JN89UGP533hLAMk5jWvQ2VjuujtrsxJ9ubcd8ZQMRczLU2HRu4RmVvhi6NWQJ
         YiVYJd82N4Zytcdk5oi0IxvwcmV4nk26wIdVrUBfpwV72Qw4bVrO5vJxjmMTfR/FVA8p
         kS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686696157; x=1689288157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aq3sc31okM8ZnAln+lk1zotJ80TO8OmDPYGqgwrHe7g=;
        b=GBJg1PUBGwgs+zSURT0okUgruS2QjHrjgWCAyiTRcRHBgPQpp6R607o5sIPcGcs1EG
         dKX4QccrBRIWjPYOtFAr0aqirFGdfQp1itdhzYefx/IP5CFT85A5yXjIU9sZEamXxXkJ
         8aWAKvTQLNEkT3tNIyp9W/4va+0rNY5oXpvAxusYU8zBCaSmWztevASXrFq7hCMQIW3r
         jDBkUN9/Yi4Rpz4++kdnjRlHipqyzZflbWbArhwOYvuv7K/iLfGe8CDqZutNa2f8Ddxp
         HMfzq6/3Q9JYA31KMnRLRXlAhu+URQnNr5wbv1PVMiDXyvSUuvED4Z0kLxe3fH1e8k7Q
         gcmw==
X-Gm-Message-State: AC+VfDxANx3u7l5ajtNwuYMTkQcQPY+3xZB08oCKDMTErRRm9TJAmQn+
        au9ZKrhfeERC4LGLdD1A6aHf6a9jyyeGR+9lwUN2xXingYX1UBIsIwU=
X-Google-Smtp-Source: ACHHUZ42ZOdrvSCH78+Crmu+h31TbzH87XIhNs4GSNW4TIg/c/7UI8c0Pdrov92x55d47j+svP/q3+iHbH3+duXvDbg=
X-Received: by 2002:a05:600c:3b23:b0:3f7:e463:a0d6 with SMTP id
 m35-20020a05600c3b2300b003f7e463a0d6mr72193wms.0.1686696156779; Tue, 13 Jun
 2023 15:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230606170711.912972-1-calvinwan@google.com> <20230606171002.914075-5-calvinwan@google.com>
 <25d47081-2096-bb8a-dca3-bd5ea931c879@ramsayjones.plus.com>
 <CAFySSZBZVn=7gBB19_uNxeUwS9Y8Q6ZZiCT=AwfuBy4+d34piw@mail.gmail.com> <xmqq8rco9zkl.fsf@gitster.g>
In-Reply-To: <xmqq8rco9zkl.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 13 Jun 2023 15:42:25 -0700
Message-ID: <CAFySSZBf51JFAY5fYRsYvk2RkZ8rDmoQOHKrCte4ERkBeoiJWA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] common.h: move non-compat specific macros and functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Is there a particular problem here?
>
> Doesn't it defeat the notion that each header file is safe to
> include twice via "#ifndef FOO/#define FOO/#endif" safeguard and
> makes anybody who sees the recursive inclusion to think twice before
> they can convince themselves that it is OK for this particular pair?

In that case do you have any recommendations as to how I can make
clear that this recursive inclusion isn't problematic or refactor away
the recursive inclusion without having to change the header inclusions
of every other Git file?
