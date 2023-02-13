Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAA0C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 18:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjBMSIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 13:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjBMSID (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 13:08:03 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22741F5F3
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:07:31 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id bd35so3515202pfb.6
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgMvVUv/mbFmvsb+Wqtwz+RJxZ99A0v+PSjWH49U0wU=;
        b=fckAsF/9Y/O9/hhvukSgUwjlIHlaRiFdUPY3RQYg3X+E5ccY/d/gtaVYAo4l0A+1SL
         nQAtY9KOXre/hF7CjL9noVvv4+a+FqVH8APs0YnwMJ5no1Nvx6MpolzhwIxPFV4/4PeY
         1jbfMdL6V2A496w9slhH+1aX98p/WiHiF0fdKyJ+0GGg7ZMAfr3yaMMR+Yard9AiKXS7
         oVBKaUrQSOX9BOJ2dDcO2M5eKcnodGQkxUifp0G/yBI2WqZprc1n3vvAFhWPhA5QxpTx
         oU7tZPdzckLf0sIYVeXUmQEGnR2JfOxzn4XlUsoSIWVR6dbS0A8NRfKyqnjhrRWm0wMl
         YfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XgMvVUv/mbFmvsb+Wqtwz+RJxZ99A0v+PSjWH49U0wU=;
        b=lnyZtVeCLktjsBKxXMcd1WrMdiEbz5s7x4ozOWDpoDVnZu35hnKKxuBtNKUEjy0JJx
         4ZlnBA/YQut5Dktbtft+ACuoDdttWFBStuafIxJI71V2hTSMc3t+K4CQ967UaSxgNu5v
         K8fMJE3gFlcByg/F+pPuL+zz8u5kXruLyOYtHmQtWbqQMBoGzhJCkz3fqXlXeEX+fw4p
         EGvfn9Lb3vQQfAh4O0xnHjzyvX/EmYmGQlFx6dXYrd8C4qv4XJytWOzB2dnhiZv67KzD
         YZvb67PULpvBog5Zb3Wtbg/Wre4A78MJ+n6VOGmLD2JSzfiZHC/W+wYUz9zoL/mseJwM
         YHBw==
X-Gm-Message-State: AO0yUKUg4eJgHo2TNfXsacToX5L/vQx4QKOAmC5OICqIbIxzeFMypt78
        Akogw1babA0UjOkcZNxF2A0=
X-Google-Smtp-Source: AK7set/5HAH8LkGtEUc5gdt/Ou3RfDYr2MyNEqItIxhALCSrEcv0Eo9M/Ewr58snMg9xkoJozSaA+g==
X-Received: by 2002:a62:6445:0:b0:5a8:bec0:d6d9 with SMTP id y66-20020a626445000000b005a8bec0d6d9mr2859057pfb.30.1676311648399;
        Mon, 13 Feb 2023 10:07:28 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79116000000b0059250c374cesm8284838pfh.115.2023.02.13.10.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:07:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] test: make SYMLINKS prerequisite more robust
References: <xmqqwn4sq73f.fsf@gitster.g>
        <230209.86k00rzqsz.gmgdl@evledraar.gmail.com>
        <xmqqbkm3ppn8.fsf@gitster.g> <xmqqk00pjuli.fsf@gitster.g>
        <ef19e164-b0ba-531d-95e6-75ef61c4fc9d@gmx.de>
Date:   Mon, 13 Feb 2023 10:07:27 -0800
In-Reply-To: <ef19e164-b0ba-531d-95e6-75ef61c4fc9d@gmx.de> (Johannes
        Schindelin's message of "Mon, 13 Feb 2023 10:12:46 +0100 (CET)")
Message-ID: <xmqq7cwlcucg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Whatever magic you used to fix these failing tests, thanks.
>
> The magic was to pester the maintainers of the dependency of the
> `setup-git-for-windows-sdk` GitHub Action that broke said action.
>
> Background (you can skip this unless you're interested in details):
>
> Since Git's test suite relies so heavily on Unix shell
> scripting, which is really foreign on Windows, we have to use the MSYS2
> Bash to run it. And when I say "MSYS2 Bash", it is short-hand for "a Bash
> that uses the POSIX emulation layer provided by the MSYS2 runtime".
>
> The MSYS2 runtime _does_ have support for actual symbolic links, it just
> depends on certain Windows features (and then it still is not quite the
> same as Unix symbolic links because on Windows, the symbolic links are
> either pointing to files or to directories and you have to specify that
> when creating them).

OK, so bash runtime accidentally enabled symbolic links. But of
course "git" thinks that Windows never do symbolic links by having
{ENOSYS; return -1;} in compat/mingw.h for readlink and symlink,
running any git operation that depends on SYMLINKS prerequisite
would not work and that is where it fails.  We do not even have to
hit a test that points a symbolic link at any special file.

Thanks for fixing the environment.  The patch in the thread only
meant to ensure that the test suite does not get fooled by only bash
supporting symbolic links without updating "git" supporting any by
being more careful.  Now "test -h" and "ln -s" behave without
contradiction with readlink(2)/symlink(2) emulation "git" uses, we
can safely drop it.


