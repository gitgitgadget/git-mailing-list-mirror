Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAF8C3DA78
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 00:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjAPALu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 19:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjAPALr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 19:11:47 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD1EC6F
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 16:11:46 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w2so4423928pfc.11
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 16:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ghlxUHsWU1cPKBIBqkdvTT4pX6e/tFxlo9u8NfJV84=;
        b=FadytUmcgJJSfobqSL38ynmf9dNkWp7KweNLttPTzU0WoBsdVhFOzDfRIy42IIxmOH
         F5Liouu7UUlgmsyyQBgIWRkIM+wnLNO57/GlS87GwMb8JJJ3/tkbPG1ADqqqzQKlSBTx
         HrF4BP3bQR9HatLx4tkXF6+DyG7kE/tZLwrMUYLCjoYxqkSH7sCWh2YI29D6M/ECwDvl
         4Q069gTlcOvQ6oV4YSkzdzFU/ACXpNmyLWpzaXruT1ILZPykZ2gM3vKC+6GejKVrSP1l
         ELxkaDRVhuTIeGR2oeE/tKCh0e0bggpS8M3UCATbSHUJow6VW7IBDjn1OAg8h3Q4RksF
         pqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ghlxUHsWU1cPKBIBqkdvTT4pX6e/tFxlo9u8NfJV84=;
        b=DCqgwEDKmKWHY39QfIjP5yDlIcCyQd/WxKRRJNO//M1j53T6Ke3/3Td8ACEXH0aYh5
         mMdidr0ncJTe6KGxET8HnuhlkaVneWvkMuNByrHFp3L4dm6cAj5B4tznGx5YFDddsHFC
         hmTqb/7uvuYyEkGkmz+hozaVEDRXRz83cbiLmLIqyGjKsvoBZKd0jJw795Yg7csURkWK
         xSU1OvkoVV5vP8AscPCOHrV0Hb7QHHIuL0XQrSC72G0uU6CSuxP/HGx5JYs6gOiCsdQB
         N0sIfMQnm1UFnPrZgG04elclYJptCbmBCR8XxkxMCAEZ9ma4V0pW/duHj6z1D+u5uQny
         D1uw==
X-Gm-Message-State: AFqh2ko0Mw9lNkgxr5N42nkx2HOg/tBFrh0K5cR7t1zw80qIZYuLlQ9Z
        XV2s8vWcJJfgMlM7XU8bL8VTsjvfnEU=
X-Google-Smtp-Source: AMrXdXvfii7qN9ZN5DZLzGM2jeDz8z1D2xwRGI/omGEDfys/N/SX3c+fgLeSrKxNcJYUHZndi8WYIw==
X-Received: by 2002:a05:6a00:4393:b0:58c:972f:92cb with SMTP id bt19-20020a056a00439300b0058c972f92cbmr6346746pfb.1.1673827905527;
        Sun, 15 Jan 2023 16:11:45 -0800 (PST)
Received: from Carlos-MacBook-Pro-2.local (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id f7-20020a623807000000b00589500f19d0sm12704864pfa.142.2023.01.15.16.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 16:11:45 -0800 (PST)
Date:   Sun, 15 Jan 2023 16:11:44 -0800
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jinwook Jeong <vustthat@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bugreport: "git checkout -B" allows checking out one branch
 across multiple worktrees
Message-ID: <20230116001144.dt76xk6hkwn45klz@Carlos-MacBook-Pro-2.local>
References: <CAA3Q-aaO=vcZd9VLFr8UP-g06be80eUWN_GjygfyGkYmrLx9yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA3Q-aaO=vcZd9VLFr8UP-g06be80eUWN_GjygfyGkYmrLx9yQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2023 at 06:45:34PM +0900, Jinwook Jeong wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> 1. `cd` into any git repo that has at least one commit.
> 2. Identify the current branch, say main
> 3. $ git branch foo # a new branch
> 4. $ git worktree add ../new_worktree foo
> 5. $ cd ../new_worktree
> 6. $ git checkout -B master HEAD

Was your intention to get this worktree's content back to what is in
master's HEAD?, then the command should had been

$ git reset --hard master

The documentation might be confusing, but you most likely do NOT want
to use -B unless you want to force things, but the lowercase version `-b`

> Anything else you want to add:
> 
> https://www.git-scm.com/docs/git-checkout#Documentation/git-checkout.txt-emgitcheckoutem-b-Bltnew-branchgtltstart-pointgt
> 
> According to the documentation, "git checkout -B BRANCH START" is the
> transactionally equivalent of:
> 
>   git branch -f BRANCH START
>   git checkout BRANCH
> 
> When I ran the first command in place of the step 6 of the above
> reproducing procedure, git refused to carry on;
> I suppose that this is the intended behavior for "git checkout -B".

I think you are correct, and this is therefore a bug, but there is also
a reason why `--force` allows doing dangerous things and I am not sure
if it might apply here.

Carlo
