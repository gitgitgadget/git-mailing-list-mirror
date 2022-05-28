Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3681C433EF
	for <git@archiver.kernel.org>; Sat, 28 May 2022 15:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiE1Pz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 May 2022 11:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiE1Pz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 May 2022 11:55:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B21582B
        for <git@vger.kernel.org>; Sat, 28 May 2022 08:55:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n10so13743017ejk.5
        for <git@vger.kernel.org>; Sat, 28 May 2022 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=uoBJJZEZk6dphB2zJ/WhCOUu1vu3L6edo8OaZLKKpBY=;
        b=UarZMMWg9lnq30Yxuz1L91ygS0U59IYLkqsGgWfcUsJrzNdurffiw94gEzj+vuQswM
         KTy+k05pU9zXWwm5hngA0QNspQ3b365IOTKAm9UVVoDCuN2v/5zdmUbF3LYlOZyv7GeP
         ayGt2dHsDUU75OILHu2wzy6XgmVHsOl+xEgo9tQK3rozyxxWmDM7+yxNteQWP6MBkU1x
         za08OpRd1Qpl/c1mu9OVy+fsCKwqIAIrwZYMAlQNXzhS0cCupacQilkaDGgIk/EWILR8
         NUTKbNSCX+qP7Vkfn16DWGbdweG5tiRY7MLjuzyI6YD4JRHKjYzA3ox0+JVifI3625X/
         6CKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=uoBJJZEZk6dphB2zJ/WhCOUu1vu3L6edo8OaZLKKpBY=;
        b=AgX4Dmtb0KJcmiZnj+ESnzokj4lCM7fyPVhU2/f5pCMYdBhuXl4M5ihEcTYBHqVA7S
         6z+gwe/TDCYwBl7Q9dJF8iUgwR5MWrzt1HNmX4UUJrvV4BVZzzKj/XdfeLRPzYXkOYEC
         lbOyzXMVejOXLrnNsGLiU1s/2vZRfM5UWf/lyZoL7MX61wvwyFRrfCB+LqVdW4JlQeHR
         26bG6UMco+JqTRUgj8sxguRlt3jOFkKrtF5NOJhMyMXTlZXScH7oRavOlM4dStubOaQ7
         TlIUM2ekz2d4X0voOwM9i0rAAHoNVppggJP6to9E2nuxnAaIfawYvN9W6ptGn4oas7bI
         RibA==
X-Gm-Message-State: AOAM532LR75omDqjAZoiusVLAwSUEoTL/HKjojKbiH4ktZnwWKdD8TVY
        QI6PueCRL7aRexpUrJTfd3x6cPzoYOg=
X-Google-Smtp-Source: ABdhPJylkS1dj5i92e/cwaoX3gStFkoG5RESEt+xiS/1ZEGf6sEU4iC90A/fXI3yEqYM8+GRlY+LWw==
X-Received: by 2002:a17:906:b74a:b0:6fe:a118:8963 with SMTP id fx10-20020a170906b74a00b006fea1188963mr38586709ejb.537.1653753354698;
        Sat, 28 May 2022 08:55:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u8-20020a170906b10800b006fed787478asm2483617ejy.92.2022.05.28.08.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 08:55:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuynB-000Zy4-EA;
        Sat, 28 May 2022 17:55:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] hook: provide GIT_HOOK for all hooks
Date:   Sat, 28 May 2022 17:53:35 +0200
References: <pull.1271.git.git.1653684771998.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1271.git.git.1653684771998.gitgitgadget@gmail.com>
Message-ID: <220528.86bkvh3b3q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 27 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> In order to allow users to use one executable for multiple hooks,
> provide a GIT_HOOK variable that is set to the hook event that triggered
> it.

You can use one executable for multiple hooks already, I've written such
dispatchers that just look at the argv of the process.

What we will need something like this for is for the config-based hooks,
and I think it makes sense to have a facility that's portable across
both methods of hook invocations.

I really don't mind this change, and I think it's a good one to
make.

But the commit message & documentation here really should be updated to
reflect that this is currently superfluous to inspecting argv in the
hook process, and that we're providing this anyway for XYZ reason.
