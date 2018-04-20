Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6002E1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 12:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeDTMSc (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 08:18:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:57741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754726AbeDTMSb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 08:18:31 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LxcbX-1eKyiN2y0R-017Ekb; Fri, 20
 Apr 2018 14:18:28 +0200
Date:   Fri, 20 Apr 2018 14:18:13 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] sequencer: leave a tell-tale when a fixup/squash
 failed
In-Reply-To: <cover.1524226637.git.johannes.schindelin@gmx.de>
Message-ID: <4f87b8ea2c47b45107e2ba1cdd6d04a66fea0d16.1524226637.git.johannes.schindelin@gmx.de>
References: <cover.1524226637.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7QGndmVsU/mzrKRS77GdJiCyPHVxRaDYi6aXjUp8PpYMx791o9g
 c2whq4O3pYcYGfFSjail8je2ns9rnT/is1huM+4nIxhmpKGlgtoFBKK5d+uF0WpqQQJhJsZ
 W+E8TDeBn/AEEoUDgWqkw3z0Y6CYp/9bA52SgR2BzQIzVsjWanQXyzVVSFs4F+lOamV9w+T
 CWdJjJvMB/uuLK8VKlNlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1if2kAXjwAk=:shLLVjjXWxNWfKEZ84OI4z
 8keQjiNrkVMPBXiv94J72p9ki9O05/4v4BH+aU7fEV+sDiKHj8tkJaQQx1GXvzq2GJ/0rm+2Z
 3a4S4fmdiA2lGu0g29CSrRegTAXV5FBdU3Rrj41KZG6uiYV6N23EnrfDj1uKMnaMOpHi96XM+
 h7qHXiGdqpace0X/1/FPMxQ3frY1eB8o1WOCcpO0rSljLBy0rtgb0ORzkXZE5qXKvkcbpANZk
 5mAEKkGX5Xs6w+pUC/nTFAxOt79BagV3PhXZ6H58SzbTT2yId/YckeH84CtLMZhe+gRlgIkPg
 S7h3tSoGU6KIpOFisjQQMDPaoy9btPODugYzmoZqtLF6t/uibUVEfvjo2ZTzn1F/+KatTLxIH
 fivJH5KeVwXBEKGwYbx9sEktGDoOd3rl2RydHfDAX2kPgxCDreFH8CZ8GpKYS/lw34bmVXyw+
 IlNa55jgoofWih6Qug6U5kCK1jaVTYrTuVJYMfx9vJPsSGz5MpEORI/IqPYc5fOyEJGKxrjrC
 OJn7XZx+7zQ1/zS6PprZZtn15xXbAXCEfjl+JTTx11Thssp5ILrjQmY2yI7tti7ff5WjVgTTT
 Y9aJHtZMSJEEbCt8SeQqgdYAHKx7cJWSpOogZMK8FmfJhBP//mBUYDJ0XR/xuF8FdHITlBiQw
 qDS2PnFCpfjhElAxThxxqhQ1YHDu6dmXI/OMoQI94KwCDohHfOp/HL9zdMBhJH7RDzy3/767S
 PSJ9w+q+VK82RRL9fbY4s5DQlWysodR5Ujqq5qs5chvnCJ0+7Mjt6Bp6m7xXmb/APo7hIk/jK
 JOLAC2VnnHBtrb8oGKA8dIu5h3u3Y+DsmK43C3jR1A9xmnGXD0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming patch to clean up fixup/squash commit messages even when
skipping a final fixup/squash that failed with merge conflicts, we will
need to have some indicator what happened.

As we need to remove the message-fixup and message-squash files upon
failure, we cannot use those. So let's just write an explicit amend-type
file, containing either `fixup` or `squash`. The absence of that file
indicates that the we were not in the middle of a fixup or squash when
merge conflicts were happening.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 667f35ebdff..a9c3bc26f84 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -106,6 +106,13 @@ static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
  * command is processed, this file is deleted.
  */
 static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
+/*
+ * If there was a merge conflict in a fixup/squash series, we need to
+ * record the type so that a `git rebase --skip` can clean up the commit
+ * message as appropriate. This file will contain that type (`fixup` or
+ * `squash`), and not exist otherwise.
+ */
+static GIT_PATH_FUNC(rebase_path_amend_type, "rebase-merge/amend-type")
 /*
  * When we stop at a given patch via the "edit" command, this file contains
  * the abbreviated commit name of the corresponding patch.
@@ -2392,10 +2399,20 @@ static int error_with_patch(struct commit *commit,
 static int error_failed_squash(struct commit *commit,
 	struct replay_opts *opts, int subject_len, const char *subject)
 {
+	const char *amend_type = "squash";
+
+	if (file_exists(rebase_path_fixup_msg())) {
+		unlink(rebase_path_fixup_msg());
+		amend_type = "fixup";
+	}
+	if (write_message(amend_type, strlen(amend_type),
+		       rebase_path_amend_type(), 0))
+		return error(_("could not write '%s'"),
+			     rebase_path_amend_type());
+
 	if (rename(rebase_path_squash_msg(), rebase_path_message()))
 		return error(_("could not rename '%s' to '%s'"),
 			rebase_path_squash_msg(), rebase_path_message());
-	unlink(rebase_path_fixup_msg());
 	unlink(git_path_merge_msg());
 	if (copy_file(git_path_merge_msg(), rebase_path_message(), 0666))
 		return error(_("could not copy '%s' to '%s'"),
@@ -2572,6 +2589,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			unlink(rebase_path_author_script());
 			unlink(rebase_path_stopped_sha());
 			unlink(rebase_path_amend());
+			unlink(rebase_path_amend_type());
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 		}
 		if (item->command <= TODO_SQUASH) {
@@ -2799,6 +2817,7 @@ static int commit_staged_changes(struct replay_opts *opts)
 	if (run_git_commit(rebase_path_message(), opts, flags))
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
+	unlink(rebase_path_amend_type());
 	return 0;
 }
 
-- 
2.17.0.windows.1.15.gaa56ade3205


