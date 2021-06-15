Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B9BC48BE8
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7074261414
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhFORXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhFORXB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 13:23:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1052BC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:20:57 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so55151pjq.3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+cD72M1t4pVa1ivEBjBmxtAr704rXXhQQ6m9Gw7UIc=;
        b=I9nfsmXMM7YwUoxyEY2A21wG6wawMaUV10527XpfIXkIuPMuZokoCRg09J9YjBe0A8
         17vMOoLZy29I2eQlhQZGCvZFn/0vWQ3YAJ+xeMudTGgbRMfDzerBayS5wTv5uw9l7Fo7
         4LO7Fi+/Sidg0kb7t0atSPNunp3oU21y1bizO2Sg5LUH80BIK8jG8jxyMQoZmDKYHOiR
         xoxBMmi2hd/ONsWR24wICKUnJNvwPxgyiM17i/3chef2GGapnBf+NPmUNTimd3YN0K6R
         wsYZXQuVc7Vdmn5njPeaTIJZt61BgogNhiEnmY/9FJBJg2Xebuxu7Ht5ig1Yo3ONVB0U
         /KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+cD72M1t4pVa1ivEBjBmxtAr704rXXhQQ6m9Gw7UIc=;
        b=MWvmdQ4FzxE0Ow3LhClxBSSE5442XchKVifSO1kfN9/X0EdjM5NWRytH5ThlQ9L89Y
         S49IcNo9dL7AwWx9TVqixofTckSuwQgQUPEd1MpZ1LqDVLrMUqDQDR7TdUxgAwqN2bNt
         20XjcjXKgToHstkJs/uWzrmrlKMyNMlR7f32UqcvbktnpakA+LVLKyUfKGsfZTy4gQe9
         HiwBLVFewjVM3cBJbMllUZsCoPDPJ6AvySL9zNL7CEFfiWfP3UBZHqfVUK3WGsZzS7mp
         r9fyG1xVB/oxSbABfY5F3ogFXh7W5EqMbhARkrPAJKij9avp1s6WjyyM/j7mswv3qRvD
         gbAg==
X-Gm-Message-State: AOAM5313wnE/22GQK82jyD5V2CIEEEoul5WljKSIIkrFTbLMb2xy1n5O
        Ka3GgmLITM5USINwbwrwPuP/nQUzY+o=
X-Google-Smtp-Source: ABdhPJwnrn6IZfIXXse0ykZslbb9qmlaI1ckhg2oquvRoFFsXHyYXw0XxDx6LCpBJVqGgX756OfFQw==
X-Received: by 2002:a17:90a:8818:: with SMTP id s24mr6014309pjn.41.1623777656419;
        Tue, 15 Jun 2021 10:20:56 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id z22sm16864162pfa.157.2021.06.15.10.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:20:56 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/5] test-lib-functions: introduce test_line_count_cmd
Date:   Wed, 16 Jun 2021 00:20:34 +0700
Message-Id: <20210615172038.28917-2-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210615172038.28917-1-congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 t/test-lib-functions.sh | 117 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f0448daa74..b3281409de 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -845,6 +845,123 @@ test_line_count () {
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
+	{
+		local outop outval outfile
+		local errop errval errfile
+		local expect_failure actual_failure
+		local trashdir="$TRASH_DIRECTORY"
+
+		if test -d "$TRASH_DIRECTORY/.git"
+		then
+			trashdir="$TRASH_DIRECTORY/.git/trash" &&
+			mkdir -p "$trashdir"
+		fi &&
+		while test $# != 0
+		do
+			case "$1" in
+			--out)
+				outop="$2" &&
+				outval="$3" &&
+				outfile="$trashdir/test_line_count_cmd_.out" &&
+				shift 3
+				;;
+			--err)
+				errop="$2" &&
+				errval="$3" &&
+				errfile="$trashdir/test_line_count_cmd_.err" &&
+				shift 3
+				;;
+			--)
+				shift &&
+				break
+				;;
+			-*)
+				BUG "test_line_count_cmd: unknown options: '$1'"
+				;;
+			*)
+				break
+				;;
+			esac
+		done &&
+		if test "x$1" = "x!"
+		then
+			shift &&
+			expect_failure=yes
+		fi &&
+		if test $# = 0
+		then
+			BUG "test_line_count_cmd: no command to be run"
+		elif test -z "$outop$errop"
+		then
+			BUG "test_line_count_cmd: check which stream?"
+		else
+			if test -n "$outfile"
+			then
+				test_when_finished "rm -f '$outfile'" &&
+				exec 8>"$outfile"
+			fi &&
+			if test -n "$errfile"
+			then
+				test_when_finished "rm -f '$errfile'" &&
+				exec 9>"$errfile"
+			fi &&
+			if ! "$@" >&8 2>&9
+			then
+				actual_failure=yes
+			fi
+		fi 8>&1 &&
+		case "$expect_failure,$actual_failure" in
+		yes,)
+			echo >&4 "error: '$@' succeed!"
+			return 1
+			;;
+		,yes)
+			echo >&4 "error: '$@' run into failure!"
+			return 1
+		esac &&
+		if test -n "$outop"
+		then
+			test_line_count "$outop" "$outval" "$outfile" >&4
+		fi &&
+		if test -n "$errop"
+		then
+			test_line_count "$errop" "$errval" "$errfile" >&4
+		fi
+	} 9>&2 2>&4
+}
+
 test_file_size () {
 	test "$#" -ne 1 && BUG "1 param"
 	test-tool path-utils file-size "$1"
-- 
2.32.0.278.gd42b80f139

