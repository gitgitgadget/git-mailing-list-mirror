Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73003C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 09:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D148610FB
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 09:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhINJuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhINJuC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 05:50:02 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2137AC061764
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 02:48:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id o11so15178867ljp.8
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Zcoqe9rFxQtxPSnOhzlWb9XY0vVH4UvVjvG/cHZoKpI=;
        b=MPn6UoDg7kWAx2w0kbZSujRxi+Yk/6iuFhU1A3luvh7fFQBKZ8lK8LtTRhCRrts0+U
         PlxrQniOIF2TXmgm3G2dxw15CcRWtah8WKY8+5EVw1VXX0ouo7QjCmJCcR92gZbZmIMC
         dJs8Of4RRHJ2fzzVkGYmNjifYqzF9eD6j0jsK7MN6dFSBNLc6ZkdmzDOmdDqOAPetkN8
         Deu0Qy73JEkMjqE9ekdzMbN3W6rJf8w2PEtU0JmEQADtzGavWLKpkPMDC5f8XBlgHP3H
         rJa0Bymlc9iTgZsymVbN06kHnU08O9kHsKCrbcSAshuJUhgPRPrjiKrR1IbLyAC4oWZF
         yzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Zcoqe9rFxQtxPSnOhzlWb9XY0vVH4UvVjvG/cHZoKpI=;
        b=mkB4PGvFqeuk+jSJL0CRM020CSWn3VMmUdpkACoePsaaj9zel7nf63Oo23ku7TnqZ1
         V7tbMdE6z2TZpyjPTyLxCXH1+p8rA2BHvrU/HI/3Z8ccrQL0mKNtgsGJM+F7tlarGEoN
         4GZ8bQfLdhTaejCYJVr2Cc3ujAy9sed4+VQep4K8y6vgoD5ngxPYgjQpPE9VKCt9gIp+
         AZNwvl5MpdKV2LlXWrY1rhZjF6ItihSMBHyKFYZ9BbEJtgg9+TVE85G5Yn4d+JW1K5s+
         iC1neFPLkAW+CNzdFTjyPG3yZJHhbPo7Mgtp7fae1gwZu3pqcHPVYVUGFbUJZ7h2wZnf
         /wTw==
X-Gm-Message-State: AOAM532pTmbYdZ+ZhpulcFEl/Ms67ZFiE0JfGTtAJjA+BcwA+uZYh47q
        NgOvJoH0lB7kCq71BT9zmKI=
X-Google-Smtp-Source: ABdhPJz1LM9RFro8tPI9H8fMM45G+UZYcFdSmD8+WAsAYylisPYrQ29XJOYuY81EADwXy2sT6M9z0A==
X-Received: by 2002:a05:651c:1504:: with SMTP id e4mr5608609ljf.475.1631612923507;
        Tue, 14 Sep 2021 02:48:43 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d23sm172260lfs.125.2021.09.14.02.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:48:43 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 11/11] rebase: dereference tags
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <951de6bb1992773cda60791c4b7a09867b5e0f19.1631546362.git.gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 12:48:42 +0300
In-Reply-To: <951de6bb1992773cda60791c4b7a09867b5e0f19.1631546362.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 13 Sep 2021 15:19:22
        +0000")
Message-ID: <87r1dr5vyd.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Aborting a rebase stated with 'git rebase <upstream> <tag-object>'
> should checkout the commit pointed to by <tag-object>. Instead it gives
>
>     error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD':
>     trying to write non-commit object
>     710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'
>
> This is because when we parse the command line arguments although we
> check that the tag points to a commit we remember the oid of the tag
> and try and checkout that object rather than the commit it points
> to. Fix this by using lookup_commit_reference_by_name() when parsing
> the command line.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

[...]

> diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
> index 162112ba5ea..ebbaed147a6 100755
> --- a/t/t3407-rebase-abort.sh
> +++ b/t/t3407-rebase-abort.sh
> @@ -11,18 +11,18 @@ test_expect_success setup '
>  	test_commit a a a &&
>  	git branch to-rebase &&
>  
> -	test_commit b a b &&
> -	test_commit c a c &&
> +	test_commit --annotate b a b &&
> +	test_commit --annotate c a c &&
>  
>  	git checkout to-rebase &&
>  	test_commit "merge should fail on this" a d d &&
> -	test_commit "merge should fail on this, too" a e pre-rebase
> +	test_commit --annotate "merge should fail on this, too" a e pre-rebase
>  '

These two do not seem to belong to this particular commit?

>  
>  # Check that HEAD is equal to "pre-rebase" and the current branch is
>  # "to-rebase"
>  check_head() {
> -	test_cmp_rev HEAD pre-rebase &&
> +	test_cmp_rev HEAD pre-rebase^{commit} &&
>  	test "$(git symbolic-ref HEAD)" = refs/heads/to-rebase
>  }


-- Sergey Organov
