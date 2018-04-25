Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1E81F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754045AbeDYM37 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:29:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:55241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753723AbeDYM3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:29:46 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M0Kp7-1eOANY3gwn-00uXj7; Wed, 25 Apr 2018 14:29:38 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v9 14/17] rebase --rebase-merges: avoid "empty merges"
Date:   Wed, 25 Apr 2018 14:29:31 +0200
Message-Id: <169bc4f09bff564032b93e0df9ffcb181d174793.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:46dovRwcDlOX2WqVMZRaFZyJZ+oIaJv2dzJq7qsUJBTFRskXnpL
 noeXJt+JIgeKoOF257oMavct/W5aSp7/l7sc6/LO0+PFTwOE2BAgTUPUuHmO0fwBUrwNQk9
 MER/4U+UGLlNWILX4qgjUZ9mSWM7BAz72cdt6q75xwrW9G0iXnago85gtAMt9C+MfqTU0oH
 YA+Tx24fpdYmVk1rOveQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DdaXxlXDNxM=:iJVXx/1pk9exF8zkcIbL4i
 piY0ZhmRVxlGYiFBHAbQTZZdyve9JKSy/wYiQJaOm5mkVo8sdMnhUBQKkeJdm+Y21k3XEj96a
 njgR754zgpM8VSA/HEtCdSjKKjScM+2F4cwyzxWp9HIAGwq4i8NTA2fg8IlxGMwFeTceWAddm
 opNK5M8zsWb7sRObiBXJ0Tr42mlKO+us8PmqQ11H4sl+xI8bLx9aolZHJDmVCZqRJjrCS3RHY
 fcdz2mRvWUYwsxfKh4T/oZTxKTzfGU4wQOghNGdiGSFfkf7dvM+fyb2g09m5Rh0N1Iirbky0H
 stcvcIrlrpQYXnh8PgFBGJtB0KRT5/gr95LiU1+dpCaoQsqwSbEGI0NUi/wCQpxT1n0+D3xPq
 D1HQeV42dtq6c09/7SEKIpmFlagKHj53v2ArIXB4YuzhU+L3Ga+9/IYCColUKXLw0mRyA9RGy
 +aoqahywntnRpjC1k+rbFRv1tYunsP0FT542ouPSxwGQmRyOV6fTgRm/GBFpJFo/ZBxThuIt/
 0kY4V0F6I/3LDkUIDoU2RJSLNALH5iyFTMeSaj1Q04hQHP7nZ5ASFgxXhed0RebaF20p3MDVl
 KjLPkkPeNqrsRFBcOWOdUifjoXVnPzKWN6kqPgcJtU1jdVNIi4ErZpxTq2O4rVtNFO9IRbuCo
 6/wO6d45WTL//qOzTTCUuRyHPSAiZil5kx6KhXdOmLjKA++T+a4vDMi2zNIijHX1c5Rk9Wjh0
 diXsfRiNp9Yi7nbFsI1udOeekyi/1DAx+4/3JhgB7XuBq2ta1g27CTTfBKaVDljBEh7haH7M5
 LxtPh9zRjb7wo2aD5x8rhwalScD7qnbCEskUwRzQWEXseyDamMBxX1AN5q1HNg482ChS64o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git merge` command does not allow merging commits that are already
reachable from HEAD: `git merge HEAD^`, for example, will report that we
are already up to date and not change a thing.

In an interactive rebase, such a merge could occur previously, e.g. when
competing (or slightly modified) versions of a patch series were applied
upstream, and the user had to `git rebase --skip` all of the local
commits, and the topic branch becomes "empty" as a consequence.

Let's teach the todo command `merge` to behave the same as `git merge`.

Seeing as it requires some low-level trickery to create such merges with
Git's commands in the first place, we do not even have to bother to
introduce an option to force `merge` to create such merge commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              | 7 +++++++
 t/t3430-rebase-merges.sh | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 558efc1af6e..afa155c2829 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2810,6 +2810,13 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
 
 	bases = get_merge_bases(head_commit, merge_commit);
+	if (bases && !oidcmp(&merge_commit->object.oid,
+			     &bases->item->object.oid)) {
+		ret = 0;
+		/* skip merging an ancestor of HEAD */
+		goto leave_merge;
+	}
+
 	for (j = bases; j; j = j->next)
 		commit_list_insert(j->item, &reversed);
 	free_commit_list(bases);
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index e9c5dc1cd95..1628c8dcc20 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -215,4 +215,12 @@ test_expect_success 'post-rewrite hook and fixups work for merges' '
 	test_cmp expect actual
 '
 
+test_expect_success 'refuse to merge ancestors of HEAD' '
+	echo "merge HEAD^" >script-from-scratch &&
+	test_config -C wt sequence.editor \""$PWD"/replace-editor.sh\" &&
+	before="$(git rev-parse HEAD)" &&
+	git rebase -i HEAD &&
+	test_cmp_rev HEAD $before
+'
+
 test_done
-- 
2.17.0.windows.1.33.gfcbb1fa0445


