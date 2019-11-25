Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28C0C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 22:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802F8207FD
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 22:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2xHy5wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfKYWpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:45:40 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:38198 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKYWpk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:40 -0500
Received: by mail-pl1-f175.google.com with SMTP id o8so2816072pls.5
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 14:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VJpN+p9oNlZXGO+b5epjnMfUj8YpCe5bVELA+GcTtXY=;
        b=C2xHy5wmfWAHLQCTqBtTodT+6qtTlmGNAc/PDI0Qc6N/yuCQ2Cdv42+RJA+rdvXEYc
         3g9I56UlYARLACMx6W/QO7qzN7pf5KH8oy3DyIDxI5p7fNmZ805bJAvK7tINegNcdoKe
         TJp2nRx5MlLgorbZ89rbsF00uqHDZpndLmz3NYanvPvpzu1cfLPix+mEQgd6zWrbfq7J
         JR0pmeLwRC7WBsJT43b/ctdsn5dJp4Zpjd4LawKqS8ewR/vjQS81+TMB1iUJUjq5qOzE
         pehIRe9UHzu342FyN7FlZACD7crdt13VNckHxCNaoo6uaMa2DS3k8dACuiueYVaAwqco
         RWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VJpN+p9oNlZXGO+b5epjnMfUj8YpCe5bVELA+GcTtXY=;
        b=ReJd8kv1nt0RqFWiWYFQxY/9iDxQ0MyN90KIvT32WaZs4GON0rVI0YBdHYyzqByz92
         CuLyukzmw6IUPCCa+1Yu2Z2daEXQ6WKCEtpBXgL09+7xudwcynxu3FhRGHCNsb8rmLvU
         xvRGKfeo31+Md6SOMPoGzngGT90OlxC1Qj0lPM616NLgtgra4aCsSYgpowcwTE5lzZZM
         iFgwEyr7yU6Pt6LkmbUhJp7CMaqUBW4aUiQRe18qkQ/NFO7tAJDI3vuYJiL3bcl8tHl5
         113gqP0383mDcVqnukUV15qxxFkJO+kW461/dBLcXUPnVDdyztQY+BoCVDWoUlYmUfaX
         9njQ==
X-Gm-Message-State: APjAAAW55m3Ou4KPtf/xZUZG5ydSKJ8p79itD6mLqD7hu58akRplEPEc
        NohR3jWJBX02MQhvmqqnlkHR8Q==
X-Google-Smtp-Source: APXvYqwQ/3CDXD7eQrUwPh0sXuTzfLADXiWOdJL3/qDVeEkb6IStjVnykiHaavvwg/M2L8vW3VJFyQ==
X-Received: by 2002:a17:902:7205:: with SMTP id ba5mr30188860plb.95.1574721938408;
        Mon, 25 Nov 2019 14:45:38 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b26sm9482553pfo.158.2019.11.25.14.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:45:37 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:45:33 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Hook management via 'git hooks' command
Message-ID: <20191125224533.GB83137@google.com>
References: <20191116011125.GG22855@google.com>
 <20191116054501.GA6538@camp.crustytoothpaste.net>
 <20191118223819.GI22855@google.com>
 <20191119005136.GA6430@camp.crustytoothpaste.net>
 <20191123011924.GC101478@google.com>
 <20191125030445.GB2404748@camp.crustytoothpaste.net>
 <20191125222113.GA83137@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125222113.GA83137@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This sounds like we both are pretty close on the same page, so I think I
> will get started in the coming weeks and see if we can get a mockup to
> pick at with the implementation details in front of us.

Hm. To elaborate (and partially as a reminder to myself) I will try to
get it done in the following order:

1. Implement 'git hook list <hookname>' which reads all the configs.
(User would need to manually add the configs at this stage)

2. (maybe) Implement 'git hook execute <hookname> <arg...>'. This may or
may not be useful; I suppose it would be pretty equivalent to:

 $ git hook list <hookname> | xargs -I% sh % <arg...>

3. Implement config modifiers like 'git hook add', 'git hook edit' etc.

My thinking is that we will have a lot of time with 1. in front of us to
nitpick how we want the config format to look, how the ordering should
go, etc. and it will be a fairly simple implementation. It'll also be
"usable" although not in a particularly friendly way in case someone
wants to try it and see, in a way that the config modifiers by
themselves wouldn't be.

 - Emily
