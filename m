Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D8C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 13:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbhK2Nqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 08:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbhK2No3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 08:44:29 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19E3C09CE40
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 04:25:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x6so70949809edr.5
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 04:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fGz43Wq0/uigNe8DuF6ZjjQwpqZay8Y/ryc9M28sdD0=;
        b=PwhL/PCpAWrbO9KKdg47owYdW3d0drBA9dqplWvDUJH3bXf+tZyaobhBXyOyYKpwpb
         jehAtOnC4AdCfRFs/R41htrmL1WN0IKJm3QyMZ5iZ7ghMpcDOG1Ii0MibkIsrEmweNT3
         xY/gaFPa0pSOSKJ28kTyGaDwp9LCO1TRfyeVQNPCAKKL36oDrL3n41/lKHLlfuCb3pN5
         56aO9c/GBPrDfWUnH6Hf15IjOB+h2btIqEHWSHJtruB+dsDFPj42C9BM8nvIrrchFEwf
         iI/4LCE5eGk8ec5bJdIXS6OBz4TY22+3YR/syO6VlSWjnzSOF/yHcyBaa+BdBjRMi0ep
         2vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fGz43Wq0/uigNe8DuF6ZjjQwpqZay8Y/ryc9M28sdD0=;
        b=Re1/QyUFwJI770fOoh8u+h8QoWr6CRE2rgPsfYlyqComEYUnmUdnnyru1/rxjBvkds
         gDOE83vABBpIF1icbbHIMn2JyKc4bakWoJAvOPvCwx4eK0Evz+dATRNs2PPvPeecAgfE
         K0kRqmVUiQX3LGuio2ehBuh4s48Keq9M9rFwI9CTqdjNdxlngAMPe9VSs++Jk8lHKv3S
         eXusKaggrFRYD/tK08VVON4NbLtt67ZRxH74SBJLsle722AKLX71uJOONaO3ieH6GWOA
         09TSZulPrDapPjH8xCwdBYPbbkKbK1RxS6YECnHofuXi3YLcgHimsVmBm81SyI/leEnG
         qk+g==
X-Gm-Message-State: AOAM532Buot4/Mwvp3lMq4Q6MrDR4jzxFnh6I1cxj4SAftnG6clrsC9n
        HmZeK9m0qC0nkQjgBxeWXlqJenm1CrE=
X-Google-Smtp-Source: ABdhPJwl2Tl+471Hc0AzgZVmOtQaOtkSCwJo1ZJdBd3ulZJS0Y+iFGrKLC8gXOeHKp9/doCBZX3EKA==
X-Received: by 2002:a17:906:dc90:: with SMTP id cs16mr59228534ejc.432.1638188728313;
        Mon, 29 Nov 2021 04:25:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dp16sm8161142ejc.34.2021.11.29.04.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 04:25:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mrfio-000hz5-SF;
        Mon, 29 Nov 2021 13:25:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Nikita Bobko <nikitabobko@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG REPORT] `git rebase --exec` shouldn't run the exec command
 when there is nothing to rebase
Date:   Mon, 29 Nov 2021 13:07:46 +0100
References: <CAMJzOtyw78-8gt3oGscN7KUzpzRRWtAQuGfcJ+R_Fjoom9Lexw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAMJzOtyw78-8gt3oGscN7KUzpzRRWtAQuGfcJ+R_Fjoom9Lexw@mail.gmail.com>
Message-ID: <211129.868rx7gnd5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 26 2021, Nikita Bobko wrote:

> Steps:
> git rebase HEAD --exec "echo foo"
>
> EXPECTED: since 0 commits are going to be rebased then I expect "foo"
> NOT to be printed
> ACTUAL:   "foo" is printed

I don't think this is a bug, but explicitly desired behavior. When you
do:

    git rebase -x 'make test' BASE

You expect to run 'make test' for all of BASE..HEAD inclusive of
"base". E.g. for HEAD~1 we'll run 'make test' twice, and you know both
your HEAD~ and HEAD passed tests.

So why wouldn't doing the same for HEAD make sense?

That being said perhaps some users would think an option or
configuration to skip the injection of "exec" after "noop" would make
sense in that case.

But does this really have anything per-se to do with --exec? Wouldn't
such an option/configuration be the same as rebase in general dying if
there's no work to do?

And wouldn't such a thing be more useful than a narrow change to make
--exec a NOOP in these cases?

E.g. if I've got a "topic" that has commit "A", that's since been
integrated into my upstream and I have a script to "make test" on my
topics, won't simply dying (and thus indicating that the topic is
dead/integrated) be better than noop-ing?
