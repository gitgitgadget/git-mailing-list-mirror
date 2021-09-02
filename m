Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55295C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B82A60525
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345325AbhIBNub (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbhIBNua (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:50:30 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53395C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:49:32 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id s16so1125590qvt.13
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i2Yci7gIfVnbfYEuj1pYAO1QBBxW/6Ty1umMXR/BLlQ=;
        b=kAPLqyIB1+/TCTi7zlu+EoE7vI1GRRBkcLjNG+1l1QTvJsIN/Ng/ujC0Gm+L4xpAOr
         0OC2OszDp7oKrxm1+OOJsVidsDNENxaJSL2U3NfssVUFsYu24tAguvmFWJnngqqa1Xl7
         kSjOoHhU1X+mdFhQp2fbwOz2TSpgjqEwnJFzg4NWstB60SJryvOLnGBWN+ToTXAKdiT6
         30VtOAmrqvR5zYHhEMHI/IZOFVo1jhnniWueZjUnYSJqpAnyG2q+YxYOkjNkicMLZvWX
         jNNLlXjFuw5T6NGWICKKjkduYTl+BdBb3A9BKf9axjUQV9wLaOMi+qOc2PP3bEzATW6l
         ftOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i2Yci7gIfVnbfYEuj1pYAO1QBBxW/6Ty1umMXR/BLlQ=;
        b=TZo36LQBn7njyr2CqjDTreGiKphJh0Yk3wheSxh7iihNJlvbCDMpVRAxRKpk8FNNiv
         SjVwntpWUNZBQm69Y71XdXzZT3oijZnK01GHYMM9dPzVgv487gP1etu4khG8k7MBFttD
         meD3MqzDHLTH3yyuUB/UkEoX5XLRGaIB5PPUMDSyPewuc+Q1qPJ/IsI2g6dPqfdqTIgZ
         UBaledV11rJx7JNwc6RTKKFd5q/JWPD9/2V5YuiPEAZ1EZYIverYY/LCT3bfP4v5Rkd0
         js+IyD0r2+lKo2BvBxqDU81/JC2eR0GXwNyiz0PGZBDzrFzKbKHjjFkubuP73Hx2401P
         XHrQ==
X-Gm-Message-State: AOAM531tOCGLprxbNheCTlBLY0X/Hn3DqCK731VHhCxGl9eKTTPgXM0d
        fieAsVxOSyOZuGvDkQs6n2Q=
X-Google-Smtp-Source: ABdhPJy3zb+C8U1szPSckXUYXDGKsz8BvnmpL5z6QK/aAE2ClCFUKHgbj5ZDlbZ/LMCJwFnpm6U7OA==
X-Received: by 2002:a0c:e983:: with SMTP id z3mr3063933qvn.1.1630590571473;
        Thu, 02 Sep 2021 06:49:31 -0700 (PDT)
Received: from [192.168.66.137] ([142.46.68.231])
        by smtp.gmail.com with ESMTPSA id m5sm1453591qkn.33.2021.09.02.06.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:49:30 -0700 (PDT)
Subject: Weird interaction between Git protocol versions and git:// and
 https:// URLs (was: Re: Bug with Git shallow clones and submodules)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     Kevin Phillips <thefriendlycoder@gmail.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <CANNNLMC_XEqjYPOig+pbqrS30dPCTmcDSev6yg+5EEBkJCaaig@mail.gmail.com>
 <1a98c659-e7db-50a6-faf3-b3b4c15df679@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Message-ID: <542a68a5-d439-921e-2691-bb8890584f27@gmail.com>
Date:   Thu, 2 Sep 2021 09:49:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1a98c659-e7db-50a6-faf3-b3b4c15df679@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

Le 2021-08-15 à 10:31, Philippe Blain a écrit :

> 5. It falls back to fetching the needed commit by its hash:
> 
>      start git fetch origin 78bc27846101e481438a98c68cac47e4476085c0
> 
> 6. The server at https://dpdk.org/git/dpdk-stable refuses this request and you get
> 
>      error: Server does not allow request for unadvertised object 78bc27846101e481438a98c68cac47e4476085c0
> 
> OK so why does the server refuses the request ? If you take a look at [4], you will
> understand that it's probably because the configs 'uploadpack.allowReachableSHA1InWant'
> and 'uploadpack.allowAnySHA1InWant' are both false (i.e. their default value) on the
> https://dpdk.org/git/dpdk-stable server. So the behaviour here is not a bug, it's
> working as it should (but leads to a bad experience for you).
> 
> What is not unfortunately not mentioned in the documentation at [4]
> is that the two configs that I mention above only apply if version 0 of the Git transfer
> protocol is in effect. So this would mean that even though we specify '-c protocol.version=2'
> in the 'git clone' command in my script, the server uses protocol v0. Protocol v2 works
> starting in Git 2.18, so let's check what version is running at dpdk.org:
> 
> $ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote https://dpdk.org/git/dpdk-stable 2>&1 | grep agent
> packet:          git< 6ee0521feb765d9105241a3f6693762c471655cf HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed no-done symref=HEAD:refs/heads/default agent=git/2.20.1
> 
> OK, it's running Git 2.20.1. And the list of capabilities above implies that it's responding
> with protocol v0, even if my local Git version if 2.29, which defaults to protocol v2. If
> it were responding with protocol v2, we would see:
> 
> $ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote https://github.com/git/git 2>&1 | grep agent
> packet:          git< agent=git/github-g78b452413e8b  # server version
> packet:          git< agent=git/github-g78b452413e8b
> packet:          git> agent=git/2.29.2  # client version
> packet:          git< agent=git/2.29.2
> 
> And grepping for "version" would confirm it:
> 
> $ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote https://github.com/git/git 2>&1 | grep version
> packet:          git< version 2
> packet:          git< version 2
> 
> I can't explain why the server refuses to talk with protocol v2. Maybe Jonathan (CC-ed),
> who worked on the implementation of protocol v2, would be able to explain that.

I'm sorry to bump this, but I would really like to understand what is going on here.
I'm not familiar at all with the protocol code, but my understanding was that after
Git 2.18, if a client requested protocol v2, the server would answer with v2 (at least
for git:// and http[s]://, and also for ssh:// if AcceptEnv is correctly configured).
Here, Git 2.20.1 at https://dpdk.org/git/dpdk-stable answers with v0 for https://,
but with v2 for git:// !

> 
> And it gets weirder. If you instead use the Git URL (instead of the HTTPS URL)
> for the dpdk-stable submodule [2], then the server responds with protocol v2!
> 
> $ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote git://dpdk.org/dpdk-stable 2>&1 | grep agent
> packet:          git< agent=git/2.20.1
> packet:          git> agent=git/2.29.2
> $ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote git://dpdk.org/dpdk-stable 2>&1 | grep version
> packet:          git> git-upload-pack /dpdk-stable\0host=dpdk.org\0\0version=2\0
> packet:          git< version 2
> 
> And indeed, if you use the 'git://' URL in the 'git submodule add' command in my reproducer
> script, it succeeds !
> 
> It don't understand this behaviour either.
> 
--- snip ---
> 
> P.S. for Jonathan I noticed some additional weirdness while debugging this:
> Some servers respond with a different Git version depending on the protocol:
> 
> $ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote  git://gcc.gnu.org/git/gcc.git 2>&1 | grep -E 'agent|version '
> packet:          git< version 2
> packet:          git< agent=git/2.26.2
> packet:          git> agent=git/2.29.2
> $ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote  https://gcc.gnu.org/git/gcc.git 2>&1 | grep agent -E 'agent|version '
> packet:          git< 882f1d58bfa56737ff2de84c3cd1e0acfc318b86 HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed no-done symref=HEAD:refs/heads/master agent=git/2.27.0
> 
> Here again, with HTTPS we fall back to protocol v0. The same behaviour happens
> with git://sourceware.org/git/binutils-gdb.git...

This is also puzzling to me...

Thanks,

Philippe.
