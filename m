Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B726AC6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 21:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCLVcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 17:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCLVcl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 17:32:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EB02FCEC
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:32:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so11594494pjn.1
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678656759;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kx5NzMa47m4evL2p51DZ0oEfH9ifSycMFz85/PV3Ofw=;
        b=egWaOiU9/sdEk05/1Z0Px4G/2HywESb3Va6QlxvH4uchYlKt/WM6I61mT9u5aStkDx
         oXJMcOAsfa98nx91EsGa0vJWGAh9CaH/XyxNADWqBaLpUsvS195hjvd4uHM1Fn85sFAx
         EQ45gcZqV+ozAaDaIIx8iZdyxDjy/41E81ziZ0LLDX1ZRr5/eGRXKqGjbXbDdnJwGNhm
         qEWhUeVMXv+yOXd/RgCHT/UPRYznN0SvytXOELVOYY8rIKJ/jozlBNsK5fYD6mC4c8eQ
         c69sliwa2OckwHv6bX/jdknA5awMoP6sBM9zLMp7XENsaviE/sm5Inr7UE+pTiEvSW4V
         jV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678656759;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kx5NzMa47m4evL2p51DZ0oEfH9ifSycMFz85/PV3Ofw=;
        b=HUhcF7okzfhzVQhUMqyiG2iDI8K50HZtrzGGiYJDwPbQ/rBEb9JNGoHyvUUbWNYQYz
         /SRZhJa/b6SGMsPFlB1cav/DJGOu5OWB6N8Eq4zE5FQnAd+Yp29wBr6B+iNYXdTgIOdw
         QTTYDyIIZajeaKjbRZRmCZGXWxCm4mBHi6vVCS3yzUAHDFXfRexW4RC29m4qTkNN38zO
         8Sk8kVuA/Fm2dsDD4dJl2to+wbkVC9McPLdrHKegDZhDyIwvAnGPeXgfpkRVbqwaeqPd
         outeqFc8ReCSrf303XcUCMrJt7LRzT7krpHdE84g/zBgX4IiRZLGQTPapyhp/Nf/kH/V
         UQHA==
X-Gm-Message-State: AO0yUKXTOTMBaqBOb3h/n1giNqjI+p5FiTxA03wiS26Ui/UwL2DT1kgG
        00U4Xon6p4KtbsmOCRGHAEA=
X-Google-Smtp-Source: AK7set/Pfz8Uc6VqO3oUTutq6EppssrwcbqQNToB2auNynuS1S6DHg+DQnu1+vS3c2//mcL9Kb1Svg==
X-Received: by 2002:a05:6a20:4415:b0:cc:4118:75f4 with SMTP id ce21-20020a056a20441500b000cc411875f4mr9025940pzb.0.1678656758766;
        Sun, 12 Mar 2023 14:32:38 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id r14-20020a62e40e000000b005a8de0f4c76sm3206318pfh.17.2023.03.12.14.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 14:32:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hugo Sales via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hugo Sales <hugo@hsal.es>
Subject: Re: [PATCH] Add `restore.defaultLocation` option
References: <pull.1467.git.git.1678578153640.gitgitgadget@gmail.com>
Date:   Sun, 12 Mar 2023 14:32:38 -0700
In-Reply-To: <pull.1467.git.git.1678578153640.gitgitgadget@gmail.com> (Hugo
        Sales via GitGitGadget's message of "Sat, 11 Mar 2023 23:42:33 +0000")
Message-ID: <xmqqfsa9y7t5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hugo Sales via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Hugo Sales <hugo@hsal.es>
>
> This options allows control over which of `--worktree` or `--staged` is
> applied when `git restore` is invoked with neither

We do not want to do this.  Tutorials and documents will be written
assuming the official default, and those users who set it to use a
different default, only because they are told to use it before they
know better, would waste a lot of time wondering why the procedures
they read from tutorials and documents would not work for them.
Even an expert who is asked to help a novice, who has this variable
set, would end up getting confused becaue "git restore" without the
explict options does not work as they expect.

Individual users are welcome to use "[alias] ri = restore --staged"
and this will hurt nobody.
