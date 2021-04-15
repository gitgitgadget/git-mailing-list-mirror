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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0933BC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 22:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D487D610F7
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 22:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbhDOWF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 18:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbhDOWF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 18:05:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE4C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 15:05:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j12so4868586edy.3
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=43kloLK2dxswgt1YMD1Knqzhz9z8AesibHacek8jVKM=;
        b=aDTqoGHa/CKYfY8eJmwCc7ngdOi+rD7rnpTDV+3hU6JAYCiQYR2/XPZR1HA93nd1zJ
         WhLrEurxWshh2G4q+4FEo/p/BMIl0SpBy22chnCmjqjDg2rf0NHBuq/CHUfX4bD47w3/
         2cJRA+TPBl/3EhdcJsVryBGpafnzDPJjoFyv/wDLtGHtNrGuLKs4wGxkFDXl3kBrf1vo
         qo0FAwAia6a6F7ZWcOINpFAihfgj2RGrTQSP0sLnpIF+UHj38ExuKmHTJbMtd36m6UqC
         +Gya8+X+xtBSDaZnBF6KcNMvskyqPeWBTmGZbsLq5bBGozMYVFvDYuhmPTmrhcfi0Ehd
         kSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=43kloLK2dxswgt1YMD1Knqzhz9z8AesibHacek8jVKM=;
        b=AbGvAgNle/S389vXKzmbM0MjxexnG5QzBTipmtSW/p8uflwvseBVXLuXLYfSa3dYpD
         piAdlN6uM5o3iv/WLIVogKiodQJ/ElqtVrfBobKpBjWdJeS0l6g1IjCzwInkAUTWA8gv
         GtCA0ca+1TLlurma3TynhopMC6xQNpsf9+Mi3sKXBkHbfi2Anini3IgczidFmNXKMqQN
         GYwFN87ujxm0LihaCy/T13EeIZAajxhDFp7BMBJhgdoWL6DwQOKcbuc/J9mVZ3g3xPAx
         xcFTYtycsQNDdYI+y3ux9wDAMVWOEyGfjOwcUWfkdAn3THgbkKFQVMB0RglLk0IOKrfE
         8UAQ==
X-Gm-Message-State: AOAM5339/kwb6F6MapBVA/Rdi+3afx/Kal3ok7Mu3Y080dfOERUmAzFd
        ICC2hhIDBkBsDRiAq8luhyE=
X-Google-Smtp-Source: ABdhPJwCWAuJ3bNvM9a3XqNltsm68ukTeI9AcrD03s2V1/C8SiYV+qYBq9Q80JjFa/OTQ5XF5aE5wg==
X-Received: by 2002:aa7:c7da:: with SMTP id o26mr6753052eds.244.1618524328646;
        Thu, 15 Apr 2021 15:05:28 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id g11sm3093111edy.9.2021.04.15.15.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 15:05:28 -0700 (PDT)
Date:   Fri, 16 Apr 2021 00:05:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 15/16] Revert and amend "test-lib-functions: assert
 correct parameter count"
Message-ID: <20210415220526.GO2947267@szeder.dev>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-15.16-0cd511206c4-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-15.16-0cd511206c4-20210412T110456Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 01:09:04PM +0200, Ævar Arnfjörð Bjarmason wrote:
> This reverts and amends my my own e7884b353b7 (test-lib-functions:
> assert correct parameter count, 2021-02-12) in order to improve the -x
> output.
> 
> When I added these BUG assertions in e7884b353b7 I missed that this
> made the -x output much more verbose.
> 
> E.g. for each test_cmp invocation we'd now emit:
> 
>     + test_cmp expect actual
>     + test 2 -ne 2
>     + eval diff -u "$@"
>     + diff -u expect actual
> 
> That "test 2 -ne 2" line is new in e7884b353b7. As noted in
> 45a2686441b (test-lib-functions: remove bug-inducing "diagnostics"
> helper param, 2021-02-12) we had buggy invocations of some of these
> functions with too many parameters.
> 
> Let's instead use "$@" instead of "$1" to achieve the same ends with
> no extra -x output verbosity. The "test" operator will die with an
> error if given more than one argument in these contexts, so using "$@"
> achieves the same goal.

I prefer the current check for its explicitness over the implicit and
somewhat cryptic approach introduced in this patch.  I hope that
sooner or later I'll finish up my patch series to suppress '-x' output
from test helper functions, and then this issue will become moot
anyway.

> The same goes for "cmp" and "diff -u" (which we typically use for
> test_cmp).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/test-lib-functions.sh | 41 ++++++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index c46bf0ff09c..2cf72b56851 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -759,39 +759,35 @@ test_external_without_stderr () {
>  # debugging-friendly alternatives to "test [-f|-d|-e]"
>  # The commands test the existence or non-existence of $1
>  test_path_is_file () {
> -	test "$#" -ne 1 && BUG "1 param"
> -	if ! test -f "$1"
> +	if ! test -f "$@"
>  	then
> -		echo "File $1 doesn't exist"
> +		echo "File $@ doesn't exist"
>  		return 1
>  	fi
>  }
>  
>  test_path_is_dir () {
> -	test "$#" -ne 1 && BUG "1 param"
> -	if ! test -d "$1"
> +	if ! test -d "$@"
>  	then
> -		echo "Directory $1 doesn't exist"
> +		echo "Directory $@ doesn't exist"
>  		return 1
>  	fi
>  }
>  
>  test_path_exists () {
> -	test "$#" -ne 1 && BUG "1 param"
> -	if ! test -e "$1"
> +	if ! test -e "$@"
>  	then
> -		echo "Path $1 doesn't exist"
> +		echo "Path $@ doesn't exist"
>  		return 1
>  	fi
>  }
>  
>  # Check if the directory exists and is empty as expected, barf otherwise.
>  test_dir_is_empty () {
> -	test "$#" -ne 1 && BUG "1 param"
> -	test_path_is_dir "$1" &&
> -	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
> +	test_path_is_dir "$@" &&
> +	if test -n "$(ls -a1 "$@" | egrep -v '^\.\.?$')"
>  	then
> -		echo "Directory '$1' is not empty, it contains:"
> +		echo "Directory '$@' is not empty, it contains:"
>  		ls -la "$1"
>  		return 1
>  	fi
> @@ -799,17 +795,15 @@ test_dir_is_empty () {
>  
>  # Check if the file exists and has a size greater than zero
>  test_file_not_empty () {
> -	test "$#" = 2 && BUG "2 param"
> -	if ! test -s "$1"
> +	if ! test -s "$@"
>  	then
> -		echo "'$1' is not a non-empty file."
> +		echo "'$@' is not a non-empty file."
>  		return 1
>  	fi
>  }
>  
>  test_path_is_missing () {
> -	test "$#" -ne 1 && BUG "1 param"
> -	if test -e "$1"
> +	if test -e "$@"
>  	then
>  		echo "Path $1 exists!"
>  		false
> @@ -1013,7 +1007,6 @@ test_expect_code () {
>  # - not all diff versions understand "-u"
>  
>  test_cmp () {
> -	test "$#" -ne 2 && BUG "2 param"
>  	eval "$GIT_TEST_CMP" '"$@"'
>  }
>  
> @@ -1043,7 +1036,6 @@ test_cmp_config () {
>  # test_cmp_bin - helper to compare binary files
>  
>  test_cmp_bin () {
> -	test "$#" -ne 2 && BUG "2 param"
>  	cmp "$@"
>  }
>  
> @@ -1104,12 +1096,11 @@ verbose () {
>  # otherwise.
>  
>  test_must_be_empty () {
> -	test "$#" -ne 1 && BUG "1 param"
> -	test_path_is_file "$1" &&
> -	if test -s "$1"
> +	test_path_is_file "$@" &&
> +	if test -s "$@"
>  	then
> -		echo "'$1' is not empty, it contains:"
> -		cat "$1"
> +		echo "'$@' is not empty, it contains:"
> +		cat "$@"
>  		return 1
>  	fi
>  }
> -- 
> 2.31.1.634.gb41287a30b0
> 
