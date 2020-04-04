Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE9EC43331
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 00:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EE1206F6
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 00:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umDLmSGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDDAQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 20:16:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46393 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgDDAQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 20:16:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id q204so7748999oia.13
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 17:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bXRgUTYankw7s7YNj4UvYbIQYlEKZ5IsuW39+dPBSVU=;
        b=umDLmSGVnxH7WW4DmrV8Fd6Z3Ha5/1UKLCu4Y4Sk8a9dLCIwAOs/QBuy9mIseLyW+6
         ORvmeH4heqK/XELoPEPEJVfJoVXLYwX5x+RVh2xaRDXe9REEr3y7TOk9uiLhyrF91ouD
         Of9a8Vh8duRnAQWsmkUIfNQMCruG94CxssKcMsKdouJc3twH+uwPyseibD+k+/JtceIV
         goE9DElAMSlY3uqyyMKluRrrlpeOIFzj810kTlpNQ7mhvpZQjLnUFc0CuRMY9oMxUli5
         5Tsj5bmLEQu6oIBDK8M0ifEmnwoXgi3DghwZGGQPTJjVlROypelkc6WRF8elmXmxEvfR
         kIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bXRgUTYankw7s7YNj4UvYbIQYlEKZ5IsuW39+dPBSVU=;
        b=eP87QeyyIcCDiXxJ0XAVePQ/3bcy8isPaAD9hrteT8iZYGQdVAzptMfV5pgfycB/dO
         rWcDu2BVzKjQjp7mdvFgDhjbpXYZBfkXC9eFLLCSz/oUqPi7c+CAhiUVCjY9AgEI28VO
         WLbr40phrRwxEvehfCwHgftG8cfOQc5pR89cLwFoKoif/Q5YqeZXygMnkcIpIwzz8XPq
         qcz7g9IVAFa7AbF5aLMiW03uMPjKnY0dXpSer4ICvZkeW0GY2JOV3d5jfvzVAztPb4Il
         ImoVhLpJqcKYF1+RdWMnj8cL7yVcjYy8p9MqsPlcp1sWApPH1GfxEugHxUzHPeVtHCdM
         EA7w==
X-Gm-Message-State: AGi0PubFwhS4qS9jmDY/uZ2ssUrCBfawJl6D/IOpe7j16m0SaoTkaLAL
        2eyExR0Q8Ac4BiOF+RMV+uI=
X-Google-Smtp-Source: APiQypLgC6LPhAKWZ+ZRoRtadGQeNmY6RcAEc1ZSmgT3+Gd0GUZFSVKwVytSQFIGf6+Lh0So8FHlmg==
X-Received: by 2002:aca:5d8a:: with SMTP id r132mr5217331oib.129.1585959384838;
        Fri, 03 Apr 2020 17:16:24 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t184sm2583093oie.47.2020.04.03.17.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 17:16:24 -0700 (PDT)
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
Date:   Fri, 3 Apr 2020 20:16:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/3/2020 5:40 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  * git run-job <job-name>: This builtin will run a single instance of a
>>    maintenance job.
>>    
>>  * git job-runner [--repo=<path>]: This builtin will run an infinite loop
>>    that executes git run-job as a subcommand.
> 
> What does this have to do with "git", though?  IOW, why does this
> have to be part of Git, so that those who would benefit from having
> a mechanism that makes it easy to run regular maintenance tasks but
> are not Git users (or those that want to do such maintenance tasks
> that are not necessarily tied to "git") must use "git" to do so?
> 
> I'll find out later why it is so after reading thru 15 patches
> myself, so no need to give a quick answer to the above; it was just
> my knee-jerk reaction.

That's a reasonable reaction. The short version of my reasoning is that
many many people _use_ Git but are not Git experts. While a Git expert
could find the right set of commands to run and at what frequency to
keep their repo clean, most users do not want to spend time learning
these commands. It's also worth our time as contributors to select what
a good set of non-intrusive maintenance tasks could be, and make them
easily accessible to users.

This series gets us half of the way there: a user interested in doing
background maintenance could figure out how to launch "git run-job" on
a schedule for their platform, or to launch "git job-runner" at start-
up. That's a lot simpler than learning how the commit-graph,
multi-pack-index, prune-packed, pack-objects, and fetch builtins work
with the complicated sets of arguments.

The second half would be to create a command such as

	git please-run-maintenance-on-this-repo

that initializes the background jobs and enables them on the repo they
are using. This allows the most casual of Git user to work efficiently
on very large repositories.

Sometimes it is hard to remember that people use Git because it is an
important tool for getting their work done. Time waiting for Git to do
a slow operation or being blocked on a triggered "git gc --auto" is
time they would rather be doing what they want to do. Background
maintenance is a way to reduce the time users spend blocked on Git and
increase their productivity on the more important things.

Of course, I'm biased to using very large repositories where the
existing maintenance process is insufficient. The design of these jobs
is taken directly from what we designed and built for VFS for Git and
Scalar over the winter of 2018-2019. These jobs were incredibly effective
in cleaning up repositories that were accumulating cruft for over a year
without any maintenance. Those repos have stayed clean and we haven't
found more maintenance tasks to be necesary.

I still believe that there are plenty of repos of similar size to the
Linux kernel that are in frequent use and could benefit from these
operations.

Thanks,
-Stolee
