Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451B9C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 05:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhK3FQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 00:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbhK3FQX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 00:16:23 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638DDC061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 21:13:05 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y16so24460940ioc.8
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 21:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4565NApiFsqOLrYA8eE9MNIAGfugQW7+A5uAp/kqXko=;
        b=n4LxbxZarfNb/qYA+QwKSiVTmkOgQTJN7hbwwQhD9TskJx3+pXEj7iYQfU6c63tRsN
         GFXZyhUyqS3xi3uFKN2SDF2yWCtWJlsuj6KgloanYBV0l1Pu1DOUv6fAw+VQFhDouU0C
         KS3zrw8CVoVtgsfrsc+irCnZLnjZbeUYqoNrotk6MgiEtnQY/uQZ3QkE46bnhIhgnf9V
         bJjRomaVscJXgLGoIc2lv9hFtc9ShvZQ07i4/urDsJW2rWn1QT/9aK3TlTlD10C52F45
         T3RemRDvgPItE+vYMAdk1PtdO1QyNcKX2qwrC/3/VPitwZnjKPTcUIRppL60Ttlp5g8K
         qXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4565NApiFsqOLrYA8eE9MNIAGfugQW7+A5uAp/kqXko=;
        b=ySerlll63gzMfh97TJgDK/s+RrfDsOanPqs+7b+6Kw1/ZSzLh9pNmRSVWn+ZOBFbPh
         tSOzP4jw1zFHMiU33K5NoQGkMndKzYtHSqIPBwtObyRYe067t5OAF6Z9aWdHPyOuzFsI
         H7IwYjiSbaWQ8scWqgAgzqJHkcSeF2/LiJYTVUUeYNegoBNrB1wT56TFxmk8Xpd3w6K6
         qFM6DHWNfwchWE9ochLeHt9seZmlG8wFV7b5PVcC4LveGNg26lylYIxMpPZUTO199R/a
         Rvb9HligXjXuZlQd6zELIeZ/Owwo/HuTWv2CAXunyXbBf509uncXWByoTwwqQEMA8G6z
         QEHQ==
X-Gm-Message-State: AOAM5337PiYaBdKBAzeBiqHEvfkSVm09JjbxM1+7LQxS06zdXOD1j6lB
        +AjSj/VHerZVx9qMEMwRknic5A==
X-Google-Smtp-Source: ABdhPJzrC7Cj+uTnbcqkwWplhpFCJ+BAhkdxJ9K+2thaq+Vu7PSBv11/wAOe01AjCyXzNStnd+TFZg==
X-Received: by 2002:a5d:8451:: with SMTP id w17mr67195643ior.139.1638249184792;
        Mon, 29 Nov 2021 21:13:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f4sm9490387ilr.79.2021.11.29.21.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 21:13:04 -0800 (PST)
Date:   Tue, 30 Nov 2021 00:13:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: avoid adding exec commands for non-commit
 creating commands
Message-ID: <YaWy3+nXC/6oLb1A@nand.local>
References: <pull.1149.git.git.1638244719381.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1149.git.git.1638244719381.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 03:58:39AM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/sequencer.c b/sequencer.c
> index ea96837cde3..aa790f0bba8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5496,7 +5496,7 @@ static void todo_list_add_exec_commands(struct todo_list *todo_list,
>  	}
>
>  	/* insert or append final <commands> */
> -	if (insert || nr == todo_list->nr) {
> +	if (insert) {

Looks good. My worry after first reading this is that we wouldn't insert
an `--autosquash` rebase that ends in a fixup, e.g.:

    git commit -m foo
    git commit --fixup HEAD
    git rebase -i --autosquash -x true HEAD~2

But we're OK there, since we set insert to 1 when we see the first pick,
and leave it because we never saw another fixup. Then we'll still have
fixup as 1 when we exit the loop, and we correctly insert an exec line
at the end of the fixup chain.

So I think that having "|| nr == todo_list->nr" part of the conditional
was broken to begin with.

As far as I can tell, this behavior of always sticking an 'exec' line at
the end of the todo list has existed since the inception of the `-x`
option back in c214538416 (rebase -i: teach "--exec <cmd>", 2012-06-12).
See the unconditional `printf "%s" "$cmd"` at the end of the sub-shell
within `add_exec_commands()` from that commit.

But this is broken according to the docs, and I think that your fix and
test coverage are sensible. Thanks!

Thanks,
Taylor
