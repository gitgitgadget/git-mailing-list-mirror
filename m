Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA74CCCA47C
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387691AbiFHAad (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1583327AbiFGXqb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:46:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557F145CB41
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 15:11:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x5so19642530edi.2
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1fFRRPp5dJtn246jKfXvan1zL7hxk7fbbxpFB5KmIVg=;
        b=iwKkOHGAHJRTCj9QCgAOqJCVitrxRUathMzEGEOeTl6M2dhgUGsZ5yOpeSqymTA/eI
         4xjt7HDY35M/burH0rIYucBaPX6u1AH4kGDC3acjWhZDYfsgwIQRRA2pV0yXcNsBZIaK
         6vTHZoCqdY9bdNH6qW2ZHZf/nVjB956ojMhhCGsP37TlJhl0mxoFf4SISy3DOWfDiSXj
         t6m1Y6ph3XvOr+40WuFOh/2hYCn0EacP+wMT36kAIOrXC8TCrMBR8A83I2DDQRgIM+YY
         SE94GihGsfz+Qsz9s/cv6VyQjjEUp2ECZnlimQXoJIHKtty211BwzsCZfrWe/DgvYXE7
         3fSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1fFRRPp5dJtn246jKfXvan1zL7hxk7fbbxpFB5KmIVg=;
        b=6tsM75Spti4kZp7Qbj4yPjPOrhhjsv+lckhH87QlMJQE+UAwESkJ1rGwPIEShRRDm3
         SvcdZ5hyhqoCAFt/um+QNqoJxfNZ0OjNeTdr7AFr5Ad6JpunB8WDFRzbfZ4dxVT/QGN6
         8jgURTnxGscMVb0j4l9QiQ7PvOf7y0rvexhXttA/khx53em9IhRVn52oC6UdVDfseQhm
         y7eUs8giDR0KS3Qxu4eSgsS9t88ECLiE+ferSQsSKHw9EQW4YIuSnpuuqHEq5tXa6t+u
         Y8jaW/E1AVK/7DWjngt4xQshM2l8yi/r+dc/a7nuok3ezPrPEkjv9gm8o5uPTw1sZ6hN
         mYww==
X-Gm-Message-State: AOAM530h4W2H+XyZ+5bWhQn96xRz7mphB+hlac81VOBMLLuTIVsqkX2j
        DbQqLKv0CgxJD2U2qpGU44505wLVNIrGvw==
X-Google-Smtp-Source: ABdhPJws6YQdtR1Wa2G/R4fA0hRZDtNZ3bXWMLJP4avBb+z3VvG2pWB/on2Ns5dehOGm62lR3wjxyA==
X-Received: by 2002:a05:6402:3224:b0:42d:e68c:2fd with SMTP id g36-20020a056402322400b0042de68c02fdmr35250073eda.282.1654639910999;
        Tue, 07 Jun 2022 15:11:50 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709064a8900b006f3ef214e2csm8414876eju.146.2022.06.07.15.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 15:11:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nyhQT-002gt6-Vt;
        Wed, 08 Jun 2022 00:11:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com
Subject: Re: [PATCH v2] run-command: don't spam trace2_child_exit()
Date:   Wed, 08 Jun 2022 00:09:14 +0200
References: <4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651179450.git.steadmon@google.com>
 <50d872a057a558fa5519856b95abd048ddb514dc.1654625626.git.steadmon@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <50d872a057a558fa5519856b95abd048ddb514dc.1654625626.git.steadmon@google.com>
Message-ID: <220608.86pmjkt97e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 07 2022, Josh Steadmon wrote:

> In rare cases[1], wait_or_whine() cannot determine a child process's
> status (and will return -1 in this case). This can cause Git to issue
> trace2 child_exit events despite the fact that the child may still be
> running. In pathological cases, we've seen > 80 million exit events in
> our trace logs for a single child process.
>
> Fix this by only issuing trace2 events in finish_command_in_signal() if
> we get a value other than -1 from wait_or_whine(). This can lead to
> missing child_exit events in such a case, but that is preferable to
> duplicating events on a scale that threatens to fill the user's
> filesystem with invalid trace logs.
>
> [1]: This can happen when:
>
> * waitpid() returns -1 and errno != EINTR
> * waitpid() returns an invalid PID
> * the status set by waitpid() has neither the WIFEXITED() nor
>   WIFSIGNALED() flags
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
> Updated the commit message with more details about when wait_or_whine()
> can fail.
>
>  run-command.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index a8501e38ce..e0fe2418a2 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -983,7 +983,8 @@ int finish_command(struct child_process *cmd)
>  int finish_command_in_signal(struct child_process *cmd)
>  {
>  	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 1);
> -	trace2_child_exit(cmd, ret);
> +	if (ret != -1)
> +		trace2_child_exit(cmd, ret);
>  	return ret;
>  }

This seems like a legitimate issue, but I really don't think we should
sweep this under the rug like this.

 * Why can't we see if we logged such an event already in common_exit(),
   if we didn't we should trace2_child_exit() (or similar). I.e. not
   miss an event, ever.

 * Should this really be an "exit" event, aren't some of these failed
   signal events? Per the "should this be an exit event?" question in my
   related "signal on BUG" series.

 * We should have tests here, e.g. in t0210 to see the exact events we
   emit in certain cases, we really should have a test for this. Perhaps
   we can instrument a simulated failure with some GIT_TEST_* variables?
