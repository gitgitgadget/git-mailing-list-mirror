Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720E0C77B73
	for <git@archiver.kernel.org>; Wed, 24 May 2023 10:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjEXK0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 06:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjEXKZp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 06:25:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB95C0
        for <git@vger.kernel.org>; Wed, 24 May 2023 03:25:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso534032b3a.3
        for <git@vger.kernel.org>; Wed, 24 May 2023 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684923943; x=1687515943;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=usC7n8hpGsc+PwYHHa0y1C0548uiY8y3jNigoC6y8Rk=;
        b=U6BrKTvN58mmQQeazRg4RVlav8Lqn+WQfQSa+cua4lDzy+JzdyY2FKKTVJHrAFtBmw
         IA8w8BZc++xECFMPQMpJJDtMaUj+yWRtw0rL2TFeb1omKrSlqetlPT42NnUX9yvA9LUh
         V1lmO/RYr/FKB/o/6XJI7yq/+6nLRoZ829wxq2tsHumgDG8+QwdrHB0aMups4PGfg7rf
         NnuEIRMh4F6xxYzlBrfEW2jMSkaA+aJjQxX82OD4BicoJvHXNKV7h2bQlB6EpjVH6zb+
         cR+/b5VYx3xefPGEa8Y2aWCh8FzP5ZWvRYD8+XG9+imNroKOn9VdrLPBZ3ToWE0vS+t/
         ik2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684923943; x=1687515943;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usC7n8hpGsc+PwYHHa0y1C0548uiY8y3jNigoC6y8Rk=;
        b=CbMPe02UWtqCGNY/zNSRRLgR+1+/b6OZgKednv57tiX0/1W3IOs7Pg/ZVhgXKQdaXI
         oObvldssyvOfBi9jg5LjtAP5mXUHybnleDe8E7hTPThlh8mT3t6JWd/JL+OiwfNv4DPs
         8fl9g5fwA+XoX15syc6rWkfxAynruSoYpwG/SPdg1n8bQdm5xUyZW74qRGYUkyNB0tkC
         dvQqER+qgDQAtxTiVCAfy0/TkXnY8M5XV4JxVKuljsXH5XQ3aVmueqiZZyt2ZCHJJ7GW
         L+KtkPy2DWvxSYmR3dFODj2SGcY4hKKpF6ljt/fFYqndaVs5lLWb5tGGb+uKqr+bGHrc
         5ePw==
X-Gm-Message-State: AC+VfDw2HbXS/cp/1VCQSIOmuPWsB0iYC6dZUvX82hj1Uh6wFcTlPa2i
        7G0DsTyiEuyCuOvxLN7oK/g=
X-Google-Smtp-Source: ACHHUZ5w7DKxLCwOByiwdPDQoQ9DNc74TbmB6nZ8MRI2mv5B0j6Auv9aYBOS16S459aPj22s0xTYfg==
X-Received: by 2002:a05:6a20:6a1e:b0:103:b448:ddd8 with SMTP id p30-20020a056a206a1e00b00103b448ddd8mr20408311pzk.58.1684923943404;
        Wed, 24 May 2023 03:25:43 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id f14-20020a63554e000000b0050927cb606asm7210584pgm.13.2023.05.24.03.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 03:25:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, chooglen@google.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/2] Fix behavior of worktree config in submodules
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
Date:   Wed, 24 May 2023 19:25:42 +0900
Message-ID: <xmqq4jo2gh5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> About a year ago, discussion on the sparse index integration of 'git grep'
> surfaced larger incompatibilities between sparse-checkout and submodules
> [1]. This series fixes one of the underlying issues to that incompatibility,
> which is that the worktree config of the submodule (where
> 'core.sparseCheckout', 'core.sparseCheckoutCone', and 'index.sparse' are
> set) is not used when operating on the submodule from its super project
> (e.g., in a command with '--recurse-submodules').

OK.  So in short, worktreeConfig used to be a singleton, global for
the entire git process, but because "git grep" (and possibly others)
wants to operate across repository boundary when recursing into
submodules, the repository_format_worktree_config needs to be per
repository instance, not a global singleton.

Makes sense.
