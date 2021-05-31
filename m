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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C176C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601F0610FC
	for <git@archiver.kernel.org>; Mon, 31 May 2021 06:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhEaGhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 02:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaGhv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 02:37:51 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5FCC061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 23:36:11 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v14so7617604pgi.6
        for <git@vger.kernel.org>; Sun, 30 May 2021 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IFnxau0vx53O/7V3iEj4fnrrsk8z0f06/hP+pvPEs0Y=;
        b=lBNooHZua1ofipcHgXprU+iYDpthr4C4OKeNhwKm4anlIQJ1dq4e2AXy6ganJYg0GZ
         Vw9GpCC9btiN5wRqQBxN4fZ60v+tlPuIDeEDpq0Z6t6w7A8pIQjyV3HN2Km7uJysNwcr
         T0R1lNtRhJ2LOkDXHOyrJw4VY1M9WtyHqULnPfHxvofkmYrJAVr8QQF4ZGyx/ZTOsuBK
         Mol3R1eCkHT6v/PSr5r35xjgm3ksWI65SzPMpEKmGzUXrRH5bpgPxrPbacW+bV3G8Rkg
         hjatSl7yctBj+Ju6+JHFPf/bX/Qi2uzjRQ5SuXSeeE4yfzJR4OpqYXaZGm4b7AzT4hu+
         NdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IFnxau0vx53O/7V3iEj4fnrrsk8z0f06/hP+pvPEs0Y=;
        b=Cz0mn5a5wNNcHP/BIq93RvV7csN0T4hqoCoMeEdbvBrfxe1tzsjF0N3Dw8bVxOSolb
         IHBue+YNCNOCvfnS8Xr+t2H4hk4WLSMsfSxWIY6B1XhExJv4ydjbmGUskyw/SM9JyLlS
         iFLjf53DJ+1yJ9+tr/0f8s8rQc9dhvOf3Z3Q298LRLXQ+MUU0BBqttrJkQS94WxgE8h5
         HsQn6wuopt9eFkF7asSB0zQtiFEgNWghAhvR1fCOezhnaj0hT9IsuUQ6d+rBr1+b5DcR
         6ZdPAAvTyRbSSIwLbqe4P67DcpXFcqlMgQetY8ybsVur55LNN7WVL4En1EAttAuGgLmF
         okaw==
X-Gm-Message-State: AOAM531WmM9xCauXn2vlZ1ZH94zbb6w+lJmMmTLnrLKo92laJyYRXi1q
        kvFVz+UaxkYi7CBLLjtlUE6bkoZVdqyxVQ==
X-Google-Smtp-Source: ABdhPJzo3/NksVOk9PkQzK5llpssbWCM5jS+NkmPJpBGF5XWTNfAbdplHzdmSxIBBqk9a1hsd8xJbg==
X-Received: by 2002:a63:8f46:: with SMTP id r6mr18645469pgn.182.1622442970781;
        Sun, 30 May 2021 23:36:10 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-52.three.co.id. [116.206.12.52])
        by smtp.gmail.com with ESMTPSA id 35sm10517235pgq.91.2021.05.30.23.36.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 23:36:10 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: =?UTF-8?Q?Slow_fetch_on_repo_with_tags_per_each_commit_=28=c3=a0_la?=
 =?UTF-8?Q?_Vim=29?=
Message-ID: <f9c1115a-2e17-9d3e-02f5-138eab8048d9@gmail.com>
Date:   Mon, 31 May 2021 13:36:07 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have full clone of Vim repository [1] on my computer. This repo has 
tags for each commit, meaning that when there is a new commit landed on 
default (master) branch, it will be tagged (something close to release 
tags but not same).

While on the other repo, doing git fetch will fetch new commits from the 
remote quickly (the only limit is network bandwidth), on vim repo it 
takes longer.

Examining the trace (run by `GIT_TRACE=1 git fetch`), I got:

> 13:21:50.429633 git.c:447               trace: built-in: git fetch
> 13:21:50.470410 run-command.c:667       trace: run_command: GIT_DIR=.git git remote-https origin https://github.com/vim/vim.git
> 13:21:50.492785 git.c:733               trace: exec: git-remote-https origin https://github.com/vim/vim.git
> 13:21:50.492849 run-command.c:667       trace: run_command: git-remote-https origin https://github.com/vim/vim.git
> remote: Enumerating objects: 137, done.
> remote: Counting objects: 100% (137/137), done.
> remote: Compressing objects: 100% (20/20), done.
> 13:23:31.589963 run-command.c:667       trace: run_command: git index-pack --stdin -v --fix-thin '--keep=fetch-pack 10745 on ubuntu' --pack_header=2,137
> 13:23:31.593505 git.c:447               trace: built-in: git index-pack --stdin -v --fix-thin '--keep=fetch-pack 10745 on ubuntu' --pack_header=2,137
> remote: Total 137 (delta 116), reused 134 (delta 113), pack-reused 0
> Receiving objects: 100% (137/137), 117.44 KiB | 871.00 KiB/s, done.
> Resolving deltas: 100% (116/116), completed with 101 local objects.
> 13:23:32.682368 run-command.c:667       trace: run_command: git rev-list --objects --stdin --not --all --quiet --alternate-refs
> 13:23:32.684986 git.c:447               trace: built-in: git rev-list --objects --stdin --not --all --quiet --alternate-refs
> From https://github.com/vim/vim
>    0b4964848..2fa9384ca  master     -> origin/master
>  * [new tag]             v8.2.2914  -> v8.2.2914
> 13:23:33.239629 run-command.c:667       trace: run_command: GIT_DIR=.git git remote-https origin https://github.com/vim/vim.git
> 13:23:33.241760 git.c:733               trace: exec: git-remote-https origin https://github.com/vim/vim.git
> 13:23:33.241815 run-command.c:667       trace: run_command: git-remote-https origin https://github.com/vim/vim.git
> 13:23:33.251931 run-command.c:667       trace: run_command: git rev-list --objects --stdin --not --all --quiet --alternate-refs
> 13:23:33.540444 run-command.c:667       trace: run_command: git rev-list --objects --stdin --not --all --quiet --alternate-refs
> 13:23:33.542831 git.c:447               trace: built-in: git rev-list --objects --stdin --not --all --quiet --alternate-refs
>  * [new tag]             v8.2.2911  -> v8.2.2911
>  * [new tag]             v8.2.2912  -> v8.2.2912
>  * [new tag]             v8.2.2913  -> v8.2.2913
> 13:23:33.828590 run-command.c:1628      run_processes_parallel: preparing to run up to 1 tasks
> 13:23:33.828702 run-command.c:1660      run_processes_parallel: done
> 13:23:33.829024 run-command.c:667       trace: run_command: git maintenance run --auto --no-quiet
> 13:23:33.831040 git.c:447               trace: built-in: git maintenance run --auto --no-quiet
> 1.80user 1.89system 1:43.54elapsed 3%CPU (0avgtext+0avgdata 25700maxresident)k
> 149520inputs+4552outputs (268major+20701minor)pagefaults 0swaps

git fetch took about 100 seconds to complete, including fetching 3 new 
tags. On the other repo, the same command took around 10-20 seconds, 
depending on how large data that must be downloaded.

Note that Vim repo has 13952 commits and 12284 tags; and for testing 
above I use Git 2.31.1.

Thanks.

[1]: https://github.com/vim/vim

-- 
An old man doll... just what I always wanted! - Clara
