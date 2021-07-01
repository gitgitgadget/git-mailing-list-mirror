Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CB2C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F3D613FB
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhGAW5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhGAW5e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 18:57:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AC5C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 15:55:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w17so10632224edd.10
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 15:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fQDszsaBDj8f8ean94dZOch+0hwh/cV13z5SS1MHP/Q=;
        b=PmSr2cJnH3u5VNRQsC9Lwslv6WBlZ3Phjjw+INnUxvTepjzmhkFlBfKfHp/SRqLszY
         +Hpz5G5MW+ePWXvlRsMkv2RwUTOsiLXUkG75wTTx573qyHqtuVaLlDgad8L2DAipQJgD
         SpY8A2udkt9wJI4KmFixFNfv3n1osmr7/eN6XA/XkvIH+XVxiQE2qj8BpG8RJPVkyeIL
         Hn4yYmXvoZlBzFQrok4WEoRuXG1zxDm8zqCXU87IUbC7x5FYkbLpPFwxJPKDJ0U/qNB3
         tfTg9Sacex+x1dwHzP0LTrsGGIlz7OEjjWluul4v8Hipf6bq5j+hlXop+I5zBSOFzkFz
         fBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fQDszsaBDj8f8ean94dZOch+0hwh/cV13z5SS1MHP/Q=;
        b=L6uwWduPXJks4eeIxVKl3zCRgtXluOD6ZIMzfTHFRObmNEfs225inqjtCYyZ2zRr9l
         DypqKPwbBJLQP2DXytZW+LyDgwx3aEIIgrLHk7c2QBUgXsvImuQtrqdtnFrTbEspfDH5
         ljeAbw/vP45f541hwzq1qTh1m6u7cWUIJk+6zubZcRJFJtxApFOB9X2s+w42WwohR5wj
         +J2UrY6NGbs5wHDKiAkPhMnE3eri6l4wc4GW6JaScTjPMHOF85XPpjNcmsi5T+0ScETm
         1zc97Z71RKygWRl3fMqA4bMoeC9doPa1bwqnm+NXqQPjzZU4SQg3P0cgUTwL5ibGRiS0
         VIUQ==
X-Gm-Message-State: AOAM530FAMKfzPkimuyJ1VWaMgRtquftDHNLCQaKuzW/tdqN64PRg/Xu
        BYRn7gw95NTifLNMnOx1b22Rcm/iz/mNDw==
X-Google-Smtp-Source: ABdhPJxTpz/SOE7U4LDQHBUiPB3NnoZTufAqorUWzKgTQyoNB08WWxRbDAoylB80DYiu7QkfLMlcAg==
X-Received: by 2002:a05:6402:419:: with SMTP id q25mr2784675edv.331.1625180100692;
        Thu, 01 Jul 2021 15:55:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u21sm504564edv.20.2021.07.01.15.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 15:54:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 15/34] fsmonitor: do not try to operate on bare repos
Date:   Fri, 02 Jul 2021 00:53:31 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <eef39aa168fec58321ee233d907db696b56ee0b8.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <eef39aa168fec58321ee233d907db696b56ee0b8.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <87pmw1bq64.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Bare repos do not have a working directory, so there is no
> directory for the daemon to register a watch upon.  And therefore
> there are no files within the directory for it to actually watch.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  builtin/fsmonitor--daemon.c |  8 ++++++++
>  t/t7519-status-fsmonitor.sh | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 7fcf960652f..d6161ad95a5 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -490,6 +490,14 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
>  		die(_("invalid 'ipc-threads' value (%d)"),
>  		    fsmonitor__ipc_threads);
>  
> +	prepare_repo_settings(the_repository);
> +	if (!the_repository->worktree)
> +		return error(_("fsmonitor-daemon does not support bare repos '%s'"),
> +			     xgetcwd());
> +	if (the_repository->settings.fsmonitor_mode == FSMONITOR_MODE_INCOMPATIBLE)
> +		return error(_("fsmonitor-daemon is incompatible with this repo '%s'"),
> +			     the_repository->worktree);

I commented on another patch that that second condition seems like it's
only hit under core.virtualfilesystem=true....


> +test_expect_success FSMONITOR_DAEMON 'try running fsmonitor-daemon in bare repo' '
> +	test_when_finished "rm -rf ./bare-clone" &&
> +	git clone --bare . ./bare-clone &&
> +	test_must_fail git -C ./bare-clone fsmonitor--daemon run 2>actual &&
> +	grep "fsmonitor-daemon does not support bare repos" actual
> +'

Isn't just:

    git init --bare bare.git
    test_must_fail git -C bare.git [...]

Enough, or does the repository need content to get to that error.

> +test_expect_success FSMONITOR_DAEMON 'try running fsmonitor-daemon in virtual repo' '
> +	test_when_finished "rm -rf ./fake-virtual-clone" &&
> +	git clone . ./fake-virtual-clone &&
> +	test_must_fail git -C ./fake-virtual-clone \
> +			   -c core.virtualfilesystem=true \
> +			   fsmonitor--daemon run 2>actual &&
> +	grep "fsmonitor-daemon is incompatible with this repo" actual
> +'
> +

Ditto. 
