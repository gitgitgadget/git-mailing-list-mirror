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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CD7C43470
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6A460FE4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhCaTKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbhCaTJz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:09:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ADCC06174A
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j7so20766614wrd.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGZ1nqMhMrfO6J25IwSyt3bko1JQcp9Ym28TvTaBIuQ=;
        b=l5bI3RDh9O6nYxBDoS+tZI4EH6/dUww8xb5LaIdlUS543V0wLgKLtztxuc2HxRSH6d
         fBtN5quKnkrkivTaOykyf5VTOKMg5CGrl7FR9TGW4rZW2QHrFGP2P/tZ1BOLnRYi8uKR
         ltQSi/VNRmsqL7retwOvoItuqxhC5lPua48v0KI8yfqm1+jnsxUcy/VW8iuNUqQeiPvb
         g0LHx5F4p1qqIqRz88QH3ORygHElnyjgb1WwACS8hQHjCzdTOApP8sm+n9KHpID7xGMn
         s56DZ4K5vpVpDx+bQZem1wCriKWR4GJD0PduEkD7BAn8Lh0fuYxAsR4VEdMMHSlzlWv8
         ZHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGZ1nqMhMrfO6J25IwSyt3bko1JQcp9Ym28TvTaBIuQ=;
        b=Hby/2ot2sFKhgGZ4qtC4vwND3tFwj0rawEjPGJbM8JBdF5jJntBnaD3R1cfWct1bUK
         9aZYdZh1A0U5cuS9jEttZzpmZQvcYZ/BI3xAPdA5WMBeozpuyGYHHUFeUxVnpHXsqOCR
         63I4FQltLAKLNd2RvKOgNnLZ6MJlJN3tvc1UYsFfTGtz9VoF9/jYAlJRSv3Z1XRJS3XK
         JXdtUqTmdH88erap+7vfHbTrHJZGcaLXlzMmLa1W13Zoi8ZjixuNuBkZ2GVT7rT1Hjq1
         3nEseyRW0nCT1nHwpXOGTR5r/PUqEPybNcCHeIO/LOFnYVNuTMCm01/2fjyVm7LGoRnq
         l/Rg==
X-Gm-Message-State: AOAM530S2LY/nZrAlgd0py5XmyToUWnY1T2MsOkpO45RYomFaL3OmOGi
        3xADnUHvnGNzdN7eJVD3e02Udme03mXO5w==
X-Google-Smtp-Source: ABdhPJx7VjjvC1Hd586UQqRpC3F7kd77VeDNbwfIDDn1YKRFShJjOim3SmqEcMnhrZdhLHGbVDPlLQ==
X-Received: by 2002:adf:c70b:: with SMTP id k11mr5418655wrg.165.1617217793109;
        Wed, 31 Mar 2021 12:09:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:09:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/18] fast-import tests: test for sorting dir/file foo v.s. foo.txt
Date:   Wed, 31 Mar 2021 21:09:32 +0200
Message-Id: <patch-04.19-2ff35f410cd-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
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
index 5c47ac4465c..8bafb8cc515 100755
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
2.31.1.474.g72d45d12706

