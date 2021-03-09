Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEAEC433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5E16522A
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCIUEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhCIUD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 15:03:59 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5E4C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 12:03:59 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b130so14366292qkc.10
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 12:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/4/IZOqsG7KAfty9aDfqzF6Yv2dh4MJDAlaqOycg9D8=;
        b=KSIw+ghslIJmXt1XY5vtRPRK2I1UAXzYk4tKSwCYdgK3h1nnzm7hBtw861g+ELOPQN
         7TBx2cqZ0XsXFFczKi3+mBB2dkeddlvR93ShD48dqbz0ZjRPfTChZ1QNL/DCUGAgZQ9R
         6kil+Z3ul8GdXhd3Kpx3SA0My2dFTuzp1gKRYTKuZkDhF2Tpfvt20QbYnLLHcblsh6jD
         fW7g7OdvhzaQq6ul2kZtFK7V0FOAx4lyOKfJokI6QzFRRYAUgJoGiQarCVZ7wTbZqXSY
         xE1gqUjc9yl91BDwPP+s4utM3XqwG3mYNHo9guODJrBEXEk87w9NKL3apXCHzOJLMSAb
         oXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/4/IZOqsG7KAfty9aDfqzF6Yv2dh4MJDAlaqOycg9D8=;
        b=rGCEN3rh/nDBj/DWHgdFu56f22uFSd3dJbpK8mDTvEmtCZvlEl9y/c8xGPe2Ql+DY5
         sMQN4vmuAbk/EA54DuBSoy0A9axPpaWbPt/BFHbK5ZWsASy1Xd60DBVhAvG+ZuzrY2zQ
         8Xt6MhgWQfPPz47OhWKlYjyQlwwZIaKt0qtJ7hVJMKsCnM88XQBAVuox8FFZejuhthjc
         3BU+LK3EKJqg6hbRMj3//QRVAnt+g9wY1UslpIEQ0WL5axFG72y2pkvz7QjFjEGpSIW8
         x9CLi7YXq8ZNqNnl1iAa9cZOj8fX4/JhPEXyaGgAwxXP5maluomCRrb//ksKd/kYQPp4
         AdAA==
X-Gm-Message-State: AOAM533yBoUK0A05R69Be6nwWxyP0IZw89Xxzllt2hHc5c+JeVikHi24
        7xH38C914KRX/8O+L2I0Gdo9Vs1dUvI+7A==
X-Google-Smtp-Source: ABdhPJziyy6zWMMydIZAhXHMwSwqeOXYzygcFagnR+ocXZn1M9I5IebpZNgsk3iUjvuLIrrY7ly0Yg==
X-Received: by 2002:a37:a44:: with SMTP id 65mr26558241qkk.479.1615320232618;
        Tue, 09 Mar 2021 12:03:52 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id n140sm1219938qka.124.2021.03.09.12.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 12:03:52 -0800 (PST)
Subject: Re: [PATCH 02/20] t/perf: add performance test for sparse operations
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <a8c6322a3dbe1130dd2026b600a896e86d54a95d.1614111270.git.gitgitgadget@gmail.com>
 <CABPp-BGYP4OdVnUW0t_Veus-bzMPNH97MSNBdyH=e-iuN2b2jw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d49c536a-7ca1-cb6f-9703-d3c6fb9802b4@gmail.com>
Date:   Tue, 9 Mar 2021 15:03:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGYP4OdVnUW0t_Veus-bzMPNH97MSNBdyH=e-iuN2b2jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2021 9:30 PM, Elijah Newren wrote:
> On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> +test_expect_success 'setup repo and indexes' '
> +       git reset --hard HEAD &&
> +       # Remove submodules from the example repo, because our
> +       # duplication of the entire repo creates an unlikly data shape.
> +       git config --file .gitmodules --get-regexp "submodule.*.path" >modules &&
> +       rm -f .gitmodules &&
> +       git add .gitmodules &&
> Why not `git rm [-f] .gitmodules` instead of these two commands?  Is
> there something special about .gitmodules that requires this special
> handling?

No, I'm just being sloppy. Will clean up.

>> +       for module in $(awk "{print \$2}" modules)
>> +       do
>> +               git rm $module || return 1
>> +       done &&
>> +       git add . &&
> What does the `git add .` do?  I don't see any changes there weren't
> already git-add'ed or git-rm'ed.

Same here. Thanks.

-Stolee

