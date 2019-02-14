Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EDD61F453
	for <e@80x24.org>; Thu, 14 Feb 2019 15:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395358AbfBNPVr (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 10:21:47 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:53516 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393538AbfBNPVr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 10:21:47 -0500
Received: by mail-qk1-f202.google.com with SMTP id q81so5350630qkl.20
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 07:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tAnOEEIW7G6raU0o947AaFSsIXb+Da+YkyrM+85jzj4=;
        b=hNbRhjfyOI1+73Z+zzOZlheXfIjOj0ZzrnFgDA0RXwl9V79QXDjTfzNKpg6/sGSf/I
         emSWyTxbNyXRymo/Y3sgSoKlg3ux16VRskmMXy23cyhaZmy7PMwVeRLHO7ALa4iA4982
         uS6S2L8DZP0QO+cXjO2rE8P34C2gpVuLJgrr6pN44jLArSNTN7opFKbVvkOG9FX6N8ZF
         qRmKI90P1eYVKw4Qs6446c26rnINWgwafsHvGaFb4SM3KzT2+npcaJ85vf8+2dDC8vE4
         QcSrLIhN3JDTmzrHFl30gI3d9dhjWMe/BUp5RJ/zPr+eBu+oXZosi1MoPHxLuTZ/YyW4
         dBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tAnOEEIW7G6raU0o947AaFSsIXb+Da+YkyrM+85jzj4=;
        b=Sk/0A1BFEtMcb/rof+WhGTjSLInZUtTVPA2LyTJOuqtzN45kLjixc77e8jdtHR2lgK
         Mx/QNTK0yaGbL9Jzd7yPwIR011K3I4cDFvmm3ytgTruoBz22opcjPcmF9Kg10Wlux8E/
         2dghJsg72QHVMSRuRJo7gK/eQdVb5ALdSWCxe87AH0pN1LNedUBhDtwfzB/Qy0dCkDcG
         /Q10UiENhvvZRNNuuWKOD4ieQNwMR+ZrV8/PlBrEaPSZ9hXds2dkP4IcYLn3NKRq8ogF
         gHx08P0RQa1SejtPO8ZXOP7OFtpLhxSNXhY7gpYivuTx2oKy3GlFwH0gfzoGwSBn9ZgA
         cBug==
X-Gm-Message-State: AHQUAuZBo4HJwlLmtGP99u6DubSiYAFF2q+I29qgNRYOwGG9J6LrLPO2
        7Xh0pOSJIUMVIS+DrUYc/irycigb
X-Google-Smtp-Source: AHgI3IYtJe1X6KOUbzxXY88bCTBGnb5EOAwOC+eW0+HoNtBZ5pwj6ayTRaR13sSBLB31F48pOeq+3nqR
X-Received: by 2002:aed:3e8d:: with SMTP id n13mr2534582qtf.12.1550157706357;
 Thu, 14 Feb 2019 07:21:46 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:21:32 -0500
In-Reply-To: <xmqqef8b9sfc.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190214152132.152793-1-brho@google.com>
Mime-Version: 1.0
References: <xmqqef8b9sfc.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v3 5/5] blame: add tests for ignoring revisions
From:   Barret Rhoden <brho@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Barret Rhoden <brho@google.com>
---

This removes the spaces after redirects and gets rid of sed -i.

I can roll a v4 of the whole patch set if you'd like.  o/w I'll wait for
more changes in the other patches.

Thanks,

Barret


 t/t8013-blame-ignore-revs.sh | 199 +++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)
 create mode 100755 t/t8013-blame-ignore-revs.sh

diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
new file mode 100755
index 000000000000..6bd17febec3a
--- /dev/null
+++ b/t/t8013-blame-ignore-revs.sh
@@ -0,0 +1,199 @@
+#!/bin/sh
+
+test_description='ignore revisions when blaming'
+. ./test-lib.sh
+
+# Creates:
+# 	A--B--X
+# A added line 1 and B added line 2.  X makes changes to those lines.  Sanity
+# check that X is blamed for both lines.
+test_expect_success setup '
+	test_commit A file line1 &&
+
+	echo line2 >>file &&
+	git add file &&
+	test_tick &&
+	git commit -m B &&
+	git tag B &&
+
+	test_write_lines line-one line-two >file &&
+	git add file &&
+	test_tick &&
+	git commit -m X &&
+	git tag X &&
+
+	git blame --line-porcelain file >blame_raw &&
+
+	grep "^[0-9a-f]\+ 1 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse X >expect &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 2 2" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse X >expect &&
+	test_cmp expect actual
+	'
+
+# Ignore X, make sure A is blamed for line 1 and B for line 2.
+test_expect_success ignore_rev_changing_lines '
+	git blame --line-porcelain --ignore-rev X file >blame_raw &&
+
+	grep "^[0-9a-f]\+ 1 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 2 2" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual
+	'
+
+# For ignored revs that have added more lines than they removed, the extra lines
+# must be blamed on an all-zeros rev.
+# 	A--B--X--Y
+# Where Y changes lines 1 and 2, and adds lines 3 and 4.
+test_expect_success ignore_rev_adding_lines '
+	test_write_lines line-one-change line-two-changed new_line3 new_line4 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m Y &&
+	git tag Y &&
+
+	git rev-parse Y >y_rev &&
+	sed -e "s/[0-9a-f]/0/g" y_rev >expect &&
+	git blame --line-porcelain file --ignore-rev Y >blame_raw &&
+
+	grep "^[0-9a-f]\+ 3 3" blame_raw | sed -e "s/ .*//" >actual &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 4 4" blame_raw | sed -e "s/ .*//" >actual &&
+	test_cmp expect actual
+	'
+
+# Ignore X and Y, both in separate files.  Lines 1 == A, 2 == B.
+test_expect_success ignore_revs_from_files '
+	git rev-parse X >ignore_x &&
+	git rev-parse Y >ignore_y &&
+	git blame --line-porcelain file --ignore-revs-file ignore_x --ignore-revs-file ignore_y >blame_raw &&
+
+	grep "^[0-9a-f]\+ 1 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 2 2" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual
+	'
+
+# Ignore X from the config option, Y from a file.
+test_expect_success ignore_revs_from_configs_and_files '
+	git config --add blame.ignoreRevsFile ignore_x &&
+	git blame --line-porcelain file --ignore-revs-file ignore_y >blame_raw &&
+
+	grep "^[0-9a-f]\+ 1 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 2 2" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual
+	'
+
+# Override blame.ignoreRevsFile (ignore_x) with an empty string.  X should be
+# blamed now for lines 1 and 2, since we are no longer ignoring X.
+test_expect_success override_ignore_revs_file '
+	git blame --line-porcelain file --ignore-revs-file "" --ignore-revs-file ignore_y >blame_raw &&
+	git rev-parse X >expect &&
+
+	grep "^[0-9a-f]\+ 1 1" blame_raw | sed -e "s/ .*//" >actual &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 2 2" blame_raw | sed -e "s/ .*//" >actual &&
+	test_cmp expect actual
+	'
+test_expect_success bad_files_and_revs '
+	test_must_fail git blame file --ignore-rev NOREV 2>err &&
+	test_i18ngrep "Cannot find revision NOREV to ignore" err &&
+
+	test_must_fail git blame file --ignore-revs-file NOFILE 2>err &&
+	test_i18ngrep "Could not open object name list: NOFILE" err &&
+
+	echo NOREV >ignore_norev &&
+	test_must_fail git blame file --ignore-revs-file ignore_norev 2>err &&
+	test_i18ngrep "Invalid object name: NOREV" err
+	'
+
+# Commit Z will touch the first two lines.  Y touched all four.
+# 	A--B--X--Y--Z
+# The blame output when ignoring Z should be:
+# ^Y ... 1)
+# ^Y ... 2)
+# Y  ... 3)
+# Y  ... 4)
+# We're checking only the first character
+test_expect_success mark_ignored_lines '
+	git config --add blame.markIgnoredLines true &&
+
+	test_write_lines line-one-Z line-two-Z new_line3 new_line4 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m Z &&
+	git tag Z &&
+
+	git blame --ignore-rev Z file >blame_raw &&
+	echo "*" >expect &&
+
+	sed -n "1p" blame_raw | cut -c1 >actual &&
+	test_cmp expect actual &&
+
+	sed -n "2p" blame_raw | cut -c1 >actual &&
+	test_cmp expect actual &&
+
+	sed -n "3p" blame_raw | cut -c1 >actual &&
+	! test_cmp expect actual &&
+
+	sed -n "4p" blame_raw | cut -c1 >actual &&
+	! test_cmp expect actual
+	'
+
+# Resetting the repo and creating:
+#
+# A--B--M
+#  \   /
+#   C-+
+#
+# 'A' creates a file.  B changes line 1, and C changes line 9.  M merges.
+test_expect_success ignore_merge '
+	rm -rf .git/ &&
+	git init &&
+
+	test_write_lines L1 L2 L3 L4 L5 L6 L7 L8 L9 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m A &&
+	git tag A &&
+
+	test_write_lines BB L2 L3 L4 L5 L6 L7 L8 L9 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m B &&
+	git tag B &&
+
+	git reset --hard A &&
+	test_write_lines L1 L2 L3 L4 L5 L6 L7 L8 CC >file &&
+	git add file &&
+	test_tick &&
+	git commit -m C &&
+	git tag C &&
+
+	test_merge M B &&
+	git blame --line-porcelain file --ignore-rev M >blame_raw &&
+
+	grep "^[0-9a-f]\+ 1 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 9 9" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse C >expect &&
+	test_cmp expect actual
+	'
+
+test_done
-- 
2.21.0.rc0.258.g878e2cd30e-goog

