Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77DD11F453
	for <e@80x24.org>; Wed, 31 Oct 2018 04:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbeJaNdy (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 09:33:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37214 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbeJaNdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 09:33:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id g9-v6so14912771wrq.4
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 21:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3/1LC4RslCW5vZf4Nbtr+CrrXBD7imxKBwVIxtVDYRo=;
        b=gyJPFTdaxKp8YB8lhUCGxrPa3UX9rmRn9s1TAJKH792PPv0rvmVSu3gF8Hc7V+S5WM
         6VPINud20BD2tTm0SrkdUxecU649h1X6Tv/XqSlCmwmXqljODI8jvjc1CBkka8vbsidu
         1gZLf8afbEDQnNT+i4i4dhN9mfx3g11PHz+zVbOTp1aGCoIGUc2SmdW7XG92/mUffZR8
         S6j2tbrYQiibt3SQMw4PG0kd4TVffh8/YA+fNv6wwluo9Ezqn4ItQ387D7wpGjPXikQ+
         D9lmyJ+wyK86xKxCZae2BxDqz+/c3DIof1ARQnwxw9URj7XvXxZ07kaDK680GDlKJhqn
         Lgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3/1LC4RslCW5vZf4Nbtr+CrrXBD7imxKBwVIxtVDYRo=;
        b=dTWyzVZHhuE32nDIpmOuEcRKqzCOdBIXSeNQCnuFx4mRGufljD9qtR783Kv5dxUPz1
         iJTf+BKDfW0GHdpt8Ezz+SGUB9HuQ1CIinmyvo4zp3Ryx8cHi2n1kBzHd/sWoCUW91vm
         L4tb/R0+pYiLxldUfpTvfn35nvfffHnGeiJHnXjEUGanpGp722gypxW03JK7Hc9cH+AU
         LLifWVFnQJJhhaU7NODTCvXjH3WybXqerTROLUJOdibWsPc4A1WkJRT9KLeo6LEb8bIq
         uHhtmP0kDlyc3sB7SMKvys6VWZsPUniU3KZfrLHzit0e47A+iUroGH3V8RvkS3stvs6w
         j/rA==
X-Gm-Message-State: AGRZ1gK7VrIErEgSE6aT2WvfAOEEAnU/tIfM9p34XtGE7b1KId1wIJcN
        WvPPUHRTepRDIh+NqXl+HC3VEYl53aI=
X-Google-Smtp-Source: AJdET5erkr4HPx5lcLDgCgKReUX3f2ZFSSzCrIG3Dsms3QaPJsB4qwvFpBRjxU52KPQAprB+Mc7+dQ==
X-Received: by 2002:adf:a2cc:: with SMTP id t12-v6mr331110wra.100.1540960648300;
        Tue, 30 Oct 2018 21:37:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 109-v6sm3439014wrb.81.2018.10.30.21.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 21:37:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] ls-remote: do not send ref prefixes for patterns
References: <20181031042318.GA5347@sigill.intra.peff.net>
        <20181031042405.GA5503@sigill.intra.peff.net>
Date:   Wed, 31 Oct 2018 13:37:26 +0900
In-Reply-To: <20181031042405.GA5503@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 31 Oct 2018 00:24:05 -0400")
Message-ID: <xmqq7ehyybnd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Since b4be74105f (ls-remote: pass ref prefixes when requesting a
> remote's refs, 2018-03-15), "ls-remote foo" will pass "refs/heads/foo",
> "refs/tags/foo", etc to the transport code in an attempt to let the
> other side reduce the size of its advertisement.

Jonathan, seeing 2b554353 ("fetch: send "refs/tags/" prefix upon CLI
refspecs", 2018-06-05), I am guessing that you are doing the proto v2
work inherited from Brandon?  Having to undo this is unfortunate, but
I agree with this patch that we need to do this until ref prefix learns
to grok wildcards.

> Unfortunately this is not correct, as ls-remote patterns do not follow
> the usual ref lookup rules, and are in fact tail-matched. So we could
> find "refs/heads/foo" or "refs/heads/a/much/deeper/foo" or even
> "refs/another/hierarchy/foo".
>
> Since we can't pass a prefix and there's not yet a v2 extension for
> matching wildcards, we must disable this feature to keep the same
> behavior as v1.
>
> Reported-by: Jon Simons <jon@jonsimons.org>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/ls-remote.c  | 8 --------
>  t/t5512-ls-remote.sh | 9 +++++++++
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 6a0cdec30d..5faa8459d9 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -88,15 +88,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  		int i;
>  		pattern = xcalloc(argc, sizeof(const char *));
>  		for (i = 1; i < argc; i++) {
> -			const char *glob;
>  			pattern[i - 1] = xstrfmt("*/%s", argv[i]);
> -
> -			glob = strchr(argv[i], '*');
> -			if (glob)
> -				argv_array_pushf(&ref_prefixes, "%.*s",
> -						 (int)(glob - argv[i]), argv[i]);
> -			else
> -				expand_ref_prefix(&ref_prefixes, argv[i]);
>  		}
>  	}
>  
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index bc5703ff9b..ca1b7e5bc1 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -302,4 +302,13 @@ test_expect_success 'ls-remote works outside repository' '
>  	nongit git ls-remote dst.git
>  '
>  
> +test_expect_success 'ls-remote patterns work with all protocol versions' '
> +	git for-each-ref --format="%(objectname)	%(refname)" \
> +		refs/heads/master refs/remotes/origin/master >expect &&
> +	git -c protocol.version=1 ls-remote . master >actual.v1 &&
> +	test_cmp expect actual.v1 &&
> +	git -c protocol.version=2 ls-remote . master >actual.v2 &&
> +	test_cmp expect actual.v2
> +'
> +
>  test_done
