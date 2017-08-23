Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B23220899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753984AbdHWMK7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:10:59 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:64377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbdHWMKy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:10:54 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue002
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LZZIC-1dGuNU2EEW-00lWan; Wed, 23
 Aug 2017 14:10:52 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     hIpPy <hippy2981@gmail.com>
Subject: [PATCH v3 4/4] merge: save merge state earlier
Date:   Wed, 23 Aug 2017 14:10:45 +0200
Message-Id: <3daa548a93e8e3166ef434deacf71b218f3c9263.1503489842.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.426.g4352aa77a5
In-Reply-To: <xmqq1so34m6d.fsf@gitster.mtv.corp.google.com>
References: <xmqq1so34m6d.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <cover.1503489842.git.git@grubix.eu>
References: <cover.1503489842.git.git@grubix.eu>
X-Provags-ID: V03:K0:Ko64Ym+mH6BfO3veX33CVrHnZtl0eW9Q+egtkc4a6VLOf+ibbo4
 z37QngU68nHdocfIArQmptMLGpSebShdO2/VMEv56gXUnkj4+6tJkhMthnrxKBX0eqKA9eZ
 tTTGzMCTEXZfcmVz0vfkRVj/jXdcG8rkhKGscUmVoYgVPycPQtgS2pIh9aEE+6a23LJLKPE
 Dn+qip55sLDwqXYG5K2Wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wp2nya3EYGQ=:48XsBqAV2DtzyOt9s/gW8K
 3i6SJ43Nqvg2t+Tai2lCFtTMG+eScp1QIS0guN4HMJdjuzt3NdhYOhb7DkQE3yKBdjWZZ4PIb
 2EbdQpIxMW2nuym9BTe6WuYt96Nls3nCaGUspDQHhB0/eariZOdTYgRVpdBtoVrgWtRgk0OlY
 9y2Odk3mcNkmvJmNM34ROJSFoZRGBFcQpTlKfWrk92RVeVzjkY+nyQWUhqcBBV8GLODc/kMHP
 z3YZNupLjYqM/8Unbv7AQEw7mOTWdFL9uYcwrUuPhFVzH1QYWQn4UMOXGDRU74BvG6EXWVIDb
 DBVQ9zlAfeRjSf4qEsYa6I1G1w4q3AfJRqXjuxMgTUAR61VBq5hGLp80TK8bmUAanuKC3jrMm
 f3pvQ14eYEGsZ1204rbv3ay3YlB5/cGOkeut72ZVI1xJXEyX+JfnFBJ6n12kOz1CLkgiovNl2
 MUKM8QoO1+HumWRmgLoeXZSyU/EPC+c+hsM+8Ezqo4eIe9gvfI6Ye7Fu1GBAcx3l18EfM2hRA
 j846j7G992La72m7jvYSWO/oksLO9dNlBwG/9E6YR8y7gMnoPjUwSohWLl5ZInJJTu6V1KAxY
 3yKhmlUvHpBHZ4ojfmuq6E0fCiDqON6lzzrtUwsFUuIXHcZxb3TJgSpg9U0YxFDKeUQCJPIA3
 Kh0IwcvPs2/gtU107uPdDvkDfALwjH3vs4Gt1eyRnPIZQV0dQvJoTRe57Cm3X7sO3T5/0qXPK
 9Duc6kPifqItE/gcFw2n+UsMgd5sjTFR79VCrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the `git merge` process is killed while waiting for the editor to
finish, the merge state is lost but the prepared merge msg and tree is kept.
So, a subsequent `git commit` creates a squashed merge even when the
user asked for proper merge commit originally.

Demonstrate the problem with a test crafted after the in t7502. The test
requires EXECKEEPSPID (thus does not run under MINGW).

Save the merge state earlier (in the non-squash case) so that it does
not get lost. This makes the test pass.

Reported-by: hIpPy <hippy2981@gmail.com>
Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/merge.c  |  2 ++
 t/t7600-merge.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index db3335b3bf..2d5c45a904 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -758,6 +758,7 @@ N_("Please enter a commit message to explain why this merge is necessary,\n"
    "Lines starting with '%c' will be ignored, and an empty message aborts\n"
    "the commit.\n");
 
+static void write_merge_heads(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
@@ -769,6 +770,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
 	if (signoff)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
+	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(), msg.buf, msg.len);
 	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
 			    git_path_merge_msg(), "merge", NULL))
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 2ebda509ac..80194b79f9 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -774,4 +774,19 @@ test_expect_success 'merge can be completed with --continue' '
 	verify_parents $c0 $c1
 '
 
+write_script .git/FAKE_EDITOR <<EOF
+# kill -TERM command added below.
+EOF
+
+test_expect_success EXECKEEPSPID 'killed merge can be completed with --continue' '
+	git reset --hard c0 &&
+	! "$SHELL_PATH" -c '\''
+	  echo kill -TERM $$ >> .git/FAKE_EDITOR
+	  GIT_EDITOR=.git/FAKE_EDITOR
+	  export GIT_EDITOR
+	  exec git merge --no-ff --edit c1'\'' &&
+	git merge --continue &&
+	verify_parents $c0 $c1
+'
+
 test_done
-- 
2.14.1.426.g4352aa77a5

