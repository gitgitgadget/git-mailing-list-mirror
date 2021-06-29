Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5254C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE8D6187E
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhF2BPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:15:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56581 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhF2BPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:15:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31D671326F4;
        Mon, 28 Jun 2021 21:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=kMLgkRRwSg1EKdAnq3G9Hjedusj8CGKKCfJZeAgYrqU=; b=UBz+
        zOuAiWO+MIZWenE0NWJy2QGHtB/IK7OMb1K/vadmGrvdm7jOiA89RRzh6tY7otPK
        TqM15b/pd63m/u2ioSKDCdvmks0xc8godZ2rgLB6jS5bQ9NZUBNlfysJvuqO479M
        DD2voCtOn00tRxOBbSJef2FE93bqUFswauGjJ90=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 299F81326F3;
        Mon, 28 Jun 2021 21:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6AC581326F2;
        Mon, 28 Jun 2021 21:12:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] perf: fix when running with TEST_OUTPUT_DIRECTORY
References: <005cc9a695f7f9b17190293821369763e9bae662.1623834515.git.ps@pks.im>
        <cb9d948646e8181e9c9c8dc35b37d48c692a92fb.1624024532.git.ps@pks.im>
Date:   Mon, 28 Jun 2021 18:12:37 -0700
Message-ID: <xmqqbl7p4goq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19717BD0-D877-11EB-9CDC-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When the TEST_OUTPUT_DIRECTORY is defined, then all test data will be
> written in that directory instead of the default directory located in
> "t/". While this works as expected for our normal tests, performance
> tests fail to locate and aggregate performance data because they don't
> know to handle TEST_OUTPUT_DIRECTORY correctly and always look at the
> default location.
>
> Fix the issue by adding a `--results-dir` parameter to "aggregate.perl"
> which identifies the directory where results are and by making the "run"
> script awake of the TEST_OUTPUT_DIRECTORY variable.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

This looks sensible to me, but it is not exactly my area of
expertise.  An Acked-by or Reviewed-by from those who have stake in
t/perf/ would be appreciated.

Thanks.

> Range-diff against v1:
> 1:  8f73bd5d38 ! 1:  cb9d948646 perf: fix when running with TEST_OUTPUT_DIRECTORY
>     @@ t/perf/aggregate.perl: sub usage {
>           --subsection  <str>  * Use results from given subsection
>       
>      @@ t/perf/aggregate.perl: sub sane_backticks {
>     - }
>       
>       my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
>     --    $codespeed, $sortby, $subsection, $reponame);
>     -+    $codespeed, $sortby, $subsection, $reponame, $resultsdir);
>     +     $codespeed, $sortby, $subsection, $reponame);
>     ++my $resultsdir = "test-results";
>       
>       Getopt::Long::Configure qw/ require_order /;
>       
>     @@ t/perf/aggregate.perl: sub sane_backticks {
>       }
>       
>      -my $resultsdir = "test-results";
>     -+if (not $resultsdir) {
>     -+	$resultsdir = "test-results";
>     -+}
>     - 
>     +-
>       if (! $subsection and
>           exists $ENV{GIT_PERF_SUBSECTION} and
>     +     $ENV{GIT_PERF_SUBSECTION} ne "") {
>      
>       ## t/perf/perf-lib.sh ##
>      @@ t/perf/perf-lib.sh: export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR GIT_TEST_CMP
>     @@ t/perf/perf-lib.sh: test_size () {
>       test_at_end_hook_ () {
>       	if test -z "$GIT_PERF_AGGREGATING_LATER"; then
>      -		( cd "$TEST_DIRECTORY"/perf && ./aggregate.perl $(basename "$0") )
>     -+		( cd "$TEST_DIRECTORY"/perf && ./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $(basename "$0") )
>     ++		(
>     ++			cd "$TEST_DIRECTORY"/perf &&
>     ++			./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $(basename "$0")
>     ++		)
>       	fi
>       }
>       
>     @@ t/perf/run: get_var_from_env_or_config "GIT_PERF_SEND_TO_CODESPEED" "perf" "send
>      -get_subsections "perf" >test-results/run_subsections.names
>      +if test -n "$TEST_OUTPUT_DIRECTORY"
>      +then
>     -+    TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
>     ++	TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
>      +else
>     -+    TEST_RESULTS_DIR=test-results
>     ++	TEST_RESULTS_DIR=test-results
>      +fi
>       
>      -if test $(wc -l <test-results/run_subsections.names) -eq 0
>
>  t/perf/aggregate.perl |  5 +++--
>  t/perf/perf-lib.sh    |  7 +++++--
>  t/perf/run            | 25 ++++++++++++++++---------
>  3 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> index 14e4cda287..82c0df4553 100755
> --- a/t/perf/aggregate.perl
> +++ b/t/perf/aggregate.perl
> @@ -58,6 +58,7 @@ sub usage {
>    Options:
>      --codespeed          * Format output for Codespeed
>      --reponame    <str>  * Send given reponame to codespeed
> +    --results-dir <str>  * Directory where test results are located
>      --sort-by     <str>  * Sort output (only "regression" criteria is supported)
>      --subsection  <str>  * Use results from given subsection
>  
> @@ -91,11 +92,13 @@ sub sane_backticks {
>  
>  my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
>      $codespeed, $sortby, $subsection, $reponame);
> +my $resultsdir = "test-results";
>  
>  Getopt::Long::Configure qw/ require_order /;
>  
>  my $rc = GetOptions("codespeed"     => \$codespeed,
>  		    "reponame=s"    => \$reponame,
> +		    "results-dir=s" => \$resultsdir,
>  		    "sort-by=s"     => \$sortby,
>  		    "subsection=s"  => \$subsection);
>  usage() unless $rc;
> @@ -137,8 +140,6 @@ sub sane_backticks {
>  	@tests = glob "p????-*.sh";
>  }
>  
> -my $resultsdir = "test-results";
> -
>  if (! $subsection and
>      exists $ENV{GIT_PERF_SUBSECTION} and
>      $ENV{GIT_PERF_SUBSECTION} ne "") {
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 601d9f67dd..f5ed092ee5 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -45,7 +45,7 @@ export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR GIT_TEST_CMP
>  MODERN_GIT=$GIT_BUILD_DIR/bin-wrappers/git
>  export MODERN_GIT
>  
> -perf_results_dir=$TEST_OUTPUT_DIRECTORY/test-results
> +perf_results_dir=$TEST_RESULTS_DIR
>  test -n "$GIT_PERF_SUBSECTION" && perf_results_dir="$perf_results_dir/$GIT_PERF_SUBSECTION"
>  mkdir -p "$perf_results_dir"
>  rm -f "$perf_results_dir"/$(basename "$0" .sh).subtests
> @@ -253,7 +253,10 @@ test_size () {
>  # and does it after running everything)
>  test_at_end_hook_ () {
>  	if test -z "$GIT_PERF_AGGREGATING_LATER"; then
> -		( cd "$TEST_DIRECTORY"/perf && ./aggregate.perl $(basename "$0") )
> +		(
> +			cd "$TEST_DIRECTORY"/perf &&
> +			./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $(basename "$0")
> +		)
>  	fi
>  }
>  
> diff --git a/t/perf/run b/t/perf/run
> index c7b86104e1..d19dec258a 100755
> --- a/t/perf/run
> +++ b/t/perf/run
> @@ -188,10 +188,10 @@ run_subsection () {
>  
>  	if test -z "$GIT_PERF_SEND_TO_CODESPEED"
>  	then
> -		./aggregate.perl $codespeed_opt "$@"
> +		./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $codespeed_opt "$@"
>  	else
> -		json_res_file="test-results/$GIT_PERF_SUBSECTION/aggregate.json"
> -		./aggregate.perl --codespeed "$@" | tee "$json_res_file"
> +		json_res_file=""$TEST_RESULTS_DIR"/$GIT_PERF_SUBSECTION/aggregate.json"
> +		./aggregate.perl --results-dir="$TEST_RESULTS_DIR" --codespeed "$@" | tee "$json_res_file"
>  		send_data_url="$GIT_PERF_SEND_TO_CODESPEED/result/add/json/"
>  		curl -v --request POST --data-urlencode "json=$(cat "$json_res_file")" "$send_data_url"
>  	fi
> @@ -203,10 +203,17 @@ get_var_from_env_or_config "GIT_PERF_SEND_TO_CODESPEED" "perf" "sendToCodespeed"
>  cd "$(dirname $0)"
>  . ../../GIT-BUILD-OPTIONS
>  
> -mkdir -p test-results
> -get_subsections "perf" >test-results/run_subsections.names
> +if test -n "$TEST_OUTPUT_DIRECTORY"
> +then
> +	TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
> +else
> +	TEST_RESULTS_DIR=test-results
> +fi
>  
> -if test $(wc -l <test-results/run_subsections.names) -eq 0
> +mkdir -p "$TEST_RESULTS_DIR"
> +get_subsections "perf" >"$TEST_RESULTS_DIR"/run_subsections.names
> +
> +if test $(wc -l <"$TEST_RESULTS_DIR"/run_subsections.names) -eq 0
>  then
>  	if test -n "$GIT_PERF_SUBSECTION"
>  	then
> @@ -222,10 +229,10 @@ then
>  	)
>  elif test -n "$GIT_PERF_SUBSECTION"
>  then
> -	egrep "^$GIT_PERF_SUBSECTION\$" test-results/run_subsections.names >/dev/null ||
> +	egrep "^$GIT_PERF_SUBSECTION\$" "$TEST_RESULTS_DIR"/run_subsections.names >/dev/null ||
>  		die "subsection '$GIT_PERF_SUBSECTION' not found in '$GIT_PERF_CONFIG_FILE'"
>  
> -	egrep "^$GIT_PERF_SUBSECTION\$" test-results/run_subsections.names | while read -r subsec
> +	egrep "^$GIT_PERF_SUBSECTION\$" "$TEST_RESULTS_DIR"/run_subsections.names | while read -r subsec
>  	do
>  		(
>  			GIT_PERF_SUBSECTION="$subsec"
> @@ -243,5 +250,5 @@ else
>  			echo "======== Run for subsection '$GIT_PERF_SUBSECTION' ========"
>  			run_subsection "$@"
>  		)
> -	done <test-results/run_subsections.names
> +	done <"$TEST_RESULTS_DIR"/run_subsections.names
>  fi
