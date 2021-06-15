Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E17DC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 15:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462DB614A7
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 15:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhFOPm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 11:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhFOPm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 11:42:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD58CC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 08:40:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v12so8657902plo.10
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TC6m+wJr3lYoQ5MDx1LAF7ZbJkNAcvMvl6FNI/i1ggw=;
        b=fLikkr2g7GUwTgOCYdWj7WkqQbBiv8CDjyeRn43MM2/LmtHNItAyGNbjU/5dRmD7zX
         FgixuVW2pZBqZJQRnyTSfEQsTUxFkhwz6/hunWoLdtxmr/t/y9jY3cFf3OWJ6y3JWxJu
         l6qAdrXFuv3vRs8O4JNnC/Y5gIWLGFkvixtFCbiOhyCkn/L2e2GUAEkZTeGG2OUkAUzk
         JfW9YyTwWJDH0mUY0eWtPOU3NOxlHTnZn/FM2fgXuTOoZb19WwABYj72nJ0tN2cSC30Q
         B/O4L/gCQyU1hg7o7st5jaxIJ13nwnTV0A5QoS/Z8ZjO8GI2uQkm9eWAPzHbf4UevR23
         wUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TC6m+wJr3lYoQ5MDx1LAF7ZbJkNAcvMvl6FNI/i1ggw=;
        b=DRqAjwJGhNEVRQzOuSYbOtS8k+C5Bwz9J2XHboYhA6CcRRubzq+m2aUHQ/t0xXMTiC
         LtlIxdrE2dMJif+xGTKRB5IvfFPt6YzkiDtNe1Nq1VVSRZm7KawtfM8DIg0wCB9ep1lj
         c9Eambs9fB5AsOrwWdMv4boENWAjKGMwqJ8iiMj+n8ikTLwAbmbNHbvpXujB8g0ZY4fJ
         1yi0mRhDRi8XKgTCeWYsDTcRqbcOXzHDCyF+8YVa4EyhKYPWcBIc3Zj4XeCNkdkY1eX1
         ORJVa4tr/OLZZu/Dd7tvuW/ZnKmT/JguDpDzAaZjgY9wFBjWJ2IwFwozCcHR9UHP7USE
         cSnw==
X-Gm-Message-State: AOAM5311fuiqYqVoqWkMsuVJ/DqqEYI5Hn+RVK6VchTYyZJhH1Rt5e7C
        0tpEvBxykGKzUBhAmohaf/4=
X-Google-Smtp-Source: ABdhPJzcx4vGa34eaUvUnibxctSppTryRzbG7JvV/FXLb/ukHEh9ohZHbj9dbxgXGu2r9CtMx70gdg==
X-Received: by 2002:a17:90b:400c:: with SMTP id ie12mr25779756pjb.107.1623771651181;
        Tue, 15 Jun 2021 08:40:51 -0700 (PDT)
Received: from localhost ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id c62sm16030909pfa.12.2021.06.15.08.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:40:50 -0700 (PDT)
Date:   Tue, 15 Jun 2021 22:40:48 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
Message-ID: <YMjKACeN1+k2+iBK@danh.dev>
References: <20210612042755.28342-1-congdanhqx@gmail.com>
 <20210612042755.28342-2-congdanhqx@gmail.com>
 <878s3d286c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878s3d286c.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-13 15:36:11+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Sat, Jun 12 2021, Đoàn Trần Công Danh wrote:
> 
> > In Git project, we have multiple occasions that requires checking number
> > of lines of text in stdout and/or stderr of a command. One of such
> > example is t6400, which checks number of files in various states.
> 
> Thanks for following up on this.
> 
> > Some of those commands are Git command, and we would like to check their
> > exit status.  In some of those checks, we pipe the stdout of those
> > commands to "wc -l" to check for line count, thus loosing the exit status.
> >
> > Introduce a helper function to check for number of lines in stdout and
> > stderr from those commands.
> >
> > This helper will create 2 temporary files in process, thus it may affect
> > output of some checks.
> 
> I think it's fine to just blindly stick the name into a file in the CWD
> as long as it's not "actual" or some other such obviously likely to
> conflict name.
> 
> The convention you've picked here (I'm not sure if it's existing
> already) of naming the temp files after the test lib function name is a
> good one.
> 
> More generally speaking we have a bunch of helpers that have this
> potential issue/bug, in practice it's not a big deal.  A test that's
> being overly specific and doing a test_cmp on unbounded "find" output or
> whatever is likely buggy anyway.

I'm going to write into $TRASH_DIRECTORY/.git/trash if .git is-a-dir,
otherwise to $TRASH_DIRECTORY in the next reroll.

> If it ever becomes a bigger issue we can easily set up two scratch
> directories during the test, one for the use of the test itself, and one
> for the internals of the test run itself.
> 
> > +# test_line_count_cmd checks the number of lines of captured stdout and/or
> > +# stderr of a command.
> > +#
> > +# NOTE: this helper function will create 2 temporary files named:
> > +# * test_line_count_cmd_.out; and
> > +# * test_line_count_cmd_.err
> > +#
> > +# And this helper function will remove those 2 files if the check is succeed.
> > +# In case of failure, those files will be preserved.
> > +test_line_count_cmd () {
> > +	local outop outval
> > +	local errop errval
> > +
> > +	while test $# -ge 3
> > +	do
> > +		case "$1" in
> > +		--out)
> > +			outop="$2"
> > +			outval="$3"
> > +			;;
> > +		--err)
> > +			errop="$2"
> > +			errval="$3"
> > +			;;
> 
> It looks like the end-state of the series leaves us with no user of the
> --err option; Maybe it's good to have it anyway for completeness, or
> just skip it? ...

In the re-roll that being prepared, t0041 will be converted, too.
So --err will have a user.

> > +		*)
> > +			break
> > +			;;
> > +		esac
> > +		shift 3
> > +	done &&
> > +	if test $# = 0 ||
> > +	   { test "x$1" = "x!" && test $# = 1 ; }
> > +	then
> > +		BUG "test_line_count_cmd: no command to be run"
> > +	fi &&
> > +	if test -z "$outop$errop"
> > +	then
> > +		BUG "test_line_count_cmd: check which stream?"
> > +	fi &&
> > +
> > +	if test "x$1" = "x!" 
> > +	then
> > +		shift &&
> > +		if "$@" >test_line_count_cmd_.out 2>test_line_count_cmd_.err
> > +		then
> > +			echo "error: '$@' succeed!"
> > +			return 1
> > +		fi
> > +	elif ! "$@" >test_line_count_cmd_.out 2>test_line_count_cmd_.err
> > +	then
> > +		echo "error: '$@' run into failure!"
> > +		return 1
> > +	fi &&
> 
> ...I think it's better to not pipe to *.err if we haven't requested it,
> so under "-v" etc. we can get the stderr.

And with t0041 converted, it reveals some difficulty when implementing
this suggestion.

Yes, it would be nice if we can get the stderr under -v,
however, -x will make our life hard, since -x also writes into
/dev/stderr, and below command is broken:

	test_line_count_cmd --out = 0 test_must_fail git for-each-ref --no-contains something 2>actual.err &&
	test_i18ngrep ! usage actual.err

> If we're unifying them I think a better pattern is to only run that "$@"
> once, get $?, and then act differently on that in the "!" and ""
> cases. It requires less careful reading of the critical function path,
> especially with the differing indentation.

This is definitely doable.

This is a replacement patch that still has trouble with "-x",
I guess I should always exec 2>*.err
---------8<--------
Subject: [PATCH] test-lib-functions: introduce test_line_count_cmd

In Git project, we have multiple occasions that requires checking number
of lines of text in stdout and/or stderr of a command. One of such
example is t6400, which checks number of files in various states.

Some of those commands are Git command, and we would like to check their
exit status.  In some of those checks, we pipe the stdout of those
commands to "wc -l" to check for line count, thus loosing the exit status.

Introduce a helper function to check for number of lines in stdout and
stderr from those commands.

This helper will create 2 temporary files in process, thus it may affect
output of some checks.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/test-lib-functions.sh | 116 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f0448daa74..2261de7caa 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -845,6 +845,122 @@ test_line_count () {
 	fi
 }
 
+# test_line_count_cmd checks exit status, and the number of lines in
+# captured stdout and/or stderr of a command.
+#
+# Usage:
+#
+# test_line_count_cmd [--[out|err] <binop> <value>]... [--] [!] cmd [args...]
+#
+# Options:
+# --out <binop> <value>:
+# --err <binop> <value>:
+#	Run sh's "test <# of lines> <binop> <value>" on # of lines in stdout
+#	(for --out) or stderr (for --err)
+# !:
+#	Instead of expecting "cmd [args...]" succeed, expect its failure.
+#	Note, if command under testing is "git", test_must_fail should be used
+#	instead of "!".
+#
+# Example:
+#	test_line_count_cmd --out -ge 10 --err = 0 git tag --no-contains v1.0.0
+#	test_line_count_cmd --out -le 10 ! grep some-text a-file
+#	test_line_count_cmd --out = 0 test_must_fail git rev-parse --verify abcd1234
+#
+# NOTE:
+# * if "--out" is specified, a temporary file named test_line_count_cmd_.out
+#   will be created.
+# * if "--err" is specified, a temporary file named test_line_count_cmd_.err
+#   will be created.
+# Those temporary files will be created under $TRASH_DIRECTORY/.git/trash
+# if $TRASH_DIRECTORY/.git directory existed.
+# Otherwise, they will be created in $TRASH_DIRECTORY.
+# Those temporary files will be cleant by test_when_finished
+test_line_count_cmd () {
+	local outop outval outfile
+	local errop errval errfile
+	local expect_failure actual_failure
+	local trashdir="$TRASH_DIRECTORY"
+
+	if test -d "$TRASH_DIRECTORY/.git"
+	then
+		trashdir="$TRASH_DIRECTORY/.git/trash" &&
+		mkdir -p "$trashdir"
+	fi &&
+	while test $# != 0
+	do
+		case "$1" in
+		--out)
+			outop="$2" &&
+			outval="$3" &&
+			outfile="$trashdir/test_line_count_cmd_.out" &&
+			shift 3
+			;;
+		--err)
+			errop="$2" &&
+			errval="$3" &&
+			errfile="$trashdir/test_line_count_cmd_.err" &&
+			shift 3
+			;;
+		--)
+			shift &&
+			break
+			;;
+		-*)
+			BUG "test_line_count_cmd: unknown options: '$1'"
+			;;
+		*)
+			break
+			;;
+		esac
+	done &&
+	if test "x$1" = "x!"
+	then
+		shift &&
+		expect_failure=yes
+	fi &&
+	if test $# = 0
+	then
+		BUG "test_line_count_cmd: no command to be run"
+	elif test -z "$outop$errop"
+	then
+		BUG "test_line_count_cmd: check which stream?"
+	else
+		if test -n "$outfile"
+		then
+			test_when_finished "rm -f '$outfile'" &&
+			exec 3>"$outfile"
+		fi &&
+		if test -n "$errfile"
+		then
+			test_when_finished "rm -f '$errfile'" &&
+			exec 5>"$errfile"
+		fi &&
+		if ! "$@" >&3 2>&5
+		then
+			actual_failure=yes
+		fi
+	# Don't use &4, it's used for test_must_fail
+	fi 3>&1 5>&2 &&
+	case "$expect_failure,$actual_failure" in
+	yes,)
+		echo "error: '$@' succeed!"
+		return 1
+		;;
+	,yes)
+		echo "error: '$@' run into failure!"
+		return 1
+	esac &&
+	if test -n "$outop"
+	then
+		test_line_count "$outop" "$outval" "$outfile"
+	fi &&
+	if test -n "$errop"
+	then
+		test_line_count "$errop" "$errval" "$errfile"
+	fi
+}
+
 test_file_size () {
 	test "$#" -ne 1 && BUG "1 param"
 	test-tool path-utils file-size "$1"
-- 


-- 
Danh
