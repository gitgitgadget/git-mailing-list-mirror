Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD83C433E6
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22C464E25
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhBVT3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:29:04 -0500
Received: from mx.kolabnow.com ([95.128.36.40]:29136 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233204AbhBVT03 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 14:26:29 -0500
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2021 14:26:27 EST
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id CF656403FC;
        Mon, 22 Feb 2021 20:14:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1614021265; x=1615835666; bh=sSSVXOhHv3oDrRfxyoh
        w+sOU60r7NJPvbfxa8ke0Z1M=; b=VHeHuSQZjr3DvKwiolIoPWGoVDO6GWazpKB
        ckrDf0c3kKuhENxNrIVbIyVOwaP74pdGhrQhYTpic0vCJ3B42Fvyc4oIfCtW5LSO
        IdBOkp325eqyJLwsxXowQHY9C7OKUA0m/RAVPslZHqVdFmZOwrnGTsWnZxNcQ6ng
        F7XHlP5rPeId4Ta4SIUVvL7waDQjt5spnubCQdsSXA8HvbZTLggvYhDwKjBQ+0hx
        LwwmCiEyuAcux1GFWhQN5jjulJYrMmpFcx/ExoqdxAM7CksFKF87qOJ7R13lLvfd
        6I7GGXHFvte+yGXvgBvEjaL3XxMhsR1ch7GlrkYu/96t+nC1pphLUXWbiMY91a9a
        /kEtzQNdfxkJ4UCmZCMFLSsa7fsQvvSidrK7FCD4X5bx5ca492JFcQUw+m1fYuq6
        Yn433s2V3lqYHUUMaTQeBtJZ8J2bK0l/njV11Ytk26BOCCxBxj4w0oO5FPOkZnO5
        4fB/vHYbyj1qeav0ln1tO4q2HOFrr5Oh0HB7ZHUF5l857eL1fDGILX1QYbBLT9Ff
        CgngvY/kdG6DXNM+LGV9jncyL07pc/kn/ypbJlfYvipLzHA5+V7UeuGIvnsaKfAb
        RPqx5NkTUytjwSPgXQP4RsrL/53hFLyjkhP3Nc/eTw9ZuzVnc9x9JONdn1GnGPqv
        SjXjoNIk=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vQLrQ6-Tg6eq; Mon, 22 Feb 2021 20:14:25 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id BA12C40475;
        Mon, 22 Feb 2021 20:14:24 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id B1328166A;
        Mon, 22 Feb 2021 20:14:18 +0100 (CET)
Subject: Re: [PATCH] commit-graph: avoid leaking topo_levels slab in
 write_commit_graph()
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <ajrhunt@google.com>
References: <pull.881.git.1613765590412.gitgitgadget@gmail.com>
 <xmqqa6rz9zrx.fsf@gitster.g> <6ef5487b-905d-8f34-a53c-d1138f5528d9@gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <dfc713c2-c5f6-6c7f-230b-810da0e39ebf@ahunt.org>
Date:   Mon, 22 Feb 2021 20:14:15 +0100
MIME-Version: 1.0
In-Reply-To: <6ef5487b-905d-8f34-a53c-d1138f5528d9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/02/2021 15:15, Derrick Stolee wrote:
> This change looks like a sane change to me. It definitely fixes a leak.
> The leak "wasn't hurting anybody" because write_commit_graph() is only
> called at most once per process, and the process closes itself out
> shortly after. Still, it's good to have good memory hygiene here.

Good to know - thank you! As I become more familiar with git, I'm 
beginning to realise that most leaks are unlikely to be much importance 
(even though I personally err on the side of fixing any and all issues).


One thing I forgot to mention: in this specific case the leak was 
causing a build failure when trying to build git's fuzzers within 
oss-fuzz locally*. Specifically the following command would fail (see 
also fuzz failure reproduction instructions which describe the setup [1]).

  $ python infra/helper.py build_fuzzers --sanitizer address git

As far as I can tell the issue is that: a copy of git built with ASAN is 
used to produce the fuzzing corpus as part of the git-specific build 
script [2] - the leak warning causes the script to fail. (It's possible 
to argue that the build script should disable ASAN's leak checking when 
running git, via detect_leaks=0 to reduce the risk of such breakage - I 
may try to suggest such a change to oss-fuzz.)

ATB,
   Andrzej


* Given that oss-fuzz is building via docker, I would intuitively 
suspect that the same issue occurs in automation - I'm not sure how to 
verify this myself.

[1] 
https://google.github.io/oss-fuzz/advanced-topics/reproducing/#building-using-docker
[2] 
https://github.com/google/oss-fuzz/blob/1b0115eefd70491376cf3cb6f88e49632c78ee18/projects/git/build.sh#L37
