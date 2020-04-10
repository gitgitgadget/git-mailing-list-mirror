Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EDEC2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1CA2145D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxQe+rkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgDJRSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:18:43 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:38951 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgDJRSj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:39 -0400
Received: by mail-pf1-f179.google.com with SMTP id k15so1286812pfh.6
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QN7Q64j4a1PYWo6C9YjXPJpU6Un4mqbMkX33ke115aM=;
        b=jxQe+rkLRPRW4UhvPRJMSbJAqsdjm6vg4UD7sL53uIYFoftfiNqcguYcYP4MzAyq0K
         wS9d+lSLTKsBjNTOAaXXicO6UQvam1nhVc8Q8GU6aKViS2yueJYtCCHbv8gbsQM5T78v
         I8ZDEn/KIiZHfBE5Tk8Hx1sQw/RYv6DN9Dbihk1pU0Xr5MTnhQcjHSmtWGNzQa/EKVQo
         qsIweH9oru32uXchQQpCnpbJszzaLaOd+tk6kN0982FhcGZIOBKb9wUtS5oxthVJz0IX
         ADGOw8fhGQAr/NEsrvpkRXdRBlxf/Nb44yAsViaxMdcB/BePw2bKqTTRDOdQ8jvDP0cs
         fIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QN7Q64j4a1PYWo6C9YjXPJpU6Un4mqbMkX33ke115aM=;
        b=cdmCq0anorgeVKuA+DDhta67uenK+YOzJ9AIugr1fT4JMvwMUy5VK7idV5sCok0Oa6
         iLoneYjmhTrxw4UM0uEFHZGM43LqpiNWLoH4o2mEcGZyM32P8FsUUIwc+51b9F94oAwt
         izVVUXLvtlHdMgHfhaAlP3SUYY1KlYiTi1tP50Y0U2CxEyOEcEW0EufvUFG5dwCToc/S
         d+Vu86kq7DL0eEMQMO30+Fdtiug5dMKXBAdETlhGHU1fViKbzrCfdi4y7jT+EHj0Hkz0
         YuxZq4DX4hS/Wqx8bDhCE8a2Da0PK5p2VGfqNY5zlORFcKSVHiIOsIKdUqy0iyhpoVje
         Xqrg==
X-Gm-Message-State: AGi0PuZVsQYpB8XRMOoa9rPlC+WIxZFj/rXKuH67KyoaJOIWxdxr1UId
        +C7OlKEpEERyJN6TBzRzjh/8So1X
X-Google-Smtp-Source: APiQypJXNSY8rgVYHqncaHWNPAsnugYo8IEFQs8xZw0c2ti+d4ORnBX/rMhTdgjH9ySmsqgi91+qJw==
X-Received: by 2002:a63:3195:: with SMTP id x143mr5422207pgx.326.1586539118631;
        Fri, 10 Apr 2020 10:18:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s125sm1972897pgc.12.2020.04.10.10.18.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:18:38 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 10/12] tests: when run in Bash, annotate test failures with file name/line number
Date:   Sat, 11 Apr 2020 00:18:12 +0700
Message-Id: <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586538752.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586538752.git.congdanhqx@gmail.com>
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

