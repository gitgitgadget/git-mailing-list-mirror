Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0F51F453
	for <e@80x24.org>; Wed, 26 Sep 2018 22:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeI0EaE (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 00:30:04 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43537 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeI0EaD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 00:30:03 -0400
Received: by mail-wr1-f51.google.com with SMTP id z14-v6so455629wrs.10
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=52c+TC1hrJoktpr+m/QpGCX2e8tDGZWs0bQVGE2teeI=;
        b=cXIMf1lsn9hzyog9M4U5sht/jAJJLxAZZm2Ndhdgsrwu9fxxQKLw3NZmUWUEgNhWjP
         UnM+4mwSdtXP1eBzch13sLv/aniwJXxXvoYS6KI2a9vCiJ9iutj6GFOekhmHcMd5i/E6
         rJB+Ly9A/Rras+OEG+Yu+wS6npPqGstnZO19UxzzpDQB/4RqgVJZir2NwDIvuapw5bi9
         Gc3OPNZMuST7VPocj62pejt94anHivYW8vKM7gpiDQXrxTfFMcn546WeQwKq0ufNPaKQ
         9X9edKBsFXiaH4q07I84jaImEUWjuOU+rswBckrXi/Xj5NsuUiu8G1ju17lpw84xR/LU
         DTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=52c+TC1hrJoktpr+m/QpGCX2e8tDGZWs0bQVGE2teeI=;
        b=EIex4HoJw/u/TanQ41FlFgELHPj9+XjWffq1B0qCT5GXJLZiUxVgwgoICGkQhByxed
         4AtxwmNwjlapQzZhxxL0HEuUfo+njR/a9KBqVMt45cPlR3prMBhA0P0DRnlxcxnkS4iq
         iH9IdnMjQ4snnKMax+Gu2IZDGVaO7/BfClvQKAE0YgNpsgTvzFooNoujkg7dSzUKaZ2y
         9x8H/z9UY25A+PYKSABAzQJwM4asxqjIJYokdJxGLGJSprAefTIhDFznVUhLg2QLa2DP
         jpL4BUD7g2dlmLkdYqGSkv9/NNiEaBHhlQb7ERvH1hQQ+PYO/As3f6kMJGJYU7uhWlpq
         0GMA==
X-Gm-Message-State: ABuFfoj1gKqTxSjtzC3ofcSuzTn6xm03wq9+ho4zo7qQJA23WA4iYQiD
        hoXTttQm3ITIUbRO4gBVc6OlYzZC
X-Google-Smtp-Source: ACcGV60Gc0j4SZxi9S8q0yn1LifwlEPcDW2aCdff6cFqZNh+igorz5gMCLZ2+RY00HwBxARATj09XA==
X-Received: by 2002:adf:9464:: with SMTP id 91-v6mr6077482wrq.200.1538000097095;
        Wed, 26 Sep 2018 15:14:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z10-v6sm144702wrv.22.2018.09.26.15.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:14:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/9] submodule.c: sort changed_submodule_names before searching it
References: <20180925194755.105578-1-sbeller@google.com>
        <20180925194755.105578-4-sbeller@google.com>
Date:   Wed, 26 Sep 2018 15:14:56 -0700
In-Reply-To: <20180925194755.105578-4-sbeller@google.com> (Stefan Beller's
        message of "Tue, 25 Sep 2018 12:47:49 -0700")
Message-ID: <xmqq1s9fkisf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> We can string_list_insert() to maintain sorted-ness of the
> list as we find new items, or we can string_list_append() to
> build an unsorted list and sort it at the end just once.
>
> To pick which one is more appropriate, we notice the fact
> that we discover new items more or less in the already
> sorted order.  That makes "append then sort" more
> appropriate.

I somehow thought that we agreed that the second paragraph above did
not make much sense in the previous review round.

    ... goes and looks ...

https://public-inbox.org/git/CAGZ79kbavjVbTqXsmtjW6=jhkq47_p3mc6=92xOp4_mfhqDtvw@mail.gmail.com/

That was two review cycles ago, I guess.
