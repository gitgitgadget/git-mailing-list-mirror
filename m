Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5943CC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 12:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF14207FD
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 12:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILfFs+ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgA0MIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:08:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34192 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbgA0MIo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 07:08:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so10973959wrr.1
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 04:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KKm2ntr8vc0NVnrNpGi8S+e0iggEoKhfKPuWN682g5s=;
        b=ILfFs+uxutTbgGlY3l+lXgo1kOlMPmog7kDAoqAWPUUSgOz2fkq///8nl+Js7O0ypd
         kbr/9r8r4oKKBNuHsvmEiEvR+LGe15KoPmR7kNuGlZgWbHu8NlfSkmJvewOUTBrClJXx
         8RToCMJM3oQiC8idEDwC60q/xkOQO7NsIsl6XXbMJYFu1dQuOgd5XmPJ5hzB45aEcAeH
         9vwhtFcLE1yCZQkkZJogrOvNF6weKzuLF7MOlS4R+cVK7vhY8aILacVk179lFaEc5vKZ
         w1FB14gGArl5JZ62pi5+O9Se85SJzCcawo0s9BsGCBPZEIgqrcf2BJKiMlOkYV539Tmp
         FdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KKm2ntr8vc0NVnrNpGi8S+e0iggEoKhfKPuWN682g5s=;
        b=fQXUwCrR8EsAvHX0PPOigZMVp2i5lnM4vXW96HgR4niJMF54EwILB2m7/lJqD8p9iF
         hDC1PeCZIzsX35wR0reMFcu+BCX14vSO/9kmcQAkRTAiINfNIc7gZeZlx46/hcTLUPTo
         eMOFhivLh4pgqf/hhE5IByQ9T5YXTpAUsnQOjJEQldEpBEGtLsgyGtxo2It1rzC/7Lq2
         vwb8ftRKjGJT9a39m96isfeikP/5FnK25ion85AqUJi2vASaG18hu+RoazVgK5pxm7KV
         KNYJJWjcAUSH8gyaooLLpia/TQEHR1Os+ZUVKfkhxDnIri+7yVTF0cIIG1XmcbrYUz+M
         yCyg==
X-Gm-Message-State: APjAAAVXiR60LJcQh5/LPTF64U2mWR08idqTr0hSJwtNgMkPSPPx/v6k
        wc5iIZj40AW3pV5X8eQyyXmbegd+
X-Google-Smtp-Source: APXvYqyITdkUdTtafnMnXMz0WXaclCeIkfukdd5ATF5/xHzYfU0ERZHcw0EutZwV/nwcN3pAolAtIQ==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr20911186wrj.261.1580126923261;
        Mon, 27 Jan 2020 04:08:43 -0800 (PST)
Received: from szeder.dev (x4db36537.dyn.telefonica.de. [77.179.101.55])
        by smtp.gmail.com with ESMTPSA id v22sm17949128wml.11.2020.01.27.04.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 04:08:42 -0800 (PST)
Date:   Mon, 27 Jan 2020 13:08:37 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Martin Melka <martin.melka@gmail.com>
Cc:     git@vger.kernel.org, Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: git status --ignored hangs when a deep directory structure
 present in working tree
Message-ID: <20200127120837.GA10482@szeder.dev>
References: <CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 11:55:01AM +0100, Martin Melka wrote:
> Hi all, I have ran across what might be a bug in git. When there is a
> deep directory structure (tried on 100+ nested dirs), then git status
> --ignored hangs indefinitely.
> Discovered this on OSX (Mojave, git 2.20.1 (Apple Git-117)), but it
> reproduces in Ubuntu (19.04, git 2.25.0) Docker container on OSX and
> also on baremetal Ubuntu server (16.04, git 2.17.1).
> 
> Steps to reproduce:
> 
> 1. Generate the deep dir structure:
> 
>     mkdir gittest; pushd gittest; git init; for i in $(seq 1 120); do
> mkdir dir; cd dir; done; touch leaf; popd
> 
> 2. Try to get git status --ignored
> 
>     cd gittest && git status --ignored
> 
> 
> If there is a dir depth limit, git should probably exit with an error
> rather than getting stuck endlessly.

This is interesting, thanks for the report.

There is no such directory depth limit, but the runtime of 'git status
--ignored' grows quickly with the depth of the untracked directory.
Running this shell loop produces the numbers below:

for depth in $(seq 10 30)
do
        dirs=$(for i in $(seq 1 $depth) ; do printf 'dir/' ; done)
        rm -rf dir
        mkdir -p $dirs
        >$dirs/untracked-file
        /usr/bin/time --format="$depth: %e" git status --ignored >/dev/null
done

10: 0.01
11: 0.03
12: 0.05
13: 0.11
14: 0.23
15: 0.47
16: 0.97
17: 1.97
18: 3.88
19: 7.85
20: 16.29
21: 32.92
22: 76.24

Beautifully quadratic, isn't it? :)

Unless I messed up my numbers, with a depth of 120 directories it
would take over 6*10^23 years to complete... so yeah, it does qualify
as indefinitely.

This slowdown was caused by commit df5bcdf83a (dir: recurse into
untracked dirs for ignored files, 2017-05-18), which was part of a
patch series to fix 'git clean -d' deleting untracked directories even
if they contained ignored files.

Cc'ing Samuel, author of that commit, and Elijah, who had quite some
fun with 'dir.c' recently.

