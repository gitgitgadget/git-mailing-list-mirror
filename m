Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C897EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 21:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbjFNV4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 17:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbjFNV4N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 17:56:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE14268C
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:56:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b3db8f3d94so21466505ad.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686779772; x=1689371772;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dC1nFRlla082P4TqRIh0A/AMAI+VgKkbG2DZcyWF5Og=;
        b=Clavv0kUm+vor0ZYrhWSNVPfQrkAdoibrhZvFBzvca/bkK5QFUqQ0ySoZ+CyYy82P/
         HJ2dDky2QT0n0rP//T4tWS4I5EnM/Dvp/aSU4nuCKympPd/aIAppdoH/F2ept+JYKy8g
         kIqggjX1QBEJyIFWpLLYUfGoKu6Pjq9vDN21Ocef4V/C+8kKk6gCXpfzkZywmU4v4EuH
         MPbySD140hYe1+zY9N0Zxa+MjH1jhUWuXuPlH6eMIazIVt7weTACdD2KLD8WyHmSjX9L
         LIY6D4AMxj5wf7G/zrwVxaVmPGF8uvJlIA7jLp684c+x/DBHmP9SMmqHL1IuAg3WHBb/
         9Mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686779772; x=1689371772;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dC1nFRlla082P4TqRIh0A/AMAI+VgKkbG2DZcyWF5Og=;
        b=g/X0tG0Gt+VZKDNF5AUP/gSnBP8aS6mVzqVi3Vxh8tyHD2DLLIDZtBeKaPBzizlmST
         clQ4hbWuuOqlP3i7QBSxp4c9jHm5swipEUIPeVPvPDVJDwzVC+oNZuACcXDiWHGC9eKe
         U4/cjryH78kT8y/BDjMfJv4AJHlMlyJCrclZM7pVGtzYqn+++yleWL7B62hL7pVwsUMK
         h7aVKVIqWJM7urxiHlb3dEKc0Z4UyiWTGylV2e5gA/d/rpyZBp+HDqgQNrGbAanf2pMB
         CDGzmTzmy347kN8FXGOUv/U3fygonjoOTeizfbH/+DMHkvOzZuEXZ3oMeX8ixVOJ91gr
         1WZg==
X-Gm-Message-State: AC+VfDyFr1ul2XFpTjy/yHv6fPvryacYBmRWUjjzADllVxQjVmMIUJQf
        6wyhe2+1lGqQ0aYJ2U56ocQ=
X-Google-Smtp-Source: ACHHUZ42P54vagUYKHdqqjqOW4DxTxbgHLTlvAl39svemNLrWDjBFKO5SvUWgOiU0REw2LFYYz5yzw==
X-Received: by 2002:a17:902:ab54:b0:1b5:f0:ccc6 with SMTP id ij20-20020a170902ab5400b001b500f0ccc6mr1899559plb.17.1686779772184;
        Wed, 14 Jun 2023 14:56:12 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id w16-20020a170902a71000b001b061dcdb6bsm12653296plq.28.2023.06.14.14.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 14:56:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2 0/2] credential: improvements to erase in helpers
References: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
        <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
Date:   Wed, 14 Jun 2023 14:56:11 -0700
In-Reply-To: <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
        (M. Hickford via GitGitGadget's message of "Wed, 14 Jun 2023 21:40:36
        +0000")
Message-ID: <xmqqjzw5wvwk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> M Hickford (2):
>   credential: avoid erasing distinct password
>   credential: erase all matching credentials

Will queue.  Comments by folks with more experience (than me) who
have worked on the credential subsystem are very much welcomed.

Thanks.

>
>  Documentation/git-credential.txt   |  4 +-
>  Documentation/gitcredentials.txt   |  2 +-
>  builtin/credential-cache--daemon.c | 11 ++++--
>  builtin/credential-store.c         | 21 ++++++-----
>  credential.c                       | 11 +++---
>  credential.h                       |  2 +-
>  t/lib-credential.sh                | 59 ++++++++++++++++++++++++++++++
>  7 files changed, 88 insertions(+), 22 deletions(-)
>
>
> base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1525%2Fhickford%2Ferase-test-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1525/hickford/erase-test-v2
> Pull-Request: https://github.com/git/git/pull/1525
>
> Range-diff vs v1:
>
>  1:  35ee1795bcd = 1:  35ee1795bcd credential: avoid erasing distinct password
>  2:  fcdb579263f ! 2:  9b12f17dc7e credential: erase all matching credentials
>      @@ Metadata
>        ## Commit message ##
>           credential: erase all matching credentials
>       
>      -    Users expect that
>      -    `echo "url=https://example.com" | git credential reject` or
>      -    `echo "url=https://example.com\nusername=tim" | git credential reject`
>      -    erase all matching credentials.
>      +    `credential reject` sends the erase action to each helper, but the
>      +    exact behaviour of erase isn't specified in documentation or tests.
>      +    Some helpers (such as credential-libsecret) delete all matching
>      +    credentials, others (such as credential-cache and credential-store)
>      +    delete at most one matching credential.
>       
>      -    Fixes for credential-cache and credential-store.
>      +    Test that helpers erase all matching credentials. This behaviour is
>      +    easiest to reason about. Users expect that `echo
>      +    "url=https://example.com" | git credential reject` or `echo
>      +    "url=https://example.com\nusername=tim" | git credential reject` erase
>      +    all matching credentials.
>      +
>      +    Fix credential-cache and credential-store.
>       
>           Signed-off-by: M Hickford <mirth.hickford@gmail.com>
