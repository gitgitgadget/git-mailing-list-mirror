Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F337DC4363D
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 18:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95188206DD
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 18:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ebm75Y9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgJCS4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 14:56:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54453 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgJCS4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 14:56:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 022A982F94;
        Sat,  3 Oct 2020 14:56:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z/cwn0H8x0R49pwiV2ExTHsUL0E=; b=ebm75Y
        9JHCYl83myGskf0Ypmzp941nbDSuA0upP0Sze9It6TTlmWn2IfgMkUHsNctD/9j4
        AUOFVLUaZ1TqZBUhTk9Im+62/dawF0tcIOlzIpFF93gKOeOyUWdR6LOf47L3s7UG
        NdQxPZ4P2BQy4lgVTNg/+HCU5XmoMaqHCnVIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XrLunxCjWP3b31eu0nHIzrhQt+Oc/6PE
        p5Ski7e5E9l0dhC5/zKgNPgGiHHzca3E/8OIwwpdNhJgfTnMeJVadJH749ARF/+F
        9saN/sszxmCgsLPd9ls2GMhbDqymw8oAPgO6Jfovnx25GhmvFm8fHCeMOhfKGy2Q
        KOaXnsQI3x4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED60B82F93;
        Sat,  3 Oct 2020 14:56:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BCFE82F91;
        Sat,  3 Oct 2020 14:56:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nico Weber via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nico Weber <thakis@chromium.org>
Subject: Re: [PATCH] bisect: add a --verify flag to `bisect run`
References: <pull.741.git.1601750003858.gitgitgadget@gmail.com>
Date:   Sat, 03 Oct 2020 11:56:17 -0700
In-Reply-To: <pull.741.git.1601750003858.gitgitgadget@gmail.com> (Nico Weber
        via GitGitGadget's message of "Sat, 03 Oct 2020 18:33:23 +0000")
Message-ID: <xmqqlfgn87fy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EB3B2D4-05AA-11EB-92E6-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nico Weber via GitGitGadget" <gitgitgadget@gmail.com> writes:

> If it's passed, then `git bisect run --verify script` will first
> check out the good revision and verify that the script passes there,

The subject of the sentence is "git bisect run --verify script", so
"it" in "If it's passed" cannot be any of the "run", "--verify" or
"script".  So what is getting passed to that command???

> then check out the bad revision and verify that it fails there,
> and only then start the actual `git bisect run script`.

Is the intended use case

    - you have *not* run "git bisect" at all, but know two
      revisions, one $bad and one $good

    - you run "git bisect start $bad $good" just once, and then

    - you run "git bisect run [--verify] script"

or does this intend to cover more cases, like

    - you have *not* run "git bisect" at all, but know two
      revisions, one $bad and one $good

    - you run "git bisect start $bad $good", and

    - you iterate manually and use "git bisect good" and/or "git
      bisect bad" to mark points you tested, which advances $bad and
      accumulates good revisions, and after that

    - you run "git bisect run [--verify] script"

If the latter (and I hope it is), it is wrong to assume that the
command can "first check out THE good revision and verify".  There
may have been multiple points in the hsitory where you said "good"
and any of them may fail the script.

> We use `git bisect run` heavily for bisecting bugs in LLVM when using
> clang to build Chromium. We sometimes end up with run scripts that are
> broken in some way, either by missing the +x bit, or in more subtle
> ways, and this adds a simple, low conceptual overhead way to smoke check
> the run script before starting a bisect that could run for a day or two.

Very good intentions.



> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-741%2Fnico%2Frunverifyforupstreaming-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-741/nico/runverifyforupstreaming-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/741
>
>  Documentation/git-bisect.txt |  12 +++-
>  git-bisect.sh                | 110 ++++++++++++++++++++++++++++++++++-
>  t/t6030-bisect-porcelain.sh  |  16 +++++
>  3 files changed, 134 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index fbb39fbdf5..37658d8ed8 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -26,7 +26,7 @@ on the subcommand:
>   git bisect (visualize|view)
>   git bisect replay <logfile>
>   git bisect log
> - git bisect run <cmd>...
> + git bisect run [--verify] <cmd>...
>   git bisect help
>  
>  This command uses a binary search algorithm to find which commit in
> @@ -93,7 +93,6 @@ Eventually there will be no more revisions left to inspect, and the
>  command will print out a description of the first bad commit. The
>  reference `refs/bisect/bad` will be left pointing at that commit.
>  
> -
>  Bisect reset
>  ~~~~~~~~~~~~
>  
> @@ -317,7 +316,7 @@ If you have a script that can tell if the current source code is good
>  or bad, you can bisect by issuing the command:
>  
>  ------------
> -$ git bisect run my_script arguments
> +$ git bisect run [--verify] my_script arguments
>  ------------
>  
>  Note that the script (`my_script` in the above example) should exit
> @@ -376,6 +375,13 @@ ignored.
>  This option is particularly useful in avoiding false positives when a merged
>  branch contained broken or non-buildable commits, but the merge itself was OK.
>  
> +--verify::
> ++
> +Before the actual bisect run, check out the current bad revision and
> +verify that the script exits with a code between 1 and 127 (inclusive),
> +except 125, then check out the current good revision and verify that
> +the script exits with code 0. If not, abort the bisect run.
> +
>  EXAMPLES
>  --------
>  
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 2f60fefcfa..99ac01fb55 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -26,7 +26,7 @@ git bisect replay <logfile>
>  	replay bisection log.
>  git bisect log
>  	show bisect log.
> -git bisect run <cmd>...
> +git bisect run [--verify | --no-verify] <cmd>...
>  	use <cmd>... to automatically bisect.
>  
>  Please use "git help bisect" to get the full man page.'
> @@ -38,6 +38,8 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>  _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>  TERM_BAD=bad
>  TERM_GOOD=good
> +CURRENT_BISECT_BAD=
> +CURRENT_BISECT_GOOD=
>  
>  bisect_head()
>  {
> @@ -215,6 +217,7 @@ bisect_replay () {
>  		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
>  		if test "$git" = "git-bisect"
>  		then
> +			tail="$rev"
>  			rev="$command"
>  			command="$bisect"
>  		fi
> @@ -237,7 +240,112 @@ bisect_replay () {
>  	bisect_auto_next
>  }
>  
> +get_current_bisect_bounds () {
> +	test -s "$GIT_DIR/BISECT_LOG" || die "$(gettext "We are not bisecting.")"
> +	oIFS="$IFS" IFS="$IFS$(printf '\015')"
> +	while read git bisect command rev tail
> +	do
> +		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
> +		if test "$git" = "git-bisect"
> +		then
> +			tail="$rev"
> +			rev="$command"
> +			command="$bisect"
> +		fi
> +		get_terms
> +		git bisect--helper --check-and-set-terms "$command" "$TERM_GOOD" "$TERM_BAD" || exit
> +		get_terms
> +		case "$command" in
> +		skip)
> +			;;
> +		start)
> +			CURRENT_BISECT_BAD="$rev"
> +			CURRENT_BISECT_GOOD="$tail"
> +			;;
> +		"$TERM_GOOD")
> +			CURRENT_BISECT_GOOD="$rev" ;;
> +		"$TERM_BAD")
> +			CURRENT_BISECT_BAD="$rev" ;;
> +		*)
> +			die "$(gettext "?? what are you talking about?")" ;;
> +		esac
> +	done <"$GIT_DIR/BISECT_LOG"
> +	IFS="$oIFS"
> +}
> +
>  bisect_run () {
> +	verify=
> +	while test $# -ne 0
> +	do
> +		case "$1" in
> +		--verify)
> +			verify=t
> +			;;
> +		--no-verify)
> +			verify=
> +			;;
> +	--)
> +			shift
> +			break
> +			;;
> +		-*)
> +			usage
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done
> +
> +	if [ -n "$verify" ]; then
> +		git rev-parse --verify -q BISECT_HEAD > /dev/null && die "$(gettext "bisect run --verify is incompatible with --no-checkout")"
> +
> +		get_current_bisect_bounds
> +		test -n "$CURRENT_BISECT_BAD" || die "$(gettext "bisect run --verify: no current bad revision")"
> +		test -n "$CURRENT_BISECT_GOOD" || die "$(gettext "bisect run --verify: no current good revision")"
> +
> +		bisected_head=$(bisect_head)
> +		rev=$(git rev-parse --verify "$bisected_head") ||
> +			die "$(eval_gettext "Bad rev input: \$bisected_head")"
> +
> +		trap "git checkout -q $rev" 0
> +
> +		# Check script passes for good rev.
> +		command="$@"
> +		eval_gettextln "verifying script passes at \$TERM_GOOD rev"
> +		eval git checkout -q "$CURRENT_BISECT_GOOD" || die "$(eval_gettext "failed to check out \$TERM_GOOD rev")"
> +		"$@"
> +		res=$?
> +		if [ $res -ne 0 ]
> +		then
> +			die_with_status $res "$(eval_gettext "aborting: run script fails for \$TERM_GOOD rev")"
> +		fi
> +
> +		# Check script fails orderly for bad rev.
> +		command="$@"
> +		eval_gettextln "verifying script fails at \$TERM_BAD rev"
> +		eval git checkout -q "$CURRENT_BISECT_BAD" || die "$(eval_gettext "failed to check out \$TERM_BAD rev")"
> +		"$@"
> +		res=$?
> +		if [ $res -lt 0 -o $res -ge 128 ]
> +		then
> +			die "$(eval_gettext "aborting: exit code \$res is < 0 or >= 128")"
> +		fi
> +		if [ $res -eq 0 ]
> +		then
> +			die "$(eval_gettext "aborting: run script passes for \$TERM_BAD rev")"
> +		fi
> +		if [ $res -eq 125 ]
> +		then
> +			die "$(eval_gettext "aborting: run sript returns 125 (skip) for \$TERM_BAD rev")"
> +		fi
> +
> +		# Check out pre-verify rev again.
> +		git checkout -q "$rev"
> +		trap '-' 0
> +	fi
> +
>  	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
>  
>  	test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index b886529e59..acb01dcfff 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -321,6 +321,22 @@ test_expect_success 'bisect run & skip: find first bad' '
>  	grep "$HASH6 is the first bad commit" my_bisect_log.txt
>  '
>  
> +test_expect_success 'bisect run --verify: script fails for good rev' '
> +	git bisect reset &&
> +	git bisect start $HASH7 $HASH1 &&
> +	test_must_fail git bisect run --verify false >my_bisect_log3.txt 2>&1 &&
> +	test_i18ngrep "aborting: run script fails for good rev" my_bisect_log3.txt
> +'
> +
> +test_expect_success 'bisect run --verify: script passes for bad rev' '
> +	git bisect reset &&
> +	git bisect start &&
> +	git bisect bad $HASH7 &&
> +	git bisect good $HASH1 &&
> +	test_must_fail git bisect run --verify true >my_bisect_log5.txt 2>&1 &&
> +	test_i18ngrep "aborting: run script passes for bad rev" my_bisect_log5.txt
> +'
> +
>  test_expect_success 'bisect skip only one range' '
>  	git bisect reset &&
>  	git bisect start $HASH7 $HASH1 &&
>
> base-commit: 9bc233ae1cf19a49e51842c7959d80a675dbd1c0
