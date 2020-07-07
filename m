Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C21C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD5820739
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDH8RY9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgGGGFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGGGFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:05:09 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606F0C061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 23:05:09 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d27so30894700qtg.4
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 23:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3GNMzB5XGdG57c9J4z50Te/wnYLlfKFYIxSwlHCaJh0=;
        b=CDH8RY9I/dT2tduZ9P0AHk13+WIvJectPWfDlrFeYU8HPB9FMMG2vFwEWRRO46gIB7
         E+MA1hYbXH6HYrNwhhm+rbODSDhnu6rQQr6U5tW5TkRuZ5vRr3wt8I6VsJo6oy5mx5Qw
         rAQtLDZR77wgrE7qdQ1nAEw6yw9tCHHikDHOmeLhxUxurFiezWHixJYYx6JKT1tg3Q4G
         +7V7dVmZgQHF4mTKtU8Wtz8xppJAtzf84cgU88T/mHmDRdq8eLadnF718eH0+FSdBEgh
         J77CNZDPzhCUIjhI6VeQ9Iy16MWWMg6V2/0jR+qrY8XtHtpDSyV2tQN02VDqn6KMbXpz
         zA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3GNMzB5XGdG57c9J4z50Te/wnYLlfKFYIxSwlHCaJh0=;
        b=H7TWmeXgdS+tl3ZNVJsEECbo5Ci2DxKVW5PpDH5OFkzJ53x+w0z6AUSn3Pks4vhzNr
         I9tdvT8iZvABF1aErW/KmEocsYS9D6pjq9eWjSxtm1oPKoW0YFYC/7r2/iSPSAfK71XA
         twVlCoVadVIXKer/iEh1yR8TgZpJRMcBoKCC8atRe6c3V2ZcLM9LmjkH/I4Ia+XIJwz9
         lnTn5HxHvbOFstx5jGKnL96tCXHdalHNa6pF0ZqwLG9HpvcdQCbNxJ254flWtpqDL/hy
         HSbs4x3a7c8oh2AxzESjCpx9xEAr1+WMMXh2602sCc7OieHq2C8OlACXxrEzQphJ7hV7
         SqnQ==
X-Gm-Message-State: AOAM530UULg1hp+QPjUhm1SehBjZzJ3Mypq10iH9PIa9eNQSrpXbboj+
        ixBiVXubkVVNN58JdhfFKqhxeVON3a8=
X-Google-Smtp-Source: ABdhPJxqs0JyaSseGj5DRM4nxHUJcekTqfU/KVjrdG+jhl10pGrRSeU8IWe8xRfkiSikDGcbRcaDRg==
X-Received: by 2002:ac8:36bb:: with SMTP id a56mr53022284qtc.201.1594101908397;
        Mon, 06 Jul 2020 23:05:08 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id k197sm23446778qke.133.2020.07.06.23.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 23:05:07 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RESEND PATCH v2 5/5] test-lib-functions: restrict test_must_fail usage
Date:   Tue,  7 Jul 2020 02:04:38 -0400
Message-Id: <3ebbda6c57005967b718d834aed7e3eaf00d18b4.1594101831.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1594101831.git.liu.denton@gmail.com>
References: <cover.1593576601.git.liu.denton@gmail.com> <cover.1594101831.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In previous commits, we removed the usage of test_must_fail() for most
commands except for a set of pre-approved commands. Since that's done,
only allow test_must_fail() to run those pre-approved commands.

Obviously, we should allow `git`.

We allow `__git*` as some completion functions return an error code that
comes from a git invocation. It's good to avoid using test_must_fail
unnecessarily but it wouldn't hurt to err on the side of caution when
we're potentially wrapping a git command (like in these cases).

We also allow `test-tool` and `test-svn-fe` because these are helper
commands that are written by us and we want to catch their failure.

Finally, we allow `test_terminal` because `test_terminal` just wraps
around git commands. Also, we cannot rewrite
`test_must_fail test_terminal` as `test_terminal test_must_fail` because
test_must_fail() is a shell function and as a result, it cannot be
invoked from the test-terminal Perl script.

We opted to explicitly list the above tools instead of using a catch-all
such as `test[-_]*` because we want to be as restrictive as possible so
that in the future, someone would not accidentally introduce an
unrelated usage of test_must_fail() on an "unapproved" command.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0000-basic.sh        | 18 ++++++++++++++++
 t/test-lib-functions.sh | 47 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2ff176cd5d..90bf1dbc8d 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1271,4 +1271,22 @@ test_expect_success 'very long name in the index handled sanely' '
 	test $len = 4098
 '
 
+test_expect_success 'test_must_fail on a failing git command' '
+	test_must_fail git notacommand
+'
+
+test_expect_success 'test_must_fail on a failing git command with env' '
+	test_must_fail env var1=a var2=b git notacommand
+'
+
+test_expect_success 'test_must_fail rejects a non-git command' '
+	! test_must_fail grep ^$ notafile 2>err &&
+	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
+'
+
+test_expect_success 'test_must_fail rejects a non-git command with env' '
+	! test_must_fail env var1=a var2=b grep ^$ notafile 2>err &&
+	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
+'
+
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 3103be8a32..b791933ffd 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -798,6 +798,37 @@ list_contains () {
 	return 1
 }
 
+# Returns success if the arguments indicate that a command should be
+# accepted by test_must_fail(). If the command is run with env, the env
+# and its corresponding variable settings will be stripped before we
+# test the command being run.
+test_must_fail_acceptable () {
+	if test "$1" = "env"
+	then
+		shift
+		while test $# -gt 0
+		do
+			case "$1" in
+			*?=*)
+				shift
+				;;
+			*)
+				break
+				;;
+			esac
+		done
+	fi
+
+	case "$1" in
+	git|__git*|test-tool|test-svn-fe|test_terminal)
+		return 0
+		;;
+	*)
+		return 1
+		;;
+	esac
+}
+
 # This is not among top-level (test_expect_success | test_expect_failure)
 # but is a prefix that can be used in the test script, like:
 #
@@ -817,6 +848,17 @@ list_contains () {
 #     Multiple signals can be specified as a comma separated list.
 #     Currently recognized signal names are: sigpipe, success.
 #     (Don't use 'success', use 'test_might_fail' instead.)
+#
+# Do not use this to run anything but "git" and other specific testable
+# commands (see test_must_fail_acceptable()).  We are not in the
+# business of vetting system supplied commands -- in other words, this
+# is wrong:
+#
+#    test_must_fail grep pattern output
+#
+# Instead use '!':
+#
+#    ! grep pattern output
 
 test_must_fail () {
 	case "$1" in
@@ -828,6 +870,11 @@ test_must_fail () {
 		_test_ok=
 		;;
 	esac
+	if ! test_must_fail_acceptable "$@"
+	then
+		echo >&7 "test_must_fail: only 'git' is allowed: $*"
+		return 1
+	fi
 	"$@" 2>&7
 	exit_code=$?
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
-- 
2.27.0.383.g050319c2ae

