Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 782FC1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeDYM3L (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:29:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:52273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753197AbeDYM3K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:29:10 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LvhC4-1eJRHW2VMy-017W6Y; Wed, 25 Apr 2018 14:29:02 +0200
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
Subject: [PATCH v9 08/17] sequencer: fast-forward `merge` commands, if possible
Date:   Wed, 25 Apr 2018 14:28:56 +0200
Message-Id: <bc72c0e471dc441541417ebf7e64374fce6e884e.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:yC+aYOOZ3nH91DryYw+U1eiBAbV9jXYEbCn0r1wZUSp0mFuokgK
 +QYyGaFL8Hp15NylQUzHcKvntLe90M6tSGAFjyFPAb7w/yRIkAVjyxOcpZ+RJGNM2S5xK6F
 hNK04sLOpfzQ8E0cw5LBEiBrFYGUl7rk0YcKkxkJfmzvzuEkz3rLlpakfLmWcWzZ+lFsEnb
 XVGJWkU++kb0VT8yGOqVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jknJMAoQLdA=:Ojmsr8pXwjfK0V8nXZ/zIJ
 iQM/SSogkvfJy7IJenZ+kZERxw7owrZzdBAKd6PTZt/I2ZDIYXGABclvajdi5f0naAD1pgg0j
 HNJvKmRBnRme4UawfeMhOGvqL4sRb+OEe3+rm6vc7BJiEnDiqQAlI6nZZBooElQ9BGGI2AYJU
 55KkmLZe2TUfWFBAAcz4iMGt5Q2srFon2I5uCPpCVsTrlKQeBA4KbCLHYtszGCOk5sOfvQKLw
 SY4OHip8cK/KqP53YT89MiMOBNjpU074Rhh5nza5pc7V+r7xpVirAFpMCyy9bgG1xEM9ZcPEX
 iP7MZyXtA8s8fIk0D/NHezf3GL1vK6EgIm1jUrCzcNeFTTF5Es3I31XFex6a1Niu687w38+8U
 Qp7GRKog0c9VAQffP0oqCReqdjNntqQoIY8ISgjfmBBbxKv7mFvEU0Jl7GNv1j2I2ArIYXCs6
 646x9uaGAbs6B6OGtROgw0RuRqDlPQWB4G28+8WCePNr1sd/SFX9Cn27uQ57grxp6v0FqrMj2
 Mor7FdwCZ08vavXg6hxeTkfHLZt3khOUagXNeT+cjlBgeYbTFnuHq1ng8mF1uGBvb6WxbS4Ve
 yIfYUt/knKXv2j1e0nyEM8k7x0qEnvJxXE4Rqokx4NV+Yts0lpgg8QvWM8wkfuhH9c6GXJeup
 W1tdgCxe37PpJ49QqbpUlNMx/Vqs/vZQVjgrjEYM5L2WuIKUIOfcicV1lnsqUI38OZfLEgOD0
 OWrfWq+oihfd6NxC75EtVzroeeRF2m25Sbkfgo1OkMGWrA4pCKtXODTvvm6piMFsUIyqoasJm
 5mSQC2cTqUrgksvcthUUjtHjRralUrrsIVnKo2WDUHi7r8Nt4PVAhnTY2vBwchvp9EhWNXp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like with regular `pick` commands, if we are trying to rebase a
merge commit, we now test whether the parents of said commit match HEAD
and the commits to be merged, and fast-forward if possible.

This is not only faster, but also avoids unnecessary proliferation of
new objects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 94f4831a0c3..6722095655d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2687,7 +2687,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *bases, *j, *reversed = NULL;
 	struct merge_options o;
-	int merge_arg_len, oneline_offset, ret;
+	int merge_arg_len, oneline_offset, can_fast_forward, ret;
 	static struct lock_file lock;
 	const char *p;
 
@@ -2772,6 +2772,37 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		}
 	}
 
+	/*
+	 * If HEAD is not identical to the first parent of the original merge
+	 * commit, we cannot fast-forward.
+	 */
+	can_fast_forward = opts->allow_ff && commit && commit->parents &&
+		!oidcmp(&commit->parents->item->object.oid,
+			&head_commit->object.oid);
+
+	/*
+	 * If the merge head is different from the original one, we cannot
+	 * fast-forward.
+	 */
+	if (can_fast_forward) {
+		struct commit_list *second_parent = commit->parents->next;
+
+		if (second_parent && !second_parent->next &&
+		    oidcmp(&merge_commit->object.oid,
+			   &second_parent->item->object.oid))
+			can_fast_forward = 0;
+	}
+
+	if (can_fast_forward && commit->parents->next &&
+	    !commit->parents->next->next &&
+	    !oidcmp(&commit->parents->next->item->object.oid,
+		    &merge_commit->object.oid)) {
+		rollback_lock_file(&lock);
+		ret = fast_forward_to(&commit->object.oid,
+				      &head_commit->object.oid, 0, opts);
+		goto leave_merge;
+	}
+
 	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
 		      git_path_merge_head(), 0);
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
-- 
2.17.0.windows.1.33.gfcbb1fa0445


