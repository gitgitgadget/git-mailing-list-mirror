Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2C7C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4968D64DA1
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 13:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhCANTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 08:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbhCANTO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 08:19:14 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0584C061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 05:18:33 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id b21so11542409pgk.7
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 05:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=DcH+QnSfUtEuDYBjTkctHJx6AUTAnxL16cKkM6KJY9A=;
        b=WCMrbY510crp3MA0UO74Y77uUnIIRljlnD1RL2cFlqqnv/t7QwXETxUQ9dtemMrPFw
         Q2wx3BtNFXu70Ribc7KH8IJ5xWEc+nKY4mD07RdVScZOSgovqoAypMcnHctii16Ud9Zm
         tlV5QR3w6xOjABMirAJ5TFRSza/PBektqqhMltBib7m22+BcgrQXcWwImU9BJIUI3JqC
         iSMmgRDQALNw73cNAbO/9+KcmILFDsolPT+Ml5Evs674DNktWFnZ+5QJiMnK+tt7M67C
         keG4sleCwdwDki0rKtX9LhTAoMX1GtBeJ5NkdYE8L2LA+LjBKIczKMxP99F1RzjWgP9L
         ADig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=DcH+QnSfUtEuDYBjTkctHJx6AUTAnxL16cKkM6KJY9A=;
        b=W3cDB9W3yRGLvN3/NrjdNCdzZQFiHgwg7Hkbwtes85zHEBlLJZIAAM7IB+CXAvN6UB
         WVdGNIp8iGPfho2i1fbFr05XVbaiGNLnkZipszvIhkzLjd9BQnQqN67Qu9D3fg0ULMuW
         VEUr1Oz2Pf+OgCmehSq/6vvhFyDMzgIlLkg9BFK+ht5JYr73a1ZNzv4W/h2NAAGVWyac
         CgLN6acFZoSYlqc5pxg7NLBiOElMPEn/cGaWsiyzIj9zqiCubfixDq5mwmMzxWHQ0JD2
         luMj//q35xnpGrjCLLVtPyM+gjmCn2ziOa9PBtxvhNhv/V3XQm4NthZoWABqBXsyaDQg
         RHoA==
X-Gm-Message-State: AOAM5309yWPETbFrQ/v8PQby5XW8ykAvyG4mSifaQcJ3e44hQK3XQP+C
        eAl4sMbPfNcAftRz2mPqyp8/Xb888P1b6A==
X-Google-Smtp-Source: ABdhPJyD4gd6ymEnY9nRgB4X7u6YqtETz1TJ1hP0zKA4i29K6IMJRj78VDWcLFE/kF+JfNa+IJIukQ==
X-Received: by 2002:a62:b516:0:b029:1ea:34a:a70e with SMTP id y22-20020a62b5160000b02901ea034aa70emr15099104pfe.38.1614604713084;
        Mon, 01 Mar 2021 05:18:33 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-67.three.co.id. [180.214.232.67])
        by smtp.gmail.com with ESMTPSA id x190sm18032028pfx.60.2021.03.01.05.18.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 05:18:32 -0800 (PST)
To:     git@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Argument list too long when fetching many missing objects from
 partial clone
Message-ID: <fd1ba192-b90c-ef20-0843-c0e47925c76a@gmail.com>
Date:   Mon, 1 Mar 2021 20:18:29 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I'm poking around with partial clone. On my local server on my computer
I have full clone of Git (git.git) repo.

I do partial clone from that server as remote (which is actually on the same
computer):

    git clone https://my-local-server.git/myself/git.git --filter=blob:none

Inside the partial clone, I tried to convert it to full clone. First, I gather
list of missing objects:

    git rev-list --objects --all --missing=print | grep -oP '^\?\K\w+' > .git/missing.list

Then I fetched those:

    git fetch origin $(cat .git/missing.list)

What did you expect to happen? (Expected behavior)

All missing objects fetched successfully

What happened instead? (Actual behavior)

Git returned:

     -bash: /opt/git/bin/git: Argument list too long

What's different between what you expected and what actually happened?

(nothing)

Anything else you want to add:

I think the problem lies on how to feed list of 110K+ objects to `git fetch`.

Note: Both the local server and the computer use Git 2.30.1

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.30.1
cpu: x86_64
built from commit: 773e25afc41b1b6533fa9ae2cd825d0b4a697fad
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.11-kernelorg-upstream-generic #1 SMP Fri Jan 29 12:56:19 WIB 2021 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks]
(none)

-- 
An old man doll... just what I always wanted! - Clara
