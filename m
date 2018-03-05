Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B177C1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 20:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeCEUxK (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 15:53:10 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36586 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeCEUxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 15:53:09 -0500
Received: by mail-wr0-f195.google.com with SMTP id v111so18719504wrb.3
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 12:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oE+RC6CW9QRpzS+NXNGsIhrIm7IWvj57WXcVQxnrtH0=;
        b=rtEKR38l9EBkhhJEJglCOxXtjWEhIZP725SgpqYoLeKVhjN/SgU/9i4oBB6m9eN9dp
         JCpf49LTsuX2V4eVYAIu8bMxiADoEjld0GiEaifnVJnuuPtXAtLvZi1VCDetHKXI2ygk
         jBh0+DhZOeRIq/pqQvoMHi5AiEUiB3UeV5aa96E+NEeQQZCI6TqY+HubM1N4FYPiGvko
         lKWXGj4Ri/DhhjzUsrmkeaugPSA4Z0tNsiSueNUqmwUoUxDMgajMT3BO83j9S6ZoF40z
         BXhf55q2817Qhv7aCRpyhBHnmrpMyHvUD2MT8PR/1/Fyhu1i0ApyCWtN2U9uLdkfsOMi
         78RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oE+RC6CW9QRpzS+NXNGsIhrIm7IWvj57WXcVQxnrtH0=;
        b=occR87PooeKFfHJxyR2V/aE6BCrHIXOlGM6nth9+WmclBvwkaIQVLYNZXQTDtu+g5b
         4Do+BExwSAWyO4SlfLp3gob72VgbGVVhSA86AHN6GXuMRcdIrWL+Suj9S9hrQWbtMSXF
         WEQvVwzEMycKPwWws5FE6gLINM2OwSuSk7A4AtPBqtSQFRL/wVBd/XraRj6npts2kKoA
         rjL/lEf1Wq8Ws94vmuXHDUeiphYK/by+czPcih7U4kNUA+UH3jjYCVsncin6+bUlSd5s
         SPcT6YI9lmSt5tfOXw7QRBZt+ZNLt1zTrg4OKOFrNfHUvqmzxCioRuo17alAqp6DM0C1
         uWmg==
X-Gm-Message-State: APf1xPAuYXancYhxqhaYhVf2uCdv8pT9b8bU8sc7nZqN6bw2fx2Hymat
        o9cxEDS9CrgkKxMJ53yiu7g=
X-Google-Smtp-Source: AG47ELuevKP/PPkJe7dKj/RCkTM394p8q1csYXI1ScZJVsM9ycJOO6cEDTwkHjEqBt4cSGVtEdvfCA==
X-Received: by 10.223.133.214 with SMTP id 22mr14468880wru.130.1520283188284;
        Mon, 05 Mar 2018 12:53:08 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d8sm7576219wmd.20.2018.03.05.12.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 12:53:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] add--interactive: detect bogus diffFilter output
References: <20180303055715.GH27689@sigill.intra.peff.net>
        <20180303055849.GB15952@sigill.intra.peff.net>
Date:   Mon, 05 Mar 2018 12:53:07 -0800
In-Reply-To: <20180303055849.GB15952@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 3 Mar 2018 00:58:49 -0500")
Message-ID: <xmqqsh9e8css.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It's important that the diff-filter only filter the
> individual lines, and that there remain a one-to-one mapping
> between the input and output lines. Otherwise, things like
> hunk-splitting will behave quite unexpectedly (e.g., you
> think you are splitting at one point, but it has a different
> effect in the text patch we apply).
>
> We can't detect all problematic cases, but we can at least
> catch the obvious case where we don't even have the correct
> number of lines.

Will queue.  We could probably also make sure that each of the
corresponding line pair begins with the same '-/ /+' letter, but we
need to draw a line and stop somewhere, and I think the number of
lines is probably a good enough place.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-add--interactive.perl  | 8 ++++++++
>  t/t3701-add-interactive.sh | 8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 964c3a7542..ff02008abe 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -705,6 +705,14 @@ sub parse_diff {
>  	}
>  	my (@hunk) = { TEXT => [], DISPLAY => [], TYPE => 'header' };
>  
> +	if (@colored && @colored != @diff) {
> +		print STDERR
> +		  "fatal: mismatched output from interactive.diffFilter\n",
> +		  "hint: Your filter must maintain a one-to-one correspondence\n",
> +		  "hint: between its input and output lines.\n";
> +		exit 1;
> +	}
> +
>  	for (my $i = 0; $i < @diff; $i++) {
>  		if ($diff[$i] =~ /^@@ /) {
>  			push @hunk, { TEXT => [], DISPLAY => [],
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 64fe56c3d5..9bb17f91b2 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -404,6 +404,14 @@ test_expect_success TTY 'diffFilter filters diff' '
>  	grep foo:.*content output
>  '
>  
> +test_expect_success TTY 'detect bogus diffFilter output' '
> +	git reset --hard &&
> +
> +	echo content >test &&
> +	test_config interactive.diffFilter "echo too-short" &&
> +	printf y | test_must_fail test_terminal git add -p
> +'
> +
>  test_expect_success 'patch-mode via -i prompts for files' '
>  	git reset --hard &&
