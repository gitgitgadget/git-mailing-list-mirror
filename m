Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D91C77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjEIRty (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEIRtt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:49:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A531035BB
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:49:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-643557840e4so6690789b3a.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654588; x=1686246588;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZT++I8gbqSJSrZnOAhWRLxm8llh14CQEAq+LLrGL5A=;
        b=Gr6IvqjVleH6s29PSt2bDq55qeSqS/jxu2+EdhrPXvM2LqLCYdxXVVhOi8G7Ft+IOc
         294vJUN9UztMAkH8gm/ewaILxdMRUPPlmtL3Vhpf2eX0d7Pi7Ugk4vn6jFtHA2v4qfmg
         CLw6l3AhUKzLuWj0PwOev2CAEWneW3HJwYp2G7j2wi1lg2l2CS8cautIF8Gu49pB74M+
         bZkCcIo22e2HfJI/cJsq7hBHKiY6oDlABuxiu64cgJGuri/CXMkPFUUKRa7BqBdBp1wP
         RErugTUihXhOXCDph4WjmH2Bz/dshTTaQrN4QEFnvdjaMuy/yu+Y02dYuIvJpfTWJoAQ
         S+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654588; x=1686246588;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gZT++I8gbqSJSrZnOAhWRLxm8llh14CQEAq+LLrGL5A=;
        b=Tct6lZ5/4yVttZnvktsg0YamvzPPC3UF6Gk1aGdvKWyyINhb0Dey541DZFTLiATf1z
         u/Xw06tj+IrV3+1QXoSHVo2MQM3CJt5Etz96zHPQNMdFi6Lze7vn+k7AVOd0IfHg7X34
         wbUcPe5hRVX6yvLcHPhUoWCHcdQWcfSVzzbmez/n8nmsshhoFaTUB7Ua1zPjM86TwR4f
         q5wOQgplooeYv3idilXDTOVNpDP73kKFwdYLPxyKyXMOQ13/PnB3D96TV8xepXBlunL3
         CIWXBVs/p9aPIYeuZrvFqR+0CrgB/42yHzwYjIhfFOWiEIcw9xYaVrxeY4UJ0V7S3VId
         7HBg==
X-Gm-Message-State: AC+VfDw44jtKzwbMaDwZ3xlLCCVXUckJH+c5OyRuFvsnSjbBtAEZ597Q
        HvQsc5Hxt0C2jB5HDJTV2Xg=
X-Google-Smtp-Source: ACHHUZ7ymZqeU1KnVuEPFy/V9WR/5o0t2DOHUm69uxWrFtjPp3Gm5Q0yoK59yh0QqqvYeBfCKPuxUw==
X-Received: by 2002:a05:6a20:8e10:b0:100:a636:6f22 with SMTP id y16-20020a056a208e1000b00100a6366f22mr8856257pzj.19.1683654588063;
        Tue, 09 May 2023 10:49:48 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id t28-20020aa7939c000000b0062e23e81b24sm2034611pfe.114.2023.05.09.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:49:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 1/8] fetch: fix `--no-recurse-submodules` with
 multi-remote fetches
References: <cover.1681906948.git.ps@pks.im> <cover.1683636885.git.ps@pks.im>
        <d82b42ed345ac7b482bf5dd96456f131ecb8c746.1683636885.git.ps@pks.im>
Date:   Tue, 09 May 2023 10:49:47 -0700
In-Reply-To: <d82b42ed345ac7b482bf5dd96456f131ecb8c746.1683636885.git.ps@pks.im>
        (Patrick Steinhardt's message of "Tue, 9 May 2023 15:02:02 +0200")
Message-ID: <xmqq1qjpz96s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When running `git fetch --no-recurse-submodules`, the exectation is that
> we don't fetch any submodules. And while this works for fetches of a
> single remote, it doesn't when fetching multiple remotes at once. The
> result is that we do recurse into submodules even though the user has
> explicitly asked us not to.
>
> This is because while we pass on `--recurse-submodules={yes,on-demand}`
> if specified by the user, we don't pass on `--no-recurse-submodules` to
> the subprocess spawned to perform the submodule fetch.
>
> Fix this by also forwarding this flag as expected.

Makes sense.

> +test_expect_success "fetch --all with --no-recurse-submodules only fetches superproject" '
> +	test_when_finished "rm -rf src_clone" &&
> +
> +	git clone --recurse-submodules src src_clone &&
> +	(
> +		cd src_clone &&
> +		git remote add secondary ../src &&
> +		git config submodule.recurse true &&

The above two is essential to this test; we are interested in making
sure that --no-recurse-submodules is propagated down even when the
"--all" option is used, and we want another remote for that.  We set
the default to recurse, so that passing "--no-recurse-submodules"
would defeat it, but just refraining to pass "--recurse-submodules"
would cause us to recurse.

> +		git config fetch.parallel 0 &&

Is this necessary for the purpose of the test, though?  It should
not hurt, but we do not require the end-users to set it in real life
for the parallel fetching to work, either, right?

Just being curious.

> +		git fetch --all --no-recurse-submodules 2>../actual
> +	) &&
> +
> +	cat >expect <<-EOF &&
> +	From ../src
> +	 * [new branch]      master     -> secondary/master
> +	EOF
> +	test_cmp expect actual
> +'

In the context of a series that attempts to introduce a new stable
output format for machine consumption, which implies the traditional
output can change to match human users' preference, this test feels
a bit brittle, but let's wait until the end of the series to judge
that.

Looking good.  Thanks.

>  test_done
