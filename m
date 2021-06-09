Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89EBC48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89270613B6
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 14:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhFIO4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFIO4y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 10:56:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B0CC061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 07:54:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f2so25789134wri.11
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UjjPsI8gKwfjWGXNDUSg1cfuDv7ehy6xMyjCgr86CvU=;
        b=JKrqhSlvagQ6QtYbXUrLPWJpWJSKtJo4PDpIq/SwnpXCBzPGQllYxgU+9GldCtcH/l
         t2znIFNHkn7h94DTIgDvmkGTTTlxvzF4BirSHeFAgo0B2ecpbaneS8k+0GXuvSGzJeqI
         kX5T8Va5e9cE9PtESYLoDPeBN0H4pBaeDx8BbyYF913zhRwm5rypLaUlSRmsIzT/gFd7
         PysevQzoP6nu4x3Jri7V+78Xv47Zr6xtjE9hbJtr06iOmKxIVg8rjf4VqKwUJ24QbitT
         IRHAJTl3lb/DVkMnsiln2SDU5N6C72wcgRkiA3FP9V7pAAbE6XGh7Peyn4rNkzI5uo1o
         KAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UjjPsI8gKwfjWGXNDUSg1cfuDv7ehy6xMyjCgr86CvU=;
        b=EOeICULaJdqWKhBqNCLc67esAIcXVsxPVEHgCibp+m6yb8sMCSwhILUbnVFK0yeaCl
         38LN5rXES7MuJSbMhe4FrYRNoeRjwbmm3jbViPFUvJkwT/rtEPi9jCPRAncS4Q+Z75TK
         B7ugM+qv5XR/WP8qnIGRKrYGgqVCYf3JdC3vpM/ACVCkV55gD9gxSAbRWQlSPZzP2+h7
         KMDLkbT0wzKPA62me7Y3Me9Ao8BNw/eDIXrgORDPTtmlu1EvzfD6M3emOinsKzIcqbek
         B7Rh83I14ps4w7txAeuiD9HFX/Ke1AM6QI5hWJBarRn0aPm+v+GZfG0JFZ5AFLdWZHUF
         zI6A==
X-Gm-Message-State: AOAM530rEMWOnPcRdERZuR+lJijXzDT08c7gqD+brKGmyqvwVmpRtxXW
        FZOs34wZXerNwtOtbFMn7A4KUqlfObM=
X-Google-Smtp-Source: ABdhPJzu7Fk7DVn3VSdxJB3si+2hNMBCWUrItBYjTylDHJbACejoi27vsAabahrAmgy2BPiRetueuw==
X-Received: by 2002:a05:6000:1862:: with SMTP id d2mr240797wri.186.1623250482605;
        Wed, 09 Jun 2021 07:54:42 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id v7sm206075wrf.82.2021.06.09.07.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:54:42 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/3] add support for systemd timers on Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210608134000.663398-1-lenaic@lhuard.fr>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <01774318-93c3-d3e9-6303-7f375008a9b8@gmail.com>
Date:   Wed, 9 Jun 2021 15:54:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608134000.663398-1-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lénaïc

Thanks for the excellent cover letter, I found it very useful while 
reviewing these patches. I think the changes address all of my previous 
concerns, the error handling in the last patch looks good. Having read 
through the patches I don't have anything to add to Peff's comments - 
with those small memory management fixed I think this will be a good shape.

Thanks for your work on this

Phillip

On 08/06/2021 14:39, Lénaïc Huard wrote:
>[...] > The patchset contains now the following patches:
> 
> * cache.h: Introduce a generic "xdg_config_home_for(…)" function
> 
>    This patch introduces a function to compute configuration files
>    paths inside $XDG_CONFIG_HOME or ~/.config for other programs than
>    git itself.
>    It is used in the latest patch of this series to compute systemd
>    unit files location.
> 
>    The only change in this patch compared to its previous version is
>    the renaming of the first parameter of the `xdg_config_home_for(…)`
>    function from `prog` to `subdir`.
> 
> * maintenance: introduce ENABLE/DISABLE for code clarity
> 
>    I just completely dropped this patch as it turned out that replacing
>    some 0/1 values by `ENABLE`/`DISABLE` enum values wasn’t making the
>    code look nicer as initially expected.
> 
> * maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
> 
>    This patch contains all the code that is related to the addition of
>    the new `--scheduler` parameter of the `git maintenance start`
>    command, independently of the systemd timers.
> 
>    The main changes in this patch compared to its previous version are:
> 
>      * Revert all the changes that were previously introduced by the
>        `ENABLE`/`DISABLE` enum values.
> 
>      * Remove the `strlcpy` in the testing framework inside the
>        `get_schedule_cmd` function.
> 
>      * `update_background_schedule` loops over all the available
>        schedulers, disables all of them except the one which is
>        enabled.
>        In this new version of the patch, it is now ensured that all the
>        schedulers deactivation are done before the activation.
>        The goal of this change is avoid a potential race condition
>        where two schedulers could be enabled at the same time.
>        This behaviour change has been reflected in the tests.
> 
>      * The local variable `builtin_maintenance_start_options` has been
>        shortened.
> 
> * maintenance: add support for systemd timers on Linux
> 
>    This patch implements the support of systemd timers on top of
>    crontab scheduler on Linux systems.
> 
>    The main changes in this patch compared to its previous version are:
> 
>      * The caching logic of `is_systemd_timer_available` has been
>        dropped.
>        I initially wanted to cache the outcome of forking and executing
>        an external command to avoid doing it several times as
>        `is_systemd_timer_available` is invoked from several places
>        (`resolve_auto_scheduler`, `validate_scheduler` and
>        `update_background_scheduler`).
>        But it’s true they’re not always all called.
>        In the case of `maintenance stop`, `resolve_auto_scheduler` and
>        `validate_scheduler` are not called.
>        In the case of `maintenance start`, the `if (enable &&
>        opts->scheduler == i)` statement inside
>        `update_background_schedule` skips the execution of
>        `is_systemd_timer_available`.
> 
>      * The `is_systemd_timer_available` has been split in two parts:
>        * `is_systemd_timer_available` is the entry point and holds the
>          platform agnostic testing framework logic.
>        * `real_is_systemd_timer_available` contains the platform
>          specific logic.
> 
>      * The error management of `systemd_timer_write_unit_templates` has
>        been reviewed.
>        The return code of `fopen`, `fputs`, `fclose`, etc. are now
>        checked.
>        If this function manages to write one file, but fails at writing
>        the second one, it will attempt to delete the first one to not
>        leave the system in an inconsistent state.
> 
>      * The error management of `systemd_timer_delete_unit_templates`
>        has also been reviewed. The error code of `unlink` is now
>        checked.
> 
> I hope I’ve addressed all your valuable feedback. Do not hesitate to
> let me know if I’ve forgotten anything.
> 
> Lénaïc Huard (3):
>    cache.h: Introduce a generic "xdg_config_home_for(…)" function
>    maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
>    maintenance: add support for systemd timers on Linux
> 
>   Documentation/git-maintenance.txt |  60 ++++
>   builtin/gc.c                      | 564 ++++++++++++++++++++++++++----
>   cache.h                           |   7 +
>   path.c                            |  13 +-
>   t/t7900-maintenance.sh            | 110 +++++-
>   5 files changed, 676 insertions(+), 78 deletions(-)
> 
