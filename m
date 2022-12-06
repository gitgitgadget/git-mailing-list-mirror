Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D2AC3A5A7
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 21:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLFVyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 16:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLFVyo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 16:54:44 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB9743840
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 13:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670363679; bh=fGK3gnE/R4tghDK8+NsGtR33HN1aTjRtgSgG3fb2Q0s=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cb4pBQAKeFXhJcnlGPZiY/f0LlzMB2Pv+/wLtgCNzCDlnOr/htb5NCQKYF2dfxVyr
         kxMaYHXDm2CshlBcD27H6kppPIZ36UYiHTVImZXrTShafm+zKZT3vCcDcHUk4cIbTk
         jZTOl3gLRMl3UE7j0cQ5MPofNu6XPjxrKu3Z0mttNS9n5IldqMILK9OokuXmZTiVIu
         ronOu2+oPBFvHpQxiqT/mMDjmn7Y9hsmlsVz6e5VDQE77eHqp6kyOwccR6r20RR9gM
         zwThsJRWhFLmLlSTlg4FJYpqQl1Xr2YHUGJask3x3NlqtnuqK9m+nP59WtFCMslAwZ
         I90PSwhTofgDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.23]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mw9xG-1ojucl2gD6-00sEPE; Tue, 06
 Dec 2022 22:54:39 +0100
Message-ID: <31d3bf6c-c0a2-d2d5-c6e2-b185fde99170@web.de>
Date:   Tue, 6 Dec 2022 22:54:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
 <pull.1309.v5.git.1670339267.gitgitgadget@gmail.com>
 <6a80fab7e3936ec56e1583d6136d47487327e907.1670339267.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <6a80fab7e3936ec56e1583d6136d47487327e907.1670339267.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E++gL8SX5SW9FfYhs99McmksNKXs8XzzFOAJHTrJf4QpyK5qJRV
 7RHYEyYAy5i8vHLMhH7iNyRQoSyeHkP3oxpxXm17/wdXCqTNBV0YXacWK98YBfFAUoinaZX
 0Jm6UHECfxnFRropkw4fTHWb+Pm7F8W4sNG+OU0+H3+eJyLptlnd1OT1Xllae/uOhqBbRTR
 45EyRoFymC7AkFOyBgM7A==
UI-OutboundReport: notjunk:1;M01:P0:ZSqLxZ8RDPo=;GFDVBhbxi9s7MaMi0ll9p233aNI
 ZPQGPte9JCwBaoSuHzDqaB0YfjTUrr9Lf5SeywLy2vazp2BvHu8pSUgliJOnDh/Bvu/LdN7PT
 XNEBwjChN52OwSVWPXRl6FYyzPLPe8aym7qQ9AhYOAawRs2MjVqUbNbrBZre3VTeZqeK4+EEB
 yP266lu/toPyN3nejSs/hEtenu/WwaKVXWz2jm1N0MSG/+eWvHFaMU2tlzPetvEfM3uL+9aRh
 v9V9vb0009ZRigBhEAFZCFiypOlBwVsSbB5d7xTgn44Ejli1lZP0H28XkMzUfHBhMqzenrJuf
 xxerS5bQ8imBG4OaotteoCtwEf5TNaN0QaJHK6R3ESjbrVsV3NJnnVbyu954+rM/Jy8D3GX2G
 qSj5h4Rik3PoijwbfqY66vI+ezNAmLzHTJQebDVY3gSFXUHmRYqX2CiOp/P8IJOm86Bhg7Q+R
 UAZifmkddkKySqcVZEqAP2DD0oY0W1tokTvzvy4KpGq+mktvw5mU9Il1Z3i+mRsQcPyn1+lt2
 E+dHAuBsV+jo8LlN+3nIh0W6L6T/MWDfJ/WJlsnrqkA2LuFAdxMRtaD17UzNYEknipTXo6o8u
 EHzMfaxlj2JEKPxTJ92GOxCVpibHZX3pgFe7ZS0NwRJH9BS+NdqkbMHkLRcP9bZ4hxYQ/vkKx
 ywzaTbE64z6KnKekzYA7jFN9UHdjmKk58EprDX1PW/oD8Ymd1py72RkoS4x6D5ExwD/iocVRC
 vN9ZH0quaO80adl8utF90e+ilSiUcmQAR2WnKnb/URl9aQNP8HzQsQi7LGQIBDosar5zXroRI
 ft2fOA625OJFAQ48/BeZfRL8Y6L3pFxxZML0S20M23wX3ev5HI0q1pZdolT2Rer2GOYtnztqZ
 uq49ymkSWukKvrjvg0fc/buh904ehjlI4ILXfJy0gjdWoyYYe/ya7T0i0s7q99Pu1DypOPFCn
 B0sQxx4Q43jSw43lmc8t3DrrMuk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.12.2022 um 16:07 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When Git's test suite uses `test_cmp`, it is not actually trying to
> compare binary files as the name `cmp` would suggest to users familiar
> with Unix' tools, but the tests instead verify that actual output
> matches the expected text.
>
> On Unix, `cmp` works well enough for Git's purposes because only Line
> Feed characters are used as line endings. However, on Windows, while
> most tools accept Line Feeds as line endings, many tools produce
> Carriage Return + Line Feed line endings, including some of the tools
> used by the test suite (which are therefore provided via Git for Windows
> SDK). Therefore, `cmp` would frequently fail merely due to different
> line endings.
>
> To accommodate for that, the `mingw_test_cmp` function was introduced
> into Git's test suite to perform a line-by-line comparison that ignores
> line endings. This function is a Bash function that is only used on
> Windows, everywhere else `cmp` is used.
>
> This is a double whammy because `cmp` is fast, and `mingw_test_cmp` is
> slow, even more so on Windows because it is a Bash script function, and
> Bash scripts are known to run particularly slowly on Windows due to
> Bash's need for the POSIX emulation layer provided by the MSYS2 runtime.
>
> The commit message of 32ed3314c104 (t5351: avoid using `test_cmp` for
> binary data, 2022-07-29) provides an illuminating account of the
> consequences: On Windows, the platform on which Git could really use all
> the help it can get to improve its performance, the time spent on one
> entire test script was reduced from half an hour to less than half a
> minute merely by avoiding a single call to `mingw_test_cmp` in but a
> single test case.
>
> Learning the lesson to avoid shell scripting wherever possible, the Git
> for Windows project implemented a minimal replacement for
> `mingw_test_cmp` in the form of a `test-tool` subcommand that parses the
> input files line by line, ignoring line endings, and compares them.
> Essentially the same thing as `mingw_test_cmp`, but implemented in
> C instead of Bash. This solution served the Git for Windows project
> well, over years.
>
> However, when this solution was finally upstreamed, the conclusion was
> reached that a change to use `git diff --no-index` instead of
> `mingw_test_cmp` was more easily reviewed and hence should be used
> instead.
>
> The reason why this approach was not even considered in Git for Windows
> is that in 2007, there was already a motion on the table to use Git's
> own diff machinery to perform comparisons in Git's test suite, but it
> was dismissed in https://lore.kernel.org/git/xmqqbkrpo9or.fsf@gitster.g/
> as undesirable because tests might potentially succeed due to bugs in
> the diff machinery when they should not succeed, and those bugs could
> therefore hide regressions that the tests try to prevent.
>
> By the time Git for Windows' `mingw-test-cmp` in C was finally
> contributed to the Git mailing list, reviewers agreed that the diff
> machinery had matured enough and should be used instead.
>
> When the concern was raised that the diff machinery, due to its
> complexity, would perform substantially worse than the test helper
> originally implemented in the Git for Windows project, a test
> demonstrated that these performance differences are well lost within the
> 100+ minutes it takes to run Git's test suite on Windows.
Only t3920 needs mingw_test_cmp on my system.  [2] on top of [1] removes
that dependency.  Does that work for you as well?


diff -u and git diff are slower than mingw_test_cmp when running
"make test" on my system ("uname -rs" says "MINGW64_NT-10.0-22621
3.3.6-341.x86_64").  Timings (sorry, only a single run each):

2.39.0-rc2:
All tests successful.
Files=3D983, Tests=3D26154, 2082 wallclock secs ( 7.86 usr 15.97 sys + 776=
.73 cusr 2352.96 csys =3D 3153.52 CPU)
Result: PASS

2.39.0-rc2 + [1] + [2] + removal of "GIT_TEST_CMP=3Dmingw_test_cmp"
from t/test-lib.sh:
All tests successful.
Files=3D983, Tests=3D26154, 2174 wallclock secs ( 7.75 usr 17.27 sys + 813=
.53 cusr 2699.12 csys =3D 3537.66 CPU)
Result: PASS

2.39.0-rc2 + your v5:
All tests successful.
Files=3D983, Tests=3D26154, 2160 wallclock secs ( 4.16 usr 10.03 sys + 647=
.75 cusr 2038.99 csys =3D 2700.92 CPU)
Result: PASS

2.39.0-rc2 + [1] + [2] + the patch below:
All tests successful.
Files=3D983, Tests=3D26154, 2026 wallclock secs ( 4.91 usr  9.91 sys + 608=
.91 cusr 1881.98 csys =3D 2505.70 CPU)
Result: PASS


This is noisy, running "make test" multiple times takes too long.
Running a single test using hyperfine is feasible.  Here are my results
for the last test that needed a CR-agnostic test_cmp:

2.39.0-rc2:
Benchmark 1: sh.exe t3920-crlf-messages.sh
  Time (mean =C2=B1 =CF=83):      5.666 s =C2=B1  0.085 s    [User: 0.000 =
s, System: 0.007 s]
  Range (min =E2=80=A6 max):    5.583 s =E2=80=A6  5.858 s    10 runs

2.39.0-rc2 + [1] + [2] + removal of "GIT_TEST_CMP=3Dmingw_test_cmp"
from t/test-lib.sh:
Benchmark 1: sh.exe t3920-crlf-messages.sh
  Time (mean =C2=B1 =CF=83):      6.540 s =C2=B1  0.065 s    [User: 0.000 =
s, System: 0.004 s]
  Range (min =E2=80=A6 max):    6.454 s =E2=80=A6  6.681 s    10 runs

2.39.0-rc2 + your v5:
Benchmark 1: sh.exe t3920-crlf-messages.sh
  Time (mean =C2=B1 =CF=83):      6.632 s =C2=B1  0.090 s    [User: 0.000 =
s, System: 0.004 s]
  Range (min =E2=80=A6 max):    6.550 s =E2=80=A6  6.791 s    10 runs

2.39.0-rc2 + [1] + [2] + the patch below:
Benchmark 1: sh.exe t3920-crlf-messages.sh
  Time (mean =C2=B1 =CF=83):      5.743 s =C2=B1  0.065 s    [User: 0.002 =
s, System: 0.001 s]
  Range (min =E2=80=A6 max):    5.684 s =E2=80=A6  5.870 s    10 runs

Still noisy, but avoiding to fork out to a comparison program seems
worth it, i.e. the shell function wins for the typically short inputs in
test scripts.  Do you get different numbers?


I'm a bit disappointed by the performance of the patch below, but we'd
need something like this to compare precisely (no longer ignoring CRs),
I suppose.


[1] https://lore.kernel.org/git/febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.=
org/
[2] https://lore.kernel.org/git/cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.d=
e/


diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 796093a7b3..bf10746a08 100644
=2D-- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1450,70 +1450,21 @@ test_skip_or_die () {
 	error "$2"
 }

-# The following mingw_* functions obey POSIX shell syntax, but are actual=
ly
-# bash scripts, and are meant to be used only with bash on Windows.
-
-# A test_cmp function that treats LF and CRLF equal and avoids to fork
-# diff when possible.
+# A test_cmp function that avoids to fork diff when possible. It's only
+# meant to be used with bash on Windows.
 mingw_test_cmp () {
 	# Read text into shell variables and compare them. If the results
 	# are different, use regular diff to report the difference.
-	local test_cmp_a=3D test_cmp_b=3D
-
-	# When text came from stdin (one argument is '-') we must feed it
-	# to diff.
-	local stdin_for_diff=3D
+	local test_cmp_a=3Da test_cmp_b=3Db

-	# Since it is difficult to detect the difference between an
-	# empty input file and a failure to read the files, we go straight
-	# to diff if one of the inputs is empty.
-	if test -s "$1" && test -s "$2"
-	then
-		# regular case: both files non-empty
-		mingw_read_file_strip_cr_ test_cmp_a <"$1"
-		mingw_read_file_strip_cr_ test_cmp_b <"$2"
-	elif test -s "$1" && test "$2" =3D -
-	then
-		# read 2nd file from stdin
-		mingw_read_file_strip_cr_ test_cmp_a <"$1"
-		mingw_read_file_strip_cr_ test_cmp_b
-		stdin_for_diff=3D'<<<"$test_cmp_b"'
-	elif test "$1" =3D - && test -s "$2"
+	# Leave the uncommon case of reading from stdin to diff.
+	if test "$1" !=3D "-" && test "$2" !=3D "-"
 	then
-		# read 1st file from stdin
-		mingw_read_file_strip_cr_ test_cmp_a
-		mingw_read_file_strip_cr_ test_cmp_b <"$2"
-		stdin_for_diff=3D'<<<"$test_cmp_a"'
+		IFS=3D read -r -d '' test_cmp_a <"$1"
+		IFS=3D read -r -d '' test_cmp_b <"$2"
 	fi
-	test -n "$test_cmp_a" &&
-	test -n "$test_cmp_b" &&
 	test "$test_cmp_a" =3D "$test_cmp_b" ||
-	eval "diff -u \"\$@\" $stdin_for_diff"
-}
-
-# $1 is the name of the shell variable to fill in
-mingw_read_file_strip_cr_ () {
-	# Read line-wise using LF as the line separator
-	# and use IFS to strip CR.
-	local line
-	while :
-	do
-		if IFS=3D$'\r' read -r -d $'\n' line
-		then
-			# good
-			line=3D$line$'\n'
-		else
-			# we get here at EOF, but also if the last line
-			# was not terminated by LF; in the latter case,
-			# some text was read
-			if test -z "$line"
-			then
-				# EOF, really
-				break
-			fi
-		fi
-		eval "$1=3D\$$1\$line"
-	done
+	diff -u "$@"
 }

 # Like "env FOO=3DBAR some-program", but run inside a subshell, which mea=
ns
