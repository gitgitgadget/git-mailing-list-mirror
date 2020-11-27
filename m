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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5C9C63798
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 15:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 686592223F
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 15:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4bXVpc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgK0PFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 10:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgK0PFL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 10:05:11 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F63C0613D1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 07:05:11 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id a15so6046356edy.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 07:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EgK+jBxCffxEJwtpesXK5BkYJBqd3j1czSOJOAx22iw=;
        b=Z4bXVpc1pz9N+WvFYdpkxLxiAQvITtrJcw6xt5LUiOOsMD69JkGTERv1Ya8Lr+UaJ2
         ouhxvdFViytYk/4qEb02iWYRrBsiBqdwyx0ouD6D0q/rL45+aU+o0XSoaRD4IgktWCCU
         IWK5CRFE6xQ2Ed63XxIoIvQsaiNpXLyCPBY9WIpo+rN6l8S3VPb7INeIu/EwzIqYQvm9
         3q4VLYNCv+4kRV/kaT7lP3XT0QeRVQ6Pco0TFSty590HkJFw7qml8CJYWMVRqh603/oB
         8SjZNFveBpuBvTESFTL8rKxh7eDvQ9UpeA5rfml1J9MJKwnGmBDv4D8eHjFjVTPbIK5j
         2HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EgK+jBxCffxEJwtpesXK5BkYJBqd3j1czSOJOAx22iw=;
        b=snsJV6pHeLTho8h0pgrg0GcDHPL7Ra/koBgc63jP69Dl25oJJs9ldyZqXzljRl2D3i
         27hB3VdtiiANSGwMBPmtmU1D52qd4hqWisYNjS3uYNN3Y4+OZmJbEueUZ4WssDWVbt+T
         X12UYSGxCtmbfBIxRlKKphHJE7bvJnE/HwwnonWCX5wSIxcRRN5BVs+CBQEIM4XpEq0Y
         JSO+ubVkiNjvycFjbtOzAYVgQTuPp0vk7uuDQNHNqkhqV3R/kmRgHmFpzARdJaok6xxU
         TEhzwUFT82coOY7KececDfSU1lohnhErrtxwZTYaruP0a9bwDBdSMuXujarwJSdhO033
         ZAbg==
X-Gm-Message-State: AOAM5323HHlIbDGvLETeQk5SgpZEbyw5RM1hLUi+SPpnSptwiCahxlB9
        ZmAZUQVRy4sBTrS0v9FyfhQ=
X-Google-Smtp-Source: ABdhPJyJjODdkxs8nNqlHyB6UrDSh9WPxLdcCjsJhOWtpgj14MlvIL49jJ+ba3ARDJare9M3Q9ts9A==
X-Received: by 2002:aa7:d711:: with SMTP id t17mr8139062edq.83.1606489510205;
        Fri, 27 Nov 2020 07:05:10 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id n22sm5155812edo.43.2020.11.27.07.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 07:05:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/3] t7900: make macOS-specific test work on Windows
References: <20201127075054.31174-1-sunshine@sunshineco.com> <20201127075054.31174-4-sunshine@sunshineco.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201127075054.31174-4-sunshine@sunshineco.com>
Date:   Fri, 27 Nov 2020 16:05:08 +0100
Message-ID: <87o8jikfh7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 27 2020, Eric Sunshine wrote:

> Although `git maintenance start` and `git maintenance stop` necessarily
> invoke platform-specific scheduling utilities, their related tests have
> been carefully crafted -- with one minor exception -- to work correctly
> on any platform, thus improving overall coverage. The exception is that
> the macOS-specific test fails on Windows due to unportable use of
> `$(id -u)` and comparison involving the value of $HOME which suffers
> from the typical shortcoming on that platform in which the same path may
> be represented two different ways depending upon its source (i.e. as a
> Windows path `C:/git-sdk-64/usr/src/git/foo` versus as a Unix path
> `/usr/src/git/foo`). Fix both problems and drop the !MINGW prerequisite
> from the macOS-specific test, thus allowing the test to run on Windows,
> as well.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t7900-maintenance.sh | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index ef3aec3253..500eaae4fd 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -408,8 +408,10 @@ test_expect_success 'start preserves existing schedule' '
>  	grep "Important information!" cron.txt
>  '
>  
> -test_expect_success !MINGW 'start and stop macOS maintenance' '
> -	uid=$(id -u) &&
> +test_expect_success 'start and stop macOS maintenance' '
> +	uid=$(test-tool getuid) &&
> +	# ensure $HOME can be compared against hook arguments on all platforms
> +	pfx=$(cd "$HOME" && pwd) &&

This seems equally portable, and means your 2/3 isn't needed, no?
    
    diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
    index c3dcb9cb4d..b23f77aebc 100755
    --- a/t/t7900-maintenance.sh
    +++ b/t/t7900-maintenance.sh
    @@ -458,10 +458,10 @@ test_expect_success 'start preserves existing schedule' '
     '
     
     test_expect_success !MINGW 'start and stop macOS maintenance' '
    -	uid=$(id -u) &&
    +	uid=FAKE_UID &&
     
    -	write_script print-args <<-\EOF &&
    -	echo $* >>args
    +	write_script print-args <<-EOF &&
    +	echo \$* | perl -pe "s[(?<= gui/)-?[0-9]+][$uid]g" >>args
     	EOF
     
     	rm -f args &&

I.e. the context here is that the test is already hardcoding an
assumption about "gui/%d" (per code in gc.c). It seems more robust & to
the point of the test to not care about the specific UID number that
comes back, since we're really testing whether we invoke our own code,
not platform getuid() sanity.


>  	write_script print-args <<-\EOF &&
>  	echo $* >>args
> @@ -432,7 +434,7 @@ test_expect_success !MINGW 'start and stop macOS maintenance' '
>  	rm -f expect &&
>  	for frequency in hourly daily weekly
>  	do
> -		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
> +		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
>  		test_xmllint "$PLIST" &&
>  		grep schedule=$frequency "$PLIST" &&
>  		echo "bootout gui/$uid $PLIST" >>expect &&
> @@ -446,7 +448,7 @@ test_expect_success !MINGW 'start and stop macOS maintenance' '
>  	# stop does not unregister the repo
>  	git config --get --global maintenance.repo "$(pwd)" &&
>  
> -	printf "bootout gui/$uid $HOME/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
> +	printf "bootout gui/$uid $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
>  		hourly daily weekly >expect &&
>  	test_cmp expect args &&
>  	ls "$HOME/Library/LaunchAgents" >actual &&

