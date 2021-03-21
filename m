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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7008C433E5
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD1F61937
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCUACM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhCUABc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957EDC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id 61so12829275wrm.12
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UiMoyzx8hfw5OEv1ZGqAvzhkErw9ACfRbmCJyDNlFbw=;
        b=n+oIUa/96qyRLs9Flk5YQYHyOvfZIJHem2GKgaCBoAu/Vb8I51oXBd7DPsGW9v7pPn
         nRFdgHVXBqA/fE3rUE9oBFvKdmiWNwNomhCcJHlWo6c7G6n1WnxyO7M+D/WvLxKB6+4f
         CfjgJmKPrZhfRbkJJ+YNwJLMgSS8IP8fdmVCBREki43ABxSSqxu2rJq667TVgOAZOc/r
         TPj6NLw4ciX5leb/a8j/dLarphoCvdA0MORSisepZnbAoTAkfUQclPZDABE3gt+2BreR
         0DVZv6fkZrYdhpH3SnzIc08Ig8MaBBzC5RoFJj1Qwb73AMSSHV2gLus/ffnmteNJWr3i
         1Kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UiMoyzx8hfw5OEv1ZGqAvzhkErw9ACfRbmCJyDNlFbw=;
        b=rPPXqvK/jAYVrUBdXmYHUFUUwZ4I3LUfZepk8NHExhIFVF6F50rxBgPSOFksiP9e2Z
         4RdiscbeatGWyg0lfEsK3WjnTyQaF2ZEs+/ZeN17h1dMbOIU2HHfQVdnDSpjw+zWKQ0O
         FkL275YPkm32fpiCUGA4+Op3ViTL4oXugz5mWuFnjFuU63arRasXvRgZz3dXIG2l9QK/
         HHTN416aM8l+XanY9VMUp3UjQjRuFFnNqs799gCiUqgsVeNktba7Dvy8G7y+BzSb8mGD
         On20V/08Zmt3xovBAajtbWJ2HBJaenB4v1po1Fzv4xGyk2aKIr7Aqq5DCM//j5inDp8J
         JtOQ==
X-Gm-Message-State: AOAM533yj7IVEtct3b8vCawSWykV1FPQQsR8Z5vntK/f2kCMcqBtNiHf
        XywlwBCy9B07P071kBv8MUGM2ZTKD9DL3g==
X-Google-Smtp-Source: ABdhPJwwbenwcrpKPvzjeJe9UaBgNCw+oJVTVSNBTzXk05yme9z6GH9+ZM4We0J3RFnB9Mj+Un5syA==
X-Received: by 2002:a5d:5083:: with SMTP id a3mr4848508wrt.38.1616284890156;
        Sat, 20 Mar 2021 17:01:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:29 -0700 (PDT)
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
Subject: [PATCH v4 05/29] fast-import tests: test for sorting dir/file foo v.s. foo.txt
Date:   Sun, 21 Mar 2021 01:00:38 +0100
Message-Id: <7016008554aacc68b70d9bea92c454b1ac53e39c.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
2.31.0.286.gc175f2cb894

