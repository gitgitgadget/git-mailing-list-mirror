Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D867C00523
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 01:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1944521734
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 01:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezwa3diC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgADBWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 20:22:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42316 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgADBWd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 20:22:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so24233055pfz.9
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 17:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AmcpNcRcIN2/jFAnMRVSsX0iCMydwuude28utO7FeC8=;
        b=ezwa3diC7NpVc3C39AxQ/tYjcj+N0jWjY+erlQxDtV4cN+edwref6BxxwiTU8j8foI
         ggRHoGnAp9garI7P62NdIQskOJ8y/FIajn+uLVYaWZuoBPNHjVcgjahSuTzcV5QYSIwJ
         zKf2jfvd/RLGKFwanAfgQ0hNYakwxzsaT8sieBrc1qXeGeQCfwde6LhmDFeWaSTRWV6Q
         UxZszrN7Kcb6nxdUFwxkauIr5lxrUA3DtYzporXE/SrU3sVOoyN5QIQK41hBwAEasfhb
         USD4s4SVHo/XuWhdipsSZ26FAGux1pQ7Oqucsfi8WCvZb55aw3VDEWisUAi3bIDDvbwX
         iYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AmcpNcRcIN2/jFAnMRVSsX0iCMydwuude28utO7FeC8=;
        b=E02ArAy0JVU0rmN3c6stWKcYoowRInR53hqjdT4NsWFRk3kLJjF3uLaBWnvxtMAHiW
         ItgAdkZYUxkeqeT4gbk5HtusbQ9QUy6HylrU+NpOnKgX53D+qYICuhqzL2+Z2b79GeB5
         dnvDbLMONVzABp68D30zcz+IkUcZi3MWYR6i0DNvXLv9DyEFEa5LhdBNrHPNvySDmx1r
         ad9DjY0gklgR1oZ8P4aEad/uhW5cesxRXRqKjNlTHg648eGGUNgBclI3Yx1lnZXqUeTF
         Mnun+A6M4qgZJSgvf5JceUljakaz3IPMPfD9Ffd3dsaq0Z99i8pN2m+kCr8uwgSYB8P/
         cBvQ==
X-Gm-Message-State: APjAAAWC81II9ppE71o0BYsGAj+sK7S/2XuPOl5QSYxlIKhXfL23/g9H
        GgDeB2/ZSpvNyw+s1QQgw/A=
X-Google-Smtp-Source: APXvYqyrG7mubR8FUhwVgE2gi/EeeNfc422U1sFYBwA+F9FUjFtVMIPMT0i+YcWkFrZt3sy2eZhJ6w==
X-Received: by 2002:a63:a43:: with SMTP id z3mr99805231pgk.232.1578100952628;
        Fri, 03 Jan 2020 17:22:32 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id r8sm15507539pjo.22.2020.01.03.17.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 17:22:31 -0800 (PST)
Date:   Fri, 3 Jan 2020 17:22:30 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stephen Oberholtzer <stevie@qrpff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] bisect run: allow inverting meaning of exit code
Message-ID: <20200104012230.GD130883@google.com>
References: <20200103043027.4537-1-stevie@qrpff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103043027.4537-1-stevie@qrpff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Christian Couder, bisect expert)
Hi!

Stephen Oberholtzer wrote:

> NOTE: This is obviously not ready for merging; I just wanted to
> get feedback.

Thanks for writing.  I like where you're going.

> In particular, I expect some bikeshedding on the specific option
> names (-r, --invert, --expect).  I'm probably going to change
> `--expect` to `--success`, in fact.
>
> If we can come to a consensus on the names (and, of course, on the
> feature itself), I'll clean up the tests, remove the debug output,
> update the documentation, then resubmit.
>
> >8------------------------------------------------------8<
>
> If your automated test naturally yields zero for _old_/_good_,
> 1-124 or 126-127 for _new_/_bad_, then you're set.
>
> If that logic is reversed, however, it's a bit more of a pain: you
> can't just stick a `sh -c !` in front of your command, because that
> doesn't account for exit codes 125 or 129-255.
>
> This commit enhances `git bisect run` as follows:
>
> * '--' can be used as an option list terminator,
>   just as everywhere else.

Could this part go in a separate commit?  That way, it can go in
more quickly while we figure out the rest. :)

> * The treatment of the exit code can be selected via an option:
>
>   - No option, of course, treats 0 as _old_/_good_
>   - `-r` (for reverse) treats 0 as _new_/_bad_
>   - `--invert` is the long form for `-r`
>   - `--expect=<term>` treats 0 as <term>

Initial thoughts:

- it's not immediately clear to me that this is common enough
  to need the short-and-sweet name "-r".  Could it have a long
  form only?

- I think I agree with you that "git bisect run --expect=5" might
  be more clearly written as "git bisect run --success=5".  Or even
  something explicitly referring to exit status, like
  --success-status=5.

- This has an interesting relationship to the "alternate terms"
  feature (--term-old / --term-new).  I don't know if there's a
  good way to make that more explicit --- maybe just some notes
  with examples in the relevant parts of the manpage?

- the name --invert doesn't make it obvious to me what it is
  inverting: good versus bad, ones complement of the status
  code, revision range passed to "git bisect start"?

  I'm even tempted to call it something like '-!', to make the
  allusion to ! in shells more explicit.  (But that's probably not a
  great idea, since quoting ! correctly in interactive shells can be
  difficult.)

  Are there other commands we can try to make this consistent with?
  "find" supports arbitrary expressions involving '!' and '-not'.
  "git grep" has --invert-match: perhaps a name --invert-status
  would be clear enough?

> You're not allowed to specify more than one expectation.

Usual convention would be "last specified option wins".

> Note that this lets one specify `--expect=good` as an explicit
> selection of the default behavior.  This is intentional.
>
> Signed-off-by: Stephen Oberholtzer <stevie@qrpff.net>
> ---
>  git-bisect.sh         |  33 +++++++++-
>  t/t6071-bisect-run.sh | 142 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 172 insertions(+), 3 deletions(-)
>  create mode 100755 t/t6071-bisect-run.sh

As you said, this needs docs.  Writing docs often helps make the UI a
bit better since it forces one to think about the various ways a tool
would be used in practice.

> diff --git a/git-bisect.sh b/git-bisect.sh
> index efee12b8b1..dbeb213846 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -26,7 +26,7 @@ git bisect replay <logfile>
>  	replay bisection log.
>  git bisect log
>  	show bisect log.
> -git bisect run <cmd>...
> +git bisect run [--expect=<term> | -r | --invert] [--] <cmd>...
>  	use <cmd>... to automatically bisect.
>  
>  Please use "git help bisect" to get the full man page.'
> @@ -238,6 +238,31 @@ bisect_replay () {
>  bisect_run () {
>  	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
>  
> +	SUCCESS_TERM=$TERM_GOOD
> +	FAIL_TERM=$TERM_BAD
> +	INVERT_SET=
> +	while [ "$1" != "${1#-}" ]; do

Might be simpler to do 'while true', and in the *) case to break.

> +		case "$1" in
> +		--)
> +			shift
> +			break ;;
> +		--expect=$TERM_GOOD)
> +			[ -z "$INVERT_SET" ] || die "$(gettext "bisect run: multiple expect options specified")"
> +			INVERT_SET=1 ;;
> +		-r|--invert|--expect=$TERM_BAD)
> +			[ -z "$INVERT_SET" ] || die "$(gettext "bisect run: multiple expect options specified")"
> +			SUCCESS_TERM=$TERM_BAD
> +			FAIL_TERM=$TERM_GOOD
> +			INVERT_SET=1 ;;
> +		--expect=*)
> +			# how to localize part 2?
> +			die "$(printf "$(gettext "bisect run: invalid --expect value, use --expect=%s or --expect=%s")" "$TERM_GOOD" "$TERM_BAD")" ;;

It's more idiomatic to use eval_gettext here.  See
"git grep -e die -- '*.sh'" for some examples.

> +		*)
> +			die "$(printf "$(gettext "bisect run: invalid option: %s")" "$1")" ;;
> +		esac
> +		shift
> +	done
> +
>  	test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
>  
>  	while true
> @@ -262,11 +287,13 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
>  			state='skip'
>  		elif [ $res -gt 0 ]
>  		then
> -			state="$TERM_BAD"
> +			state="$FAIL_TERM"
>  		else
> -			state="$TERM_GOOD"
> +			state="$SUCCESS_TERM"
>  		fi
>  
> +		echo "exit code $res means this commit is $state"
> +
>  		# We have to use a subshell because "bisect_state" can exit.
>  		( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
>  		res=$?
> diff --git a/t/t6071-bisect-run.sh b/t/t6071-bisect-run.sh
> new file mode 100755
> index 0000000000..2708e0f854
> --- /dev/null
> +++ b/t/t6071-bisect-run.sh
> @@ -0,0 +1,142 @@
> +# verify that unrecognized options are rejected by 'git bisect run'
> +#!/bin/sh
> +
> +# the linter's not smart enough to handle set -e
> +GIT_TEST_CHAIN_LINT=0
> +
> +test_description='Tests git bisect run'
> +
> +exec </dev/null
> +
> +. ./test-lib.sh
> +
> +{ test_expect_success 'Setting up repo for "git bisect run" tests.' "$(cat)" ; } <<'SETUP'

Tests put the commands to be passed to test_expect_success in a
single-quoted argument, with explicit &&-chaining.  ("set -e" has
enough exceptions that it hasn't been worth using for this.  The test
harness is able to detect a missing "&&" so this is less error-prone
than it sounds.)  See t/README and any recently added test scripts in
t/ (try "git log -p --diff-filter=A -- t") for more details.

Thanks for a clear and pleasant description of the problem being
solved.  I would like to say "here's a simple shell construct to use
instead of ! that makes this all redundant" but lacking that, for what
it's worth this set of new options seems like a good idea to me. :)

Sincerely,
Jonathan

(the rest left unsnipped for reference)
> +(
> +# I don't know how they managed it, but the git test engine
> +# somehow ignores the effect of 'set -e'.
> +set -eu || exit 1
> +# set -e canary
> +false
> +# hopefully, next year, we get -o pipefail!
> +echo '.DEFAULT: dummy
> +.PHONY: dummy
> +dummy:
> +	true
> +' > Makefile
> +make
> +echo '0' >path0
> +git update-index --add -- Makefile path0
> +git commit -q -m 'initial commit'
> +git tag working0
> +# make some commits that don't cause problems
> +for x in `test_seq 1 20`; do
> +	echo "$x" >path0
> +	git update-index --replace -- path0
> +	git commit -q -m "working commit $x"
> +	git tag "working$x"
> +done
> +# break the makefile
> +sed -i.bak -e 's/true/false/' Makefile
> +rm -f Makefile.bak
> +! make
> +git update-index --replace -- Makefile
> +git commit -q -m "First broken commit"
> +git tag broken0
> +# make some more commits that still FTBFS
> +echo "exit code was $?; flags are $-"
> +for x in `test_seq 1 20`; do
> +	echo "$x" >path0
> +	git update-index --replace -- path0
> +	git commit -q -m "broken build $x"
> +	git tag "broken$x"
> +done
> +# repair it
> +git checkout working0 -- Makefile
> +make
> +git update-index --replace -- Makefile
> +git commit -q -m "First repaired commit"
> +git tag fixed0
> +# make some more commits with the bugfix
> +for x in `test_seq 1 20`; do
> +	echo "$x" >path0
> +	git update-index --replace -- path0
> +	git commit -q -m "fixed build $x"
> +	git tag "fixed$x"
> +done
> +#sh -c 'bash -i <> /dev/tty >&0 2>&1'
> +)
> +
> +SETUP
> +
> +test_expect_success 'setup first bisect' 'git bisect start && git bisect good working0 && git bisect bad broken9'
> +
> +test_expect_failure() {
> +	shift
> +	#echo arguments are "$*"
> +	test_must_fail "$@"
> +}
> +
> +# okay, let's do some negative testing
> +
> +OLDPATH="$PATH"
> +
> +PATH="$PATH:."
> +
> +test_expect_success 'setup this-is-not-a-valid-option' '
> + echo "#/bin/sh" > --this-is-not-a-valid-option &&
> + chmod a+x -- --this-is-not-a-valid-option &&
> + --this-is-not-a-valid-option'
> +
> +test_expect_failure 'git bisect run: reject unrecognized options' git bisect run --this-is-not-a-valid-option
> +
> +PATH="$OLDPATH"
> +
> +test_expect_failure 'git bisect run: reject invalid values for --expect'  git bisect run --expect=invalid make
> +
> +# okay, all of these settings are mutually exclusive (for sanity's sake, even with themselves)
> +for a in --expect=bad --expect=good -r --invert; do
> +	for b in --expect=bad --expect=good -r --invert; do
> +		test_expect_failure 'git bisect run: reject multiple --expect options'  git bisect run $a $b make
> +	done
> +done
> +
> +# finally, verify that '--' is honored (note that will mess things up and require a bisect reset)
> +PATH="$PATH:."
> +
> +test_expect_success 'git bisect run: honor --' 'git bisect run -- --this-is-not-a-valid-option'
> +
> +PATH="$OLDPATH"
> +
> +for expect_syntax in '' --expect=good; do
> +
> +	# now we have to undo the bisect run
> +	test_expect_success 'restarting bisection' 'git bisect reset && git bisect start && git bisect good working0 && git bisect bad broken9'
> +
> +	test_expect_success "running bisection ($expect_syntax)" "
> +git bisect run $expect_syntax make &&
> +git log --oneline &&
> +	# we should have determined that broken0 is the first bad version
> +	test_cmp_rev broken0 refs/bisect/bad &&
> +	# and that version should be the one checked out
> +	test_cmp_rev broken0 HEAD
> +"
> +done
> +
> +
> +# NOW, test the reverse:  find when we fixed it again
> +
> +for expect_syntax in -r --invert --expect=fixed; do
> +
> +	test_expect_success 'restarting bisection' 'git bisect reset && git bisect start --term-old=broken --term-new=fixed && git bisect broken broken20 && git bisect fixed fixed20'
> +	test_expect_success "running bisection ($expect_syntax)" "
> +		git bisect run $expect_syntax make &&
> +		git log --oneline &&
> +	test_cmp_rev fixed0 refs/bisect/fixed &&
> +	test_cmp_rev fixed0 HEAD
> +	"
> +done
> +
> +test_expect_failure 'sanity check error message with custom terms' git bisect run --expect=invalid make
> +
> +
> +test_done
> -- 
> 2.20.1
> 
