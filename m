Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE581F404
	for <e@80x24.org>; Tue,  6 Feb 2018 14:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeBFOvC (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 09:51:02 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40951 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeBFOvB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 09:51:01 -0500
Received: by mail-wr0-f193.google.com with SMTP id i56so2217671wra.7
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 06:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=18PE8rmkU+9Uc/R7IvuId83spWyDxmvj2sxEUwoUFQM=;
        b=OKkZK3O8b2I+7Kd6/sds4v3OMoTSq4cHWpGKq2GchffunvF7OQcZe+HqBMoAuQ9l0u
         kb89ZdDNpNGKmG2AZGTXHUEye+uwFNOoj8gd/F91MjfvwBnG7Y5pX4fxYoPGWEykRL/8
         Alzz51+zFZZ1bGtz3GRH2rENTXxvzDZHelTQofMTJ6TL7I6YfMTMHOO6ZGb7XWuSgXRR
         kztidbtGwNUCZoRD3pXmIQ6f5EM+j2ZRFETvM8uvqqCR0+0PhjM3jACQ5nZQFtSY7jQb
         d6XCnzl1FruSkhvmp985AHLhRA4k2UZJXktJfqH9VKZ0X/uO4BNWcC/pkAtSt+yOYCwk
         l7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=18PE8rmkU+9Uc/R7IvuId83spWyDxmvj2sxEUwoUFQM=;
        b=Zc4waytHeqFFQkt3jD9dMd8/TsmsRJvHqS7eQU9RyBkQ3OB2Age/QyNFl4FznWnoHe
         CEtbEdAQwBA1eV494H4H0PAgW6zVX1X140qFAQMkde8OuNqHMBe7kvETGxJ2Bcw9MKmC
         kdQyNSp6+bdfLAE0gWSZVc8kVr28ipOiNENGP7z9YUAhI3PW82WSvspAdJr1AnsfMEcf
         P/Ko6Bly6aMZxaUy9Uy4TV/oLMDzzBnnqN9JIJAoa6qeK8sbvB5hWlxKZJxriq7HMaWd
         dy8/P9ncgYfU0neZ+GeOjZ3FOAigHkySKnPYGWy/Arxrsh0Y9cUzcwnmNvGV3YvJy+Hd
         1FZw==
X-Gm-Message-State: APf1xPC5W5lUKyc+EjDLFME0emNuZm437FsxynN5nS9o5yOjfhQeQac0
        bnjZYqlStEoMrEmCYLTqClk=
X-Google-Smtp-Source: AH8x226txUTMxtF333AWIM8Cr6pAQWGYVUXsR6mv4bSxaYtUL6ZBTP9lTJh+k0x1ERNFiliMjvarWg==
X-Received: by 10.223.156.207 with SMTP id h15mr2271716wre.281.1517928659612;
        Tue, 06 Feb 2018 06:50:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e127sm5921173wmg.10.2018.02.06.06.50.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Feb 2018 06:50:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to the untracked cache
References: <20180205195619.31064-1-benpeart@microsoft.com>
        <20180205215805.GA90084@google.com>
        <6fb43664-7546-7865-0488-8ed6292d77a6@gmail.com>
        <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com>
Date:   Tue, 06 Feb 2018 06:50:57 -0800
In-Reply-To: <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 6 Feb 2018 19:27:07 +0700")
Message-ID: <xmqqbmh2894e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Please don't do that, at least not this way. cache_changed mask should
> reflect all dirty parts in .git/index. If UNTR extension is not marked
> updated, it's legit to just skip generating/writing it down (e.g. if I
> kept the old UNTR extension from the last time I read .git/index
> around in memory)

Excellent point.  Thanks for mentioning this (it crossed my mind
when I responded but I forgot to metion in my message).

