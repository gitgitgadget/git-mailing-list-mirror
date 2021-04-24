Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA62AC433ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 04:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769C361474
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 04:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhDXEz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 00:55:26 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:35338 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhDXEzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 00:55:25 -0400
Received: by mail-ej1-f54.google.com with SMTP id u17so76785175ejk.2
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 21:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTf3GMcGaRUHC0GW4pn6k92L1eOqHILoLqpX9C9OO9w=;
        b=qSfTp6njo+BRpING0HFgM+qr9EGufzf5nxt5XCp0NMkWua3+6kzvjsiwxkastWLUES
         vAJ9J6OiW0h/QtshAtYM26Ryu1AK4eGWh34qiRk3lc/xq97x3WCEUCU3ec+nKIY678GZ
         y4jKU1s19ZjGt4Y8np97YDNHc1wzO8Bv8SLyRjggYQi9FurWacd7arew0JI5sA7mVMCU
         ZuYm1uXqkmhozCHCULc3FlzarSiNULcOXYLNkSGqjaI5WjR0Wby2HPZ95SJmQPL/RfWq
         IuxtDd7ZeUewv4OxFTMx8wQ6FNKzSwAK5yYIlhEYZMduj5yUEMs5AX58CUAoUyKLpFnF
         pWUA==
X-Gm-Message-State: AOAM530vOq4hbI5p6CnoQI5K+dyvxbYTWySdduNiymnwIxCAhMKzP1Q8
        2Y2Qnlh1vvg9kItbF8Tg1vf9p+0yDoBZ1wLVesc=
X-Google-Smtp-Source: ABdhPJx+KojNRMGbyXZfg2K+vkgN2spt9t8Fg/CbZS5QheKToZjHyfNp2DjzaKFl5HmAlFn5r41zLTkFETnUq8kYZEE=
X-Received: by 2002:a17:906:6d41:: with SMTP id a1mr7722794ejt.482.1619240087390;
 Fri, 23 Apr 2021 21:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-25-lukeshu@lukeshu.com>
 <CAPig+cRaQnZ7DWYdU+efNpMgxdniXNQdF43TSFiaj6ezLELC_g@mail.gmail.com> <87v98ca4uf.wl-lukeshu@lukeshu.com>
In-Reply-To: <87v98ca4uf.wl-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 24 Apr 2021 00:54:35 -0400
Message-ID: <CAPig+cSJJ9EXRN4p2MYcMGVe8sCutdZ4NGZYfX+E0mLSuFA6SQ@mail.gmail.com>
Subject: Re: [PATCH 24/30] subtree: don't let debug and progress output clash
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 8:44 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
> On Fri, 23 Apr 2021 15:07:12 -0600, Eric Sunshine wrote:
> > Makes perfect sense when output is to a terminal, though might be
> > annoying for the person who redirects stderr to a file. Just idly
> > wondering if it makes sense to take that case into consideration...
> > (but maybe it doesn't matter much when someone is working at debugging
> > a problem).
>
> The '%s\r' isn't really useful when written to a file, so this change
> is useful in the file case too.  I'll add a comment and update the
> commit-message.

Ah, right. I didn't pay close enough attention to really notice that
the "\r"-terminated line was going to stderr, so ignore that bit in my
review comment.
