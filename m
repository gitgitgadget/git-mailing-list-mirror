Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0451C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 20:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjCWUQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCWUQx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 16:16:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8320D25E0D
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:16:48 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d13so22522687pjh.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679602608;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4E0tjNNqKJnuuSMZLvdcAkclCnIa472H2ONEhtVooo=;
        b=JBcSSL8DQcKYpO0B2q6xf+OWTkKK7rp+hp1qGtQLDFT28RS96JqiL93IAKTF2g5H/e
         ZR5zZ5Zs/qdF2A6bGHmKBYfrqrt3t4vKU6mmohvFMQNaZ5jKzVEjJVIyhEbMl6xiX8Oj
         uDZq+4OTDptdqlc9tgz/dy8bzOkGwV2wlthAsrj0/jdZuhY7hWa1ey9CHqJq2mmKtW82
         9bl3aE7GaT8qodzPKtj9aVigmtbjJtdu3K7XxgFfOERlHd+R2Xl9Sg2eqKUzkXThcb5/
         5dHsEze5n8YLmsaocdFprBZOE0QR4EYFPzg/8J1ezsPjir558G1hInmC5LEzVtC6+MUn
         ooNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679602608;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b4E0tjNNqKJnuuSMZLvdcAkclCnIa472H2ONEhtVooo=;
        b=zvEIL0jzKZ+MD9ofeOvt9UQ83JP8yeszF4v5qxV9eqyA3RitsdLDBCm5AxY6goyCWM
         v+bbhGj2Ha/qQ+gWTtUezqfZshoSKci/KxpgyVcS0zF+EHpGH3CohD+uvPOG9aYCVGqD
         KA55dt0LoQPwaOQyuvXvw0Dj4X/u9yhWtJXwFcfbufJQ9yt6yynTRXLH7Jsvgg1akPWf
         UrpCEsywZ7uU1qgy7l65E2ku8AdoTt7IyG94AgQzwI5Vv7mx9Dki39aI6VVy1vKxW1Gd
         DQIhFQrrt2xv4O4qRRBAsoPM+z7e2beQQA0z9Oxfb1eR8nDOr3mlWAJ23HB1TrTz2pI7
         KypQ==
X-Gm-Message-State: AAQBX9eRV7DIu4S1br08f4Yy/Kq6vElxu6lQC45GmLgZdIvWdoSBixP6
        Az0K9C5pCHphT3m+raVvEM0=
X-Google-Smtp-Source: AKy350bXs9jRzTMj2WrcPHuiiGQGHFXXXqCfGL8mpmCdWxrIpNcxeUZtUZguI4WnOtWLI5VRrW3wug==
X-Received: by 2002:a17:90b:4a02:b0:234:ba34:71bf with SMTP id kk2-20020a17090b4a0200b00234ba3471bfmr299276pjb.1.1679602607917;
        Thu, 23 Mar 2023 13:16:47 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902eec600b0019cb131b89csm11847203plb.254.2023.03.23.13.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 13:16:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] rebase: preserve interactive todo file on checkout
 failure
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
        <20230323162235.995574-6-oswald.buddenhagen@gmx.de>
Date:   Thu, 23 Mar 2023 13:16:47 -0700
In-Reply-To: <20230323162235.995574-6-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Thu, 23 Mar 2023 17:22:32 +0100")
Message-ID: <xmqq8rfn8bps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> Creating a suitable todo file is a potentially labor-intensive process,
> so be less cavalier about discarding it when something goes wrong (e.g.,
> the user messed with the repo while editing the todo).

Is there a reason why we do not always keep it?  Why is the file
sometimes precious but not precious at all in other times?

Tying the previous bit to "-i was explicitly given" feels a bit
unintuitive---when the sequencer machinery was implicitly chosen,
and gives the control back to the user, should a user be forbidden
to muck with the todo list?

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index a309addd50..728c869db4 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -153,6 +153,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>  	replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
>  	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
>  	replay.verbose = opts->flags & REBASE_VERBOSE;
> +	replay.precious_todo = opts->flags & REBASE_INTERACTIVE_EXPLICIT;
>  	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>  	replay.committer_date_is_author_date =
>  					opts->committer_date_is_author_date;
> diff --git a/sequencer.c b/sequencer.c
> index b1c29c8802..f8a7f4e721 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4570,6 +4570,10 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
>  		.default_reflog_action = sequencer_reflog_action(opts)
>  	};
>  	if (reset_head(r, &ropts)) {
> +		// Editing the todo may have been costly; don't just discard it.
> +		if (opts->precious_todo)
> +			exit(1);  // Error was already printed

No // comments, please.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ff0afad63e..c625aad10a 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -288,13 +288,14 @@ test_expect_success 'abort' '
>  '
>  
>  test_expect_success 'abort with error when new base cannot be checked out' '
> +	test_when_finished "git rebase --abort ||:" &&
>  	git rm --cached file1 &&
>  	git commit -m "remove file in base" &&
>  	test_must_fail git rebase -i primary > output 2>&1 &&
>  	test_i18ngrep "The following untracked working tree files would be overwritten by checkout:" \
>  		output &&
>  	test_i18ngrep "file1" output &&
> -	test_path_is_missing .git/rebase-merge &&
> +	test_path_is_dir .git/rebase-merge &&
>  	rm file1 &&
>  	git reset --hard HEAD^
>  '

Are we happy to just see that the directory still exists?  I thought
the original motivation explained in the proposed log message was to
keep the todo list file, so shouldn't you be checking if the file is
there (and if you can reliably ensure that the file has contents
that are expected, that would be even better)?

Also, as the keeping of the todo list is now conditional, we should
have another test that checks that the file is gone when that
condition ("INTERACTIVE_EXPLICIT"?) does not trigger, I think.

Other than that, nicely written.  Thanks.
