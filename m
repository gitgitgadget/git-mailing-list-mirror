Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61C4C433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 05:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FD6610EA
	for <git@archiver.kernel.org>; Sun,  2 May 2021 05:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhEBF31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 01:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhEBF30 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 01:29:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12195C06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 22:28:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso1508971pjn.3
        for <git@vger.kernel.org>; Sat, 01 May 2021 22:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r+ENski+uisDvERMp5Kq+2YVxDeIdhQ1CVssDHEyOXs=;
        b=O9e1i9a0sHPADOBoHFtVpASnePf21d9xCFyoBzHBBKvnwftWUU3a3xAjKlkGzLTV/8
         zs2ZdaAYAhWEbT8n785JZuR/iZjijfn1kl750rgpMuaV64A4BYtYS5Zel1Ggbe/ygZ1I
         G8fHpx0Xk572qwtITDmaNv32VzQ7L226HxPK9f9xn1X0iz0oIAm2KS+FDGsv+lG65m/e
         VG8WP/+Aw7hp8q7f8/xq53t0FvUP8skpePmVpDV9DGjudDVq6K3vihF1go6gpDNfOm/D
         fxbQ9+e+F+wNwTDvt+fDCPXm8ZRNK0clZh7tmbfWWBiH7SRxT1CujB3UXf/W+S4HpR9J
         wD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r+ENski+uisDvERMp5Kq+2YVxDeIdhQ1CVssDHEyOXs=;
        b=kt3OCFlcVrqO4hDLbQ6JK1M0bmyviDZC6EW0AH/Z3iIw7BSskXrngKKZc07n/8FbG2
         QuMfFuRdHfkP+8RRup32gJVGu9Wbsu7LjwdAZXoUC7u9yNai1K5V3C3G4Mh8KFS7EzmO
         Bj8S/abRQYx4gKbkP0cIsgNhErAw9PYn5p0Z3IKwJXXS5+i7UUBBodQOT8wmlPEgJqvB
         Zw+2+/lrvdSh9ZqSQ1C7dXRj0BMG4UAfIn+nDbpeDSQQ9fACmW8BZRVFG3RAUytjmphX
         6YZESfeajmU9IoQszHhmmB2RNwL7t3EIKZxE8uzvRtEzHZo2w+hLK8vUJUHa98l1cbwf
         MpBQ==
X-Gm-Message-State: AOAM531+HrxKzO6H5eJs1HE723GqVuwti6sHneeRI5cSN4fZWrZ8OeUL
        8ebw6y3fL1MDzKHSMnWOpg0=
X-Google-Smtp-Source: ABdhPJzMdT7ZR4SHf2X5LJUyFkNi3xdDEFW/TauzLPcfvvlvcvzk0q44o9aw78sfqsoyoXx4XyM5BQ==
X-Received: by 2002:a17:90a:ad09:: with SMTP id r9mr24296162pjq.2.1619933315402;
        Sat, 01 May 2021 22:28:35 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id t192sm218005pfc.56.2021.05.01.22.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 May 2021 22:28:34 -0700 (PDT)
Subject: Re: [PATCH] maintenance: use systemd timers on Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <81e77586-8e9a-44b8-bee6-94ecf1b60d12@gmail.com>
Date:   Sun, 2 May 2021 12:28:31 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210501145220.2082670-1-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/05/21 21.52, Lénaïc Huard wrote:
> The existing mechanism for scheduling background maintenance is done
> through cron. On Linux systems managed by systemd, systemd provides an
> alternative to schedule recurring tasks: systemd timers.
> 
> The main motivations to implement systemd timers in addition to cron
> are:
> * cron is optional and Linux systems running systemd might not have it
>    installed.

Supposed that I have Linux box with systemd and classical cron. Should
systemd timers be preferred over cron?

> * The execution of `crontab -l` can tell us if cron is installed but not
>    if the daemon is actually running.
> * With systemd, each service is run in its own cgroup and its logs are
>    tagged by the service inside journald. With cron, all scheduled tasks
>    are running in the cron daemon cgroup and all the logs of the
>    user-scheduled tasks are pretended to belong to the system cron
>    service.
>    Concretely, a user that doesn’t have access to the system logs won’t
>    have access to the log of its own tasks scheduled by cron whereas he
>    will have access to the log of its own tasks scheduled by systemd
>    timer.
> 
> In order to schedule git maintenance, we need two unit template files:
> * ~/.config/systemd/user/git-maintenance@.service
>    to define the command to be started by systemd and
> * ~/.config/systemd/user/git-maintenance@.timer
>    to define the schedule at which the command should be run.
> 
> Those units are templates that are parametrized by the frequency.
> 
> Based on those templates, 3 timers are started:
> * git-maintenance@hourly.timer
> * git-maintenance@daily.timer
> * git-maintenance@weekly.timer
> 
> The command launched by those three timers are the same than with the
> other scheduling methods:
> 
> git for-each-repo --config=maintenance.repo maintenance run
> --schedule=%i
> 
> with the full path for git to ensure that the version of git launched
> for the scheduled maintenance is the same as the one used to run
> `maintenance start`.
> 
> The timer unit contains `Persistent=true` so that, if the computer is
> powered down when a maintenance task should run, the task will be run
> when the computer is back powered on.
> 
> Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
Nevertheless, because we are dealing with external dependency (systemd), it
should makes sense to enforce this dependency requirement when user choose to use
systemd timers so that users on non-systemd boxes (such as Gentoo with OpenRC)
don't see errors that forcing them to use systemd.

-- 
An old man doll... just what I always wanted! - Clara
