Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81142C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 09:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0876220756
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 09:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcPWYTzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895922AbgJ0Jr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 05:47:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35848 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895736AbgJ0Jr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 05:47:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id l16so745825eds.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 02:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QB5ozJttmCcW6oQVCsxo/1WGaLR4rasrqA+d4Tr6oEc=;
        b=bcPWYTzcDlXP/eT4Jj4vstD6YY9Qi6UH3vp9gePzy1r6jdZhw/KszB7BDxt0NbhX7t
         Tzwpjl2uXrH79WNAFz9ZIPIcSMCQEKInpE/Gk8gvPJKLvp6FHWc0FykPW1PUZ11w7nEi
         XZGy3nL5Al6jwEVya5S87RXqN1cv6qm8LLCXgAARgYRjd7yN3meLpZwquP2F7GNsEhsx
         Bfr04QqD5wLKSVFSRSeyLeTluHu2QA3WSj7O5AS0vazNmpFT2z/FAYX24h+63L2H6S9H
         xjSt+xd3TUaJxAVZ6zQ8xvAcTO9IRx4nVwck3ub9K5GKXuWfDonxzibSUuKrYzw4KAyF
         x3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QB5ozJttmCcW6oQVCsxo/1WGaLR4rasrqA+d4Tr6oEc=;
        b=Ii99+YtQqTI+X1tPD+NjdQiNB1CgdCfBF3oiYs5P98dUWkwvXVt+Vbx8PYNC7m6T5D
         wiba23cMZGHi++ruDyasomNT0Psb7YthfHEJTsZDZoLaHhkfaFbxvg7bxil35cEl0tdj
         nYGPnLL5UzsTSkGwaUxCQfS+rvep68U4LDEIJQAIx+LpSRmwaWf2Q/gOm4HKlNvbi5qO
         2cWa+Ew3DijlI/4DclujnelVdt1qcEGpQ/DDRzbdnXb74YPA7u5Gnl3n6prKv4pSmEyZ
         acVCvlVZptRdkPFik4vQpiVZRrVFeNznS56A/gb7yiUyprRVh2aKqHb03lNG/zTOtaG/
         MCiA==
X-Gm-Message-State: AOAM533fxJx/ZY0EbUZeVr13QcUPa9XhdtZglwNHAxN4sCH8iV7nT1gy
        WhJyf9xQf1ulOpNKZpwgAR4=
X-Google-Smtp-Source: ABdhPJxERS86kkM0BdTY/DrtE1PaCGdia8aHFe+2Izndnx1hMa65U+ha1pB1SONjyAXjwZcytI7Y/A==
X-Received: by 2002:a50:85c6:: with SMTP id q6mr1355567edh.126.1603792045268;
        Tue, 27 Oct 2020 02:47:25 -0700 (PDT)
Received: from szeder.dev (92-249-246-148.pool.digikabel.hu. [92.249.246.148])
        by smtp.gmail.com with ESMTPSA id t15sm688933ejs.3.2020.10.27.02.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 02:47:24 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:47:22 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/4] fast-rebase: demonstrate merge-ort's API via
 temporary/hidden command
Message-ID: <20201027094722.GG24813@szeder.dev>
References: <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
 <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com>
 <27ad7566007676fc69dc28aa3b289547f0ccabca.1603764490.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27ad7566007676fc69dc28aa3b289547f0ccabca.1603764490.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 02:08:09AM +0000, Elijah Newren via GitGitGadget wrote:
> Add a special built-in that is only of use to git-developers and only
> during the development of merge-ort, and which is designed to
> immediately fail and print:
>    git: 'fast-rebase' is not a git command
> unless a special GIT_TEST_MERGE_ALGORITHM environment variable is set.


> ---
>  Makefile              |   1 +
>  builtin.h             |   1 +
>  builtin/fast-rebase.c | 210 ++++++++++++++++++++++++++++++++++++++++++
>  git.c                 |   1 +
>  4 files changed, 213 insertions(+)
>  create mode 100644 builtin/fast-rebase.c

Please also list this new command in '.gitignore'.

Perhaps it should be listed in 'command-list.txt' as well, though I'm
not sure.  It starts with:

  # All supported commands, builtin or external, must be described in
  # here. This info is used to list commands in various places.

though I'm not sure that we want to list such a special-purpose
command in "various places", and it appears to work anyway...

Or perhaps this is a sign that this would be better added as a
test-tool helper as suggested earlier?

