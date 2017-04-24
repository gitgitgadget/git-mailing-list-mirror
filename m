Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE37207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 21:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966217AbdDXVNR (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 17:13:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34168 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1174280AbdDXVNG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 17:13:06 -0400
Received: by mail-wr0-f193.google.com with SMTP id 6so8484995wrb.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 14:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRXsNNB8EPQ8wQ1UNi7lMaPoJtMBUe7wYFb9NzE4kVY=;
        b=NCkU9MvejOVl2LMIelh7k2PHD50sKiuz4hB+a8TqXnfRQ3jrhiqqeeXsnbbi4TegO1
         UucrW8jyYUeLu2tBDEZUE7+AN6UGly2AsdKJKar1AF+WNuAYN6XXOVqSVelaZH6jm8l0
         USgHyjQGx8mmosg/uvbQffkFnNYIJjV0HlphPz7Y/mM5B1ZPTW+I0u1cYOzrw67nM47Z
         VDbYP7E/MjLP+a5nb7Fh/D65wfrPS8/M1NYIeF/w5PUqgPelJUKrUQP75iZ6i94SGM2I
         Ect3FeT5W8fzzXdzal97qkIqVy8okh7i44+43CHq+mkWJ67124PspmvIN/kA6ZTyaT3s
         8SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRXsNNB8EPQ8wQ1UNi7lMaPoJtMBUe7wYFb9NzE4kVY=;
        b=Cwhd5TkyzVlBm54wqJY8QuFewQiSAE99ZC7rbIJRK+gp9Dfy/grkmPt6EPLGDVWw4C
         S4WKWjTCw5tcxdb5wsjqJxG7cPUUzzMLRNfGPI0yQk+9SkiOQKeyi+DybgF76O0bPoay
         P1d2A+RW19vPkIQCXXM48UJMN8UrXdnplnNHjDWhSRvo80a2pThbA4TuBdzeE9NYid0R
         dTzNa/3HLwD02d25+RcKNz9lSvkvrBzdqAcuDJbDlmm8Qsv3pSfKlttOYUJvyu+X59EV
         IuIGp+5WRXtuQrnP8pNK9+9xxRYU5d3UXdHCZrFHHywQDlPQ9jUMiHrqcVcdwq6V8CUt
         sekg==
X-Gm-Message-State: AN3rC/65b1MSwyCI+VXrBcEicfZW0nH14qn22Z8mknmgwjhAhLIV659h
        CycLXcFNby4qGw==
X-Received: by 10.223.132.39 with SMTP id 36mr6921840wrf.182.1493068385056;
        Mon, 24 Apr 2017 14:13:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p107sm12911027wrb.64.2017.04.24.14.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 14:13:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] perf: add test showing exponential growth in path globbing
Date:   Mon, 24 Apr 2017 21:12:49 +0000
Message-Id: <20170424211249.28553-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170424211249.28553-1-avarab@gmail.com>
References: <20170424211249.28553-1-avarab@gmail.com>
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

