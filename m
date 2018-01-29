Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D34731FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 22:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeA2WzO (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:55:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:56329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751970AbeA2WzM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:55:12 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LvVYZ-1eoAJI1f19-010gRE; Mon, 29 Jan 2018 23:55:03 +0100
Date:   Mon, 29 Jan 2018 23:55:02 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 08/10] sequencer: handle autosquash and post-rewrite for
 merge commands
In-Reply-To: <cover.1517266437.git.johannes.schindelin@gmx.de>
Message-ID: <7449a6b30f15a00b80924b732cb6998cbee99e5e.1517266437.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FIx0JFaPUhFKg7V5+bq0kBPBF7Riiyg93y+aG6iB8Uv6hBajB8F
 o2v5fsrFdLP3ftCwR+CojwGegp8S9ozTm8hTKa6DXdtEW4hkBAiQ3mC1GwXV5VoN/YNuEyi
 Pe8ss1wdqYZm6Of6TkJJz+3sOPNOv1egpskKcuuB+Lk459KK6SsHu+rB3b+weBaaS64niY5
 mswdHLhcv1uMK+4rJ8rmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d4wW+1Fce04=:fRau5cMb7w1vgEav5Cgp/s
 bXMhnU7Bo6hMTAdwO+kUpi3k4lzH/Sxn8k2hFCWzaNZdJ1yPgcJQCa6EHuvgEn4Z6coeQFH2v
 ihpMLmALHWwXk8wbnzcSGqQ8kJkwmVlIOrn6cZUmmANejSR6bgq8yx6x0jG0Yo2c5ZBX0nCq1
 4I7myh0E6TYX3+sPB8iczPfyG1wsruiA+5lFkHHzQvSP40Lw1DcppSfLKtBwVSP8gv3iBB8bz
 e2St7d/FsuZeiVOWTx3atwaN00fYzKwn54ueVUV27UvJdZvCa1NQVj1bR01hkqZb+4yxRqol3
 KTJpcKKUl2KdQ+UbYTJBWloA3eq/cN6SfMxvNu4Q0N9TtdavKTOmV3SAr4dn1OaP27yQXIPz2
 FIlU8VS2w7pwiR7o9OJYYLoGy7B72WVbtLZPdpJz7tI3chIRM8N185F8Rmk0GmtImMESqvIoB
 zmVWsmFEYeFPVOT1457ikP/r/SxrsD/HY3p0DAE4GDmTCkNwx4rhrEwWJtKW4JisSFdW6eSsu
 yJcF8oYljBDm9ZZop9fDiVVh3yQMM+fI85BCPfbYTfP2So4viMHTZA4zJna6MJWG2Y0wd5ls4
 elXMwqLCJLYRxMQPwS2NchsrYcC+g4f7xQyfn7YQzlB0prroyk1231SwYM5qZWM8+tSTbmOyg
 y5wzab7Sr9FEow8dHioLmrG4g1Ybjv3r1MsSPCSwBwa0DZUMPkY7tKVmJ9YK8KltUn7MvKXzs
 yLoaTZxGmBgFK41QpXLK6wQsVjkDKkGvvY8S5QXsCfrMA0P1R98U5/stiFzHVlcTNrZUSNzRa
 B595n+LzOOUTpLWmwCtwhJ14NqIbR+PKwkNZBLAQi+AzK0v7J2RG/wS2Okw24iMt9Ga60gB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous patches, we implemented the basic functionality of the
`git rebase -i --recreate-merges` command, in particular the `merge`
command to create merge commits in the sequencer.

The interactive rebase is a lot more these days, though, than a simple
cherry-pick in a loop. For example, it calls the post-rewrite hook (if
any) after rebasing with a mapping of the old->new commits. And the
interactive rebase also supports the autosquash mode, where commits
whose oneline is of the form `fixup! <oneline>` or `squash! <oneline>`
are rearranged to amend commits whose oneline they match.

This patch implements the post-rewrite and autosquash handling for the
`merge` command we just introduced. The other commands that were added
recently (`label` and `reset`) do not create new commits, therefore
post-rewrite & autosquash do not need to handle them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                       | 10 +++++++---
 t/t3430-rebase-recreate-merges.sh | 25 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d5af315a440..4cc73775394 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2414,10 +2414,13 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			res = do_label(item->arg, item->arg_len);
 		else if (item->command == TODO_RESET)
 			res = do_reset(item->arg, item->arg_len);
-		else if (item->command == TODO_MERGE)
+		else if (item->command == TODO_MERGE) {
 			res = do_merge(item->commit,
 				       item->arg, item->arg_len, opts);
-		else if (!is_noop(item->command))
+			if (item->commit)
+				record_in_rewritten(&item->commit->object.oid,
+						    peek_command(todo_list, 1));
+		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
 		todo_list->current++;
@@ -3560,7 +3563,8 @@ int rearrange_squash(void)
 		struct subject2item_entry *entry;
 
 		next[i] = tail[i] = -1;
-		if (item->command >= TODO_EXEC) {
+		if (item->command >= TODO_EXEC &&
+		    (item->command != TODO_MERGE || !item->commit)) {
 			subjects[i] = NULL;
 			continue;
 		}
diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-recreate-merges.sh
index 5295bb03dc0..2eeda0c512b 100755
--- a/t/t3430-rebase-recreate-merges.sh
+++ b/t/t3430-rebase-recreate-merges.sh
@@ -157,4 +157,29 @@ test_expect_success 'refs/rewritten/* is worktree-local' '
 	test_cmp_rev HEAD "$(cat wt/b)"
 '
 
+test_expect_success 'post-rewrite hook and fixups work for merges' '
+	git checkout -b post-rewrite &&
+	test_commit same1 &&
+	git reset --hard HEAD^ &&
+	test_commit same2 &&
+	git merge -m "to fix up" same1 &&
+	echo same old same old >same2.t &&
+	test_tick &&
+	git commit --fixup HEAD same2.t &&
+	fixup="$(git rev-parse HEAD)" &&
+
+	mkdir -p .git/hooks &&
+	test_when_finished "rm .git/hooks/post-rewrite" &&
+	echo "cat >actual" | write_script .git/hooks/post-rewrite &&
+
+	test_tick &&
+	git rebase -i --autosquash --recreate-merges HEAD^^^ &&
+	printf "%s %s\n%s %s\n%s %s\n%s %s\n" >expect $(git rev-parse \
+		$fixup^^2 HEAD^2 \
+		$fixup^^ HEAD^ \
+		$fixup^ HEAD \
+		$fixup HEAD) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.16.1.windows.1


