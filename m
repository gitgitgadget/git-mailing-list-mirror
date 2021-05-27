Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5C3C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4A56101B
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhE0RIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 13:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbhE0RID (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 13:08:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DD5C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:06:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g7so1689151edm.4
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=o1sE/SufcfmEUheJy6DVXh8uMQWsgQnUxuaKcRqRAmw=;
        b=cqx3i4p8ZlaiTdB8BQMFxt0x6HxbJe0uGq+4LgzXP12FaOGVUKcf2o1iQKbas/Te8o
         wHtzky5TD359zct0CORZkqNvqCiy2VKMmBdVAAtDRsJn0/fwUvgo3wZHa4XrT9P8Q7YB
         WP9cHXkNPgeWQdEZ88njCvaBqAxonFi3CXRHiTuWZ6G+sXIzyV33s2svHuqSWpAvxzLH
         a+Iwez2iUoxBS7zBFsngvYS8xrUBYcS7kKAisTz66xa0LMXpAMUAoDLJWFWsZ4flTUIk
         oYWBdtjmh4PHxZYA/AuNfB4JyGyCW58dgRMvr7ohqyPtMpExqnf37FzFVxpnGfGvkh3i
         N0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=o1sE/SufcfmEUheJy6DVXh8uMQWsgQnUxuaKcRqRAmw=;
        b=cH/DX1MbP1A08jMZiFWF0EvmTkPpOuQj9m5pY9Gj81yhZ8oDIDfQa5oynfnYMHFmzn
         mP8zghUtCT9mZVOO/9Bo6yC7l9tXPcetGTi4N/b88s4McpbFC2yyM6CE5497QstTbLtX
         lVjJruvW+FNJBF6d1qNhzjTW+zDYkhOkUDUHMdxSAZ+w0mD9AqCNHfJh/gkwAj+J/J3z
         oRO3MJIdTTrei6UCtvcQB+SFVZY58ys1jjCdCb9VPxhFNqTcBMYHoZVeCH7Gs8ZGjuuj
         GD/Mgez3owNmWSozqkO1OK1aKe4FyFcgwioNnFCyqWTbfbx1uc8iJnyAwZWNOfvmyXl+
         sZTA==
X-Gm-Message-State: AOAM530aWT1VxNRgdhI7At9dkVrWnQToJu2JYOf3u0aBIxYXh1SbZzbv
        131jTnP8yN+lHN5aaGT663BSA6xq4y4=
X-Google-Smtp-Source: ABdhPJzopqZdTxoNNs4XEpa9iOGMWxk5dnfoDzzXzboHMUovtiPklP0oGkAENUW4P5Wrxlpzwff6ww==
X-Received: by 2002:a05:6402:35d4:: with SMTP id z20mr5287177edc.164.1622135187277;
        Thu, 27 May 2021 10:06:27 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e002:8cf0:b0b8:f178:ae9f:6d19? (2a02-8388-e002-8cf0-b0b8-f178-ae9f-6d19.cable.dynamic.v6.surfer.at. [2a02:8388:e002:8cf0:b0b8:f178:ae9f:6d19])
        by smtp.googlemail.com with ESMTPSA id fe20sm981592ejc.108.2021.05.27.10.06.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 10:06:26 -0700 (PDT)
To:     git@vger.kernel.org
From:   Mathias Kunter <mathiaskunter@gmail.com>
Subject: git push doesn't use local branch name as default
Message-ID: <065528bf-b496-83d3-767d-2a78e50a9edf@gmail.com>
Date:   Thu, 27 May 2021 19:06:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

at https://git-scm.com/docs/git-push#_description it says:

> When neither the command-line nor the configuration specify what to
> push, the default behavior is used, which corresponds to the simple
> value for push.default: the current branch is pushed to the
> corresponding upstream branch, but as a safety measure, the push is
> aborted if the upstream branch does not have the same name as the local
> one.

However, on a branch which does *not* have an upstream branch 
configured, the command

> git push <remote_name>

doesn't use the local branch name as default, but fails with an error 
instead:

> fatal: The current branch master has no upstream branch.
> To push the current branch and set the remote as upstream, use
> 
> git push --set-upstream <remote_name> master

Note that it *does* work if the remote branch name is explicitly specified:

> git push <remote_name> <branch_name>

But shouldn't this also work without having to explicitly specify the 
remote branch name, and default to the local branch name instead?


[System Info]
git version:
git version 2.31.1.windows.1
cpu: x86_64
built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19042
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
