Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 529B61F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 23:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeKMJVV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 04:21:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41777 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbeKMJVU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 04:21:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id e22-v6so5031884pfn.8
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 15:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=anW27HCUX5QvJky5CQcYIXpIik4ebc83hWyjaMHMWSE=;
        b=cL0beO/aITVA2iTVGdz3x8DEYssdz198tRY35JnzXsIQn+wohuWWLQvZMP2cTDa5Xq
         eyjByl19Lc2YLybo13X//bxU6q94QpVp2sAV7gEb/pCufqxgzICqOL+7ZYYfSPgAv9Zb
         P0D0RPWexoi0Ov334ACrL56yykNe7+FKlLKSwy4hM/6OZJswoj4MXyU08yIBVFv/4rru
         zPFBq++ZFL92Qw5xJPzs/O/SY8qcCFiVMrxqLsu7SOCs42/UfxgpW4MYWF1469btYX6X
         LvygDo5oz3RA57VLbWLtcsYSVETVV0JOQL88ZRiyTd2S+D9DGtrDEVfuW+bs32PPaBiY
         Qq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=anW27HCUX5QvJky5CQcYIXpIik4ebc83hWyjaMHMWSE=;
        b=N4ZH9T4PhWCAvsH+P1LF8qsDlGv9usjrEJPADmUp13dYiEi/laeVJPyzxlQaj2RXPj
         tljcUVTUNIXBRScv05mB06xNtWWOSpyvowtU9Xgv0yyp37DCzPXZ47Du4IrZre5uD4eO
         BRIoa2CicoiwRxgI8JhjASccGT3Y72C4XmWClV2ilgUsK0QomIj33eB/c4/K3BAne2EY
         KzagR1b9lWmnStA0G4w+qJLmYinip08Bo2GQInVkUWKTos8FGd4QfOOLjZrXqmRKBDUr
         GxuJ4EdtImmj1yeJlvzdhd5RaXXh2zRhULhmESdJHv1fl/dUvxeMZk4rPnCxJZ1Qnqvh
         +lVw==
X-Gm-Message-State: AGRZ1gJ83yNN8etRvBp4LInVYMVNb8pCRfo62KqryejoLbd0yhAVe04i
        hhuLVtpd35VO2bY1n1/GsFKuskxv
X-Google-Smtp-Source: AJdET5fx8UMbn3F9sgFP31MRzaCjqSPgJtAL9OgjfIyKWUhMD7sgnyRq1o/Lk/SWLo5SCEDCUnAqRg==
X-Received: by 2002:a63:d301:: with SMTP id b1mr2609452pgg.61.1542065159236;
        Mon, 12 Nov 2018 15:25:59 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id p2sm17290303pgc.94.2018.11.12.15.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 15:25:58 -0800 (PST)
Date:   Mon, 12 Nov 2018 15:25:58 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 23:25:50 GMT
Message-Id: <8aa3dac3147fdd2483dd530792baf3c575d3d3aa.1542065154.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.75.git.gitgitgadget@gmail.com>
References: <pull.75.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/5] rebase -r: do not write MERGE_HEAD unless needed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When we detect that a `merge` can be skipped because the merged commit
is already an ancestor of HEAD, we do not need to commit, therefore
writing the MERGE_HEAD file is useless.

It is actually worse than useless: a subsequent `git commit` will pick
it up and think that we want to merge that commit, still.

To avoid that, move the code that writes the MERGE_HEAD file to a
location where we already know that the `merge` cannot be skipped.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              | 8 ++++----
 t/t3430-rebase-merges.sh | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9e1ab3a2a7..7a9cd81afb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3191,10 +3191,6 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	}
 
 	merge_commit = to_merge->item;
-	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
-		      git_path_merge_head(the_repository), 0);
-	write_message("no-ff", 5, git_path_merge_mode(the_repository), 0);
-
 	bases = get_merge_bases(head_commit, merge_commit);
 	if (bases && oideq(&merge_commit->object.oid,
 			   &bases->item->object.oid)) {
@@ -3203,6 +3199,10 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		goto leave_merge;
 	}
 
+	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
+		      git_path_merge_head(the_repository), 0);
+	write_message("no-ff", 5, git_path_merge_mode(the_repository), 0);
+
 	for (j = bases; j; j = j->next)
 		commit_list_insert(j->item, &reversed);
 	free_commit_list(bases);
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 1f08a33687..cc5646836f 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -396,7 +396,7 @@ test_expect_success 'with --autosquash and --exec' '
 	grep "G: +G" actual
 '
 
-test_expect_failure '--continue after resolving conflicts after a merge' '
+test_expect_success '--continue after resolving conflicts after a merge' '
 	git checkout -b already-has-g E &&
 	git cherry-pick E..G &&
 	test_commit H2 &&
-- 
gitgitgadget

