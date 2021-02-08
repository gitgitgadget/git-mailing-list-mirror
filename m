Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BAFC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 13:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B3A64E0B
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 13:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhBHNd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 08:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBHNdx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 08:33:53 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30256C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 05:33:13 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id g46so3434825ooi.9
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 05:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xsx+2SYuLFD1sckTvNX/VKzNmwbq9li96MyWQEPRoaw=;
        b=cXTDtnuXJBcsHRiGy1WM2m21yC6u5Xe7G19cpDAZarzs5v2gzl1w6uFlP2QP+hgxIj
         /Ile5fvHe8NITyW4iWCQPmZ5T9sJIjanu9EI97VzgxO7p3ZcuQYUx0OnsOhd09eozokQ
         A6Mabx5BY/9KEDLsRVfA3bhG2ivhQpOAVs6uPRR6sp8HufZ6JZ3RhvQaSOXYLuP963ID
         fdpahEfX2Pa3kvP7Ejnz6J58t1TEbLMZgD0fc8uPC6pQTkbFPRlCukeMsPzAFODLRj5c
         7mkJs7pB5Gg3m93s9277+43KKN3fUn1fwYjMHpXAGPCDGkncRKfjSewd3qJFouJiGGpP
         YJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xsx+2SYuLFD1sckTvNX/VKzNmwbq9li96MyWQEPRoaw=;
        b=rvKT4CBLr4l7xbW87YCAORNWK+IuST/gECCDOT9QkglhRJ6pdNOvZsS1Ksb9ujrarw
         v0PDauvSuv79xY4wvZ9qmGH/4FZxTfxnwDAYX4hwPJIBlQYv1kiZWonMUY3X4C+lUN0P
         7e65EXr+PXNk5Hc9NmaRHBiVdctawmiI0vb1W1ddcRjgH1XTNLELb9ceq2QY6tEyYTYb
         +4RcmMZygw468dca6Bn1QWby0Dsua7xlJnwu11nr9d5HapMnzk8Gfn6q9ZG9sMHEdZaP
         y0YlNOmCxjl4RklV/5ELNgQ3LjZghtHlNHrMOEX3paI2b7j3IEB0+3q+z/py6hUoBeC6
         6DUg==
X-Gm-Message-State: AOAM533SeXnSgMZ9lCGUMpu4Nln+SyJskzrmPrU/BizVo8O9noWqGjZm
        X84fnpRc8Ho/VindQzzlo30=
X-Google-Smtp-Source: ABdhPJz9aUxZ85b2rr+KyTQVfK3SAgze+6YOeDBERRxJZYIK4zALDJUXqgC0P6B8lDLoRSPxNTrp1w==
X-Received: by 2002:a4a:2f56:: with SMTP id p83mr3150189oop.56.1612791192542;
        Mon, 08 Feb 2021 05:33:12 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b91a:dd2f:a591:6ed1? ([2600:1700:e72:80a0:b91a:dd2f:a591:6ed1])
        by smtp.gmail.com with UTF8SMTPSA id 3sm628825oid.27.2021.02.08.05.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 05:33:11 -0800 (PST)
Message-ID: <a6228e5f-0552-f4e1-b064-df3bea217f06@gmail.com>
Date:   Mon, 8 Feb 2021 08:33:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 0/2] builtin/clone.c: add --no-shallow option
Content-Language: en-US
To:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        dscho <johannes.schindelin@gmx.de>,
        Li Linchao <lilinchao@oschina.cn>
References: <pull.865.git.1612409491842.gitgitgadget@gmail.com>
 <pull.865.v2.git.1612773119.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.865.v2.git.1612773119.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/2021 3:31 AM, Li Linchao via GitGitGadget wrote:
> Range-diff vs v1:
> 
>  1:  594323684af0 = 1:  2f9602495eb5 builtin/clone.c: add --no-shallow option
>  -:  ------------ > 2:  cfcfc3ec6b37 builtin/clone.c: add --reject-shallow option

You should rewrite your history to make this one commit again. You can
do this by running 'git rebase -i HEAD~2' then editing the todo file
to 'squash' the second commit in to the first. You will be prompted to
edit the combined commit message, and you should preserve only the message
from the second commit.

Thanks,
-Stolee

