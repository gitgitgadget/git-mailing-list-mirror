Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F25C6FD1D
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 14:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCNOvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCNOvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 10:51:04 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F63A2C29
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 07:51:02 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g6so6491494iov.13
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678805461;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4M9UlmlmvU0BgAHKsMYrfqJmo05VcLtL2JCYhmbOZk=;
        b=ffOXWv7IQDMCmmjuQQ/zxhQtV0GUuaRG5sr503XUo7wmlg1636mdCD59XEC4Uo7YZX
         LVeFlMUKhXX4nkhincjFAfrXi8IwInfm351p1OwuWCcxTWcgQdQcnggucCVxvBhHJ7EK
         L7Ll9UnXX21Q+jblcnLRTrNmx/2XdDG6v94KStup68vgb+x3VZrkLSvlb+P85SHqEMvf
         My1kkl08+5HfQyOjVHWUBsHnAXJ9whnmJ3+mNM2UuRtmT+kaMQEZl6NAWnc/UhWC9FPv
         5TsMFo5yg/lrfgn5cU+SrnI5HiXjemsRJrtXg2V7y8BnhVenJ0bRnOu9G21L3EFML22b
         J1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678805461;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y4M9UlmlmvU0BgAHKsMYrfqJmo05VcLtL2JCYhmbOZk=;
        b=4NKvgLXQcK4ahCbK6Ho5jLexYGE4tihkKg0sE3D5MKe8SURSATaWqFVdAtv5i6A+6E
         GfcHOmnKf9CD0gSoK08CrU9sYE1I1bCxZVLgT7flT98fzc04D8kdBKBrE1dpHxATT8LA
         sUhzJzwLpUuXpeSBeJ3CIAxBozj39HqCYjwvrygHIs+WasWKUxPZ3wfnl6xdPN2ASi9k
         atdWje1qnG1/6o2hL1nJXgssktY176GYKrjHyi2Cz3ZolaCl80aDB0bv+4y6/Oyzg4NG
         2kYqDeRz95ul7WoT3f05r7K1xsx//vcHCNSRxzzKyL2yHm+NhjHifRQz7DL2Q+tZYM8Q
         XrVQ==
X-Gm-Message-State: AO0yUKVTD+o8Gd4GVLtSog563zYIGooGC77Qa5htG0HBiU/FOmF56FbF
        PSah0kUsBR+zWypKlqa6EpczXHLLODy2pA==
X-Google-Smtp-Source: AK7set8hrM0CteIhsl0cquYE6EusNnPLpG69hS17dimQS1VycD5qc8XGN8Yn4MVdDHn4aoHCZW6ESg==
X-Received: by 2002:a5d:9297:0:b0:74c:99e8:7f44 with SMTP id s23-20020a5d9297000000b0074c99e87f44mr7654787iom.2.1678805461212;
        Tue, 14 Mar 2023 07:51:01 -0700 (PDT)
Received: from epic96565.epic.com (pat-verona-h.epic.com. [199.204.56.213])
        by smtp.gmail.com with ESMTPSA id i21-20020a02b695000000b003ab21c8fa84sm821223jam.121.2023.03.14.07.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 07:51:00 -0700 (PDT)
References: <e28a23e8eb044d26947462b8619e88bd@xiaomi.com>
User-agent: mu4e 1.9.22; emacs 28.2
From:   Sean Allred <allred.sean@gmail.com>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5aec5rWp5ZOy?= <jianghaozhe1@xiaomi.com>
Subject: Re: Git fetch slow on local repository with 600k refs
Date:   Tue, 14 Mar 2023 09:29:31 -0500
In-reply-to: <e28a23e8eb044d26947462b8619e88bd@xiaomi.com>
Message-ID: <m0wn3jxu7g.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


=E7=A8=8B=E6=B4=8B <chengyang@xiaomi.com> writes:

> We're holding a Gerrit server cluster. And uses pull-replication
> plugin to sync changes between master and slave.
>
> When a change is pushed to master, it notify the slave, and slave
> fetch it from master.
>
> But we found in a big repository with 600k refs. Fetch takes 5-10
> seconds even if fetching a 1 byte change. Here is the GIT_TRACE2_PERF
>
> I did an experiment to fetch a ref that my slave already have. And we
> can find git rev-list takes 2 seconds to perform. (I guess it try to
> find remote object from reachable objects of local refs one by one)
>
> Is there anyway to optimize such situation?

Do you need all those refs as refs -- or are you just looking to keep
the commits?

We found a rather clever solution for the latter we're looking to
upstream at some point to collect all refs into a single 'archive' ref
that collects commits in fake merge commits (there's no actual conflict
resolution happening -- we just use the same tree over and over). We
make each commit message look like show-ref output. For example:

A single ref (refs/archive) pointing to commit (A), with contents

    tree <some arbitrary tree>
    parent <B> [... 500 other commits 'merged' in ...]
    author <system user>
    committer <system user>

    deadbeef0123456788... refs/tags/very/old/release-1
    deadbeef0123456789... refs/tags/very/old/release-2

When we want to pull a ref out of the archive, we have a process in
place to do so. This keeps the total number of refs down and the
fetch/push performance within acceptable limits.

--
Sean Allred
