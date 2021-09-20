Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935F2C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D13961157
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhIUBpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhIUBj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:39:59 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76016C04F35D
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 13:28:14 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id w1so20220574ilv.1
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/hUDXhk7hrwxCC5uUGm/kSPwAVnvx0UGW7fKnAB7YJs=;
        b=K8Z1VgD43KF26dDL2ss+hEIheYYhlhe3WHijirpUaWlJu1iqK1XlY2kiROAZ4oMVzr
         fgAD02+KJ1/qynohAvPzWUhvmRn5zy18Tz/CFC+G5Vvq394ncd3PCY8gbtXVXqoPhfkD
         17J13pXHD44BZ6hH8em0xS6DuwcNgAFz63Wnsl/hA28N+9eUuNLQWz5erATrRzm62zTs
         WeXTMXsig/2oznjGd6LPaDmmwBi3RG7cNjL58b5aUTg1u5gR9O0aJnbCBlGC75ftIs3W
         FaQFqwETihjcTBB2NsFNYP7GnyU73qQkSF4Y1tFHCGve4tN+jkwTiIRdxm/pKXGx3lU5
         4cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/hUDXhk7hrwxCC5uUGm/kSPwAVnvx0UGW7fKnAB7YJs=;
        b=Mv4EoR9D7nmbkcvjvHcoXt43qUTXZNsrjDAmCW3O0BijqNLAojbNy9chz8YZ+BGDLX
         GGe6fq9mMY+ojT9gRUiUc9kEN0gt/qFJ5Y71cFu8tmh+8oD7LuUZ9gK3ozgnKLorjOBC
         GEahsDW6SMNJjqeu9R0iLYVs+mesdurriBM8Ht2hMTtfEDWTKhGbz8hrHfPZjGT5VmrM
         s21puoW0fwHuD6Vnf0V3j4koc+AkWP/ylqlGW9rJdRQXzt4tkgSV22RwpF6GNDivHJYF
         HHm6Fq/cFd6wu6mErCIgW6OS9AyL1ddu3K1mrTyKAaK7xPbG/+RwkVe4m8DsMg8zmR/t
         Cbjg==
X-Gm-Message-State: AOAM531DL56vt5JnL8porCkF/q3yQ1c2sJt+8Fmc88KT/0AnXKUdAKvU
        Vx91iQV/CGIhIz1nHQQ8bPU9XQ==
X-Google-Smtp-Source: ABdhPJxlDxmLTsE1e8qNDP/ShKwF7A20cCktnWDSAvGLpSIh6D/9UN7bssGulCEBe/Ru3P9J6ELPUA==
X-Received: by 2002:a05:6e02:1c2c:: with SMTP id m12mr15665595ilh.114.1632169693904;
        Mon, 20 Sep 2021 13:28:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d67sm4642258iof.50.2021.09.20.13.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 13:28:13 -0700 (PDT)
Date:   Mon, 20 Sep 2021 16:28:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] clone: handle unborn branch in bare repos
Message-ID: <YUju1gmT1nDh1PLv@nand.local>
References: <YUjbKt0Hw0ieHcaN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUjbKt0Hw0ieHcaN@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 03:04:10PM -0400, Jeff King wrote:
> When cloning a repository with an unborn HEAD, we'll set the local HEAD
> to match it only if the local repository is non-bare. This is
> inconsistent with all other combinations:
>
>   remote HEAD       | local repo | local HEAD
>   -----------------------------------------------
>   points to commit  | non-bare   | same as remote
>   points to commit  | bare       | same as remote
>   unborn            | non-bare   | same as remote
>   unborn            | bare       | local default
>
> So I don't think this is some clever or subtle behavior, but just a bug
> in 4f37d45706 (clone: respect remote unborn HEAD, 2021-02-05). And it's
> easy to see how we ended up there. Before that commit, the code to set
> up the HEAD for an empty repo was guarded by "if (!option_bare)". That's
> because the only thing it did was call install_branch_config(), and we
> don't want to do so for a bare repository (unborn HEAD or not).

Readding this and 4f37d45706, I tend to agree. Thanks for a
straightforward patch, fix, and test :-).

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
