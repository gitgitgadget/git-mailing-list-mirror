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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70473C48BE8
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 01:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497DE61264
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 01:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhFSBdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 21:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbhFSBdS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 21:33:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F42C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 18:31:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 69so5587071plc.5
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 18:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vDHfeJP22GuNROdbt/1+yJShEIMmGVQB1yTYPYJRjw=;
        b=KCuV0dpYiSzxKnFMl4JONRG1Od2WNL9FvNocTAA2gqNxShRoJ7kIMATd0xOaEyaQVn
         Uz9FnxgYHPIb8NvFhd4wxaWgKOKgRK4DyjAnSkMOrrv5mmZUMKbEjf5NXJ/Zi3JTIgp9
         ptQpa1ptzDwMYQ8dlTzLKpNmfkRSfg2LCE3H7LkPcH6tTQNYv66W/JZ2iY8bzH66Ma4M
         DbZauqgGfiquSjzGxP7y7TX58WlFFliZxQRZP7opvp3cskTyaP4BWl9RjVxqB6Uf9ICP
         vijQB1GzkRGQQkQGH7TWNQFPIhB8z8Crs+uX8T1Edhds4avigYem7MGUCcv9yAHdkFxN
         mrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vDHfeJP22GuNROdbt/1+yJShEIMmGVQB1yTYPYJRjw=;
        b=FDdjWi2OX9JEhzphViiF9669U3owWrJuJFnwMO/Cw7ha+re0Wu32QntsGOnh5LyAHp
         nlaAOK7WWnF4sKKUXZGmta4FHTUUKUAU7eE7ry2zi432Rz6m7OAhpCIFqRWxICNoz0+O
         SO3cIB5vUDNp27eWKiwoKvg4rTewoiem21XkByLHhoTaQLQgehf1O33Agvr9nzTy9omj
         Md3TyahjquqkYye3D7wbNBXg33DhMweYwPW7/zdJHEB43o7r8EygI3rqjg/d2h9JDvwR
         mtnPhDD2ZCbZ0ENgbKJ1j5G+2eROtVshuOoOJQvdnPRbnwEFFukKHYZjzcH5imhapmzP
         IQeA==
X-Gm-Message-State: AOAM531yZRLOcBo9NaqJuW5KaYbch59wyT/mLorF87K6DvlDQdyOJ/YJ
        k44ZneUoEm9QK2/x/6+UFeD/vXib+u0=
X-Google-Smtp-Source: ABdhPJzdwrelKHBRFWZcWwJB1bEY1xtBptjglbyspH47dhwjugVwcY5BL0xQJCTyu5wcr+SMNvmv0A==
X-Received: by 2002:a17:902:8c83:b029:11b:3f49:f88c with SMTP id t3-20020a1709028c83b029011b3f49f88cmr7222520plo.63.1624066267078;
        Fri, 18 Jun 2021 18:31:07 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id s123sm8733427pfb.78.2021.06.18.18.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 18:31:06 -0700 (PDT)
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
Subject: [PATCH v3 1/4] test-lib-functions: introduce test_line_count_cmd
Date:   Sat, 19 Jun 2021 08:30:32 +0700
Message-Id: <20210619013035.26313-2-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210615172038.28917-1-congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the Git project, we have multiple instances that requires
checking number of lines of text in the stdout of a command.
One of such examples is t6400, that checks number of files
in various states.

Some of those commands are Git command, and we would like to check
their exit status.  In some of those checks, we pipe the stdout of
those commands to "wc -l" to count the number lines, thus losing
the exit status.

Introduce a helper function to check for the number of lines in stdout
from those commands.

This helper will create a temporary file in the process, thus it may
affect the output of some checks.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/test-lib-functions.sh | 80 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f0448daa74..e055a4f808 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -845,6 +845,86 @@ test_line_count () {
 	fi
 }
 
+# test_line_count_cmd checks the exit status, and the number of lines in
+# the captured stdout of a command.
+#
+# SYNOPSIS:
+#
+#	test_line_count_cmd <binop> <value> [!] cmd [args...]
+#
+# Expect succeed exit status when running
+#
+#	cmd [args...]
+#
+# then, run sh's "test <# of lines in stdout> <binop> <value>"
+#
+# OPTIONS:
+# !:
+#	Instead of expecting "cmd [args...]" succeed, expect its failure.
+#	Note, if the command under testing is "git",
+#	test_must_fail should be used instead of "!".
+#
+# EXAMPLE:
+#	test_line_count_cmd -ge 10 git tag --no-contains v1.0.0
+#	test_line_count_cmd -le 10 ! grep some-text a-file
+#	test_line_count_cmd = 0 test_must_fail git rev-parse --verify abcd1234
+#
+# NOTE:
+# * a temporary file named test_line_count_cmd_.out will be created under
+# $TRASH_DIRECTORY/.git/trash iff $TRASH_DIRECTORY/.git/ exists.
+# Otherwise, created in $TRASH_DIRECTORY. This temporary file will be
+# cleaned by test_when_finished
+test_line_count_cmd () {
+	{
+		local outop outval outfile
+		local expect_failure actual_failure
+		local trashdir="$TRASH_DIRECTORY"
+
+		if test -d "$TRASH_DIRECTORY/.git"
+		then
+			trashdir="$TRASH_DIRECTORY/.git/trash" &&
+			mkdir -p "$trashdir"
+		fi &&
+		if test $# -lt 3
+		then
+			BUG "missing <binary-ops> and <value>"
+		fi &&
+		outop="$1" &&
+		outval="$2" &&
+		shift 2 &&
+		outfile="$trashdir/test_line_count_cmd_.out" &&
+		if test "x$1" = "x!"
+		then
+			shift &&
+			expect_failure=yes
+		fi &&
+		if test $# = 0
+		then
+			BUG "test_line_count_cmd: no command to be run"
+		else
+			test_when_finished "rm -f '$outfile'" &&
+			exec 8>"$outfile"
+			# We need to redirect stderr to &9,
+			# and redirect this function's 9>&2
+			# in order to not messed with -x
+			if ! "$@" >&8 2>&9
+			then
+				actual_failure=yes
+			fi
+		fi 8>&1 &&
+		case "$expect_failure,$actual_failure" in
+		yes,)
+			echo >&4 "error: '$@' succeed!" &&
+			return 1
+			;;
+		,yes)
+			echo >&4 "error: '$@' run into failure!" &&
+			return 1
+		esac &&
+		test_line_count "$outop" "$outval" "$outfile" >&4
+	} 9>&2 2>&4
+}
+
 test_file_size () {
 	test "$#" -ne 1 && BUG "1 param"
 	test-tool path-utils file-size "$1"
-- 
2.32.0.278.gd42b80f139

