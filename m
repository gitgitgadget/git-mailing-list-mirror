Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC31C2BB1D
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 10:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBEA206F7
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 10:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcsi2qDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgDGK7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:59:12 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36415 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGK7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 06:59:12 -0400
Received: by mail-qv1-f68.google.com with SMTP id z13so1582747qvw.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vj019lvSeROroxTKtDLw2clXMAAS7/iSJYSQa9eqDIQ=;
        b=hcsi2qDCnnzDPwNGHuwN8q4Hb2O4ryUSXMSuNQaJYbDZlqKNNa2gox/Al8gqHPTlVc
         m0VYj/bEv5OQBrL9bgkxtZyv6utC15PwlsiVNsxHLvldxwOJudmgylf8DlZCIc+a7vc3
         Q073Z9nD678bvvLrZQpxzV9nxMNu4Fk/wg6DSloTty8xrofJs5HGnqymqOfPO2TA0cI7
         xkjMzv+qEj8lMXJhBGojHLbxV2dbKQmqrXBeH1T7SCs2CkcYFkDmiAL8su5JGI67teYO
         AQdTOP67uS5OjDxuyHPIVsYM5yeTjcqpuuyBgZ9Towg5aPJ2awyes0mpWelIWcYjJu+h
         UPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vj019lvSeROroxTKtDLw2clXMAAS7/iSJYSQa9eqDIQ=;
        b=kEpQGQm5VmeCIB9hcE3LsvzKa1rsUZP1D+NZMEecgzwEl29VYkiQwadhDi10iB+Qxx
         1dfyuj9qwPqreqj4yS8dhfX9lQodkSZPBsvFuRSf+dS6aCnmufOk2zUrlBUDDPc9Wumq
         MhIAx4mMGV4WjDNj9vMkbjUpyWqKukJ80EesK/pZjr3tOL63Tp++SJ9zUfBk+Rdsg5nq
         WeYbwn+f3ewjcixG+yZSLKFWRqWKbBn2sF1LVmhYGVhmI6Z6jKs7uOnTmgIz47KjYoe6
         6iWWchkECPRXQE/jraF5vJwcfVHWSOgrF+QmpC3jLs2jZ0xGgiiGKsRSz5p1aj9E9qhS
         KwUg==
X-Gm-Message-State: AGi0PuYIpvQsWuQkiSZvwaQk0WkEoT1pSQQIdN2o7z1XWz2GhcJYdejG
        uidIG+9v5eC1ptXerjh8qEM=
X-Google-Smtp-Source: APiQypKHkFc/s3FX/3pWAhYATAOr6+uU/8jGidMjbQPFurG/el+/dqF8XOtSd9Rg5NCwA9VJkuAVDw==
X-Received: by 2002:a0c:a2a2:: with SMTP id g31mr1551617qva.31.1586257151275;
        Tue, 07 Apr 2020 03:59:11 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j85sm16837525qke.20.2020.04.07.03.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 03:59:10 -0700 (PDT)
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
 <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
 <20200407005004.GB2568@danh.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8946b9bc-06c2-3269-0fea-c9ba5b60d0ba@gmail.com>
Date:   Tue, 7 Apr 2020 06:59:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200407005004.GB2568@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/2020 8:50 PM, Danh Doan wrote:
> On 2020-04-03 20:16:21-0400, Derrick Stolee <stolee@gmail.com> wrote:
>> On 4/3/2020 5:40 PM, Junio C Hamano wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>>  * git run-job <job-name>: This builtin will run a single instance of a
>>>>    maintenance job.
>>>>    
>>>>  * git job-runner [--repo=<path>]: This builtin will run an infinite loop
>>>>    that executes git run-job as a subcommand.
>>>
>>> What does this have to do with "git", though?  IOW, why does this
>>> have to be part of Git, so that those who would benefit from having
>>> a mechanism that makes it easy to run regular maintenance tasks but
>>> are not Git users (or those that want to do such maintenance tasks
>>> that are not necessarily tied to "git") must use "git" to do so?
> 
> I also agree with Junio,
> I don't think Git should be responsible to be a scheduler.
> It's the job of either tranditional crontab, at on *nix, or scheduler
> on Windows.
> 
>> That's a reasonable reaction. The short version of my reasoning is that
>> many many people _use_ Git but are not Git experts. While a Git expert
>> could find the right set of commands to run and at what frequency to
>> keep their repo clean, most users do not want to spend time learning
>> these commands. It's also worth our time as contributors to select what
> 
> And now, people will need to learn _both_ Git existing maintainance
> command, and new scheduler (Do I understand it right?, I haven't go
> through all patches)

The point is that they would not need to learn the existing commands.
They could accept the community's "best practices" by running the
simple command to start background maintenance.

In an "enterprise" environment, the users would not even need to learn
the command in the first place, because the engineering tools team
could configure the maintenance tools using the necessary setup scripts
to built the repo.

> Yes, it could be a setup it once and forget, but,
> if there's a problem with their local repo, they will scratch
> their head to understand what wrong with them.
> 
> It's easier to destroy their repo, and it's harder to know what
> operation is running in their computer.

That's why we need to be careful. Luckily, these steps have been
tested in the wild for over a year with great success (as part of
VFS for Git).

Thanks,
-Stolee

