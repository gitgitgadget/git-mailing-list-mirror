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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E889C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446E1613C4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbhDMTok (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 15:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhDMToj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 15:44:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562D1C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 12:44:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l4so27781068ejc.10
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fRJseCS+LCGyUOwMEYiKn5aMuL9jfOJdBRKAyaDXIiI=;
        b=lo+Uz4UxB5coxdCIQCsZX20hVwlXeB2IZuV+RLPdHOPlYtvMMRzvC7K0/8s2fFHIAU
         LFAn96P0BaWxyCLHM/ihu/Pt80Uzp5KNKzXJfSngX1hrbJukzVYMLb4thYemaeKPdAXs
         D2TLZv77MOGcVTk2w6lZlkPYFOHAGl2izJ8MduCUGGFkiAqDQvpUmaTF+trk0aBFbEmV
         95oTGoWAQDE7qj725LY/Dy6HvAQi6myljX8melAYjIZpm9NXkIRsBYWR/Ghi6800yyx2
         RB5YvESgxYqPZ5Vm8ZqqpuHdTXgHfr5X0WiBsvefovkb1hqwvHMLbIG/Nv0seJP13K5/
         +uhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fRJseCS+LCGyUOwMEYiKn5aMuL9jfOJdBRKAyaDXIiI=;
        b=PMe0j+WGzt80CSndnLm5Lz27X/2wCERGcZhvZvYvDEWEMAsTv3M/sRQUlGV6Uza2PG
         EYclem+35Qc+uFE4oCt9EJb6WgG5CINwOqbVykiFQmJ4LmrIOatcf0bgPs2Djm0UCJIQ
         Dqv4sNkwfqYaLqnd2LE/LF3vMGnqGLgGxZoSCVt9U4TRbK4zE6fft1aoTszuhg4/NJot
         5vCI+fb4eGNuTTxc4UhrdgQ21iYfBLsk2lLQSmsK3QXtet9UR/0H7y4oHL8IQrKb3I4W
         OysPXuu0FfuzGfhXCQRP4sNvxPl78pL4sVyskfO1ppt2JCoN8ZobQbSs3NjPGHWG4XAj
         +WFA==
X-Gm-Message-State: AOAM533EQIekZ/QcB2WiThhzGCxPpUjnvGik2s/aXCOTFBrndZD9oae2
        N4zZ1wu+nj9KRMzgVsZnwOY=
X-Google-Smtp-Source: ABdhPJyK/Dol28y8k1M2Ru6nc8DEhijGoKI0HNwKahz2rBbt5WPYLugxwRz6BmKQodqYFryoRZ7awg==
X-Received: by 2002:a17:906:cc48:: with SMTP id mm8mr8064181ejb.58.1618343057916;
        Tue, 13 Apr 2021 12:44:17 -0700 (PDT)
Received: from szeder.dev (94-21-23-40.pool.digikabel.hu. [94.21.23.40])
        by smtp.gmail.com with ESMTPSA id q12sm8793353ejy.91.2021.04.13.12.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 12:44:17 -0700 (PDT)
Date:   Tue, 13 Apr 2021 21:44:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t0091-bugreport.sh: actually verify some content of
 report
Message-ID: <20210413194415.GK2947267@szeder.dev>
References: <20210409212724.GE2947267@szeder.dev>
 <20210411143354.25134-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210411143354.25134-1-martin.agren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 11, 2021 at 04:33:54PM +0200, Martin Ågren wrote:
> In the first test in this script, 'creates a report with content in the
> right places', we generate a report and pipe it into our helper
> `check_all_headers_populated()`. The idea of the helper is to find all
> lines that look like headers ("[Some Header Here]") and to check that
> the next line is non-empty. This is supposed to catch erroneous outputs
> such as the following:
> 
>   [A Header]
>   something
>   more here
> 
>   [Another Header]
> 
>   [Too Early Header]
>   contents
> 
> However, we provide the lines of the bug report as filenames to grep,
> meaning we mostly end up spewing errors:
> 
>   grep: : No such file or directory
>   grep: [System Info]: No such file or directory
>   grep: git version:: No such file or directory
>   grep: git version 2.31.1.164.g984c2561cd: No such file
> 
> This doesn't disturb the test, which tugs along and reports success, not
> really having verified the contents of the report at all.
> 
> Note that after 788a776069 ("bugreport: collect list of populated
> hooks", 2020-05-07), the bug report, which is created in our hook-less
> test repo, contains an empty section with the enabled hooks. Thus, even
> the intention of our helper is a bit misguided: there is nothing
> inherently wrong with having an empty section in the bug report.
> 
> Let's instead grep for some contents that we expect to find in a bug
> report. We won't verify that they appear in the right order, but at
> least we end up verifying the contents more than before this commit.
> 
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  > It does scare me..
> 
>  Maybe something like this?

Thanks!

>  t/t0091-bugreport.sh | 26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> index 526304ff95..9111c4c26f 100755
> --- a/t/t0091-bugreport.sh
> +++ b/t/t0091-bugreport.sh
> @@ -4,29 +4,13 @@ test_description='git bugreport'
>  
>  . ./test-lib.sh
>  
> -# Headers "[System Info]" will be followed by a non-empty line if we put some
> -# information there; we can make sure all our headers were followed by some
> -# information to check if the command was successful.
> -HEADER_PATTERN="^\[.*\]$"
> -
> -check_all_headers_populated () {
> -	while read -r line
> -	do
> -		if test "$(grep "$HEADER_PATTERN" "$line")"
> -		then
> -			echo "$line"
> -			read -r nextline
> -			if test -z "$nextline"; then
> -				return 1;
> -			fi
> -		fi
> -	done
> -}
> -
> -test_expect_success 'creates a report with content in the right places' '
> +test_expect_success 'creates a report with content' '
>  	test_when_finished rm git-bugreport-check-headers.txt &&
>  	git bugreport -s check-headers &&
> -	check_all_headers_populated <git-bugreport-check-headers.txt
> +	grep "^Please answer " git-bugreport-check-headers.txt &&

This "Please answer" is translated and you look for it with plain
'grep' instead of 'test_i18ngrep', which is fine nowadays...  However,
Junio queued this patch on top of v2.29.3, which is old enough to
still have the GETTEXT_POISON CI job, and fails because of this.

> +	grep "^\[System Info\]$" git-bugreport-check-headers.txt &&
> +	grep "^git version:$" git-bugreport-check-headers.txt &&
> +	grep "^\[Enabled Hooks\]$" git-bugreport-check-headers.txt
>  '

I have to wonder, however, whether this is worth testing at all.

>  
>  test_expect_success 'dies if file with same name as report already exists' '
> -- 
> 2.31.1.163.ga65ce7f831
> 
