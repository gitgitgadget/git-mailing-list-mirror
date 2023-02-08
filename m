Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE47DC05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 21:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjBHVJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 16:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBHVJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 16:09:28 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02514204
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 13:09:27 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v23so385708plo.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 13:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wx0d3m2s32nL5WZb3nIEsIH9BIBuT+aMShIqS+iRfTQ=;
        b=TiI7eZZk2WGyfKwEJQ7TNIJpB40WVgTImwTvs/jRL3TI3zEjIXguBSlpCYp/pPS/ax
         aTwWMpUBzAPjNJVbIQ1dVNnhz8D6CDsFMzZUwMwm/XrXDk8KySQtRr/JU/tlqzBjLlkX
         R4doVtXwjZQwoh8IrlTWyY/sgixYPbai68IJnFNmT4ceGT7dttif6BkClVduKC3cK6uQ
         e+dBFwqhcB4I+ZL7DqcHjv/fn5XYpf1jYW9odCxh1Uk4gmI3ak1fbSBif9u11KDNw/yw
         f0ZyWmE7v0EMZq7mCLRYksEBcIBURU+AcwHv3OPxJlqMlcQUHjhuuM4zUwMG8vNMNRAg
         zPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wx0d3m2s32nL5WZb3nIEsIH9BIBuT+aMShIqS+iRfTQ=;
        b=Lu0dRXwlKhJuF1YHjOEPSYR6h/RMoc0+cNlnz/2lMdhah6Qan3uGa+JegbfijzXhfH
         JTyha+ygDlLZLYrABGGMxxxs2wp9n0p6mRPsxFq8k/rwrab+LnGlqVPmohqsL592dd5x
         9bJPenahdKYkkkdNznKXyyLANdo5zPA/Fe7boBaNCUteAay66dfvAbhsdlNeOSK76kSS
         NzrVWWUg8vzcTr530FlP4/3vOudbi33vCc+SMglmZUkCi0YO/WmVw8c/Qtx3AJEEzp3k
         yspicDxkUWRWOO9sMQ3KbfR0pxoSHmVFXaIflSa3KrMBZp2kBSU+HHneuQqVWxtNzem6
         7WDA==
X-Gm-Message-State: AO0yUKViNTyawHG1Oj66yBwS6lnJrynRxROk+/LRGUz01UFHx1aENiBP
        DrD9RbA9SQ8apwVTUkX6NfY=
X-Google-Smtp-Source: AK7set8t+uRSbsIxymgT+IlzmeMoyoJJlP7LyDHN/hGn/1S6k3q3GjSikzAmcL9iPJQU5LyK6/OzXQ==
X-Received: by 2002:a17:90b:4b0c:b0:229:74a2:a692 with SMTP id lx12-20020a17090b4b0c00b0022974a2a692mr9742707pjb.28.1675890566973;
        Wed, 08 Feb 2023 13:09:26 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id fr12-20020a17090ae2cc00b002260cff0b2dsm1992429pjb.26.2023.02.08.13.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:09:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/5] run-command: allow stdin for run_processes_parallel
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
        <patch-v2-2.5-9a178577dcc-20230208T191924Z-avarab@gmail.com>
Date:   Wed, 08 Feb 2023 13:09:26 -0800
In-Reply-To: <patch-v2-2.5-9a178577dcc-20230208T191924Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 8 Feb
 2023 20:21:12
        +0100")
Message-ID: <xmqq357frhix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> While it makes sense not to inherit stdin from the parent process to
> avoid deadlocking, it's not necessary to completely ban stdin to
> children.

I do not think deadlock avoidance is an issue.  Unpredictable
feeding of pieces of input into multiple children is.  One possible
semantics is to grab the input and dup/tee into all the children, so 
that each child gets its own copy to process.  A hook like "pre-receive",
when it has more than one scripts listening to the event, may want
such a semantics.  Another possible semantics is to give priority
among the children running simultaneously and feed only one child,
while starving others.

> An informed user should be able to configure stdin safely. By
> setting `some_child.process.no_stdin=1` before calling `get_next_task()`
> we provide a reasonable default behavior but enable users to set up
> stdin streaming for themselves during the callback.

I _think_ this alludes to the latter, e.g. "only one child is
allowed, and the one that controls what children are spawned sets
no_stdin for everybody but the chosen one".  We may want to be a bit
more explicit in the proposed log message and definitely in the
documentation.

The implementation is "nice".

> +	/*
> +	 * By default, do not inherit stdin from the parent process - otherwise,
> +	 * all children would share stdin! Users may overwrite this to provide
> +	 * something to the child's stdin by having their 'get_next_task'
> +	 * callback assign 0 to .no_stdin and an appropriate integer to .in.
> +	 */
> +	pp->children[i].process.no_stdin = 1;
> +
>  	code = opts->get_next_task(&pp->children[i].process,
>  				   opts->ungroup ? NULL : &pp->children[i].err,
>  				   opts->data,
> @@ -1601,7 +1609,6 @@ static int pp_start_one(struct parallel_processes *pp,
>  		pp->children[i].process.err = -1;
>  		pp->children[i].process.stdout_to_stderr = 1;
>  	}
> -	pp->children[i].process.no_stdin = 1;
>  
>  	if (start_command(&pp->children[i].process)) {
>  		if (opts->start_failure)
