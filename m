Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05197C4332E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBD2650F8
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbhCPP7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbhCPP6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E6DC061765
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e10so10730250wro.12
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJteMU6h8ULo+a1oO7hctp1MKm49zgDRKN+RbwKlzV0=;
        b=O8WXO4JWmHrVifgMB4+NKHeFAWbeQW6AFy0rcmjzfOZJu1AUIsEVBIQ5jH0v5erBiT
         QlEg8P6HZ5LxNxLdJl4M3kyu7hzA8bel9w1MtCErf9EN60TLhvHQsheUUZasZISpDrhy
         LqXg2TS+8TTRgbYQ7O1esRv4pkr0RjaSvptV22nkvqmezn7PsvkRgFay4LB+Na9e2iTz
         uoFNO1B44iRIhPAXkVfzh2YDSydTZ2e93b3GFWOu+TJz584bbgL8mPEphSNPCAvDBZN3
         SxZmLpPIbBcvRP2bqNonOjMI1xR/8sPuGoiewLTCA+q8/jjhHnBX7BkMhKZMlMZ79UII
         Qxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJteMU6h8ULo+a1oO7hctp1MKm49zgDRKN+RbwKlzV0=;
        b=QFgApwlsZQW80Cm1STc6xceCMJE1lWPFArTcnrExG2V7EQZp5G5wuZGx/l3Yb44m+Q
         NDLFdQPCzVZ+qWt+yNPO5LspXBQEAa5n6o3XHNxRDRs2doKXWRprMybvKpllfVxiFBrl
         T1V1n98j25AjgN683C06qyPkv258raU37Mb3YH3bc79ASDNS8xoJcbJUKT2uDJMPvZVm
         eKMNdhK9bylq+APcMpoiKv9pKv0a/lLDWTqqvL/bo6v4xIWgeFgEPxaCEDcQPwFUhdU/
         vk5BwN9PDd01SfXsx+LetJZQ3I5wwwAV2zSd90Jy5f3iFEwRjchAPkNeuXQFG3ElXDwW
         T+jw==
X-Gm-Message-State: AOAM530i5XjJ53Q2pRgrbQYj4EKVbv2D68Xovv5NwJdRmY90ZyBNsqY4
        PNqgu3mQsmHl1rfScONXDsBNyb9cnyduzg==
X-Google-Smtp-Source: ABdhPJy8fo5RaMbWq9oW+ayJH2I6yzbOLfoBFUeFG19YTeuG92etfdpng63XtriLNDwtUNpumYLEXQ==
X-Received: by 2002:adf:f841:: with SMTP id d1mr5567598wrq.36.1615910322783;
        Tue, 16 Mar 2021 08:58:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/32] fast-import tests: test for sorting dir/file foo v.s. foo.txt
Date:   Tue, 16 Mar 2021 16:58:03 +0100
Message-Id: <20210316155829.31242-7-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing test for the sorting of "foo" v.s. "foo.txt" where "foo"
can be either a file or a directory. If it's a file then "foo" should
sort before "foo.txt", and the other way around if "foo" is a
directory.

See [1] for a reply to a patch of mine introducing such a
regression. We now finally have a test for this code added back in
463acbe1c6 (Added tree and commit writing to fast-import.,
2006-08-14).

This tests both the tecmp1() and tecmp0() functions introduced inn
4cabf8583f (Implemented tree delta compression in fast-import.,
2006-08-28).

This will catch cases where the "mode" is the same, or reversed
between a & b in both functions.

There was an existing test for the tecmp1() function(s) just above
this one added here.

That existing test was added in e741130386 (New fast-import test case
for valid tree sorting, 2007-03-12) and would catch cases where
entries were reversed, but not if their mode (or rather, type) was the
the same or otherwise wrong value.

There were no tests at all for the tecmp0() function. As with the
tecmp1() test the new test will catch cases where the "mode" is the
same (e.g. "1"), or if the two are reversed. It won't catch a "return
0" from the function (i.e. already sorted), that case requires
tecmp1() to also be broken.

1. https://lore.kernel.org/git/CABPp-BEZfG_pNNTWsnxEa1xG+kgpQfpXj=KHBkCBAMikrXj-aA@mail.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9300-fast-import.sh | 87 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5c47ac4465..8bafb8cc51 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -955,6 +955,93 @@ test_expect_success 'L: verify internal tree sorting' '
 	test_cmp expect actual
 '
 
+test_expect_success 'L: verify internal tree sorting on bad input (tecmp1)' '
+	test_create_repo L1-0 &&
+
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data 0
+
+	reset refs/heads/L1-0
+	commit refs/heads/L1-0
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	create L1-0
+	COMMIT
+	M 100644 :1 x.txt
+	M 100644 :1 x/y.txt
+	M 100644 :1 z.txt
+	M 100644 :1 z
+	INPUT_END
+
+	cat >expected <<-EXPECT_END &&
+	x.txt
+	x
+	z
+	z.txt
+	EXPECT_END
+
+	git -C L1-0 fast-import <input &&
+	git -C L1-0 ls-tree L1-0 >tmp &&
+	cut -f 2 <tmp >actual &&
+	test_cmp expected actual &&
+	git -C L1-0 fsck 2>err &&
+	# Would happen if tecmp1() were broken
+	! grep "error in tree .*: treeNotSorted: " err
+'
+
+test_expect_success 'L: verify internal tree sorting on bad input (tecmp0)' '
+
+	test_create_repo L1-1 &&
+
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<EOF
+	some data
+	EOF
+
+	reset refs/heads/L1-1
+	commit refs/heads/L1-1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	create L1-1
+	COMMIT
+	M 100644 :1 x.txt
+	M 100644 :1 x/y.txt
+	M 100644 :1 z.txt
+	M 100644 :1 z
+
+	commit refs/heads/L1-1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	update L1-1
+	COMMIT
+	M 100644 :1 another.txt
+	M 100644 :1 x.txt
+	M 100644 :1 x/y.txt
+	M 100644 :1 z.txt
+	M 100644 :1 z
+	INPUT_END
+
+	cat >expected <<-EXPECT_END &&
+	another.txt
+	x.txt
+	x
+	z
+	z.txt
+	EXPECT_END
+
+	git -C L1-1 fast-import <input &&
+	git -C L1-1 ls-tree L1-1 >tmp 2>err &&
+	# Would happen if tecmp0() passed a fixed mode
+	! grep "fatal: not a tree object" err &&
+	cut -f 2 <tmp >actual &&
+	test_cmp expected actual &&
+	git -C L1-1 fsck
+'
+
 test_expect_success 'L: nested tree copy does not corrupt deltas' '
 	cat >input <<-INPUT_END &&
 	blob
-- 
2.31.0.256.gf0ddda3145

