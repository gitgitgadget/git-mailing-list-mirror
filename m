Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3FEC388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5818E24754
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWL9gP79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgJ1WFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbgJ1WFX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:05:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD0FC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:05:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 126so741240lfi.8
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=TIAmcLWk8H4ss5DQQ5ulPRYFJnlkVwrGf2a2YFkAI2s=;
        b=OWL9gP79TeCB7W6DhSkrIj0vE7lWGMxXCb2GU7Uksq/fV5lVvFK4cc9n/qR55ys8Mg
         i2B1Y/vD17AUHgtJ7OWOsi3VC/J/FllxiK1cabL+LBsfLxVyxdTscXKoxmTUCwNU6nL4
         09bnEgyOdNHU6PbmRQhqafWBHJpe8WLZUu1Z6XqRAYSUYsUSwomNwooJC50Q2uNlP8mr
         YsNoQVKJZ/yy+1XSQOW1izaenfH5AN4Uwmi4+fYG3tF2d0k90CDjUTtYUm52f+XOAPJU
         XXRtLgMLvyoba2tk9Z7lto0gCZVw8Cb1aDOgBalcv44a0bJsnLSJ/yaag98ftHKgg0Nr
         xxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=TIAmcLWk8H4ss5DQQ5ulPRYFJnlkVwrGf2a2YFkAI2s=;
        b=fnQZJ8rvAxBb3E3xj1bfLDMlwQEb/EyxBNhsbo+Vpq/+nO8ry21cCCL4dalSi9HF88
         EGg5qHP/1fDvK0PX9CTde8vEjOVdV79fhP9cKCQZ9OUK60dCAxs7YXt30zzJ6Fwngrfr
         rcl4Nb1uajAzm2ifS3fNMV7swI0sBAM2aHcU0QWSsVZnyk/QQ07I45Lpr6FdbtnBzd9o
         HuKzQ/1Qk14WvdmWSK+Soyz1a2MhkjJiPqg3PhhqN9rPhN9qiNJ85PVrdIzZ9aivQueK
         I4FwD4IxxZdcQJy01pJBITFhoVQwTmkZcGfGJMe9RZfipJ9J6iizQqM/ecSyxa46JbMv
         +vBA==
X-Gm-Message-State: AOAM5312fRT71X9cPH7MsPh17gPSWCCZws3zpRwQKbPDaGe/DXQWp1gu
        6k1Ceod4hhBSDRitRmC6INONFNQH/ws=
X-Google-Smtp-Source: ABdhPJyGU8Ejfb0KbUFrjIKT5b+BcvDiQFjLkaRBiQjHSGSmciyQHHSBD4xoMSEETyhZ8FHNIyKzhg==
X-Received: by 2002:a19:4d5:: with SMTP id 204mr461359lfe.104.1603869927234;
        Wed, 28 Oct 2020 00:25:27 -0700 (PDT)
Received: from [192.168.0.100] ([88.223.58.41])
        by smtp.gmail.com with ESMTPSA id m18sm430985lfb.35.2020.10.28.00.25.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 00:25:26 -0700 (PDT)
To:     git@vger.kernel.org
From:   Zaoshi <kabazaoshi@gmail.com>
Subject: git mergetool does not work since 2.29.0
Message-ID: <a284dc99-7da3-a313-6d9b-1dd40cbc5b22@gmail.com>
Date:   Wed, 28 Oct 2020 09:25:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have tried using 'git bugreport' but could not figure out how to edit 
text in the console and send report, so I'm just reusing that form in 
this email. Let me know if any other information is needed.

What did you do before the bug happened?
Ran the following commands:
git checkout mybranch
git merge master
git mergetool

What did you expect to happen?
I expected git to open my configured mergetool

What happened instead?
It fails with message "merge of myfile.cs failed"

What's different between what you expected and what actually happened?
Merge does not work.

Anything else you want to add:
This issue started to happen since git version 2.29.0. Earlier versions 
work as expected.

.gitconfig:
[core]
     editor = \"C:\\Microsoft VS Code\\Code.exe\" --wait
[user]
     name = myname
     email = myemail
[fetch]
     prune = true
[pull]
     rebase = true
[diff]
     tool = bc4
[merge]
     tool = bc4
[difftool "bc4"]
     cmd = \"c:\\Program Files\\Beyond Compare 4\\bcomp.exe\" $LOCAL $REMOTE
     trustExitCode = true
[mergetool "bc4"]
     cmd = \"c:\\Program Files\\Beyond Compare 4\\bcomp.exe\" $LOCAL 
$REMOTE $BASE $MERGED
     trustExitCode = true

[System Info]
git version:
git version 2.29.1.windows.1
cpu: x86_64
built from commit: e6d53c456169235fe72602e2b4d985934fa9ad23
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 10.0 19041
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]


Regards,
Z

