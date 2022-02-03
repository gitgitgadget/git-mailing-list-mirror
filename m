Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332DFC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355167AbiBCVav (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355156AbiBCVas (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:30:48 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB9C06173B
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:30:48 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j16so3351941plx.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mS96rgSRB3csw/bEbiVyetbztF8s7OUTi8xT/Le7o4M=;
        b=SMbGC9SaPAV0IooQ4jx21oXFFbM7iBMzyjfRkjJF1N6EnZfC9z/r3L8XkApiNWcfx6
         O9qeOWmeNOP3OQvOVKoBPIkwmFnQ7dDqkt7c2bZ9pypVXucAHl3TOI1v4xXkMm0Y4KAd
         vPYiJbtJnRfvxuFCVjOoyXlTGoH2RmRMjvSDc1r2TdzacBbg/3Fvm+Cksj2izCfCrmYJ
         3U3HvgVnigO3jrajMk3563oMod0ls+KqpZvBYNGPp8RZ6ZRPg/AN41tzFv7sPG0V2d9l
         qLen571brQ1NkEEwxYp/2debhufn00XD/0aRUhPWDshe++RL8Z5wSIZM7sfGbHcgT53D
         L2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mS96rgSRB3csw/bEbiVyetbztF8s7OUTi8xT/Le7o4M=;
        b=aC3LLYQb+IcAmf9Qg336Xi2ozyZKWLCLV4ZVr5XXtKxuQsERzQFWH4jDc/yxGVx5Y6
         2Ij3zaN2VEi9+tKT33Bnj4bb57/sWi0KeKzI6ZPocYUXhp+ULutE7R4k0KbfwK9zKjLD
         kj0OAg7KitJAnHCkak5V+N6Dx0rqdn/Mdv8g9salXPWkuckNxpM/CkgATQmZBu3zbKft
         tlYSu83mj4uN2MSGN5LHkLEEmYx5N4h0zdANRZeabFC2AxA6SEKvCYSYDu+B8DgYzdbn
         NfET8JJZns7ikUOLVcgYzYBIWJbPFb6hL2jlbgOIcsFID8hS6E0JG+gKVwe3NQN4bgru
         R2oA==
X-Gm-Message-State: AOAM530iowaDzti52qOFoB0NUsgvTcU/+EiGgMM9ntIujz1jfa7x/4KI
        ROqnRmjrqU5gkYxG7tzYaHP7leNSlgk=
X-Google-Smtp-Source: ABdhPJyhmicCzqMObKpjaWKrK+caHZXbQQWuDST1Tskhfby1QBxnJ9Gd10cS/3hzQacwC0zxs8iRiQ==
X-Received: by 2002:a17:90a:c20a:: with SMTP id e10mr15662469pjt.165.1643923848018;
        Thu, 03 Feb 2022 13:30:48 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id d8sm32056654pfv.64.2022.02.03.13.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:30:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v3 00/21] git-p4: Various code tidy-ups
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
        <xmqqr197xi0b.fsf@gitster.g>
        <BL0PR12MB4849847CD8385F0FABD9AE95C8289@BL0PR12MB4849.namprd12.prod.outlook.com>
Date:   Thu, 03 Feb 2022 13:30:47 -0800
In-Reply-To: <BL0PR12MB4849847CD8385F0FABD9AE95C8289@BL0PR12MB4849.namprd12.prod.outlook.com>
        (Joel Holdsworth's message of "Thu, 3 Feb 2022 21:22:22 +0000")
Message-ID: <xmqq8rurskmw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

> At what point will the next branch be merged into master? At the
> point of the next release, or before? I couldn't find any
> information about it.

Each topic that is in 'next' is merged to 'master' individually when
it is ready, so topics A, B, and C may have got merged to 'next' in
this order, but only A and C may be merged while B may stay in
'next' while waiting for necessary follow-on work.

The answer is "'next' is never merged as a whole to 'master'".  From
time to time, the tip of 'next' and 'master' may happen to have the
same tree when all topics merged to 'next' have graduated to
'master' while no new topics become ready for 'next', but that is a
mere coincidence and not a designed part of the workflow.

Perhaps looking for "Note from the maintainer" in the list archive
would find more info, hopefully?

> The SubmittingPatches guide talks about branching off master, and merging the prerequisite topic branches. For this patch-set I will need:
>
>   * jh/p4-spawning-external-commands-cleanup
>   * jh/p4-fix-use-of-process-error-exception
>   * ab/config-based-hooks-2

Correct.  FWIW, I was updating the "What's cooking" report and am
planning to propose merging the first two to 'master' either today
or tomorrow as part of the first batch, and the last one in the next
batch after a few days.

> If I then do "git send-email [...] origin/master" you will get all
> these patches included in my emails. Is this expected? It seems
> undesirable.

You'd use "git format-patch [...] $BASE" where $BASE is the commit
you'll locally create by merging these prerequisite topics to
'master'.

Thanks.
