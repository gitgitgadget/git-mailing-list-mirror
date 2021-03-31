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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06307C43603
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D178B61056
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhCaTK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhCaTJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:09:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8144CC061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k8so20730934wrc.3
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPccigzXjD7CnycMzn3GzFlt3/n2yXFkTGL9QP/fG+o=;
        b=egXcRJ9ma0woAWJeRL2iGIsXGxWofcOe/2YgU+KRPBMq3D9hwLVnUcY1/CoadfdJ2D
         274PjhWTU+grcq4ahvqFqo9Umt7hDDlIr9iI+YYp+A2YSlQ3MP0B/52p3jkGylQCpGaQ
         ZJy/JLwieN2dDgCXIfMBHoXwKcJbUEW2HU2IKtFVpx39qH68TuTZrmAdIbxxU3ebT1R9
         Wxnft6BSsEudW1gJsW0mMWe7CqN+qk2rmrNyKJusQTglaoa99djH086KfTbW27YEuLE+
         uzhewkzEluc2+kDpwXqpMFdSVgX+UxydQxnZFmeW4KoTBiLSft5KrZnWwhZoRHw/4DjS
         MUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPccigzXjD7CnycMzn3GzFlt3/n2yXFkTGL9QP/fG+o=;
        b=c/tPJCbpToC5mROKf9NnoQSpEW+0jwAkP9fWQItQKzUDey9UixljcosUqiBoLyKNCI
         e2SXVmuZ3F61t7KqqhFew/IP84Zq9CrL+HkV8+TGkG3t6prxbQL3IEnGiEpDDFx5fLdM
         0CZBKLiS0eYjE7qxWIxw0u06OV7NDbRzaOcrkpC8N3CbQ3UVzHOkQF3kQ0fgUcqboBTK
         7RmpN0KYk6VzR1Fj2q3RwWWhn24jibbVYLX/nqgbjqsCw4wRE6XkmUGZDla14nhm39G4
         0QsXVIfuYGPbaXMbb2WMOkgXpukhvss9MNy2dLfuODCb7r6DJw4kyw9wQF2th2nDgCve
         I3dw==
X-Gm-Message-State: AOAM530JPzWWuLKpdIbmlzTHZcueWnezsYAnVXxxBjaCzy3EM7wR+bTl
        agKp5XtzkcYGtHrIXeLUhZFquXOMbhZxDA==
X-Google-Smtp-Source: ABdhPJxZeN7zozoNvXq52OnaL+6uybglKZ3Jwa/pxVyNlXWMdE1x/c1R5kQKmy994qoLuNtksV8afQ==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr5448266wrs.94.1617217795035;
        Wed, 31 Mar 2021 12:09:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:09:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/18] diff tests: test that "mode" is passed when sorting
Date:   Wed, 31 Mar 2021 21:09:34 +0200
Message-Id: <patch-06.19-0be013e47c4-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
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
2.31.1.474.g72d45d12706

