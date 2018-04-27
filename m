Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E751F424
	for <e@80x24.org>; Fri, 27 Apr 2018 22:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932997AbeD0WcD (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 18:32:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:43715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932889AbeD0WcB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 18:32:01 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LnUna-1ek1or0aw2-00hfiK; Sat, 28 Apr 2018 00:31:57 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH 5/6] rebase --rebase-merges: a "merge" into a new root is a fast-forward
Date:   Sat, 28 Apr 2018 00:31:32 +0200
Message-Id: <0b7379b576be2cee807b8237dc52e5412663a2fd.1524868165.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524868165.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:bWHWrZqvfqVyWMlBljPN9oVG67ZQ2ktLMTNhCpas33SjMNJOZuS
 Yj9t9wUJTDYAiFb2M7AchcqbyHjpGP7XTaS/8CLsqI4XkJb6kkgBmoJo7MR2J4CDRlW6fO5
 O/yelKTvcGgCopxMT7Rl/S2VbCAmofbsM2+cEq0jf7HGo5cFNOxuRfn4uOyB8n8y7tsDCs7
 6NHGLGrS6ieOv5nrEUlnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lONlMk0vjpU=:me9I+qz9hRyJkqmNVIAta3
 73+ZtrXgUy2e5/cSc3sd/+r7B8FApINRpVuqPud7oEh9F3I3Ly43ianrgYDivVwfjyUy3n99K
 dB03YrzhUO4HiV9c0HQ2Wk5F5ro/R/a0xEzUUxvOXMwOkbzp/aGMUxkZsSxBa2aQaZvMmO2vl
 3m1J59sq2d7ete/XnhtM0jRJ8EEd3zBZZ8ff6rLssJqyCaSSTmbAO2aFdsJ10a2TMAQEHOlXE
 ph7GT9StQD5blqxkZFZSRi5XtIgs9lGJwgl3c3CX5JUQwbCr5Ty1tla0trOQWuFVKTrvomoHb
 QkhOlgVqPbWYX/33fG5E+FrujkucYbhH9vVlFiKCBr1PFkaqGPD4f79Pd86amxPcE3chgZEPG
 g52f5rdsLNQ7CwcyiWYmIJsw8ZDvqbgroioEAkxUk1TEig5n+9yOX7iFYAzIYwTVi3oSGwgyv
 muwRDMM6oxpWlNcrWH7EayMhmMytZYaj4AD41SM76dAs0hMuW64qwld0vyo/PKy1scIXxTMx2
 Z0Jaq+t+xPSZtLBOnJm22b/fHsLvCE2anJ7QrrOv+qpYSUYn9sTErd9ZOYS07ZTH/a954fmgE
 /yRsBN9Ftx5+hC4683xxGpJvJS2849QAe6XERDpSBJ6ndY1dfwgyfpSnPH8bVMRjgcCAd+J62
 1nU9bxLFETCJEDzJGIrGIMeENT37S5iUWEuYbMWSSH+/od/EvwjqvNqGAz/INQOwHR85ghBOe
 vuPFcQzkNBGJ6/X5H/3UaVBn9kaBoamr25r6fp9V3x3mYRwkPm32U9pZg4R8iPTHgXn+fyld1
 4RSI4vD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a user provides a todo list containing something like

	reset [new root]
	merge my-branch

let's do the same as if pulling into an orphan branch: simply
fast-forward.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              | 12 ++++++++++++
 t/t3430-rebase-merges.sh | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index d10ebd62520..ad5ff2709a6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2850,6 +2850,18 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		goto leave_merge;
 	}
 
+	if (opts->have_squash_onto &&
+	    !oidcmp(&head_commit->object.oid, &opts->squash_onto)) {
+		/*
+		 * When the user tells us to "merge" something into a
+		 * "[new root]", let's simply fast-forward to the merge head.
+		 */
+		rollback_lock_file(&lock);
+		ret = fast_forward_to(&merge_commit->object.oid,
+				       &head_commit->object.oid, 0, opts);
+		goto leave_merge;
+	}
+
 	if (commit) {
 		const char *message = get_commit_buffer(commit, NULL);
 		const char *body;
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 35260862fcb..5543f1d5a34 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -275,4 +275,17 @@ test_expect_success 'root commits' '
 	test_cmp_rev HEAD $before
 '
 
+test_expect_success 'a "merge" into a root commit is a fast-forward' '
+	head=$(git rev-parse HEAD) &&
+	cat >script-from-scratch <<-EOF &&
+	reset [new root]
+	merge $head
+	EOF
+	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
+	test_tick &&
+	git rebase -i -r HEAD^ &&
+	test_cmp_rev HEAD $head
+'
+
+
 test_done
-- 
2.17.0.windows.1.33.gfcbb1fa0445


