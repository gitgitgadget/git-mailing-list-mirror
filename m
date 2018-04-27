Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5821F424
	for <e@80x24.org>; Fri, 27 Apr 2018 22:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932957AbeD0Wbj (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 18:31:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:48475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932940AbeD0Wbi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 18:31:38 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MfAog-1f0jpW0O8A-00OsDI; Sat, 28 Apr 2018 00:31:32 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH 4/6] sequencer: allow introducing new root commits
Date:   Sat, 28 Apr 2018 00:31:30 +0200
Message-Id: <8a7f575141218c8780b94d5df948906695294a2f.1524868165.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524868165.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:IyAlg3Q9i2HFaRAVOOg3K+MXJd8uBJhUVoM7O+FIZBp03ubJdAd
 erNLQnhi11y4h1cVXOqlvy2eWpyhMFDPF8a0Z2WgwWxkXcpPywFTYaUwvymI4MNSckIlUfa
 asoHOMoi1oWtdfYMgMJlMPh079eHr3YaFTrIdNyB+frIHXNbw/vuO/lZe0Yi9DEAiCW04wL
 5aPmMCsPr55VOBe1h8MpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nZJxoG/j7Io=:HZivnQ+jmR6kIgQHe/DayP
 J7vK4Pjn2kmuORmeIhkBYcjRXf0PZ2RspYo7AUCXYZ+eDx28vFNw6+hLZCCXKHFhZ/hHbfyaF
 a32/sjevMuFonBo0CfKo9Va7jlEhJVM0oqUfe5ciTMPdXDy9NtQ/9SyOraOEs9U8DBGTiSWB8
 B2MhjEmWDJqea06sDobDMwAnzhESYspTxO02cFFkVs2LcORA1KnxxQ42As37tGpUC5E+7dAHH
 V1sYenXqBI/maG5pjp1YD+drmVKNCgSwcEkJnNElglpm5cfqOYix4hl03BKU40KQGML3jZDbm
 dNgEHRbb01VNsHhBlMgDelSE7uFt15Y7WGVYQIMTueEQtUxAUX6wgC+8J2R1QegDAsVDkD/fn
 HaGKxeD4aSasPC64GU4rgPN1DerphrwfAezcmGmEoCjcCbxVptNEBZU3xMPUla4dHSw7oxT+u
 QjlBm0wucvZA5Z+3bHzwR/vpznO702MqZ9BH16CJqM/YbOO0U3t2d7ySN1Z8mb/Y10DQ/f81Y
 ojLZvhaqfkHRGPUfMlS+x4/CORD1UnvwWVrOTknda1FaOii556oQrwwQ7zx5+iJ81ECvWYm4K
 QBFO/bXlc4ILUPqnzJ2LIS/GwQBEi9Dnhzph8SyfffnwImuIGHsufiSne/GToxHT0tNc2WjGe
 nbEiPgAP8ytMlrFZ8mDHMRXBWhlZbJdjpMInlMjtTpNMuYhfzyxbIdzNzWWET3yNbYNVt8bks
 3TNuennK7MBcP6FmMMljd2gWqt8iI7E7CAMQbnbyYW5kH35fxoj6Gr71sidIgVJKuqqziJJGq
 zIQEyf4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the context of the new --rebase-merges mode, which was designed
specifically to allow for changing the existing branch topology
liberally, a user may want to extract commits into a completely fresh
branch that starts with a newly-created root commit.

This is now possible by inserting the command `reset [new root]` before
`pick`ing the commit that wants to become a root commit. Example:

	reset [new root]
	pick 012345 a commit that is about to become a root commit
	pick 234567 this commit will have the previous one as parent

This does not conflict with other uses of the `reset` command because
`[new root]` is not (part of) a valid ref name: both the opening bracket
as well as the space are illegal in ref names.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              | 40 ++++++++++++++++++++++++++++------------
 t/t3430-rebase-merges.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fc124596b53..d10ebd62520 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2727,18 +2727,34 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
-	/* Determine the length of the label */
-	for (i = 0; i < len; i++)
-		if (isspace(name[i]))
-			len = i;
-
-	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
-	if (get_oid(ref_name.buf, &oid) &&
-	    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
-		error(_("could not read '%s'"), ref_name.buf);
-		rollback_lock_file(&lock);
-		strbuf_release(&ref_name);
-		return -1;
+	if (len == 10 && !strncmp("[new root]", name, len)) {
+		if (!opts->have_squash_onto) {
+			const char *hex;
+			if (commit_tree("", 0, the_hash_algo->empty_tree,
+					NULL, &opts->squash_onto,
+					NULL, NULL))
+				return error(_("writing fake root commit"));
+			opts->have_squash_onto = 1;
+			hex = oid_to_hex(&opts->squash_onto);
+			if (write_message(hex, strlen(hex),
+					  rebase_path_squash_onto(), 0))
+				return error(_("writing squash-onto"));
+		}
+		oidcpy(&oid, &opts->squash_onto);
+	} else {
+		/* Determine the length of the label */
+		for (i = 0; i < len; i++)
+			if (isspace(name[i]))
+				len = i;
+
+		strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
+		if (get_oid(ref_name.buf, &oid) &&
+		    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
+			error(_("could not read '%s'"), ref_name.buf);
+			rollback_lock_file(&lock);
+			strbuf_release(&ref_name);
+			return -1;
+		}
 	}
 
 	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 3d4dfdf7bec..35260862fcb 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -241,4 +241,38 @@ test_expect_success 'refuse to merge ancestors of HEAD' '
 	test_cmp_rev HEAD $before
 '
 
+test_expect_success 'root commits' '
+	git checkout --orphan unrelated &&
+	(GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
+	 test_commit second-root) &&
+	test_commit third-root &&
+	cat >script-from-scratch <<-\EOF &&
+	pick third-root
+	label first-branch
+	reset [new root]
+	pick second-root
+	merge first-branch # Merge the 3rd root
+	EOF
+	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
+	test_tick &&
+	git rebase -i --force --root -r &&
+	test "Parsnip" = "$(git show -s --format=%an HEAD^)" &&
+	test $(git rev-parse second-root^0) != $(git rev-parse HEAD^) &&
+	test $(git rev-parse second-root:second-root.t) = \
+		$(git rev-parse HEAD^:second-root.t) &&
+	test_cmp_graph HEAD <<-\EOF &&
+	*   Merge the 3rd root
+	|\
+	| * third-root
+	* second-root
+	EOF
+
+	: fast forward if possible &&
+	before="$(git rev-parse --verify HEAD)" &&
+	test_might_fail git config --unset sequence.editor &&
+	test_tick &&
+	git rebase -i --root -r &&
+	test_cmp_rev HEAD $before
+'
+
 test_done
-- 
2.17.0.windows.1.33.gfcbb1fa0445


