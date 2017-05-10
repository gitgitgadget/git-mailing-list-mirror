Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBD4F20188
	for <e@80x24.org>; Wed, 10 May 2017 22:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753704AbdEJWxg (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 18:53:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34242 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753180AbdEJWxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 18:53:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so2988074wmf.1
        for <git@vger.kernel.org>; Wed, 10 May 2017 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRXsNNB8EPQ8wQ1UNi7lMaPoJtMBUe7wYFb9NzE4kVY=;
        b=tJbT8D501l/Heh7jVcAbQPlSdLMTvee0CB6Dvx/qetncM2IrHE5xSUwW9r8nHVRWDh
         A8ypOhISLp0NqkhVdC7zF1cOuwK7IsrUL6vntCHrsV9ddhvZtt/y5ruYDPh/bbyy4GMm
         sukzJiD7XLKf0O4FJFHsqZkED21rw9Zue/i17dnWESyqhXviHdrcQzmDyNa9DFyMzQ/h
         C6gCtc5mO5ZY4PpK6/bpegk+I/5iJCygkjf0L0FcEKAlF5awt2ATM51civQ3nmL8KKcn
         U8/ToixZ68SVQms/5Ig8hwke5Xe1L+c01kUZJYxeAkR2/yhZ48LqfLPARct+87VWaaQ/
         wZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRXsNNB8EPQ8wQ1UNi7lMaPoJtMBUe7wYFb9NzE4kVY=;
        b=QAvYE/4eH8EzSo49oWASJ/SusvzLK4wXQ94M6vHMmW33IifWRstsVi2d2F8itVjrnl
         +aaPIk3dGuiL8qYiST1bFdYoJrOsK3hEFTtHzvelfup3H+3I69QZCS/LDw4ZSPq8GLDk
         oIsGnxDi36Mw3QUA6PYpXMmzGDDPcXu9AlM24uVm9P1+xhKnZT++5EFlF6GsMc1yzmd4
         FICBrM5wJT1vu09w3gWyTYZN/aqj0O32vova5rC+94opAih21FI4x6kZZ8aHpSyluV6i
         0pZ6cLEP2ZND0IuEoS8iIXF2S/M0KFoCqwwIY//6TwsxXXxvILPFBD2X19HsQhahkjRS
         hGIA==
X-Gm-Message-State: AODbwcDkpdOTUzSPPohxD9Ha047eAxD3+w4mYTmaKuHFGX+n8gerBntX
        s61LXPHgnsjJlg==
X-Received: by 10.80.137.155 with SMTP id g27mr1860598edg.125.1494456813528;
        Wed, 10 May 2017 15:53:33 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id x26sm86722edx.60.2017.05.10.15.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 May 2017 15:53:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] perf: add test showing exponential growth in path globbing
Date:   Wed, 10 May 2017 22:53:16 +0000
Message-Id: <20170510225316.31680-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170510225316.31680-1-avarab@gmail.com>
References: <20170510225316.31680-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test showing that ls-files times grow exponentially in the face
of some pathological globs, whereas refglobs via for-each-ref don't in
practice suffer from the same issue.

As noted in the test description this is a test to see whether Git
suffers from the issue noted in an article Russ Cox posted today about
common bugs in various glob implementations:
https://research.swtch.com/glob

The pathological git-ls-files globbing is done by wildmatch() in
wildmatch.c. The for-each-ref codepath also uses wildmatch(), but will
always match against e.g. "refs/tags/aaa...", not "aaa.." as
git-ls-files will.

I'm unsure why the pathological case isn't triggered by for-each-ref,
but in any case, now we have a performance test for it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p0100-globbing.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 t/perf/p0100-globbing.sh

diff --git a/t/perf/p0100-globbing.sh b/t/perf/p0100-globbing.sh
new file mode 100755
index 0000000000..e98fd7ce4b
--- /dev/null
+++ b/t/perf/p0100-globbing.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description="Tests pathalogical globbing performance
+
+Shows how Git's globbing performance performs when given the sort of
+pathalogical patterns described in at https://research.swtch.com/glob
+"
+
+. ./perf-lib.sh
+
+test_globs_big='10 25 50 75 100'
+test_globs_small='1 2 3 4 5 6'
+
+test_perf_fresh_repo
+
+test_expect_success 'setup' '
+	for i in $(test_seq 1 100)
+	do
+		printf "a" >>refname &&
+		for j in $(test_seq 1 $i)
+		do
+			printf "a*" >>refglob.$i
+		done &&
+		echo b >>refglob.$i
+	done &&
+	test_commit $(cat refname) &&
+	for i in $(test_seq 1 100)
+	do
+	echo	git tag $(cat refname)-$i
+	done &&
+	test_commit hello
+'
+
+for i in $test_globs_big
+do
+	test_perf "refglob((a*)^nb) against tag a^100; n = $i" '
+		git for-each-ref "refs/tags/$(cat refglob.'$i')b"
+	'
+done
+
+for i in $test_globs_small
+do
+	test_perf "fileglob((a*)^nb) against file (a^100).t; n = $i" '
+		git ls-files "$(cat refglob.'$i')b"
+	'
+done
+
+test_done
-- 
2.11.0

