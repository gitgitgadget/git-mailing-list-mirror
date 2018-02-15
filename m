Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B708F1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 21:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163717AbeBOVgX (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 16:36:23 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39181 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162541AbeBOVgW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 16:36:22 -0500
Received: by mail-wr0-f196.google.com with SMTP id w77so1105984wrc.6
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 13:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1dJpyKYAo4jqoNu7IRDI8PLV77oM82vXPM3ewpOSu5s=;
        b=jNOsKsMiOFL33mcKL9gxPA5gyo8hEUmzKZpAJ0b3+OPtJ+xTtF2Me69Loq/2sgjl9d
         VzLsrA0zJedHbUlHI5NxaFcwPKpnLGe916yMTkz9YQh3VRAqdwdQrNVEXPsOCFDeio3j
         DX05tafzhhiJGOagaAVHxrrMUTQmZ1LsKh4zEpPQwNrxo2ANmDMK3qtGqTt3Gr2dEPcR
         zY2s1sHJJGEk1ebtLS2YJuAnHvpZt7g6XfSNn5MfJYDfa5tVLb68dGAaqxu9yFwO0/fZ
         33sbJd8CJD7+rsZBgPjN9R1gwhaxsJkOR4wH23sfQjxH+ki8tzoQ9acQQJOI2firar7t
         ggGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1dJpyKYAo4jqoNu7IRDI8PLV77oM82vXPM3ewpOSu5s=;
        b=EqgEfJMoGzF5t2t/X8DHS008D72dVyAeBAvMQIYed933HOJA3t1gKRHuSR8P1HpnVO
         jlWqJDTPPUTdwTWIxbgLrZqpM1q6Pv+GcOOQBwOvDvZdcJcTm4mV5eGS1klP1E0ARar9
         1nBWgZTPtdV2pIlymfktVEPW4vQwA+x8QUWt5aMTP/QFR4UlcLFajFXl31umYmRX4fL+
         O56g1LAL4WUDgHSK9CxJ48OYcDCWdHGrTVZ0L5ZGBNVL6W5o91JA1WEVDYo/Q73QXE9V
         WPzF9WewfcbZwoNUwEn3UxM2zIgg6ugfkeemcfmJiAO31WSF48/qXoePYUgZOo2c6x+N
         w8Cw==
X-Gm-Message-State: APf1xPAIuB+XKaAJl9SD62pAQCsTNzubMFnt3Sop8/HT/NnxsUXD66KT
        Lo5d7mQZ0+Unq8V+wZl+BfE=
X-Google-Smtp-Source: AH8x227IGGKew/Li/PDVejirTRSJkifYJXM37d3veb3HxExqq6p1mugZONZbXCbY0oV4h8wy4CHJGA==
X-Received: by 10.223.160.100 with SMTP id l33mr3646820wrl.51.1518730581250;
        Thu, 15 Feb 2018 13:36:21 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v9sm16405408wre.8.2018.02.15.13.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 13:36:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        matthew.k.gumbel@intel.com
Subject: Re: [PATCH v2] worktree: add: fix 'post-checkout' not knowing new worktree location
References: <20180212031526.40039-1-sunshine@sunshineco.com>
        <20180215191841.40848-1-sunshine@sunshineco.com>
        <xmqqh8qi7z7o.fsf@gitster-ct.c.googlers.com>
        <20180215212751.GA42108@flurp.local>
Date:   Thu, 15 Feb 2018 13:36:19 -0800
In-Reply-To: <20180215212751.GA42108@flurp.local> (Eric Sunshine's message of
        "Thu, 15 Feb 2018 16:27:51 -0500")
Message-ID: <xmqq8tbu7x64.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I'm a dummy. Can you squash in the following and retry?

I haven't tried, but that does look like the right thing to do,
whether it is the root cause of the fault I am seeing.

Thanks.

>
> --- >8 ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 604a0292b0..f69f862947 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -348,7 +348,7 @@ static int add_worktree(const char *path, const char *refname,
>  	if (!ret && opts->checkout) {
>  		const char *hook = find_hook("post-checkout");
>  		if (hook) {
> -			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE" };
> +			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
>  			cp.git_cmd = 0;
>  			cp.no_stdin = 1;
>  			cp.stdout_to_stderr = 1;
> --- >8 ---
>
> If that fixes it, can you squash it locally or should I re-send?
