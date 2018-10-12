Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4DF1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 03:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJLKtS (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 06:49:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39911 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeJLKtS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 06:49:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id y144-v6so11372695wmd.4
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 20:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PwsnjpPynJ0fGSW57E4oBEcqxoiihAywWxQv/kB7FIQ=;
        b=rnTnsHA7ptnvjMZBl8bATLzmIMv9FSm/wwMoU/ILBK6Hvsq0YYZ3TqaZCaxcD/KPfa
         EbaHRV3XtQ1d6bSKoBzlGaeZv8rpTZYSquwslnJWbDy8BoizpPjQmnT17ebGwq+6Xezq
         FykeO78O1K+7nhlQNiWoVtkn4NBF0dcK1mZ1KChgZCx7nRORz71b6ASmVcxCqy2R+dFN
         xAZsyEvg9fBL7K7XztL7fnMbkQmyoKd5Zvm8qdKfEh+JRB4hhRVtMHLk6spSncvjE9pE
         2RUz/6x2y7UNXcjXs+/8eRi2i8B25ud0QC8xWYlDJi2s7x8AZL5buFhWOXg1Dhv95faH
         +b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PwsnjpPynJ0fGSW57E4oBEcqxoiihAywWxQv/kB7FIQ=;
        b=XE3zge4gi6c6thdHrKUjFmXz0I53UH6e/6dPmUDvXRnJ7fK4bHtmZzff08c9pSBZYo
         ot2qy/qAKMG+GHKun8YhLXQZo4YIB8erRj44x8MeA54v1tU6hOCyG8XrddmobJOY6HRv
         YmCdrQCqhdoj6ZMln/P/aUXE4Q5E9ssqOw86Lg6uCl3iSvfJBFpfrdljHtncJbfkEj/y
         eKKntJSi6d5ZKUcniEQ/wBKQ8vPVekWwOLmdFpoPmI8G+Zc+opsAkwyzUUVWnBAI2kg7
         Ijoj1xko0bHvwjiI+JeBDu68F6iGikvpppJjhnRfV2rll1TmrC/glyuAUsMAghiECmNl
         YGcw==
X-Gm-Message-State: ABuFfoiN4/35f4hiEUZ1fRrZ8OXxCCoKpJakRDEcdUuS7T3PLBT5WMG3
        uHIq/ufzfxRId7XADH0k3l8p7i7VC/w=
X-Google-Smtp-Source: ACcGV62AHvbeJvKhMnlqQETce41Pi/uRH0E+iIIsSONtqd3RO+VM3tIhqkGnQkO4MgfxVmlpQAgYDQ==
X-Received: by 2002:a1c:e12:: with SMTP id 18-v6mr3579003wmo.30.1539314340714;
        Thu, 11 Oct 2018 20:19:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c184-v6sm123712wma.15.2018.10.11.20.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 20:18:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v8 0/7] speed up index load through parallelization
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20181010155938.20996-1-peartben@gmail.com>
Date:   Fri, 12 Oct 2018 12:18:59 +0900
In-Reply-To: <20181010155938.20996-1-peartben@gmail.com> (Ben Peart's message
        of "Wed, 10 Oct 2018 11:59:31 -0400")
Message-ID: <xmqqwoqndf8c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> From: Ben Peart <benpeart@microsoft.com>
>
> Fixed issues identified in review the most impactful probably being plugging
> some leaks and improved error handling.  Also added better error messages
> and some code cleanup to code I'd touched.
>
> The biggest change in the interdiff is the impact of renaming ieot_offset to
> ieot_start and ieot_work to ieot_blocks in hopes of making it easier to read
> and understand the code.

Thanks, I think this one is ready to be in 'next' and any further
tweaks can be done incrementally.

