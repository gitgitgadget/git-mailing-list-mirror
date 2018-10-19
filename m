Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679761F453
	for <e@80x24.org>; Fri, 19 Oct 2018 05:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJSN3b (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 09:29:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55411 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbeJSN3b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 09:29:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so2329957wmb.5
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 22:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uJO3kJZIkUgnyOVnBJmYRjtw/An20G9f7T7ZaWVaZRU=;
        b=Evs/CBAM0OkrETZKU34JsBw7UYvvmOHQUpvo5P1YDwBdSiD0r7I+w+4UMGyD3aIHoP
         5WZX/EtKYFRYfATnjxUi3IY6oDTPB2TYiq3RAXU2PTI7zuZMfOC+a5J/FGlKCKg8UXtw
         2hQFRMy1uFXECbCRDBKq12ABoYzIcInYkktG9vt5Om8CWHazLtC955vPQypTYSL74Uuu
         ZPe1pIaVU6UcPj5AVHuREtxjkd/vnD31gH4mAX3JHTSiR8BbIwD29TgAV4Dvlmohs+4c
         iuUa0o1CwhsM/qPnzOyFfZc/HrYVfUkDGDezn4cNAgu6YJY6lFRA1yBwf/7xEICo4skd
         tgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uJO3kJZIkUgnyOVnBJmYRjtw/An20G9f7T7ZaWVaZRU=;
        b=qf796VH008SsAbPsR2VhI55ra5aQ23Wm6V2WrQDlVjb7FmPz9q9CPWLbbNBc4vE+Jx
         z3ykWhLqXzhgmIRsj7/jm+oFSaAi5lQAsUdmJz/GtKZPEW5bdyUsAyGX5WTQgeK3jce3
         jJDZqbdvpcrRhmNqTuHaXHOLfKg4AXYLoDOS7VTGkrsCY3XmkJOC0QA9sgYNlq7Rz1Jz
         aJorsO5PWUFDHTBFdbvmC78iD7bJRPMEXFNJQBFv1fNG8SbFiWBwook285mpplWgRdoP
         Heq1dDWoDDhsEf78BEBU6bD0Ngs/HfW451XKvwmMEyA9JHLXJpV1Vw+iiaNYHOGfVPMz
         kSYw==
X-Gm-Message-State: ABuFfojNYRito4mL9y0k/d1fov7XjwkOZzST/yWk/hhji4nxoytic71B
        tmiS0eJhJzO+fyybMJPMleI=
X-Google-Smtp-Source: ACcGV60R1tsnKEcIBEvKSnFHtE9VieC6icmRS2QM2CiSu1ROp8nKH/GZ1hfowEzjzE1DwiszM6Pt4g==
X-Received: by 2002:a1c:9816:: with SMTP id a22-v6mr3143894wme.13.1539926700445;
        Thu, 18 Oct 2018 22:25:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h78-v6sm2643717wmd.4.2018.10.18.22.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 22:24:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit-reach: fix first-parent heuristic
References: <pull.51.git.gitgitgadget@gmail.com>
        <53ebceb7f11d1e1ea39ae4ca86850190ae839eff.1539883476.git.gitgitgadget@gmail.com>
Date:   Fri, 19 Oct 2018 14:24:58 +0900
In-Reply-To: <53ebceb7f11d1e1ea39ae4ca86850190ae839eff.1539883476.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 18 Oct 2018
        10:24:40 -0700 (PDT)")
Message-ID: <xmqqd0s61pat.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> We can also re-run the performance tests from commit 4fbcca4e
> "commit-reach: make can_all_from_reach... linear".
>
> Performance was measured on the Linux repository using
> 'test-tool reach can_all_from_reach'. The input included rows seeded by
> tag values. The "small" case included X-rows as v4.[0-9]* and Y-rows as
> v3.[0-9]*. This mimics a (very large) fetch that says "I have all major
> v3 releases and want all major v4 releases." The "large" case included
> X-rows as "v4.*" and Y-rows as "v3.*". This adds all release-candidate
> tags to the set, which does not greatly increase the number of objects
> that are considered, but does increase the number of 'from' commits,
> demonstrating the quadratic nature of the previous code.

These micro-benchmarks are interesting, but we should also remember
to describe the impact of the bug being fixed in the larger picture.
What end-user visible operations are affected?  Computing merge-base?
Finding if a push fast-forwards?  Something else?
