Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E97120248
	for <e@80x24.org>; Mon, 18 Mar 2019 09:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbfCRJkz (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 05:40:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38037 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfCRJkx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 05:40:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so16205784wrm.5
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ex/qe0gQMnO7qtZ/8bj8CudmDiip1QkamsgSRWWc+SA=;
        b=VwC5GJf6T8QlCOPRbek+pr5lKHl96wAwPBkp59D2q6OLxWF7bhYRwQTejTT+mAfRvl
         0LYVrURWYSGUcyemvvJDc+Z0DRXOGoZ+HTgqiU6yoriErYEFkSxKb3GaAALbr4Lp8YA5
         nG93647PseAODIjKeNrIztzNNiYcQRBy0lnYrMH9UzD55SVhBL7uyPQ0P5NDmuncdwHe
         pcpZ9hZzRSCy5cm4227C87Ne3F3jCEkFNq1QmJfZ5ttSsgZPq38Gj0NuCXqWAAQ+xP3+
         OMf0EqDGEWocdu5RSFG2A1vwHB/rrhL6qOgSkqBsb9qJVCfl7cHdToT7PFcQ5k5YdErr
         bIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ex/qe0gQMnO7qtZ/8bj8CudmDiip1QkamsgSRWWc+SA=;
        b=Kbe4GtTCSwzXrz90HG7GHaouyITvZLYc9fm+gzzr5HhEJZkRg6gXhy1fSXw/PWMyzA
         xfNwubWQ6SnIONrAqBnzOm+5yuTXlQNcdpN6/5u+/cNvU3/txbV++z/0Ze5DiANJyecJ
         LmGmLu/JWprfE6QOcVhuaC4+hdKMCRMdzuijUK0Wp5yF2M9WQqM5oXUe7hOag2/kNPpT
         F6GDJbmdFJr+1U3V5/8Rw5noIfCuV4jDUrD2j4AKwt80tLwY2J9lpQPgqlcS+q5OecCw
         cbSsEOaaHeSp1f/MIOjgw7xP/tU1W8WhLC4zJG/KIUQxAOma6P4ABX8uiCPwDO3i8hS7
         5y8w==
X-Gm-Message-State: APjAAAWPlTD0KayQLqNFtxwljZBgtA732ukdBoQiXJ23tEwOHBq+CzOI
        2YtTFvBuzS+bxjdOkButWEM=
X-Google-Smtp-Source: APXvYqxfFSKOktKnv3vmtt02NI4Glrt2ZGULecW1XC3Qlb7S0OUFru0/s3EoZn6Dq3FyICuiEPJwRg==
X-Received: by 2002:a5d:5482:: with SMTP id h2mr11972651wrv.203.1552902051021;
        Mon, 18 Mar 2019 02:40:51 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id s127sm6470912wmf.39.2019.03.18.02.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 02:40:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] unpack-trees: fix oneway_merge accidentally carry over stage index
References: <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
        <20190317060023.3651-1-pclouds@gmail.com>
        <xmqqh8c06dgq.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CdS1oHt__SzgOxnoD=0h=iN51SWm3YjkOwYGkbzb4o9A@mail.gmail.com>
Date:   Mon, 18 Mar 2019 18:40:49 +0900
In-Reply-To: <CACsJy8CdS1oHt__SzgOxnoD=0h=iN51SWm3YjkOwYGkbzb4o9A@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 18 Mar 2019 16:24:40 +0700")
Message-ID: <xmqqh8c0zfj2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> > +     test_cmp_rev :1:a $A_OBJ &&
>> > +     test_cmp_rev :2:a $B_OBJ &&
>> > +     test_cmp_rev :3:a $C_OBJ &&
>> > +     git checkout -f topic &&
>> > +     test_cmp_rev :a $A_OBJ
>>
>> So in short, "checkout -f" should have given us an entry for path
>> "a", taken from the tip of the 'topic' branch, at stage #0 while
>> switching to that branch, but it didn't?  That would be a nice
>> summary to have at the beginning of the log message before going
>> into the implementation detail of how that happens.
>
> OK. And the last line probably should be :0:a to make it clear we're
> looking for stage #0.

I would say ":a" is plenty clear that it is looking for a merged
entry without getting replaced with an overly explicit ":0:a", but
":0:a" would not hurt, either.

