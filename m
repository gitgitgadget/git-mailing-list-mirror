Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F89C433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 06:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1CB020DD4
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 06:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbhADG0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 01:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbhADG0e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 01:26:34 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9652EC061793
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 22:25:54 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id x12so13968869plr.10
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 22:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=MNtHEQIacCUKJ/pxu13xs6Wj5ysrdBLBQDkK7wDU4o8=;
        b=JhEgMHwrf9pw0Ub0upEoyOMgggfTmaq1ax7sNPh9w8/1yzUN9i6Sz493VjDKyqFi5v
         gLQJXCLYGpcIpN30RC4y3TM67LMQpq0vXszcMdLZvtv+q47ECFVzKpOKAW8Q7ZOTRlaL
         TexzRO99ZidF729atDzTjKo/cb0AU0ht9xY9pFQka/S4xRCcaEXByXcVcKhkiWY7zJVS
         4DYkKkbZGE1+MrCGeAbCtofaaLYgUdeyQOrINu8fDk8A6X4EPJog7YeKvXhIypnUHS4+
         bi4Nl39uRSO1AZO3hqTCGCnM4hiv3czSMqs0/iUWzALweowZ2tCfovDOqeOMbSBAruXm
         XHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=MNtHEQIacCUKJ/pxu13xs6Wj5ysrdBLBQDkK7wDU4o8=;
        b=XyLDPLvkHG+rAvnHzPh3SmceQdZfQT+bnzHQUqm/Zih+ZWVVf+prSZIT1CZU6dS45u
         aO120c0Y66XqqF4s+KQEm7VoYTUsCFWOQzDEC6T9ayqrJCmzERaoAinIpgOjtAcsIDcb
         h28HUN3RXR0Hs/wtz1yhWaW1JuiED1ZO/wTBYDPH72BBfBoTWH9Z9jssk+wzvYVkDKDP
         CzWid2uSwglX4AAjXyt63SIK/TAxmKZNaw0djF+oaeRMLX8aDc1aH92GTljzgIHzsFvu
         2XOhpQ4vrnDdkTpgwf3/D4oHAzNqQ+zFcDtC5Clo0W7RWC+qOwzveHXapH/QubifCrNP
         fz6g==
X-Gm-Message-State: AOAM530Os+F1nVAdLAXOsr45ryWgOY4q+7ij8SDehY+765oP0sPcNETm
        +WcUwhtEdD6KDEsHxxe3HTLmcef03o4=
X-Google-Smtp-Source: ABdhPJxLPgb2Q/Ne51JVSmD8zBWTE+UQmYxOv5A/R3KZKo2LpxWnsL5nQtnu7RNs7CpMlKI4Pl0UoQ==
X-Received: by 2002:a17:90a:5782:: with SMTP id g2mr29276672pji.124.1609741554021;
        Sun, 03 Jan 2021 22:25:54 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:2ea2:315e:e4c8:7b10:b376:20dc])
        by smtp.gmail.com with ESMTPSA id 8sm38610161pfz.93.2021.01.03.22.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 22:25:53 -0800 (PST)
Date:   Mon, 4 Jan 2021 11:56:14 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Antonio Russo <aerusso@aerusso.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] t6016: move to lib-log-graph.sh framework
Message-ID: <X/K1BgP8tpsgNe2x@Abhishek-Arch>
Reply-To: 6dc37f6b-1afd-544d-126e-2be9422571c6@aerusso.net
References: <6dc37f6b-1afd-544d-126e-2be9422571c6@aerusso.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc37f6b-1afd-544d-126e-2be9422571c6@aerusso.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 03, 2021 at 07:30:35PM -0700, Antonio Russo wrote:
> t6016 manually reconstructs git log --graph output by using the reported
> commit hashes from `git rev-parse`.  Each tag is converted into an
> environment variable manually, and then `echo`-ed to an expected output
> file, which is in turn compared to the actual output.
> 
> The expected output is difficult to read and write, because, e.g.,
> each line of output must be prefaced with echo, quoted, and properly
> escaped.  Additionally, the test is sensitive to trailing whitespace,
> which may potentially be removed from graph log output in the future.
> 
> In order to reduce duplication, ease troubleshooting of failed tests by
> improving readability, and ease the addition of more tests to this file,
> port the operations to `lib-log-graph.sh`, which is already used in
> several other tests, e.g., t4215.  Give all merges a simple commit
> message, and use a common `check_graph` macro taking a heredoc of the
> expected output which does not required extensive escaping.
> 

Glad to see others using `lib-log-graph.sh` as well!

The changes look alright to me but maybe you could have split the two
changes into two different commits: Using tags directly instead of
environment variables and using `check_graph` instead of manually
`echo`-ing to an expected output and comparing with the actual output.

Other contributors would have a better idea whether it's truly required
or not.

> Signed-off-by: Antonio Russo <aerusso@aerusso.net>
> ---
>  t/t6016-rev-list-graph-simplify-history.sh | 354 ++++++++++-----------
>  1 file changed, 167 insertions(+), 187 deletions(-)
> 
> This patch builds, and passes the test suite on travis-ci:
> 
> https://travis-ci.org/github/aerusso/git/builds/752694578
> 
> diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
> index f5e6e92f5b..f79df8b6d1 100755
> --- a/t/t6016-rev-list-graph-simplify-history.sh
> +++ b/t/t6016-rev-list-graph-simplify-history.sh
> @@ -8,6 +8,12 @@
>  test_description='--graph and simplified history'
>  
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-log-graph.sh
> +
> +check_graph () {
> +	cat >expect &&
> +	lib_test_cmp_graph --format=%s "$@"
> +}
>  
>  test_expect_success 'set up rev-list --graph test' '
>  	# 3 commits on branch A
> @@ -28,7 +34,7 @@ test_expect_success 'set up rev-list --graph test' '
>  
>  	# Octopus merge B and C into branch A
>  	git checkout A &&
> -	git merge B C &&
> +	git merge B C -m A4 &&
>  	git tag A4 &&
>  
>  	test_commit A5 bar.txt &&
> @@ -38,81 +44,64 @@ test_expect_success 'set up rev-list --graph test' '
>  	test_commit C3 foo.txt &&
>  	test_commit C4 bar.txt &&
>  	git checkout A &&
> -	git merge -s ours C &&
> +	git merge -s ours C -m A6 &&
>  	git tag A6 &&
>  
> -	test_commit A7 bar.txt &&
> -
> -	# Store commit names in variables for later use
> -	A1=$(git rev-parse --verify A1) &&
> -	A2=$(git rev-parse --verify A2) &&
> -	A3=$(git rev-parse --verify A3) &&
> -	A4=$(git rev-parse --verify A4) &&
> -	A5=$(git rev-parse --verify A5) &&
> -	A6=$(git rev-parse --verify A6) &&
> -	A7=$(git rev-parse --verify A7) &&
> -	B1=$(git rev-parse --verify B1) &&
> -	B2=$(git rev-parse --verify B2) &&
> -	C1=$(git rev-parse --verify C1) &&
> -	C2=$(git rev-parse --verify C2) &&
> -	C3=$(git rev-parse --verify C3) &&
> -	C4=$(git rev-parse --verify C4)
> -	'
> +	test_commit A7 bar.txt
> +'
>  
>  test_expect_success '--graph --all' '
> -	rm -f expected &&
> -	echo "* $A7" >> expected &&
> -	echo "*   $A6" >> expected &&
> -	echo "|\\  " >> expected &&
> -	echo "| * $C4" >> expected &&
> -	echo "| * $C3" >> expected &&
> -	echo "* | $A5" >> expected &&
> -	echo "| |   " >> expected &&
> -	echo "|  \\  " >> expected &&
> -	echo "*-. | $A4" >> expected &&
> -	echo "|\\ \\| " >> expected &&
> -	echo "| | * $C2" >> expected &&
> -	echo "| | * $C1" >> expected &&
> -	echo "| * | $B2" >> expected &&
> -	echo "| * | $B1" >> expected &&
> -	echo "* | | $A3" >> expected &&
> -	echo "| |/  " >> expected &&
> -	echo "|/|   " >> expected &&
> -	echo "* | $A2" >> expected &&
> -	echo "|/  " >> expected &&
> -	echo "* $A1" >> expected &&
> -	git rev-list --graph --all > actual &&
> -	test_cmp expected actual
> -	'
> +	check_graph --all <<-\EOF
> +	* A7
> +	*   A6
> +	|\
> +	| * C4
> +	| * C3
> +	* | A5
> +	| |
> +	|  \
> +	*-. | A4
> +	|\ \|
> +	| | * C2
> +	| | * C1
> +	| * | B2
> +	| * | B1
> +	* | | A3
> +	| |/
> +	|/|
> +	* | A2
> +	|/
> +	* A1
> +	EOF
> +'
>  
>  # Make sure the graph_is_interesting() code still realizes
>  # that undecorated merges are interesting, even with --simplify-by-decoration
>  test_expect_success '--graph --simplify-by-decoration' '
> -	rm -f expected &&
>  	git tag -d A4 &&
> -	echo "* $A7" >> expected &&
> -	echo "*   $A6" >> expected &&
> -	echo "|\\  " >> expected &&
> -	echo "| * $C4" >> expected &&
> -	echo "| * $C3" >> expected &&
> -	echo "* | $A5" >> expected &&
> -	echo "| |   " >> expected &&
> -	echo "|  \\  " >> expected &&
> -	echo "*-. | $A4" >> expected &&
> -	echo "|\\ \\| " >> expected &&
> -	echo "| | * $C2" >> expected &&
> -	echo "| | * $C1" >> expected &&
> -	echo "| * | $B2" >> expected &&
> -	echo "| * | $B1" >> expected &&
> -	echo "* | | $A3" >> expected &&
> -	echo "| |/  " >> expected &&
> -	echo "|/|   " >> expected &&
> -	echo "* | $A2" >> expected &&
> -	echo "|/  " >> expected &&
> -	echo "* $A1" >> expected &&
> -	git rev-list --graph --all --simplify-by-decoration > actual &&
> -	test_cmp expected actual
> -	'
> +	check_graph --all --simplify-by-decoration <<-\EOF
> +	* A7
> +	*   A6
> +	|\
> +	| * C4
> +	| * C3
> +	* | A5
> +	| |
> +	|  \
> +	*-. | A4
> +	|\ \|
> +	| | * C2
> +	| | * C1
> +	| * | B2
> +	| * | B1
> +	* | | A3
> +	| |/
> +	|/|
> +	* | A2
> +	|/
> +	* A1
> +	EOF
> +'
>  
>  test_expect_success 'setup: get rid of decorations on B' '
>  	git tag -d B2 &&
> @@ -122,142 +111,133 @@ test_expect_success 'setup: get rid of decorations on B' '
>  
>  # Graph with branch B simplified away
>  test_expect_success '--graph --simplify-by-decoration prune branch B' '
> -	rm -f expected &&
> -	echo "* $A7" >> expected &&
> -	echo "*   $A6" >> expected &&
> -	echo "|\\  " >> expected &&
> -	echo "| * $C4" >> expected &&
> -	echo "| * $C3" >> expected &&
> -	echo "* | $A5" >> expected &&
> -	echo "* | $A4" >> expected &&
> -	echo "|\\| " >> expected &&
> -	echo "| * $C2" >> expected &&
> -	echo "| * $C1" >> expected &&
> -	echo "* | $A3" >> expected &&
> -	echo "|/  " >> expected &&
> -	echo "* $A2" >> expected &&
> -	echo "* $A1" >> expected &&
> -	git rev-list --graph --simplify-by-decoration --all > actual &&
> -	test_cmp expected actual
> -	'
> +	check_graph --simplify-by-decoration --all <<-\EOF
> +	* A7
> +	*   A6
> +	|\
> +	| * C4
> +	| * C3
> +	* | A5
> +	* | A4
> +	|\|
> +	| * C2
> +	| * C1
> +	* | A3
> +	|/
> +	* A2
> +	* A1
> +	EOF
> +'
>  
>  test_expect_success '--graph --full-history -- bar.txt' '
> -	rm -f expected &&
> -	echo "* $A7" >> expected &&
> -	echo "*   $A6" >> expected &&
> -	echo "|\\  " >> expected &&
> -	echo "| * $C4" >> expected &&
> -	echo "* | $A5" >> expected &&
> -	echo "* | $A4" >> expected &&
> -	echo "|\\| " >> expected &&
> -	echo "* | $A3" >> expected &&
> -	echo "|/  " >> expected &&
> -	echo "* $A2" >> expected &&
> -	git rev-list --graph --full-history --all -- bar.txt > actual &&
> -	test_cmp expected actual
> -	'
> +	check_graph --full-history --all -- bar.txt <<-\EOF
> +	* A7
> +	*   A6
> +	|\
> +	| * C4
> +	* | A5
> +	* | A4
> +	|\|
> +	* | A3
> +	|/
> +	* A2
> +	EOF
> +'
>  
>  test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
> -	rm -f expected &&
> -	echo "* $A7" >> expected &&
> -	echo "*   $A6" >> expected &&
> -	echo "|\\  " >> expected &&
> -	echo "| * $C4" >> expected &&
> -	echo "* | $A5" >> expected &&
> -	echo "* | $A3" >> expected &&
> -	echo "|/  " >> expected &&
> -	echo "* $A2" >> expected &&
> -	git rev-list --graph --full-history --simplify-merges --all \
> -		-- bar.txt > actual &&
> -	test_cmp expected actual
> -	'
> +	check_graph --full-history --simplify-merges --all -- bar.txt <<-\EOF
> +	* A7
> +	*   A6
> +	|\
> +	| * C4
> +	* | A5
> +	* | A3
> +	|/
> +	* A2
> +	EOF
> +'
>  
>  test_expect_success '--graph -- bar.txt' '
> -	rm -f expected &&
> -	echo "* $A7" >> expected &&
> -	echo "* $A5" >> expected &&
> -	echo "* $A3" >> expected &&
> -	echo "| * $C4" >> expected &&
> -	echo "|/  " >> expected &&
> -	echo "* $A2" >> expected &&
> -	git rev-list --graph --all -- bar.txt > actual &&
> -	test_cmp expected actual
> -	'
> +	check_graph --all -- bar.txt <<-\EOF
> +	* A7
> +	* A5
> +	* A3
> +	| * C4
> +	|/
> +	* A2
> +	EOF
> +'
>  
>  test_expect_success '--graph --sparse -- bar.txt' '
> -	rm -f expected &&
> -	echo "* $A7" >> expected &&
> -	echo "* $A6" >> expected &&
> -	echo "* $A5" >> expected &&
> -	echo "* $A4" >> expected &&
> -	echo "* $A3" >> expected &&
> -	echo "| * $C4" >> expected &&
> -	echo "| * $C3" >> expected &&
> -	echo "| * $C2" >> expected &&
> -	echo "| * $C1" >> expected &&
> -	echo "|/  " >> expected &&
> -	echo "* $A2" >> expected &&
> -	echo "* $A1" >> expected &&
> -	git rev-list --graph --sparse --all -- bar.txt > actual &&
> -	test_cmp expected actual
> -	'
> +	check_graph --sparse --all -- bar.txt <<-\EOF
> +	* A7
> +	* A6
> +	* A5
> +	* A4
> +	* A3
> +	| * C4
> +	| * C3
> +	| * C2
> +	| * C1
> +	|/
> +	* A2
> +	* A1
> +	EOF
> +'
>  
>  test_expect_success '--graph ^C4' '
> -	rm -f expected &&
> -	echo "* $A7" >> expected &&
> -	echo "* $A6" >> expected &&
> -	echo "* $A5" >> expected &&
> -	echo "*   $A4" >> expected &&
> -	echo "|\\  " >> expected &&
> -	echo "| * $B2" >> expected &&
> -	echo "| * $B1" >> expected &&
> -	echo "* $A3" >> expected &&
> -	git rev-list --graph --all ^C4 > actual &&
> -	test_cmp expected actual
> -	'
> +	check_graph --all ^C4 <<-\EOF
> +	* A7
> +	* A6
> +	* A5
> +	*   A4
> +	|\
> +	| * B2
> +	| * B1
> +	* A3
> +	EOF
> +'
>  
>  test_expect_success '--graph ^C3' '
> -	rm -f expected &&
> -	echo "* $A7" >> expected &&
> -	echo "*   $A6" >> expected &&
> -	echo "|\\  " >> expected &&
> -	echo "| * $C4" >> expected &&
> -	echo "* $A5" >> expected &&
> -	echo "*   $A4" >> expected &&
> -	echo "|\\  " >> expected &&
> -	echo "| * $B2" >> expected &&
> -	echo "| * $B1" >> expected &&
> -	echo "* $A3" >> expected &&
> -	git rev-list --graph --all ^C3 > actual &&
> -	test_cmp expected actual
> -	'
> +	check_graph --all ^C3 <<-\EOF
> +	* A7
> +	*   A6
> +	|\
> +	| * C4
> +	* A5
> +	*   A4
> +	|\
> +	| * B2
> +	| * B1
> +	* A3
> +	EOF
> +'
>  
>  # I don't think the ordering of the boundary commits is really
>  # that important, but this test depends on it.  If the ordering ever changes
>  # in the code, we'll need to update this test.
>  test_expect_success '--graph --boundary ^C3' '
> -	rm -f expected &&
> -	echo "* $A7" >> expected &&
> -	echo "*   $A6" >> expected &&
> -	echo "|\\  " >> expected &&
> -	echo "| * $C4" >> expected &&
> -	echo "* | $A5" >> expected &&
> -	echo "| |     " >> expected &&
> -	echo "|  \\    " >> expected &&
> -	echo "*-. \\   $A4" >> expected &&
> -	echo "|\\ \\ \\  " >> expected &&
> -	echo "| * | | $B2" >> expected &&
> -	echo "| * | | $B1" >> expected &&
> -	echo "* | | | $A3" >> expected &&
> -	echo "o | | | $A2" >> expected &&
> -	echo "|/ / /  " >> expected &&
> -	echo "o / / $A1" >> expected &&
> -	echo " / /  " >> expected &&
> -	echo "| o $C3" >> expected &&
> -	echo "|/  " >> expected &&
> -	echo "o $C2" >> expected &&
> -	git rev-list --graph --boundary --all ^C3 > actual &&
> -	test_cmp expected actual
> -	'
> +	check_graph --boundary --all ^C3 <<-\EOF
> +	* A7
> +	*   A6
> +	|\
> +	| * C4
> +	* | A5
> +	| |
> +	|  \
> +	*-. \   A4
> +	|\ \ \
> +	| * | | B2
> +	| * | | B1
> +	* | | | A3
> +	o | | | A2
> +	|/ / /
> +	o / / A1
> +	 / /
> +	| o C3
> +	|/
> +	o C2
> +	EOF
> +'
>  
>  test_done
> -- 
> 2.30.0

Thanks
- Abhishek
