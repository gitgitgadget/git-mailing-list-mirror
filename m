Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66A3C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbiKRLSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbiKRLSj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:39 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ECC1403A
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:36 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id i10so12234669ejg.6
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVIATdrav0gFbw12TFNmdDh+HKS2CloRQfdF2atTVsI=;
        b=mGLl+Xj/sut7xssuWUutYFloard/juAViRD0coUpQY1Ht+fpq2mSK31JQfIFZsuj1x
         PwyEB4Nxdx/YQMJAcMcMn+0yxVjB2MH88MxuQ8QFJV7D4A1gtEGq3FzxsR5XIsd6EmlR
         pq9iMCZSLF9sJg6wAlF8qi65LhBt1K/dqnDmTXocqUzmZKW8b5ofYwaqxiYIgaaMyG2h
         PN1UyPMwOMNjwsVsrP8AmnUFeKlN37XNQ8CE5wi396GNmTx4cFDRR3MAjJUuWQi3o1J+
         JwSorQCVDJNEymDqttn46jrqBB9KTMLQg6OY8kHIHUWvr+3dFDjgwNk4SUs6CWuO3b1s
         5b3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVIATdrav0gFbw12TFNmdDh+HKS2CloRQfdF2atTVsI=;
        b=A6UXznATwy9sb7v+tc0ECxArSXto+41qSGmxfgkM6r0VzbOzZIlDzJfXTukbrXaq1W
         KQQph80s+A4xZm6/tvkPkcPytadv6oi8ZBv6ujEXCcmsBC+cE0qF/DabQOt73RXo+Ddi
         mujY6PtEyyf5HvIt00r9tNFMFfkeC29DndN3c8lTVaaTBCL948eKi6Ms0HKaq1iPJQTw
         aWmuhYKqpW5Mxp45YSGavXRVBA3i4N6Pcobr6lS74K3t6uXfThVU/wBkbsue4Q7d7qTf
         hUgIGjzuTeSlDvj7PSLYqCuz7rl/Q/pWIMEtuZZi61rHxAGstVDFIUXO2h/EsHYNKRhl
         5v7Q==
X-Gm-Message-State: ANoB5pnlkV+XA5IwEzOZHZjRAbIcgv/xdCXEFLlVpRv63Vp8ygSBDu17
        qDHPSINBRE5L5BezJita1zLsAAUY/sSvBg==
X-Google-Smtp-Source: AA0mqf6HoM2Z/DNsW3IR0yg33Ipid27+K8v/9tE0LTEwVINeKeOO4pja92OmYDPZDnzh3NDQ6rjLWg==
X-Received: by 2002:a17:907:2bde:b0:7ae:4a7f:3280 with SMTP id gv30-20020a1709072bde00b007ae4a7f3280mr5687605ejc.265.1668770314769;
        Fri, 18 Nov 2022 03:18:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 02/12] t6060: modify multiple files to expose a possible issue with merge-index
Date:   Fri, 18 Nov 2022 12:18:19 +0100
Message-Id: <patch-v9-02.12-099d4812601-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com> <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alban Gruin <alban.gruin@gmail.com>

Currently, merge-index iterates over every index entry, skipping stage0
entries.  It will then count how many entries following the current one
have the same name, then fork to do the merge.  It will then increase
the iterator by the number of entries to skip them.  This behaviour is
correct, as even if the subprocess modifies the index, merge-index does
not reload it at all.

But when it will be rewritten to use a function, the index it will use
will be modified and may shrink when a conflict happens or if a file is
removed, so we have to be careful to handle such cases.

Here is an example:

 *    Merge branches, file1 and file2 are trivially mergeable.
 |\
 | *  Modifies file1 and file2.
 * |  Modifies file1 and file2.
 |/
 *    Adds file1 and file2.

When the merge happens, the index will look like that:

 i -> 0. file1 (stage1)
      1. file1 (stage2)
      2. file1 (stage3)
      3. file2 (stage1)
      4. file2 (stage2)
      5. file2 (stage3)

merge-index handles `file1' first.  As it appears 3 times after the
iterator, it is merged.  The index is now stale, `i' is increased by 3,
and the index now looks like this:

      0. file1 (stage1)
      1. file1 (stage2)
      2. file1 (stage3)
 i -> 3. file2 (stage1)
      4. file2 (stage2)
      5. file2 (stage3)

`file2' appears three times too, so it is merged.

With a naive rewrite, the index would look like this:

      0. file1 (stage0)
      1. file2 (stage1)
      2. file2 (stage2)
 i -> 3. file2 (stage3)

`file2' appears once at the iterator or after, so it will be added,
_not_ merged.  Which is wrong.

A naive rewrite would lead to unproperly merged files, or even files not
handled at all.

This changes t6060 to reproduce this case, by creating 2 files instead
of 1, to check the correctness of the soon-to-be-rewritten merge-index.
The files are identical, which is not really important -- the factors
that could trigger this issue are that they should be separated by at
most one entry in the index, and that the first one in the index should
be trivially mergeable.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6060-merge-index.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 1a8b64cce18..30513351c23 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -7,16 +7,19 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 test_expect_success 'setup diverging branches' '
 	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
-	git add file &&
+	cp file file2 &&
+	git add file file2 &&
 	git commit -m base &&
 	git tag base &&
 	sed s/2/two/ <file >tmp &&
 	mv tmp file &&
+	cp file file2 &&
 	git commit -a -m two &&
 	git tag two &&
 	git checkout -b other HEAD^ &&
 	sed s/10/ten/ <file >tmp &&
 	mv tmp file &&
+	cp file file2 &&
 	git commit -a -m ten &&
 	git tag ten
 '
@@ -35,8 +38,11 @@ ten
 EOF
 
 test_expect_success 'read-tree does not resolve content merge' '
+	cat >expect <<-\EOF &&
+	file
+	file2
+	EOF
 	git read-tree -i -m base ten two &&
-	echo file >expect &&
 	git diff-files --name-only --diff-filter=U >unmerged &&
 	test_cmp expect unmerged
 '
-- 
2.38.0.1511.gcdcff1f1dc2

