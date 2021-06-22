Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8224AC4743C
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B61E611C1
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFVA3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhFVA3c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 20:29:32 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0B9C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:27:16 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so12974881ote.11
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nlx9h5JwTgLSqX9A/71NCSnWlzvVXSxZscado7GyrA8=;
        b=i5ZkJxeK25vF61gAHeZNtSJ3bfrH5Rplp2JHaKYXL2cLc+GPAeUOJM42MDp9kjvtgi
         FtaHpNJRElI/AJ4VolAd6y5X4U/LF/CXIL1UZZOLk+plVGlfTvcTZ+/pu3hR27709H/i
         EVJrdSJdftbpwoRQaicZE3/8HTCpU642Y06eg8L4NUQeio+XNpw6Vab8SX6yXlhSp55c
         yQYwomXs94fqQET5+kzuw3UY7yIkIyM/CzzWfa06TQ8U1H6LSdJfqsJgHlZEk/RMXSjx
         hfekCtVQt69gmsE51jcg1JO2vCzHGaV4xtFQCHdjs8DmJAp6t4J4/6fTL9tOHjtJrd7e
         z4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nlx9h5JwTgLSqX9A/71NCSnWlzvVXSxZscado7GyrA8=;
        b=hBwj/VNjEZtM/2EHPRZMIt0roWRsFPmqe22sf5LzrC1nE+JVAdmiyBmdBvhZUJsEEO
         B3LGPrxdHgqGD/umYLgl2iEJP7DbtlH0KP4GwchSUtK6n7OWrDbDV43mbfgqq0DGMfC5
         F1G0ephQFaW9rc2jnGkX0BUmwIvjUr+DG7R9UTz5WjoXx0Yqn4iBjXDp3r3ek7txA8Aw
         N5wGA/H0OkaRS/c+227AiJhQGtXWmSS9Sl5XfoUYT3Y02qetZj7wfF9qHIW4ZBx8BkGc
         qQk9vEE0UanK/oJWkbkqAsaF2MtuetqVqFaSzP039JFHeQpLhTa/K47pmFpzjHwHaYKG
         d6RQ==
X-Gm-Message-State: AOAM530s9lDm8Nw6QceblFeqy7ih2YKECztyL4O37Ms8i6NT87bL2CPl
        fo0AP0myN27n2bjArLfVZbb1Kok8MZXftQ==
X-Google-Smtp-Source: ABdhPJz+b6MmnVDPLiLNBuH61EnHv+XB9Dn0Np2i6RxiW68Iqd5pQg9OQAECNrDIvugEMcLD19dobg==
X-Received: by 2002:a05:6830:3155:: with SMTP id c21mr628274ots.153.1624321636001;
        Mon, 21 Jun 2021 17:27:16 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l25sm3912978oie.57.2021.06.21.17.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:27:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/4] Generic conflict style fixes
Date:   Mon, 21 Jun 2021 19:27:10 -0500
Message-Id: <20210622002714.1720891-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The switch to diff3 by default got stuck on a tar pit, however that's no
reason not to improve the merge.conflictStyle handling.

I dropped all the controversial changes and focused only on the obvious
improvements.

I switched to from the custom fill function to test_write_lines as Eric
Sunshine suggested, and used a simpler and stricter grep regex for diff3
markers as Phillip Wood prompted.

Felipe Contreras (4):
  test: add merge style config test
  merge-tree: fix merge.conflictstyle handling
  notes: fix merge.conflictstyle handling
  test: document broken merge.conflictStyle handling

 builtin/merge-tree.c               |   4 +
 builtin/notes.c                    |   3 +-
 t/t6440-config-conflict-markers.sh | 116 +++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100755 t/t6440-config-conflict-markers.sh

Range-diff against v1:
1:  118388c313 ! 1:  51351f1a77 test: add merge style config test
    @@ t/t6440-config-conflict-markers.sh (new)
     +
     +. ./test-lib.sh
     +
    -+fill () {
    -+	for i
    -+	do
    -+		echo "$i"
    -+	done
    -+}
    -+
     +test_expect_success 'merge' '
     +	test_create_repo merge &&
     +	(
     +		cd merge &&
     +
    -+		fill 1 2 3 >content &&
    ++		test_write_lines 1 2 3 >content &&
     +		git add content &&
     +		git commit -m base &&
     +
    @@ t/t6440-config-conflict-markers.sh (new)
     +		git commit -a -m left &&
     +
     +		test_must_fail git merge r &&
    -+		! grep -E "\|+" content &&
    ++		! grep "^|||||||" content &&
     +
     +		git reset --hard &&
     +		test_must_fail git -c merge.conflictstyle=diff3 merge r &&
    -+		grep -E "\|+" content &&
    ++		grep "^|||||||" content &&
     +
     +		git reset --hard &&
     +		test_must_fail git -c merge.conflictstyle=merge merge r &&
    -+		! grep -E "\|+" content
    ++		! grep "^|||||||" content
     +	)
     +'
     +
2:  697f2a2a5c ! 2:  1fccf561ed merge-tree: fix merge.conflictstyle handling
    @@ t/t6440-config-conflict-markers.sh: test_expect_success 'merge' '
     +		test_commit l content l &&
     +
     +		git merge-tree initial r l >actual &&
    -+		! grep -E "\|+" actual &&
    ++		! grep "^+|||||||" content &&
     +
     +		git -c merge.conflictstyle=diff3 merge-tree initial r l >actual &&
    -+		grep -E "\|+" actual &&
    ++		grep "^+|||||||" actual &&
     +
     +		git -c merge.conflictstyle=merge merge-tree initial r l >actual &&
    -+		! grep -E "\|+" actual
    ++		! grep "^+|||||||" content
     +	)
     +'
     +
3:  56a20f41a4 ! 3:  3bb872e3cd notes: fix merge.conflictstyle handling
    @@ t/t6440-config-conflict-markers.sh: test_expect_success 'merge-tree' '
     +		git notes add -f -m l initial &&
     +
     +		test_must_fail git notes merge r &&
    -+		! grep -E "\|+" .git/NOTES_MERGE_WORKTREE/* &&
    ++		! grep "^|||||||" .git/NOTES_MERGE_WORKTREE/* &&
     +
     +		git notes merge --abort &&
     +		test_must_fail git -c merge.conflictstyle=diff3 notes merge r &&
    -+		grep -E "\|+" .git/NOTES_MERGE_WORKTREE/* &&
    ++		grep "^|||||||" .git/NOTES_MERGE_WORKTREE/* &&
     +
     +		git notes merge --abort &&
     +		test_must_fail git -c merge.conflictstyle=merge notes merge r &&
    -+		! grep -E "\|+" .git/NOTES_MERGE_WORKTREE/*
    ++		! grep "^|||||||" .git/NOTES_MERGE_WORKTREE/*
     +	)
     +'
     +
4:  adce598754 < -:  ---------- checkout: fix merge.conflictstyle handling
5:  a4ddbbc44a < -:  ---------- xdiff: rename XDL_MERGE_STYLE_DIFF3
6:  c3e0940dab < -:  ---------- xdiff: simplify style assignments
7:  6415e53345 < -:  ---------- xdiff: make diff3 the default conflictStyle
-:  ---------- > 4:  a767bc68e6 test: document broken merge.conflictStyle handling
-- 
2.32.0

