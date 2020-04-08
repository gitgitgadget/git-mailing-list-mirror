Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26858C2BA2B
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBCF2076E
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es8v8RWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgDHEGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:17 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:39065 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgDHEGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:06:16 -0400
Received: by mail-pl1-f178.google.com with SMTP id k18so2051735pll.6
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QN7Q64j4a1PYWo6C9YjXPJpU6Un4mqbMkX33ke115aM=;
        b=Es8v8RWIwddC2UlIyymvPVYFNgFRe7IGpVx438WLD0X3JDo49Ju4Im31HEfST0XkNJ
         5wjbl4zrbxMI2fXIJIykmRHRLK6D3N5+M1e6aar/+UCr//X5HJjbjpnCsincerFnQFhc
         o23U/ijZy3KhtcxlhT0peFiDmd2Bg+7xV1CIZ6LGnT7pncygT/23Rz3R7RXoS8CFzqz4
         0QVeWwSx4In5fj/iQU7v4mrlpnpo6KethxgHl/7/t03Noh3QaSYKBzhGO+FZ1EIoHBew
         zyM/ykvOaWquxDNPiL87al5mMdRoGk7k4qXgqeyXLOVghwgCpH+aVV6IUWEvRbL6F/k9
         eMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QN7Q64j4a1PYWo6C9YjXPJpU6Un4mqbMkX33ke115aM=;
        b=N2NVntHtLSH0ilCWfVASfdx+WIBiPdnmUaRjkkb6JUlfg1b7BSCby7ncS6lX/LN7WU
         F5+lGqA7fUQCX29Js68UgdK+91GvCYk5NJjv9x+kgwyZQd+lzpvjwN5LAQ4WUveaQtDa
         cP2+KZ2j2uCv73JVlBh251z6ErZOkPwG0JMVIDsSd2T1pQPlm8sLfdGIu80/r8g46tay
         rFafaVyFE8Xau5wWkBrI/k6gR9cHmfXScPgE6P2F9KuIEmd0wOve7+mXEuWtVE3PhBUo
         wlPhqQnIZhEo0n/VgRfdoiOvsNM1TAQjPybr/u1e2Hjb0syP1s6tTYwJK7OJdWFoxv8e
         2zzg==
X-Gm-Message-State: AGi0PubWwf3IHzxCN9OhWhB1PSuF8pruZG1WKQ0FOc38oajQ03cW/LBl
        VXf2YcxBPnZpZQJ4hTvcaix/+vQxleo=
X-Google-Smtp-Source: APiQypLCMtPIXNKTpWlcv82eNDxnqjPsExEQwYiev1YSvDqOutN0tyGpVmSXfjtm0j9KguriAhWteg==
X-Received: by 2002:a17:902:9b90:: with SMTP id y16mr4450307plp.227.1586318774822;
        Tue, 07 Apr 2020 21:06:14 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:06:14 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 10/12] tests: when run in Bash, annotate test failures with file name/line number
Date:   Wed,  8 Apr 2020 11:05:41 +0700
Message-Id: <f688fa50d3d08bcb317d5e4738a7a753ab5592f9.1586309211.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586309211.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586309211.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a test fails, it is nice to see where the corresponding code lives
in the worktree. Sadly, it seems that only Bash allows us to infer this
information. Let's do it when we detect that we're running in a Bash.

This will come in handy in the next commit, where we teach the GitHub
Actions workflow to annotate failed test runs with this information.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/test-lib.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0ea1e5a05e..40a00983f7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -657,6 +657,18 @@ die () {
 	fi
 }
 
+file_lineno () {
+	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
+	local i
+	for i in ${!BASH_SOURCE[*]}
+	do
+		case $i,"${BASH_SOURCE[$i]##*/}" in
+		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;;
+		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${1+$1: }"; return;;
+		esac
+	done
+}
+
 GIT_EXIT_OK=
 trap 'die' EXIT
 # Disable '-x' tracing, because with some shells, notably dash, it
@@ -702,7 +714,7 @@ test_failure_ () {
 		write_junit_xml_testcase "$1" "      $junit_insert"
 	fi
 	test_failure=$(($test_failure + 1))
-	say_color error "not ok $test_count - $1"
+	say_color error "$(file_lineno error)not ok $test_count - $1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	test "$immediate" = "" || { finalize_junit_xml; GIT_EXIT_OK=t; exit 1; }
-- 
2.26.0.334.g6536db25bb

