Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567AD1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 00:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeKCJr5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 05:47:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40194 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbeKCJr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 05:47:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so3612548wre.7
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 17:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W6DuLrLxGro8TjeM1cHjt3Nc5MZ5RTr+QBVMQCPviL8=;
        b=THS/jA9mQwPWlQqF31847KtHEpAv/EqqTgCFywTVL5s5SfSRKxoaanCOewM3yz+Wwu
         0fyQEI6m3RqMyvEH5gCBpal25xoGVPawBtkLzP//LTQO+ZjbUGf/3K3uNTvQ3sATEvmL
         LVs02z3eB6XPDVl2vdaBfc49eut5N3wn8ZtfN3RzYRckPj54mmv1Tp9jgsK7YhTbt2Kg
         KucLnvEb4lmgJRZWQb9vochAXX6xFNRDjKUamydzBeNrTUGwEqI8t6ORhK38smncB0Bq
         K+eqIK5sm/spotcMLoO3j3hBQoUmCIAw6HJ//ueb7smflwuQTY/5csVRlbO4EyKxKXAi
         zK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W6DuLrLxGro8TjeM1cHjt3Nc5MZ5RTr+QBVMQCPviL8=;
        b=kbYD1kgEBXEZKF6xoRT9WezS5i3KQ+b+X6RP5FvIDh4gwJP48+5AdVXT/WkBU36vlK
         U9fAO5LMiM6bAFdziq9Vm+Zbwt4xqE9MID8c7QKBayIQyXfPGmZ8fNy1INkuz8exQuYv
         987iX+8qNVhNh6fEC8qD3rqDoA96GWudXCIZQHYTdtP1ogSB4tn7jYruEfHO+Ovo56Ub
         stt/vsCwFNHoGYJqUJkhewHaEv+aN/BMGdo/8cZw9NWVAgKc50iubqy7EuVlEvbjz3MV
         WTp8ZCCqSvU25uXHHHeuSbhGnjWP3FPA5HyXrUWlLIUKL33MJuc1YZD0YYZswHMfa4T1
         X2tg==
X-Gm-Message-State: AGRZ1gJvr0oIROzvpcxtXLzKPvGs7+WbtAkLSw7NjyStQybWVOuQWMEB
        drPDJFKnarguzT1n+7qDCN8=
X-Google-Smtp-Source: AJdET5flF7FHAlx4E0TRXcz+uVZqKgFsqjAQeaodFbvcKC9aB01Itb4MD18pTRCZiliVvFM4k8BQgQ==
X-Received: by 2002:adf:a78a:: with SMTP id j10-v6mr4616558wrc.286.1541205512040;
        Fri, 02 Nov 2018 17:38:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g16-v6sm7396433wrr.38.2018.11.02.17.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 17:38:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1] add: speed up cmd_add() by utilizing read_cache_preload()
References: <20181102133050.10756-1-peartben@gmail.com>
        <CACsJy8CVPSe8TWYMrK9MiRCaG36qyWfd42cEPo5844XWuTmqew@mail.gmail.com>
Date:   Sat, 03 Nov 2018 09:38:29 +0900
In-Reply-To: <CACsJy8CVPSe8TWYMrK9MiRCaG36qyWfd42cEPo5844XWuTmqew@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 2 Nov 2018 16:49:59 +0100")
Message-ID: <xmqqmuqrngfu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Nov 2, 2018 at 2:32 PM Ben Peart <peartben@gmail.com> wrote:
>>
>> From: Ben Peart <benpeart@microsoft.com>
>>
>> During an "add", a call is made to run_diff_files() which calls
>> check_remove() for each index-entry.  The preload_index() code distributes
>> some of the costs across multiple threads.
>
> Instead of doing this site by site. How about we make read_cache()
> always do multithread preload?

I suspect that it would be a huge performance killer. 

Many codepaths do not even want to know if the working tree files
have been modified, even though they need to know what's in the
index.  Think "git commit-tree", "git diff --cached", etc.


