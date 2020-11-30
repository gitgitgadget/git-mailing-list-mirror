Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7B1C64E90
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 13:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F542073C
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 13:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYHaDwFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgK3NMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 08:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgK3NMs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 08:12:48 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CF3C0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 05:12:27 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id h19so11231779otr.1
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 05:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+VvEQ8iiLf3S57MYBkJqb5OpxD3orBTxS5/jsWEBYS8=;
        b=CYHaDwFeeY6pvzFZd66ffNeDPsoQOJ4mZ57Z42CqB2Isanah5PTAHo4Aaj5cn2nDae
         aJ9mAxtwP+KmmmNafUNKOsfit0EENjcvKfxo0LII1Z2BW+Opq4sg01c3kzqE8r9Ko72e
         oTvj/DMmLF9VDQbp6YKcHknN8hAX7y4GkoaDMYG+s9nLv9sE9jQKjtiazci3IkCUVAWt
         yLvCk6gVmGmf4FTAymA2Z7TYIkdHNaBm9aAeq9C6DkwVLEEZ7Q5GYD1EXpyQ6GOD3lQB
         h5rfMW/lBLmP1eZoDuwQS5LGFyiAh36c9VcbU++T9wT52xDX0J/7IRFbu0oLs6admRcf
         Rp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+VvEQ8iiLf3S57MYBkJqb5OpxD3orBTxS5/jsWEBYS8=;
        b=POved5nJoVuAAuz2tTqnKSnMmPHIx5RtSLbTdXPl1mt17Car/6LJtB4nmr9IhjMjO+
         PbQ8aMKq50HkTqrMXZj/W7YkW3VVzowRfzcMCAMQdVmwj1tG0vsRuwCoOwQwXUXWhnOm
         8/3eSqaH04sRpBgAuJnMB6gsyUaXpT5I+92d0eAn1HGwSWq8CZ0sM/FZjbuvQLfvUgtO
         V2x5b+Ly8rXiGxrbklDJDLy785AD8l5nH+W8jaexYeffKH89BDKdtDF5TzBdWlZYbuWR
         Zosvh1EYz5UA7MzQkTx+Sbg/FWmCYqkVcPW3cQoGYvsdtDipInYeMgr1W/INb0azhW2l
         oHLw==
X-Gm-Message-State: AOAM533G0o9bcJ26jVYRB2Ae5bJfC3X1wHwTw8c/IoXzBke8CrN8LD/V
        XSd2Rj3REeF0Oh9WDkVJc/4=
X-Google-Smtp-Source: ABdhPJz+351MpBuZRXUaiRk9/w5ZzNMYjjiLuOKx4U9/wuZ2ljajkBqWroxBM/rJPv5u365X8emTmA==
X-Received: by 2002:a9d:67d8:: with SMTP id c24mr15668583otn.356.1606741946697;
        Mon, 30 Nov 2020 05:12:26 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id j16sm9914998oot.24.2020.11.30.05.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 05:12:25 -0800 (PST)
Subject: Re: [PATCH v2 2/2] t7900: make macOS-specific test work on Windows
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20201130044224.12298-1-sunshine@sunshineco.com>
 <20201130044224.12298-3-sunshine@sunshineco.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e4647058-3bb6-7aa4-c245-95e3f4b3bc66@gmail.com>
Date:   Mon, 30 Nov 2020 08:12:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201130044224.12298-3-sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2020 11:42 PM, Eric Sunshine wrote:
> Although `git maintenance start` and `git maintenance stop` necessarily
> invoke platform-specific scheduling utilities, their related tests have
> been carefully crafted -- with one minor exception -- to work correctly
> on any platform, thus improving overall coverage. The exception is that
> the macOS-specific test fails on Windows due to non-portable use of
> `$(id -u)` and comparison involving the value of $HOME.

I appreciate your time making this change, as I was unable to work
around these issues myself.

> In particular, on Windows, the value of getuid() called by the C code is
> not guaranteed to be the same as `$(id -u)` invoked by the test. This is
> because `git.exe` is a native Windows program, whereas the utility
> programs run by the test script mostly utilize the MSYS2 runtime, which
> emulates a POSIX-like environment. Since the purpose of the test is to
> check that the input to the hook is well-formed, the actual user ID is
> immaterial, thus we can work around the problem by making the the test
> UID-agnostic.
> 
> As for comparison of $HOME, it suffers from the typical shortcoming on
> Windows in which the same path may be represented two different ways
> depending upon its source (i.e. as a Windows path
> `C:/git-sdk-64/usr/src/git/foo` versus as a Unix path
> `/usr/src/git/foo`).
> 
> Fix both problems and drop the !MINGW prerequisite from the
> macOS-specific test, thus allowing the test to run on Windows, as well.
> 
> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t7900-maintenance.sh | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index ef3aec3253..514977a838 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -408,11 +408,12 @@ test_expect_success 'start preserves existing schedule' '
>  	grep "Important information!" cron.txt
>  '
>  
> -test_expect_success !MINGW 'start and stop macOS maintenance' '
> -	uid=$(id -u) &&
> +test_expect_success 'start and stop macOS maintenance' '
> +	# ensure $HOME can be compared against hook arguments on all platforms
> +	pfx=$(cd "$HOME" && pwd) &&

> -		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
> +		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&

This pair of changes make sense to get around the $HOME issue
that caused me to surrender the effort.

>  	write_script print-args <<-\EOF &&
> -	echo $* >>args
> +	echo $* | sed "s:gui/[0-9][0-9]*:gui/[UID]:" >>args

Filtering out the UID into a fixed string...

> -		echo "bootout gui/$uid $PLIST" >>expect &&
> -		echo "bootstrap gui/$uid $PLIST" >>expect || return 1
> +		echo "bootout gui/[UID] $PLIST" >>expect &&
> +		echo "bootstrap gui/[UID] $PLIST" >>expect || return 1
>  	done &&
>  	test_cmp expect args &&

.. then checking for that fixed string. Clever!

Thanks!
-Stolee
