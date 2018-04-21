Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818871F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeDUKsL (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:48:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:48521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbeDUKsK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:48:10 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mcyxq-1erkwb3wA6-00IGo4; Sat, 21
 Apr 2018 12:48:04 +0200
Date:   Sat, 21 Apr 2018 12:47:47 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v8 13/16] rebase --rebase-merges: avoid "empty merges"
In-Reply-To: <cover.1524306546.git.johannes.schindelin@gmx.de>
Message-ID: <nycvar.QRO.7.76.6.1804211247230.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:K3+4S9aR6+9Xm44ITevcghDIEidKCWlXNfLn0CHL10ZO8ixB5Es
 t/kqvrH8Yvf42df2jp53/NcZhbnfqfCyJswaoNA0T1brpO+/ljhXf3m4akweV41YKcX53/h
 +HyY9hxEqcGFzFeQNPs1bipYhaEUnjuqibt07X5Lz5TXmUHeuvMiRo1fX7evDpQqlyrBeQn
 P/d3PnIzzHo+eDkzNWVUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xvg9KcWUSG4=:tp9sHZGwE/fkhAMF/y6ngP
 rclW38XTste12XPxX0Wq8pxoshwSQELtzWke1tJIBsVYPiDlw6SGDjOLyuJ7Tmn1GXQrt8XW3
 TPJZLQPzfbEbhxr68bIVlQ0hDfQ73uMEOX37Rm1T1qyR2WaWk97brKguS0P0BqIR3POT1BNpV
 6j7Cmi35c1UwwZ2QuksQOKzswMv9Dn8O6yINdkhbBQMGv6oxRukyq6kH+8yfOztY+R/Zfm/46
 eG6yumcymPFxqKRLtDEJBuG2OpYN5hHkcrSTM29lBHrLocjuIeB/sigytk/go4PBikjIJCLml
 4I94DIrnBfTj3Ff5GLAUNUVc1qwogXTOOEswUX3iNc1raca/9xt3cQdKyq4xXhrdRY7UFiUD4
 zZP+PlufPlOcITOQln085R2r7VB4okNeajBd/Jca1XAwczgviXwAiwcRhq6YnBOEygIcherGM
 9MMGIJEx4H8hxrJ9IUSA1p+Ov/LLBPThsU9YEBCEFboCjjseSJYqiMwwvNjr8mLN4eM+kVSu5
 Kq8lvTJSO+ZGkjfAerfdjoWEHbj0cyRBy5cLJfPyuJlYnKI4jVO2eDVYVhCg3UGfnkVuosLQN
 m93VDJtlBR5s3El0pz932Hry1lD3m37QQ0mrkO/bWaY6NmRMa5z1SAuv5rzjTNd0j4wnT+rKE
 iyBZpxJnYGb2qjN4bPeGpUY1ch0/wYm6Ac6rA6f1FVJ6BTOLxvegCnocSP1Ig0MkuEgnbmg8g
 dCoZp+Of9ZkTD6XoQ1b5dcEwje0lXTXDEDgIAGiwFI5DARzy7OJxS8tRshNRN2zjx4EUiKQas
 t+2ec4TU4GPK695uXPtTp7d3dT1c6Gcjgoive2XYm2R6Xjvjrk=
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
index f3b4fe4d75f..443a0a0ee87 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2803,6 +2803,13 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
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
2.17.0.windows.1.15.gaa56ade3205


