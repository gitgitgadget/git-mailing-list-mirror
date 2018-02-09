Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325361F404
	for <e@80x24.org>; Fri,  9 Feb 2018 02:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeBICnI (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 21:43:08 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:44994 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeBICnH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 21:43:07 -0500
Received: by mail-wr0-f180.google.com with SMTP id v31so6721147wrc.11
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 18:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3+GaYecuPKNcl58s1VMpw6VXop2GSpWiFc+BPjGdQA=;
        b=fogqobNH8aNZQNBcjIRvYdtDUmzP6vp6Rgvz6EaCkuOKREOf9AgfRxMAyTAixRXW+o
         9zRzX7/+C9yw1ns47Yn3LzinvuDVFFqdL1Sfz37R5vtUkDoGrjTtFmXBSfuD1t3YvOiL
         v33K9lxOXOJXwkskjtiET+8ieE9mXkCFI/cr7OrgZZdHp74UZ30ZqaHWWoLG3QrtCJsT
         zvm24mhc99kf8igSnNlEM4lsP4SMwvb7o2jBi1r7wuI7kfpRur3vjkQdLsH49QlQrt6k
         Nn4r0MQrkxvZpERYCkqKJkWOW1CqYME3uv8/mKocieXAuAGv4R/sf4zchg6XADnubNeM
         84sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3+GaYecuPKNcl58s1VMpw6VXop2GSpWiFc+BPjGdQA=;
        b=GChq3RoepjtJlt6OzNnAc5hUqANrNKwmGBqvuWFzZ6rPDffBtj/dOIewWCI5PN5ZlV
         /TK9Y7dAv0dWkF7w47vyi54IuS22+Do0Ryyeqagt7Z3lXmn0FC9Gen6XGA9RWkgt0KH6
         fAzbA3IN7YJQ8wtRqMMG5PMi1UXRWji9QUYi3szOmDDEZnV74YSzr5xANsUdpp3T6HQM
         OQ+XF3CtNWQbPEOAO52KPSer7hSZHUVy3RwsYNhMnkpJXuGl7ZvXU1YUZjTRX5Um26Bc
         K7g/Kd5qUxJIq+yDc7Q6pcjXm2VaoISqU6swjNUgRt1kDK8ReKQ3Wfveblp3gUsUH/F8
         xMYg==
X-Gm-Message-State: APf1xPAL0QhzrcwNeEPstDqEZvIyBKPgumrXnlsx0bQ5fAjBcPafaOk3
        TEpVu7OZ3u5+IZ6j8QsAPNeFjg==
X-Google-Smtp-Source: AH8x226heiUmx+0P08dIB8TlaVEZ0VHm0PFm2gAnq1bxpzLlT1tekEQqMTx639C518bAdn/6QjWSBg==
X-Received: by 10.223.179.69 with SMTP id k5mr939470wrd.278.1518144185633;
        Thu, 08 Feb 2018 18:43:05 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id x18sm2226174wrg.82.2018.02.08.18.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 18:43:05 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] t: teach 'test_must_fail' to save the command's stderr to a file
Date:   Fri,  9 Feb 2018 03:42:34 +0100
Message-Id: <20180209024235.3431-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.180.g07550b0b1b
In-Reply-To: <20180209024235.3431-1-szeder.dev@gmail.com>
References: <20180209024235.3431-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To check that a git command fails and to inspect its error message we
usually execute a command like this throughout our test suite:

  test_must_fail git command --option 2>output.err

Note that this command doesn't limit the redirection to the git
command, but it redirects the standard error of the 'test_must_fail'
helper function as well.  This is wrong for several reasons:

  - If that git command were to succeed or die for an unexpected
    reason e.g. signal, then 'test_must_fail's helpful error message
    would end up in the given file instead of on the terminal or in
    't/test-results/$T.out', when the test is run with '-v' or
    '--verbose-log', respectively.

  - If the test is run with '-x', the trace of executed commands in
    'test_must_fail' will go to stderr as well (except for more recent
    Bash versions supporting $BASH_XTRACEFD), and then in turn will
    end up in the given file.

  - If the git command's error message is checked verbatim with
    'test_cmp', then the '-x' trace will cause the test to fail.

  - Though rather unlikely, if the git command's error message is
    checked with 'test_i18ngrep', then its pattern might match
    'test_must_fail's error message (or '-x' trace) instead of the
    given git command's, potentially hiding a bug.

Teach the 'test_must_fail' helper the 'stderr=<file>' option to save
the executed git command's standard error to that file, so we can
avoid all the bad side effects of redirecting the whole thing's
standard error.

The same issues apply to the 'test_might_fail' helper function as
well, but since it's implemented as a thin wrapper around
'test_must_fail', no modifications were necessary and 'test_might_fail
stderr=output.err git command' will just work.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Notes:
    I considered adding an analogous 'stdout=<file>' option as well, but in
    the end haven't, because:
    
      - 'test_must_fail' doesn't print anything to its standard output, so a
        plain '>out' redirection at the end of the line doesn't have any
        undesirable side effects.
    
      - We would need four conditions to cover all possible combinations of
        'stdout=' and 'stderr='.  Considering the above point, I don't think
        it's worth it.

 t/README                |  6 ++++++
 t/test-lib-functions.sh | 35 +++++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/t/README b/t/README
index 1a1361a806..2528359e9d 100644
--- a/t/README
+++ b/t/README
@@ -430,6 +430,10 @@ Don't:
    use 'test_must_fail git cmd'.  This will signal a failure if git
    dies in an unexpected way (e.g. segfault).
 
+   Don't redirect 'test_must_fail's standard error like
+   'test_must_fail git cmd 2>err'.  Instead, run 'test_must_fail
+   stderr=err git cmd'.
+
    On the other hand, don't use test_must_fail for running regular
    platform commands; just use '! cmd'.  We are not in the business
    of verifying that the world given to us sanely works.
@@ -670,6 +674,8 @@ library for your script to use.
        Multiple signals can be specified as a comma separated list.
        Currently recognized signal names are: sigpipe, success.
        (Don't use 'success', use 'test_might_fail' instead.)
+     stderr=<file>:
+       Save <git-command>'s standard error to <file>.
 
  - test_might_fail [<options>] <git-command>
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 26b149ac1d..d2f561477c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -618,18 +618,33 @@ list_contains () {
 #     Multiple signals can be specified as a comma separated list.
 #     Currently recognized signal names are: sigpipe, success.
 #     (Don't use 'success', use 'test_might_fail' instead.)
+#   stderr=<file>:
+#     Save the git command's standard error to <file>.
 
 test_must_fail () {
-	case "$1" in
-	ok=*)
-		_test_ok=${1#ok=}
-		shift
-		;;
-	*)
-		_test_ok=
-		;;
-	esac
-	"$@"
+	_test_ok= _test_stderr=
+	while test $# -gt 0
+	do
+		case "$1" in
+		stderr=*)
+			_test_stderr=${1#stderr=}
+			shift
+			;;
+		ok=*)
+			_test_ok=${1#ok=}
+			shift
+			;;
+		*)
+			break
+			;;
+		esac
+	done
+	if test -n "$_test_stderr"
+	then
+		"$@" 2>"$_test_stderr"
+	else
+		"$@"
+	fi
 	exit_code=$?
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
 	then
-- 
2.16.1.180.g07550b0b1b

