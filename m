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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175B0C433EB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE396193A
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCUACO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCUABd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B260C061763
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v4so12834260wrp.13
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kKueBp07VfWt3ROhSSuTzbz2ru3R0c4WTLIHPrsWT1k=;
        b=tal0JyIOYhmHnEm9F0JliVETz5WWNlgKpbBGnT39SZORbfCPJE394Des/ZJ+H+wsUU
         ykwNaiIRv01ULwIYSeiFimGo2K5ZOlKNsk532+ktjplw+b7gCpsYCNM1Zb5mZfj6JDBb
         Z6nU3b2EYL1sD3w69BcePMw5hU18blKSTuJOh5akKD8aBwnFU25IkeD3mFNxWK4EL52v
         454rU0JeR7XZ+QoCVUR1LZuajCFCA4Es/GeDm+kYQ6ue/eVsbint8bca2IPUcJAsAXGQ
         6RZy6WhOOQKKg/N4DdvDwsJzwyuTfHOcGiPnSLSYGjOrwj9tm3lX+lAkEwExY6WuFLqE
         9F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kKueBp07VfWt3ROhSSuTzbz2ru3R0c4WTLIHPrsWT1k=;
        b=k5MbKS4I7DqBbTBS6PNuSkN7/f/APHVC9yqaFwdDlGGmccxGGpxtMEYXf8GGX742gQ
         TfTEK49vjdTd2nrj5suPLs4gHsDVueaeQwHdluuLrRK8zrAP64oXpogsqRERUlcI41/a
         kgXNfAwcRam81npq2rIyZ2v/ANqGJPWRnD6CjTMGb+g6GO4fKkVmRQlHEtPBanXPrMB1
         8k5qXw0YgtZOafPf//UYWoQ4/i9Jts5474UpCnUrbhX4guexX16uzEF0IYCAxETn6kLU
         EzYgkHbSZxq1nXLNOypRoltQ1XC6ifakY6zh8eS6lqZY0Rd+ZwpalyT/TVDh62o2Wlww
         0V7g==
X-Gm-Message-State: AOAM5309Bop51SYgRYynhTi2hDAleol8U9whCYL75qyjh6Si5bFVyZ0B
        fSLwWa9lTRrrLSgRnrn66wvqcrs/liNCxA==
X-Google-Smtp-Source: ABdhPJw1t1mV+hUhyLCIQy58Ycj2X3tBbYcn510IF3k03chPSHQgCBR/BQjD1mXdBwasTma64cxBuQ==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr11529806wrt.18.1616284891696;
        Sat, 20 Mar 2021 17:01:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:31 -0700 (PDT)
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
Subject: [PATCH v4 07/29] diff tests: test that "mode" is passed when sorting
Date:   Sun, 21 Mar 2021 01:00:40 +0100
Message-Id: <73e92ac187d3bdf82fe81b3a0ccd97ebe1fefa11.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Piggy-back on the recently added fsck tests for mode comparisons in
mktree and assert that diff-tree also does the right thing in this
implausible scenario.

As with the other tests I've added in preceding commits, these tests
will fail if the mode is the same or reversed, respectively.

The diff-tree code being tested here was originally added back in
.9174026cfe (Add "diff-tree" program to show which files have changed
between two trees., 2005-04-09).

Unlike the other tests I've added there are existing tests for both of
these scenarios. Breaking that function as described above will make
tests in t4002-diff-basic.sh, t6409-merge-subtree.sh and
t4037-diff-r-t-dirs.sh fail.

I think it's good to have tests for this regardless, so let's add
these.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 46125190b45..5dd842bb82c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -362,6 +362,28 @@ test_expect_success 'tree entry with duplicate type mismatching objects' '
 	)
 '
 
+test_expect_success 'diff-tree stressing tree-diff.c::tree_entry_pathcmp(), not the same type' '
+	zero=$(test_oid zero) &&
+	git -C duplicate-entry diff-tree broken-commit-1 broken-commit-2 >1-to-2 &&
+	grep "$zero" 1-to-2 >lines &&
+	test_line_count = 2 lines &&
+
+	git -C duplicate-entry diff-tree broken-commit-2 broken-commit-1 >2-to-1 &&
+	grep "$zero" 2-to-1 >lines &&
+	test_line_count = 2 lines
+'
+
+test_expect_success 'diff-tree stressing tree-diff.c::tree_entry_pathcmp(), types not reversed' '
+	blob_ok=$(git -C duplicate-entry rev-parse broken-commit-2:A) &&
+	git -C duplicate-entry diff-tree --diff-filter=A broken-commit-1 broken-commit-2 >1-to-2 &&
+	grep "$blob_ok" 1-to-2 &&
+	test_line_count = 1 1-to-2 &&
+
+	git -C duplicate-entry diff-tree --diff-filter=A broken-commit-2 broken-commit-1 >2-to-1 &&
+	grep "$blob_ok" 2-to-1 &&
+	test_line_count = 1 2-to-1
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	badoid=$(test_oid deadbeef) &&
 	cat >invalid-tag <<-EOF &&
-- 
2.31.0.286.gc175f2cb894

