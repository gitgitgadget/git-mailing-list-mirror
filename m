Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F7BC433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC89650A0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhCET2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCET2X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 14:28:23 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9085C06175F
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 11:28:22 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id d20so3158399qkc.2
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 11:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=discourse.org; s=google;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=FmGT9O8ya8BW7QMm7gCBIGRKjXTNFyYhIqW9gGKy3s8=;
        b=mZz5YlO72GwZbb2pfK+mLzyFrFio2FZUpC9nnD3ekTOFfdOahz6hQ5eQJCkRlJYf0z
         0PzSUSqPHg9B/JqrxcPnANQ7000MvJPaCYcgUy9u9As9PC0PImUD1NEo/TiFcaD3x7RG
         8mkUjy6oOXvQN4WhWFmAO7lQCCtvl/cE+1iSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=FmGT9O8ya8BW7QMm7gCBIGRKjXTNFyYhIqW9gGKy3s8=;
        b=HF4T96nE81ks8lsndAnOHAX7SxrTj5U7Nmpe63xRH+4vmzkw4X/bqnWiU44R/18Fzt
         FeS406Txm4ihoOwBlOgPt1HY2fGtxuknN2vm1KxhgOCsWqxmU3Gx0J67YNJcxwo2kvRG
         VOK18zpc5h3kg43TooqdH4vWPKwZw+qi5gkgeJZpNjExbmFJRw/u6wZ0E9RAuvx0NofL
         CkfWqDmlAzRf8pqWUT1WzKDpqx6XWnRc4XTm2eFdi8KunQ9+9zdrgaWImyjCjBrYDXAu
         IUXL0ErpfALnWtUB/NTu8HMp4eONoSbmwb6yy5HMeoz50QoNnrob+hbueFB2y6/TH/Qg
         QLww==
X-Gm-Message-State: AOAM532k51vg2K1Ze9pLAHtmddOlYFjDcB4moGldFfkkSP+hFxOhIX/C
        R9Toh61eFkzrmqRRL2WHaEhp/L55MiarzlZx
X-Google-Smtp-Source: ABdhPJwdFQjpPs2fNl+mnQyvHhd/iWDDFib2JCvBydfOFAvzgX7Xv3/oVhF2EYNJUmfVqP815cYMSw==
X-Received: by 2002:a37:660e:: with SMTP id a14mr10305639qkc.35.1614972501870;
        Fri, 05 Mar 2021 11:28:21 -0800 (PST)
Received: from [192.168.1.216] (dhcp-24-53-242-66.cable.user.start.ca. [24.53.242.66])
        by smtp.gmail.com with ESMTPSA id z2sm2589431qkg.22.2021.03.05.11.28.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 11:28:21 -0800 (PST)
From:   Michael Brown <michael.brown@discourse.org>
To:     git@vger.kernel.org
Subject: "git diff-files" command reports differences that don't exist
X-Clacks-Overhead:  GNU Terry Pratchett
Message-ID: <4210f5f1-dd7e-f425-6ab2-e220a33e82bf@discourse.org>
Date:   Fri, 5 Mar 2021 14:28:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

1. Be in any existing repository in a clean state (I tested with 2 existing
   repositories and 1 completely fresh)
1. run `git diff-files`, see no output
1. touch an existing file: `touch a`
1. run `git diff-files`

What did you expect to happen? (Expected behavior)

`git diff-files` should show no output

What happened instead? (Actual behavior)

`git diff-files` reported a difference on the touched file.

What's different between what you expected and what actually happened?

git reports a difference where none exists

Anything else you want to add:

This difference vanished after running other commands (e.g. `git diff`).

A complete reproduction using docker is below:

$ docker run -it --rm debian:latest
root@d24ec0793bdf:/# apt update && apt -y install git
…
root@d24ec0793bdf:/# mkdir ~/new-repo
root@d24ec0793bdf:/# cd ~/new-repo
root@d24ec0793bdf:~/new-repo# git init
Initialized empty Git repository in /root/new-repo/.git/
root@d24ec0793bdf:~/new-repo# touch a
root@d24ec0793bdf:~/new-repo# git add a
root@d24ec0793bdf:~/new-repo# git config --global user.email
'user@example.net'
root@d24ec0793bdf:~/new-repo# git config --global user.name 'Example User'
root@d24ec0793bdf:~/new-repo# git commit -m 'initial'
[master (root-commit) 791011f] initial
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a
root@d24ec0793bdf:~/new-repo# git diff-files
root@d24ec0793bdf:~/new-repo# touch a
root@d24ec0793bdf:~/new-repo# git diff-files
:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
0000000000000000000000000000000000000000 M    a
root@d24ec0793bdf:~/new-repo# git diff
root@d24ec0793bdf:~/new-repo# git diff-files
root@d24ec0793bdf:~/new-repo# git --version
git version 2.20.1


[System Info]
git version:
git version 2.30.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.11.1-arch1-1 #1 SMP PREEMPT Tue, 23 Feb 2021 14:05:30
+0000 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/bash

This same behaviour was also found in:

* 2.20.1
* 2.25.1

[Enabled Hooks]
(none)

-- 
Michael Brown
Civilized Discourse Construction Kit, Inc.
https://www.discourse.org/

