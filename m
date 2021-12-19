Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD0EC433F5
	for <git@archiver.kernel.org>; Sun, 19 Dec 2021 20:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbhLSUQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 15:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhLSUQn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 15:16:43 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749E7C061574
        for <git@vger.kernel.org>; Sun, 19 Dec 2021 12:16:43 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id a11so7558963qkh.13
        for <git@vger.kernel.org>; Sun, 19 Dec 2021 12:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7aqWsuugymvkRCTrzQ5WFWrMm7eUCwMA5gDLIrWIVqA=;
        b=kcbRVrBwD4FFFA7pYvfT5nXKUHEzCGiNFDrOrmwnUsjqc1cCw5fjy2m5sb7e4jssfZ
         2wH2UkEWOQgx8PzmjjQxK/7F2bl4nE9EDf5EcFswrXmiutVXD9i5gmMQN6Mxhsi9r/tY
         1haEGEui+fcp0fF9i6W3qQ4N34F0TJjGpXxgVaeBYrxWNhukn4K6EpaCb7l0iAi2Yimc
         iqUNwucR7+DgwZHDDmWo74P0zvfES2aNU4CMGrTFDFDekSv6sfxFE9u8mDNKgIIce2hA
         H+2AH1sNcLVuDL4usyZU+6BA6nG3MeLVQITc7e1k+hhTzuJ2Y0rdkg81MKDoQJcuVSfl
         rvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7aqWsuugymvkRCTrzQ5WFWrMm7eUCwMA5gDLIrWIVqA=;
        b=v6RTHsxuwZup37g3xpeXzFLvZNIfGD4pTHhsOUMhXyKvp8jq91/jCTD5b132RNgJ6e
         adwYxXQDftmaLJdSsL8R23rVYwJRvxLU7ACMj0dwL3ZegfpJQ/N5bCIIbrPHjfRDb+wT
         yPsW8LLd/2y+TjHHB1fl7+15clb0n8gCx6EQ0Dyd8If28HQPJihsIfoJUwLFghIaNt/8
         ob5ymuCA7OOjgCRKp7QhV5ujn6lGtJj2rT5RgAdqYbGi8aZqBe5zcw9FYUvAHYrLhySP
         0GvWUl3qtuXWUZ4W6FWMa1PHhqmgEnKKLYpCLq1mC683lN+td6kQGDKJZ7fFGudD6glm
         sGWw==
X-Gm-Message-State: AOAM533WjEnzefc8wZOPPcAuR/muSya0AMsRLqw4V1tdl+qg/KG1FUR6
        hTBnZtaGM4qBJSmrtk12SFDiz0kBF6SD5g==
X-Google-Smtp-Source: ABdhPJzr9xlb0Cftjya82Q6WWv971jXGQ0D0vDHAhuWg9pFXC8Bnawnlez2zuCfRqNHGlcNfyHBu5A==
X-Received: by 2002:a37:b53:: with SMTP id 80mr7833750qkl.91.1639945002256;
        Sun, 19 Dec 2021 12:16:42 -0800 (PST)
Received: from [10.11.12.100] (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id v4sm9817499qkp.118.2021.12.19.12.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 12:16:41 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Message-ID: <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com>
Date:   Sun, 19 Dec 2021 15:16:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: Bug report - Can create worktrees from bare repo / such worktrees
 can fool is_bare_repository()
Content-Language: en-US
To:     Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18/21 11:46 AM, Sean Allred wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
>      ~$ git clone --bare https://github.com/git/git.git
>      ~/gitbare$ git config --list --show-origin
>      file:config     core.bare=true
>      ~/gitbare$ git worktree add --no-checkout ../next
>      Preparing worktree (checking out 'next')
>      ~/gitbare$ git config --list --show-origin
>      file:config     core.bare=true
>      ~/gitbare$ cd ../next/
>      ~/next$ git config --list --show-origin
>      file:../gitbare/config    core.bare=true
>      ~/next$ git rev-parse --is-bare-repository
>      false
>      ~/next$ git config extensions.worktreeconfig true
>      ~/next$ git rev-parse --is-bare-repository
>      true
>      ~/next$ git config --unset extensions.worktreeconfig
>      ~/next$ git rev-parse --is-bare-repository
>      false

As far as I can tell, this is working as designed and as documented[1]. 
`git rev-parse --is-bare-repository` is supposed to return "true" in the 
bare repository, and "false" in a worktree. However, you missed the step 
(discussed in [1]) in which it is your responsibility to move the 
`core.bare=true` setting from git.git/config to git.git/worktree.config 
manually after setting `extensions.worktreeconfig=true`.

When `extensions.worktreeconfig` is false, --is-bare-repository special 
cases `core.bare` to return "false" in a worktree regardless of the 
setting in git.git/config. When `extensions.worktreeconfig` is true, 
however, that special-casing behavior is disabled, and 
--is-bare-repository returns whatever it pulls from the configuration. 
In this case, it returned the value of `core.bare` from git.git/config 
since you hadn't moved `core.bare=true` to git.git/worktree.config, 
which would be local only to the bare repository, and not seen by any 
worktrees.

[1]: https://git-scm.com/docs/git-worktree#_configuration_file

> I actually found this situation (and narrowed it to the above) by
> trying to perform a sparse-checkout in the worktree.  It appears
> sparse-checkout by default uses a worktree-specific config (which
> does make sense).
> 
> What did you expect to happen? (Expected behavior)
> 
>      I expected one of the following to happen:
> 
>      1. I should have been blocked from creating a worktree from a bare
>      repository.
> 
>      2. is_bare_repository() shouldn't be fooled by this situation,
>      assuming it's valid.
> 
>      All things being equal, I would more expect to have been blocked
>      from creating a worktree from a bare repository.  Personally, this
>      bare repo + worktree setup doesn't not align with my experience so
>      far with how bare repos are normally used (i.e., as a convenience
>      for centralized remotes that will never be doing a checkout).

Regarding #1, creating worktrees from a bare repository is an 
explicitly-supported use-case, and we've heard several times on the 
mailing list from people who take advantage of the ability in automation 
situations (often in CI setups), as well as from people who use it as a 
part of their daily workflow (in which they don't consider any 
particular worktree to be "blessed").

Regarding #2, --is-bare-repository is not so much being fooled as it is 
being lied to by your configuration which wasn't updated to move 
`core.bare=true` to git.git/worktree.config. (Granted, it's painful that 
it's your responsibility to move the setting manually; automating would 
avoid this sort of confusion.)

> What happened instead? (Actual behavior)
> 
>      is_bare_repository() is fooled and I'm prevented from performing
>      any operation that requires a worktree (like performing a sparse
>      checkout).
> 
> What's different between what you expected and what actually happened?
> 
>      is_bare_repository() is fooled into thinking the worktree is not a
>      worktree / I'm able to create a worktree from a bare repo.
