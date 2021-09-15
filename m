Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86011C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 00:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6071561212
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 00:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbhIOAbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 20:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbhIOAbg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 20:31:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A02C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 17:30:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c22so1483051edn.12
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3hTELvOSGsl1zXGiioQY4RzlJ1kZIH/2wQ7EVMSbRrQ=;
        b=LEgWlauSrYYqadx0JRXNMAP64kOJ6nbgogYZ4ewv8a21VO+3JZX1lElUf5bvaJcRUC
         rdKo+dxU3Q9ehOl3+3QV34XVtLAI4wQuLNuTBXwZfPYeSczEkfRfbLm2NSa5hNzXNwE9
         grIE8Cho7Srdi/6I5f8zFqxVBrKmmgp0PfSAbK2n9Ih7BFzPLvlSaQz6gT8nL+ztgNCQ
         +b2LMHmBjg7WaKRErPRTbRN2CRbMMIGXuu+3j7uoCPisWOMIEJu2+0B1SRUUq9gRvnHB
         ySJjLm4m4nt1Eadw8jSTSwsNfUjCq4ismu1rBclmgu573/sPupbFRhsG2e8uqjp1dnaQ
         LF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3hTELvOSGsl1zXGiioQY4RzlJ1kZIH/2wQ7EVMSbRrQ=;
        b=IwsO8chmIy0N4AS9Kv+nXRCrq37oKRDdLKsHzhmi6DR80P/9EXgORLKsu46QAKVqTE
         gbB/0glmjghS1oAMMcm0ZqtDzlpJadxgxW8UyDfcy3EhbwTcdqVwWnKUaO4oibKh/MpD
         dRiIl/ps2q0lexucjxyfE4glSIqDoZ18n1SvxvMxjbDxxrEjatsbxdeaE0d889jLZqjD
         IyRk3RjOdFWUsVLqcYyhSWapZ1pTT/S5dvhhol+Z8U6oVk3Sb7NKGxPnZLEM6SjomVpx
         LaUwscNMLOkzgag65Mrr2fl7TcIvtMu6frlp4KYqyvd3jYjVSGdk3whS7BC4L20SLC2d
         Z0bg==
X-Gm-Message-State: AOAM532Hx2IIxkfBzc1Nhj6JCzhgEmsu9hkrksK9zuABlmFjVJccMG91
        dd747FHMpcebr2YzgH/Sa5QtyfrX1BM=
X-Google-Smtp-Source: ABdhPJyvCJ64Lrh/qailrL7mlcZl1lYQHbb7qCI5NJfsjjV8yvjVLFFkBrrwe9Mol4zT8fj/ADePyw==
X-Received: by 2002:aa7:c988:: with SMTP id c8mr16096500edt.105.1631665815696;
        Tue, 14 Sep 2021 17:30:15 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b13sm6189772edu.27.2021.09.14.17.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 17:30:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 09/11] serve: reject bogus v2 "command=ls-refs=foo"
Date:   Wed, 15 Sep 2021 02:27:35 +0200
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUE1ym1dALRQLztq@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUE1ym1dALRQLztq@coredump.intra.peff.net>
Message-ID: <87wnnin0ix.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 14 2021, Jeff King wrote:

> When we see a line from the client like "command=ls-refs", we parse
> everything after the equals sign as a capability, which we check against
> our capabilities table. If we don't recognize the command (e.g.,
> "command=foo"), we'll reject it. But we use the same parser that checks
> for regular capabilities like "object-format=sha256". And so we'll
> accept "ls-refs=foo", even though everything after the equals is bogus,
> and simply ignored.
>
> This isn't really hurting anything, but the request does violate the
> spec. Let's tighten it up to prevent any surprising behavior.

Doesn't need a re-roll, but just for my own sanity:

By violating the spec you mean it doesn't coform to the "key" in the
"Capability Advertisement" section of protocol-v2.txt, one might skim
this and think values with "=" in them are OK, but a command=WHATEVER
has a WHATEVER as a "key", not a "value", that's for other parts of the
dialog.

But you could also have meant that it violates the spec because there's
no such command as "ls-refs=whatever", just like there isn't "foobar",
but I don't think that's what you mean...

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  serve.c              |  2 +-
>  t/t5701-git-serve.sh | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/serve.c b/serve.c
> index 5ea6c915cb..63ee1be7ff 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -220,7 +220,7 @@ static int parse_command(const char *key, struct protocol_capability **command)
>  		if (*command)
>  			die("command '%s' requested after already requesting command '%s'",
>  			    out, (*command)->name);
> -		if (!cmd || !cmd->advertise(the_repository, NULL) || !cmd->command)
> +		if (!cmd || !cmd->advertise(the_repository, NULL) || !cmd->command || value)
>  			die("invalid command '%s'", out);
>  
>  		*command = cmd;
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index 3bc96ebcde..ab15078bc0 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -72,6 +72,16 @@ test_expect_success 'request invalid command' '
>  	test_i18ngrep "invalid command" err
>  '
>  
> +test_expect_success 'requested command is command=value' '
> +	test-tool pkt-line pack >in <<-\EOF &&
> +	command=ls-refs=whatever
> +	object-format=$(test_oid algo)
> +	0000
> +	EOF
> +	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
> +	grep invalid.command.*ls-refs=whatever err
> +'
> +
>  test_expect_success 'wrong object-format' '
>  	test-tool pkt-line pack >in <<-EOF &&
>  	command=fetch

