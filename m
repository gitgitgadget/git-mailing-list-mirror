Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD596C433EF
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 10:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354281AbhK0KkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 05:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhK0KiT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 05:38:19 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15127C06173E
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 02:35:05 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z5so49311199edd.3
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 02:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YcZxnuoTXKBFACAO9GAgSCF2z5t7zFEDd7TYJeOvoks=;
        b=KIpogkrav0whqxXGLYeTxlni9AtuVATd3SgRFZsS1VZymp6Qikw3a96zI5tjjnux/X
         cZEyvBjbn+X/yWmgAZs0Y5fhXHj0ksu3r7aNu/rWYKx3J0qjLfp2qZLn6QPGg8lfbB5t
         N9JrxCY2I+xE1gFGX8yzPFKk2262NywwztCIGsDII3sTBPYgDXJp4nVgdJsW67zefaRL
         ILyCSVlFn54lLcbcm13TOO6nOjLB9JMUuW/vDYkcNzEMgyqj0hO/6Tpu7owLIqr3GWco
         QY1cex8pWIbJo+116aOBvEJYaGqZD2NrM1qm3XWK8wOwJMHBNfIEmG9IVXGSGVf5lRVJ
         x1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YcZxnuoTXKBFACAO9GAgSCF2z5t7zFEDd7TYJeOvoks=;
        b=xXkF2LhH24zu9DlPOpSLE46MiZRPNTVytJLLwA9eO/gQp0k0JX3d+DzpdiPxCEno6i
         DNdrfOQaTW+vUINgQ3/QlCbNCPxsp8ulmq+hYsKIkXDxHuTujOxQSMNzF0IKV2R2/fkC
         WyOAhvIcm3sqsH/ulZUziUdaDU31J7qQ06iC35HyGO2zHmK95IYxK0Vnct8xnMCE9BAG
         mr4MY3wTE3GTWgXGluklpGLTzM4nMgadK+xvd10es9bEyy5USlpNu8UcJx6PN8pKo111
         8mZVrYTKcZlWQRNN38Ijw6s4fl01wnEewdyrtaDuGthVsReEEkeBplFVMqoyWNEhCsRH
         sKkQ==
X-Gm-Message-State: AOAM533O9glboBwDltuUkjuoYI6MEi3a7nnRaKucjfjY1AaW2ONTJd1g
        XPWuhE4CWlbCgGqhb8AJqwGH4S1UQZw=
X-Google-Smtp-Source: ABdhPJweDEGNv7G2lNkcOsm7djY0dGe2tIlamwArAktwVKz0w7E8xumxitKod4uVXaSX4gfLpTDEJg==
X-Received: by 2002:a50:d88a:: with SMTP id p10mr54317534edj.274.1638009303313;
        Sat, 27 Nov 2021 02:35:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w5sm6019919edc.58.2021.11.27.02.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 02:35:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqv2s-000Ust-7b;
        Sat, 27 Nov 2021 11:35:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 01/11] t2501: add various tests for removing the
 current working directory
Date:   Sat, 27 Nov 2021 11:32:17 +0100
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
 <4b0044656b0ebe81db60f605a184948f728c4b9d.1637966463.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <4b0044656b0ebe81db60f605a184948f728c4b9d.1637966463.git.gitgitgadget@gmail.com>
Message-ID: <211127.864k7xj38p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 26 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>

> +		# Although we want pwd & git status to pass, test for existing
> +		# rather than desired behavior.
> +		if [[ $works == "success" ]]; then

Wasn't "[[" bash-specific or something? In any case a more regular "if
test "$works" = "success" would work here.

> +			pwd -P &&

I wonder if this is doing what we want everywhere cf. 482e1488a9b
(t0001: fix broken not-quite getcwd(3) test in bed67874e2, 2021-07-30),
but haven't looked much/thought about it.

> +test_expect_success 'checkout does not clean cwd incidentally' '
> +	test_incidental_dir_removal failure git checkout init
> +'
> +
> +test_expect_success 'checkout fails if cwd needs to be removed' '
> +	test_required_dir_removal failure git checkout fd_conflict
> +'
> +
> +test_expect_success 'reset --hard does not clean cwd incidentally' '
> +	test_incidental_dir_removal failure git reset --hard init
> +'
> +
> +test_expect_success 'reset --hard fails if cwd needs to be removed' '
> +	test_required_dir_removal failure git reset --hard fd_conflict
> +'
> +
> +test_expect_success 'merge does not clean cwd incidentally' '
> +	test_incidental_dir_removal failure git merge reverted
> +'

This testing the current behavior (and below) looks much better, thanks!
