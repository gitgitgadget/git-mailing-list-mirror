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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612C6C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388CF61C6C
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhGFUQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFUQi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:16:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C256C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 13:13:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y40so316081ede.4
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 13:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=FlPLj9sZ0v/xKfyJFo0LXdIljXujk6qriXrx4oFgfGM=;
        b=j2Px6WcMaSK2BPAHYEBqkgKCsIohfgkKX9U/AJ5mR0M/wCawJbuH2wr3vQkFEwzijQ
         OATUthoSsYg5r87ra9GLlbDSdgfm2Q9cgNufJbuZVQebMJqM6w/Ys2Ilgd4P+rZSTyih
         jEkJ3AH3Wl4rFAsCSsaS+T0H1RQoSS0AEoCrqARa/TdZaBR8AeVOlY3jrAXEf//eX0i9
         yQcqYi600ZetAspb2wRTYgNb8awBSRLDP1jeLCPC5FrgRvBVIq5N8NmrAi7e692yx9yk
         qL+vLi3OjoJ00wTcmmfjtfOtf296+ZJBoIKGsiB+8vn8U82J6st/gfjwAF/nQqG2hXNZ
         gwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=FlPLj9sZ0v/xKfyJFo0LXdIljXujk6qriXrx4oFgfGM=;
        b=seERhXiKI0V2VmIR1+fq8Mgjou7610a7agKbWN3avfsOJBFl9j058e7EX6O5YIdQbQ
         tDv5lGDNmmH3JIqAekHBogOhr83dCk+B+Vs4whx44RhejR1lkWzmn/qpAtCLruU1fgLb
         4WCUzNJ+q88ynWvQOpX0//CwH56RXUn+R1gD04wU29mxGJjFF7j4eisnQxg6vKzuhnn+
         wMerh6G9F2/IuwweBF4pqyZAyvAQBNbCgpEjhQYL35yRYkCDm4bI4tFqPa1iwN8zOIKR
         jdeXCiAm1JAnurzVjgpBSHvdmbpQcJkmRbEIBvHoj/dN57gNBWhUazPtmXUMxgrRJCJ3
         NM4Q==
X-Gm-Message-State: AOAM533w845p6zJwbGzwM2HppdMCVqLLejFJP8sJICSua52YNI+65rGW
        jUuK4bCIdM332cW/ynBN6wSxzNll7rU=
X-Google-Smtp-Source: ABdhPJy0/BNaZV4w47he10N20f78pd413L4fN3yj8pWM+HyUgf/uEO793sPG5tfvUHBe7kx1HKBDYA==
X-Received: by 2002:a50:99cf:: with SMTP id n15mr25932041edb.146.1625602436582;
        Tue, 06 Jul 2021 13:13:56 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g23sm6123182ejh.116.2021.07.06.13.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:13:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 11/35] update: add --merge mode
Date:   Tue, 06 Jul 2021 22:13:30 +0200
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
 <20210705123209.1808663-12-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210705123209.1808663-12-felipe.contreras@gmail.com>
Message-ID: <8735sr5hfg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 05 2021, Felipe Contreras wrote:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-update.txt |  4 ++++
>  builtin/update.c             | 20 +++++++++++++++++++-
>  t/t5563-update.sh            | 15 +++++++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-update.txt b/Documentation/git-update.txt
> index df778b7ef4..075653c6fd 100644
> --- a/Documentation/git-update.txt
> +++ b/Documentation/git-update.txt
> @@ -29,6 +29,10 @@ OPTIONS
>  --ff::
>  	Forces a fast-forward.
>  
> +-m::
> +--merge::
> +	Forces a merge.
> +
>  SEE ALSO
>  --------
>  linkgit:git-fetch[1], linkgit:git-fast-forward[1],
> diff --git a/builtin/update.c b/builtin/update.c
> index 34681fe21a..5946b383f5 100644
> --- a/builtin/update.c
> +++ b/builtin/update.c
> @@ -8,7 +8,8 @@
>  #include "dir.h"
>  
>  enum update_mode_type {
> -	UPDATE_MODE_FAST_FORWARD = 0
> +	UPDATE_MODE_FAST_FORWARD = 0,
> +	UPDATE_MODE_MERGE
>  };
>  
>  static enum update_mode_type mode = UPDATE_MODE_FAST_FORWARD;
> @@ -22,6 +23,9 @@ static struct option update_options[] = {
>  	OPT_SET_INT_F('f', "ff", &mode,
>  		N_("incorporate changes by fast-forwarding"),
>  		UPDATE_MODE_FAST_FORWARD, PARSE_OPT_NONEG),
> +	OPT_SET_INT_F('m', "merge", &mode,
> +		N_("incorporate changes by merging"),
> +		UPDATE_MODE_MERGE, PARSE_OPT_NONEG),
>  
>  	OPT_END()
>  };
> @@ -50,6 +54,18 @@ static int run_fast_forward(void)
>  	return ret;
>  }
>  
> +static int run_merge(void)
> +{
> +	int ret;
> +	struct strvec args = STRVEC_INIT;
> +
> +	strvec_pushl(&args, "merge", "FETCH_HEAD", NULL);
> +
> +	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
> +	strvec_clear(&args);
> +	return ret;
> +}
> +
>  int cmd_update(int argc, const char **argv, const char *prefix)
>  {
>  	if (!getenv("GIT_REFLOG_ACTION"))
> @@ -68,6 +84,8 @@ int cmd_update(int argc, const char **argv, const char *prefix)
>  
>  	if (mode == UPDATE_MODE_FAST_FORWARD)
>  		return run_fast_forward();
> +	if (mode == UPDATE_MODE_MERGE)
> +		return run_merge();
>  
>  	return 1;
>  }
> diff --git a/t/t5563-update.sh b/t/t5563-update.sh
> index 951df41ac4..833a5285da 100755
> --- a/t/t5563-update.sh
> +++ b/t/t5563-update.sh
> @@ -42,4 +42,19 @@ test_expect_success 'non-fast-forward update' '
>  	)
>  '
>  
> +test_expect_success 'git update non-fast-forward with merge' '
> +	test_when_finished "rm -rf test" &&
> +	(
> +	git clone . test &&
> +	cd test &&
> +	git checkout -b other master^ &&
> +	>new &&

We usually indent the subshell...

> +	git add new &&
> +	git commit -m new &&

And if we can use test_commit, less verbose.
