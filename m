Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F1EC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 04:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3F6613CA
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 04:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhFBEOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 00:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhFBEOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 00:14:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD47FC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 21:13:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x10so436518plg.3
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 21:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qPfJZ4S/rmDWEkovEfQMQMP+bKXB/FZsFN31XTQz3gM=;
        b=vQX5Ie9GPlofxtgHnIwYuF5QXuLD4o6+3kgyyzz0VdZAhDTU8CV5ndvwP1PN8vMb7S
         n7HYdCI1AQI91Iq4HQf6cE0oKuI7d1OGO+4whSNujiGhmE7Pqz9fLSD8PiFz1Bc0WQ6M
         ODKuB0cYIC0kZ5c5OFYvT6nuAhHqTBh8vGgTEQpqp0yS59BkN18nM0l1CrCiF/umklvh
         6kzDHDSLyfM07VXB9sN4hsOBMDkr7H3790Ja1Rk8OD7QkpHuoklSdKJ+KDxQkeZf8CJR
         xN79TP965jKoJBC3a0+Si8lhaHGn9Wdg8BaEn9+PnNfxzzjDkoU+1031UJL0Z3YswSNj
         Libw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qPfJZ4S/rmDWEkovEfQMQMP+bKXB/FZsFN31XTQz3gM=;
        b=f1NmD/ah7SvrGGt+WgpPJVjm4pw+K1N+MNIs9onFpAkfnzV8epOrwc1iixytjG7rCR
         t0oeYhlMeIa/Jf9Stevb7B4OWlr2v1xTnRJ7Pib/KTfI0K/ftw5/L949hB7yxd+9gBN9
         RbQnkYTZ2BRnEfbJybeCPSlebsl9baLTCaouFPc+Icm7tqYZnQuOrdUeSJA9tzEA/ocY
         WjSQZGpG4+5dZC4TLQnvNS/kb4rPoLhiWXyM36JF4Mj3eP0D7IrAQlgcNtpTlD1IGc11
         zDeDgLozU0Tmtf/AorsKQ6DGJUPxtQGXLnjhBOFhxQ9JdiGgyF7Y8HlfAd+Gr3BYjtKq
         2pzQ==
X-Gm-Message-State: AOAM533CZ/uU5su5WjNwBUAeiye9VP0hmnOfdUHqWrNJ6EVTMorxBF8K
        hkEAPytix8g/q99nWite1cel7gdSwWgYSg==
X-Google-Smtp-Source: ABdhPJxoVK6xMNJquDT/33r4Lns7a3YwFgS0UZTYwbWCgV7nxJdHxnbUcXIm0aF1YXjsZq194xgJSw==
X-Received: by 2002:a17:90b:3b92:: with SMTP id pc18mr28672331pjb.218.1622607190386;
        Tue, 01 Jun 2021 21:13:10 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id u11sm14179522pfk.198.2021.06.01.21.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 21:13:09 -0700 (PDT)
Date:   Wed, 2 Jun 2021 11:13:07 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
Message-ID: <YLcFU+ORZTzAsyBy@danh.dev>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev>
 <60b61089ba63d_e40ca20894@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b61089ba63d_e40ca20894@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-01 05:48:41-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > How about alias? It's part of my muscle memory.
> 
> No aliases.
> 
> If a new user doesn't have them, neither should you.
> 
> All VCSs have default aliases, and I advocated for git to do the same
> [1], but it wasn't accepted.
> 
> The whole point is to suffer like them.

Get back to the alias topic.
I also agree with other people's opinion in that thread.
IOW, I support the decision to not accept those default alias ;)

It's not required to be different people to have alias defined to
different command. I have alias conditionally defined to different
command based on git-dir. For example, I had ci alias to "commit" by
default, and "commit -s" on other repositories.

So, Git decides alias for me will not only break my current alias, but
also break my conditional alias.

Anyway, remotes/branches are all configuration values.
Would you prefer:

	git remote add a-remote git://some/repository.git
	git fetch a-remote a-branch && git merge FETCH_HEAD

or
	git fetch git://some/repository.git a-branch && git merge FETCH_HEAD

I guess it's another exception, then ;)

> [1] https://lore.kernel.org/git/1379791221-29925-1-git-send-email-felipe.contreras@gmail.com/

-- 
Danh
