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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1990C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF2E61154
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhGQPct (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhGQPcr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 11:32:47 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C9C06175F
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:29:50 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 23so11952214qke.0
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CBpXPxxfr5Mik9zj9iBU6nOfjuE/quD+wJdGsXquolY=;
        b=LOGvYEcUGWOmkejX3pRS+790EDnrECJFRvnYbuCWGFq2Mc9jk5PVbiONBPyato3kcw
         dyiXYV5/K8sAGxYCaq9alzS1q9wdeCqWfWeHagW6JAZZEAWWs4X5p/o1NBQDFtSFu6Va
         JMEt80ZXIACgaUybVKCq3j8ro9A1Yi6u4GXvxKrp5TPRyRxqVt/zRKFzrchvoR2oOg0w
         osQSO+RrVKkx5HgqjP7d0icrNMKMaMH2MrgvE1RbtGGH6oq/Xfwkdq7zePeyPBzxdklk
         UAo0KCdxYxRoPyV9G+O5wamCE7LRCUQbx8caPwq1Iy2euSjQmv/pHctxf65lL116kmC5
         bHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CBpXPxxfr5Mik9zj9iBU6nOfjuE/quD+wJdGsXquolY=;
        b=pudQu66bqXLNwhkhg99UGXqEr78xDBjoA7zGLfa37qBbxuEZPkgbT04Tryp2tQSlxG
         kv6XUJ+2FaHGK8DpVMJ2XmjDDsx0sD9lG1B26q64enBcIw1amkmaGSNYhNU3kRDgExdG
         ezgA91G+I+TJN1DmPvAJE67UJtl1T2NCEty8r4TJz8KQqcnxAgLt4KaZZvbQ+yKEvUx4
         sUufm84/Tmwsn2DGkAYOZUPHHdC8cK2eYMvKyPWzEJSOzd6t5/58NXLe1LA6XgeLS5YX
         +sxXulkSAm0dXVRAn6rPOvXef8gqH93EdX/Ppb3yw4fkFwwVBhrHOslGmp1z1ijg8VN2
         04fA==
X-Gm-Message-State: AOAM5321msJm25w27XdPZRvNzVVqaft+IKzcaIVKrbjFo0azoZDOvxMs
        wmKKvdLcRcLkLXTzFgY9raU=
X-Google-Smtp-Source: ABdhPJxEuXZKm7UszLVGSub9pZULZf+DW3Jt5hWFn4fQCKOQ9rNjybgbqYqQ+XwYefOlpdBxlqp0Jw==
X-Received: by 2002:ae9:e10e:: with SMTP id g14mr15852043qkm.207.1626535789677;
        Sat, 17 Jul 2021 08:29:49 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 5sm5679544qkr.100.2021.07.17.08.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 08:29:49 -0700 (PDT)
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Regression in 'git pull --rebase --autostash' since v2.32.0
Message-ID: <a0071549-73f6-9636-9279-3f01143a05de@gmail.com>
Date:   Sat, 17 Jul 2021 11:29:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

Your recent clean-up of 'git pull --autostash' seems to unfortunately have made things
worse if the pull brings new files that conflict with existing untracked files,
which makes the pull abort,
and there are tracked files with modifications (so --autostash comes into play).

Before your change, 'git pull --no-rebase --autostash' did *not* apply the autostash
after the pull failed, thus loosing modifications to tracked files (and it did not save the
stash entry !). 'git pull --rebase --autostash' correctly applied the autostash, but ended with
a strange "error: could not detach HEAD".

After your change, both 'git pull --no-rebase --autostash' and 'git pull --rebase --autostash'
have the same buggy behaviour: they do not apply the autostash and do not save it in the stash list.

I had already documented the old behaviour at [1]. Here, I copy my reproducer script
(save it as "script"):

~~~bash
#!/bin/sh

# usage: ./script <'git pull' arguments>

set -x

rm -rf test
rm -rf clone

# Create origin repo
git init test
(
cd test
date>>file
git add file
git commit -m "add file"
)
# Clone
git clone test clone
# Create new file in origin
(
cd test
date>>other
git add other
git commit -m "add other"
)
# Create the same file in clone (untracked)
(
cd clone
date>>other
# If testing '--autostash', add some modifications to 'file'
if [[ "$@" =~ "--autostash" ]]; then
   date>>file
fi
# status before pull
git status
# Try to pull
git pull "$@"
# status after pull
git status
# see if the stash was saved
git stash list
)
~~~


Here are the buggy results :

** ./script --no-rebase --autostash **

~~~
+ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
	modified:   file

Untracked files:
   (use "git add <file>..." to include in what will be committed)
	other

no changes added to commit (use "git add" and/or "git commit -a")
+ git pull --no-rebase --autostash
remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), 283 bytes | 94.00 KiB/s, done.
 From /Users/Philippe/Code/GIT-devel/BUGS/ggg-759-pull-autotash-untracked/test
    4ebab2f..fc7a169  master     -> origin/master
Updating 4ebab2f..fc7a169
Created autostash: cfd51b5
error: The following untracked working tree files would be overwritten by merge:
	other
Please move or remove them before you merge.
Aborting
+ git status
On branch master
Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded.
   (use "git pull" to update your local branch)

Untracked files:
   (use "git add <file>..." to include in what will be committed)
	other

nothing added to commit but untracked files present (use "git add" to track)
+ git stash list
# empty!
~~~

** ./script --rebase --autostash **

~~~
+ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
	modified:   file

Untracked files:
   (use "git add <file>..." to include in what will be committed)
	other

no changes added to commit (use "git add" and/or "git commit -a")
+ git pull --rebase --autostash
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 2 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (2/2), 223 bytes | 13.00 KiB/s, done.
 From /Users/Philippe/Code/GIT-devel/BUGS/ggg-759-pull-autotash-untracked/test
    1aa91d4..4f8c34c  master     -> origin/master
Updating 1aa91d4..4f8c34c
Created autostash: d5dffd9
error: The following untracked working tree files would be overwritten by merge:
	other
Please move or remove them before you merge.
Aborting
+ git status
On branch master
Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded.
   (use "git pull" to update your local branch)

Untracked files:
   (use "git add <file>..." to include in what will be committed)
	other

nothing added to commit but untracked files present (use "git add" to track)
+ git stash list
# empty!
~~~

Reverting 221ec24e9b (Merge branch 'fc/pull-cleanups', 2021-07-08) brings
back the old behaviour (which is still buggy for --no-rebase).

I noticed (by reading the code and checking)
that the autostash is not completely lost, it's still pointed to by the MERGE_AUTOSTASH
special ref, but this is ref is not documented (it's just mentioned without a
clear definition).

Cheers,
Philippe.


[1] https://github.com/gitgitgadget/git/issues/759
