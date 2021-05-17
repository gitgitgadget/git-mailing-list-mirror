Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A38C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 17:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6E860FE7
	for <git@archiver.kernel.org>; Mon, 17 May 2021 17:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhEQRYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 13:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbhEQRYG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 13:24:06 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03790C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 10:22:50 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u11so7192553oiv.1
        for <git@vger.kernel.org>; Mon, 17 May 2021 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YSBV1Wrgu9WpbajQghHaUb0pxMLkAbP0RjfV+b+g9b0=;
        b=nFgLmBxVqG1xuzcmcIGEV8W+YYUXAxqiGRq81w0Nuxkq5cmCDbT6FnLOWQQinGCaZO
         W12yojwn9ox2QoMg+A4Sv3+E2KfV2dYUDT8NqJdjEQ95ECagDSi/mCH87Hu1vTcLa66x
         /mTRuBqDSqxiHB6VvKdO0N3WlbIzDgNytKifthCEPF/dTsetZ51l7vrEPVWghu/9Cl8j
         A0zvZ/u4oTgOz3DGEe+a1RaJCrcb6ED3fhkRpw21f78pWmwyk/yW35sNHOxi6YPsONjD
         mLZZUghA3FtdjTTU09NtsAwzMexwjNC77yyv9dMyBcj94D1pzX6XPTb4ow027VrH1W54
         GERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YSBV1Wrgu9WpbajQghHaUb0pxMLkAbP0RjfV+b+g9b0=;
        b=kYjhph8kxUMj/iAjiGWxS0Nj9NyZLkNK1eaZA5LZXNU70cSjJkZMnpuEcrSNWLzjEL
         FFMeRJbi58USEmPGdx27/w7d3hXmZ6zjRpnl/9lC+vjHntS69HZANcdXSb9gQFFo2jMG
         Pa5kbEp3T+ZJCVHwVVdxG4x9ws3iCMGYLWvbRxPTegxZPyTXxDTgiS+fEY0o9iB7Bu7l
         JNbuWY7BQ8AVNkriuJOY5kycnpBK8tnU6jGqy3wbcmtqS/Ev5e8csX9/p48l9xQFkxIz
         dgtUMiuIJlrmBr0J6claDMS+7xogC4SIq5WFGIEV9N8xkAEyLtB3os4R6S2K4OFcKa40
         4X7g==
X-Gm-Message-State: AOAM533WsJIhpV3BdOvBQ3mFqPUWS2X/wFtCuLq9QTAZiUP+yFkTB/xn
        4KO6PK4lKBDk7v/jA/Ou1Vo=
X-Google-Smtp-Source: ABdhPJx5mP7RFzAS3JNO6A8d/7obQ0EQ1a4JhPUef46TaJkfEw3N7X4E4Jl3TS7/9jFvvqoLF5W5Yw==
X-Received: by 2002:aca:f0c:: with SMTP id 12mr605251oip.131.1621272169432;
        Mon, 17 May 2021 10:22:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:68e5:b0b1:d7d3:e820? ([2600:1700:e72:80a0:68e5:b0b1:d7d3:e820])
        by smtp.gmail.com with ESMTPSA id v1sm1594769ott.62.2021.05.17.10.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 10:22:48 -0700 (PDT)
Subject: Re: [PATCH v5 9/9] dir: introduce readdir_skip_dot_and_dotdot()
 helper
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
 <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
 <b7c6176560bda67e146d0402f927180dace534a2.1620840502.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2b7ba27c-5ffa-0ef0-6c7a-4da45f979b9c@gmail.com>
Date:   Mon, 17 May 2021 13:22:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b7c6176560bda67e146d0402f927180dace534a2.1620840502.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/12/2021 1:28 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Many places in the code were doing
>     while ((d = readdir(dir)) != NULL) {
>         if (is_dot_or_dotdot(d->d_name))
>             continue;
>         ...process d...
>     }
> Introduce a readdir_skip_dot_and_dotdot() helper to make that a one-liner:
>     while ((d = readdir_skip_dot_and_dotdot(dir)) != NULL) {
>         ...process d...
>     }
> 
> This helper particularly simplifies checks for empty directories.
> 
> Also use this helper in read_cached_dir() so that our statistics are
> consistent across platforms.  (In other words, read_cached_dir() should
> have been using is_dot_or_dotdot() and skipping such entries, but did
> not and left it to treat_path() to detect and mark such entries as
> path_none.)

I like the idea of this helper!
  
> +struct dirent *
> +readdir_skip_dot_and_dotdot(DIR *dirp)

nit: This seems like an accidental newline between the
return type and the method name.

Otherwise, patch LGTM.

-Stolee
