Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937BDC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577C4613A9
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhDZPYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhDZPYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 11:24:07 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BEFC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 08:23:24 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id d25so19271191oij.5
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kLNjjnWe0FI0IZJOTsbTJketOS76H+wMIPosWmldSqg=;
        b=e/5eF9DnWZeOtbkpCJR2rt+3+rWkgqVta5oCZ350qTGAn8NwtRFbGTex1ac8kUaqS0
         aCNUUqr3kPU5+1iPj7s5epODUuYmS7VBElvuSFYBzUpmZTumtANn1pWlpmqMasFR/XKF
         JWdw0aKhjCk1e6b46HVdDQvf2Dx3cQKNTFeorYhPz0Gk7AWBqaduzF/iRQsuLOLOTZe7
         1ydymMmegIsF/RDBQDFkCIEdC21SG2PQUXUk7vDNgJpG//JAjNc2iwJGozwLk5sZ3vk0
         aG79CnzSN0mseNWk5bS2yyashjHYS3wyLBl//hCYPinG40moTXvatxhHQCXYtTOOZobf
         kIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kLNjjnWe0FI0IZJOTsbTJketOS76H+wMIPosWmldSqg=;
        b=mOraamgVL5mvwXeaWe3Si0SJDNGF1QEXV2ltsUcvDn9SRQ7D6Zu3JlL2Svezdw6YjJ
         mEYYH5h8gPFMr2CoQK92KAApGbOWHbjpdgvrqheDw94jKa4kk79QFj9fByHTEkZsSsPR
         2jWAbNT8o8icO8naf8RYpyaq0YerRyi0ttNBTVfmFZ/w/LpzohEaXQXp1YpJ9JPDWNaQ
         3/6t8ZwUej4OAk+eJI3FOKRaNP6FssFV+Hte7VoNqFUgi+Fa6KFjiqv7gGnCZvxRLZ9H
         x6xrn15gBiSh33YpjrWh5gqvhYCWWq7u7MYMA6eM9kZRWx8GYw5ObPGOAwUD/jgb4B0s
         0mpA==
X-Gm-Message-State: AOAM533nPlOhsq1c5hG2wTw1fqU3AByGEoZXcZN5F8CjF6RNCS1rVUvw
        NguG7YcA8Z/CH82MwgeDl3w=
X-Google-Smtp-Source: ABdhPJzo1BuJBZsIwqE6ka7zVkqb5WNhOg6LvN4Q17HMfaOh3y93j9uSCM1pr2/EKkP/nNmf9AaZBQ==
X-Received: by 2002:a05:6808:f08:: with SMTP id m8mr13751382oiw.27.1619450603870;
        Mon, 26 Apr 2021 08:23:23 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:adc0:7fde:95f:205f])
        by smtp.gmail.com with ESMTPSA id f21sm235267otp.52.2021.04.26.08.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 08:23:23 -0700 (PDT)
Subject: Re: [PATCH 07/23] fsmonitor-fs-listen-win32: stub in backend for
 Windows
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <27f47dfbd9cf1103fcc5ffff9da6239c1a441987.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <36e7dfeb-e833-ec11-f1b9-a596d560b35e@gmail.com>
Date:   Mon, 26 Apr 2021 11:23:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <27f47dfbd9cf1103fcc5ffff9da6239c1a441987.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:

> +# If your platform supports an built-in fsmonitor backend, set
> +# FSMONITOR_DAEMON_BACKEND to the name of the corresponding
> +# `compat/fsmonitor/fsmonitor-fs-listen-<name>.c` that implements the
> +# `fsmonitor_fs_listen__*()` routines.
I found this to be a little confusing, specifically that you
care about the "<name>" part of the filename, not the full file
name. Here is an option:

# If your platform supports an built-in fsmonitor backend, set
# FSMONITOR_DAEMON_BACKEND to "<name>", corresponding to the file
# `compat/fsmonitor/fsmonitor-fs-listen-<name>.c` that implements the
# `fsmonitor_fs_listen__*()` routines.

Everything else looks pretty standard. Good to create stubs this
way so they can be consumed by a platform-agnostic caller and then
implemented with that context.

Thanks,
-Stolee
