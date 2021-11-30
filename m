Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871C1C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbhK3VLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbhK3VLM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:11:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B3C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:07:52 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id l25so92120633eda.11
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0uA73gGj/6+Gocu8OB2rUsqAzsb3LPPFJoKoFXNRpjc=;
        b=j/d+xWjKkxc9wDupymeCWLnpL1sOjJP2hodtASbL/BxzCjebOGIgRRiw438KMSUX+b
         S7Fdt6rN+1pvX8HVYre+zbbN5cx+gZeWOv7fIHyhIJd1cprqSAhL1/Km5AI4NQ/rNOtw
         /NaXuz51lFJjCx9JH4vokQJIQ4phM4A8snf8ZAAHyendgINipr+kR03RcGbSfDUvxM9q
         k/yGmZ1u4x4IBZDRYbUzzaMjNIRHLG9/FNHUhsNsbw/Wiidj+GTJePQjKpeKn3yZYEBM
         ZHhF+poYIYGlE1BKEMo/d7413hGgNQoBilqM8BOgytA0TQh/8tCu/et+kat/yplAaTvM
         DGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0uA73gGj/6+Gocu8OB2rUsqAzsb3LPPFJoKoFXNRpjc=;
        b=zSKmwQa7UOaf/cz/8dnpb2Tg07CvQTNzwCZkBjCgNDieJv4nZvWPB+XF7GEpsT1d7q
         X1D5fn4CrZ0MJYKklw2H7cveuYEIx+POM2UfcZVLpCbmW1W02vSg0Igm7YB3hK/j5GGT
         CV7m7euXCbIeGAHIG6ZyZbOBHW5vsdmO9rMR4WufAFWPPxNRyW1clq4oQc8PVs6RWfzY
         nYrMLx6Ggzf3OjpFeIvZ54Vv59Dr3jt9NMU9nn8c/ts5XFX4HgF/yczoymxnPJavpZ2n
         lPWLJyaZKKgOmifV6beDHOL6oK93LCrjqT2P84gV18LytoH1PDisAeohsLH08VZUpLHZ
         Gj/g==
X-Gm-Message-State: AOAM5317znrpfyy71CUeiS7MSyVMYy4W3U9j3nkF6Ie5t5ZBkgVixKsM
        jb6tlPma4ZQR1/v0Vchr5GTEOldHfDY=
X-Google-Smtp-Source: ABdhPJzK9+qEKrj/sMQ8dRaW8tJNiEfD17ZQCgo6KpSKqlPyC3gg0pbfw1t8h55ZZGkoZKsVHWiGIQ==
X-Received: by 2002:a17:906:d92f:: with SMTP id rn15mr1691399ejb.557.1638306471004;
        Tue, 30 Nov 2021 13:07:51 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qa7sm10057082ejc.64.2021.11.30.13.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:07:50 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msALt-0019uq-NA;
        Tue, 30 Nov 2021 22:07:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: ab/run-command + em/missing-pager (was: What's cooking in git.git
 (Nov 2021, #07; Mon, 29))
Date:   Tue, 30 Nov 2021 21:54:33 +0100
References: <xmqqzgpm2xrd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqzgpm2xrd.fsf@gitster.g>
Message-ID: <211130.86k0gpcpy2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Junio C Hamano wrote:

> * ab/run-command (2021-11-25) 9 commits
>  - run-command API: remove "env" member, always use "env_array"
>  - difftool: use "env_array" to simplify memory management
>  - run-command API: remove "argv" member, always use "args"
>  - run-command API users: use strvec_push(), not argv construction
>  - run-command API users: use strvec_pushl(), not argv construction
>  - run-command tests: use strvec_pushv(), not argv assignment
>  - run-command API users: use strvec_pushv(), not argv assignment
>  - upload-archive: use regular "struct child_process" pattern
>  - worktree: stop being overly intimate with run_command() internals

I think the only outstanding thing for this topic is Eric's [1] comment
(on his own code). I think that variable shadowing is OK.

1/2 of that patch will also be rewritten in the in-flight hook topic
(but the "reset --hard" shadowing is left in place).

> * em/missing-pager (2021-11-24) 1 commit
> - pager: fix crash when pager program doesn't exist

As noted in [2] I'm happy to get this more isolated fix first. I'd
missed that there was a re-submission[3] until now (since In-Reply-To
wasn't maintained).

The code change in [3] isn't needed anymore when combined with my
ab/run-command.

Depending on how you're planning to advance these perhaps you'd like to
revert that as it's merged with ab/run-command, or I can re-roll
ab/run-command on top of it if you'd like.

We could also just leave that now-redundant child_process_init() in
pager.c, but having something that'll amount to cargo-culting to get
around a bug in dead code doesn't seem ideal. It would be nice to have
the API use reflect "argv" and "env" being gone.

1. https://lore.kernel.org/git/CAPig+cRi6SeuV7k_+9JCcnf79daLZp5B=EyHK-KxC1VGN0B4ig@mail.gmail.com/
2. https://lore.kernel.org/git/211124.865ysie2br.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/20211125000239.2336-1-ematsumiya@suse.de
