Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D350C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D422073E
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrA2owW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389242AbgF3PDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbgF3PDk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:03:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3A0C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e12so15760850qtr.9
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fh2dfIVEBOy9PppBa/lU0BMRIiOvh5Fs5PbqhuwLFAw=;
        b=VrA2owW3TmxGs/IOMlwxxzDEQW8muqpB+ozzlyDO7ciESD2+D/kl0mgmD+TULpyxyt
         wfkp5X/Z2H0k2z6AFGT+oiPC1FbKU8uqIB8861rhQqqKlgzGGw/Fk5Mw+V/gutEvEKnG
         APbPkttTe28p4mTZeedJA6UwOE/Fp29RDoLhvOAzTE2qEGf+b+f4n4hCK7VmCAz+4uth
         VMrTGPBBFIRP+j0oN0LFVoEI5wxs/erQxwkH+2KgWYOFdtZc308Fq9UOzD0ttrth2l1f
         Sc3KYRN21kkECyRIVA7PTPjiheJKvt6GQXW49BwO9HlHzNWim3X+rGwg3ln0geRBQL3h
         lyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fh2dfIVEBOy9PppBa/lU0BMRIiOvh5Fs5PbqhuwLFAw=;
        b=fpig3PAiUvniRFsPT4ws+o+ApQcXpWD+cWPT2jtwjdZMX+TsqwzTlRPVgRL6VowWBv
         71DA4mUilyqaezpmhooWgUAbextanQGgsiWGbLWP5BFLqZeVqNsZD7xPO8oeQMINiXMM
         P2REERVBSStH6LVG6SJ/0+P0B3ldejv04MuYA1aAh4wwhek6zVDxCpG4Y5w2jbtryyzP
         13g+ZEQ6ZBNqPwHAFKAOrZW2TlYz9GPR+1uJSx9strEP8sNu06VEHwvfzZV8dh34shiD
         VOSfm2uC+i/P3JaxYzNkG1IPYyQ6SnP2xSVXygrX003P583sAwswU7m3MA3/98IyZK9v
         IN+A==
X-Gm-Message-State: AOAM533jTvtXrZFsexhK1gHL//QW7DuzGrKYoZb0aSiKTF0ZW9YC3ITX
        UjZOoDEUErydYOY6ORZkbRlhhg/EIuk=
X-Google-Smtp-Source: ABdhPJyl+kAugjenrj6h87Ieoes1B/EeXQ1Vfqdr8btQUJYXr2Y7jHEElIbijJuJUnOM+t8phPBPfg==
X-Received: by 2002:ac8:7343:: with SMTP id q3mr22440717qtp.165.1593529414285;
        Tue, 30 Jun 2020 08:03:34 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id p66sm3209626qkf.58.2020.06.30.08.03.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:03:33 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 5/5] test-lib-functions: restrict test_must_fail usage
Date:   Tue, 30 Jun 2020 11:03:19 -0400
Message-Id: <01e29450fe51a4ba13e07c611d8795ffd0282b9e.1593529394.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1593529394.git.liu.denton@gmail.com>
References: <cover.1593529394.git.liu.denton@gmail.com>
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
we're potentially wrapping a git command (like in these case).

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
 t/t0000-basic.sh        | 18 ++++++++++++++++++
 t/test-lib-functions.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2ff176cd5d..f5e4fb515d 100755
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
+	test_must_fail env var1=a var2=b env var3=c git notacommand
+'
+
+test_expect_success 'test_must_fail rejects a non-git command' '
+	! test_must_fail grep ^$ notafile 2>err &&
+	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
+'
+
+test_expect_success 'test_must_fail rejects a non-git command with env' '
+	! test_must_fail env var1=a var2=b env var3=c grep ^$ notafile 2>err &&
+	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
+'
+
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 3103be8a32..16596b28ba 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -798,6 +798,31 @@ list_contains () {
 	return 1
 }
 
+# Returns success if the arguments indicate that a command should be
+# accepted by test_must_fail(). If the command is run with env, the env
+# and its corresponding variable settings will be stripped before we
+# test the command being run.
+test_must_fail_acceptable () {
+	while test "$1" = "env"
+	do
+		shift
+		while test $# -gt 0
+		do
+			case "$1" in *?=*) ;; *) break ;; esac
+			shift
+		done
+	done
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
@@ -817,6 +842,15 @@ list_contains () {
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
+# Just use '!' instead.
 
 test_must_fail () {
 	case "$1" in
@@ -828,6 +862,11 @@ test_must_fail () {
 		_test_ok=
 		;;
 	esac
+	if ! test_must_fail_acceptable "$@"
+	then
+	    echo >&7 "test_must_fail: only 'git' is allowed: $*"
+	    return 1
+	fi
 	"$@" 2>&7
 	exit_code=$?
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
-- 
2.27.0.383.g050319c2ae

