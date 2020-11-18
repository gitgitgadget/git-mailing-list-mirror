Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E23C56201
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5A224248
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzFZIonN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKRSWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRSWu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 13:22:50 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB9C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:22:50 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id l2so2811213qkf.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wS7k4FBdeTBNourCjYXTLouWPSc21H3LaywxEYFP/gI=;
        b=WzFZIonNA+TpMIVVsjajf9LH+EUM+ok0Oj6L6wXvSWP0o3RqhCaRIcoQbHiaB6w1vV
         QTMw9GGdEu5aPGnZqeVc3XNuLDukkunpBkt3u+G5PgNW1CCX9fmmYfJyaCAz4fqIkYU0
         +gvwV60Ntu9aFJSllb5e63uwYMoYN9pH/gj3qxIVBYjU/U8lseM3bxQU1S+q7GNhpOwA
         6U5BQG6wgOf0Z408ILNCii40DENlzqEC35yqPVfGsHcqphywzneC98Jncy3LfeOSdYcj
         HYqh2A+Tvp9Iqrazg6cuJPE65azrSXrpIjvI6ILtJYkPb2cUfKgP/ukO6JhAwGZj63/M
         lUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wS7k4FBdeTBNourCjYXTLouWPSc21H3LaywxEYFP/gI=;
        b=LLuVVX56mvLrOKwnXoKScd/G1uZgd5W1UP6zP2/DDK/R7rm1y2GWZzL0Ppww7ZZ7dc
         GZuTkXwIKwWEysCeDUlnEvAXyT8hwciAuntfOktDoV20EM+8AqMPnw9wyU86FWi/Quh/
         V1B2gDBEvORy72zPomdjvMlGXyFbEGHnsv2+AJ9lqN5Irwn2WNkiWpYwrvOIbY9PHbm7
         zKwR2C1NfQtC3NJlwu2g4sl7Fo2mwcIkPbK0M6zOjM1CwA6soF8XjD+sg57Gg+FXXqAl
         SqVhAu8N5IGcO/Vzz1/XmcJEvdez/mWg1QF/9vGrx63MJt4j1B8Y1/ncyEHG6xOZQ20S
         4pUg==
X-Gm-Message-State: AOAM532/xxxhqu5y+9qeyeyQ3d++D7j2OxszkHnCN3bkIhEN7SURFIhQ
        mfcCCXV4Cg+2lqtLLIC/SsA=
X-Google-Smtp-Source: ABdhPJwzq8mRx1CYGfr2al3GjcbWclT56gvhik+VRtIdyxtwI+HKMNKh7e2Vx59hWPQ/Fx9jgBmYLQ==
X-Received: by 2002:a37:9f14:: with SMTP id i20mr5823834qke.137.1605723769490;
        Wed, 18 Nov 2020 10:22:49 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:805f:b8ae:cbb3:6b01? ([2600:1700:e72:80a0:805f:b8ae:cbb3:6b01])
        by smtp.gmail.com with UTF8SMTPSA id j202sm16649315qke.108.2020.11.18.10.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 10:22:48 -0800 (PST)
Subject: Re: [PATCH v4 3/4] maintenance: use launchctl on macOS
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
 <ed0a0011fb0b06780bc6ce2920f17cad46eccdf9.1605647598.git.gitgitgadget@gmail.com>
 <CAPig+cRQJ9VpRk_0oz4BP3GF7dtsHtE3Qcd=nGsS26=JZvps7g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3dc00733-e736-9483-4a46-372e1560bcc2@gmail.com>
Date:   Wed, 18 Nov 2020 13:22:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRQJ9VpRk_0oz4BP3GF7dtsHtE3Qcd=nGsS26=JZvps7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18/2020 1:45 AM, Eric Sunshine wrote:
> On Tue, Nov 17, 2020 at 4:13 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +static int launchctl_boot_plist(int enable, const char *filename, const char *cmd)
>> +{
>> +       child.no_stderr = 1;
>> +       child.no_stdout = 1;
>> +       if (start_command(&child))
>> +               die(_("failed to start launchctl"));
> 
> Did you have any thoughts on the observation I made in a followup
> response[1] during review of v3 in which I suggested that we might be
> able to avoid suppressing stderr (and stdout) here? In particular, the
> idea was that if, in launchctl_schedule_plist(), we do a simple
> existence check for the .plist file and only call
> launchctl_boot_plist(0,...) to `bootout` the .plist file if it exists,
> then we shouldn't need to muck with stderr/stdout suppression. The
> benefit is that if `bootout` fails for some reason, then the user
> would see the (hopefully) meaningful error message emitted `launchctl
> bootout`.
> 
> The same .plist existence check could be done in
> launchctl_remove_plist() before trying to `bootout` the file.

If the file exists but isn't still registered with launchd, then
the bootout command will send output

"<path>.plist: Could not find specified service"

and return a failure code. This output isn't helpful to users,
since we still are in the desired state afterwards.

> Anyhow, such refinement can be done later is desired, so not worth a
> re-roll, but I was curious about your thoughts on the issue.

This pattern of squashing the output even in the successful case
is important for Windows where schtasks sends a line of output for
each task being registered!

I think it would be a reasonable extension to store the error
message for logging or communicating to the user if we actually
need it, but I don't believe we should be piping the output
directly.

Thanks,
-Stolee
