Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2FCB1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759648AbcHaI5y (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:57:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:53509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933787AbcHaIz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:28 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LcBin-1bDhIE0seT-00jYnC; Wed, 31 Aug 2016 10:55:23
 +0200
Date:   Wed, 31 Aug 2016 10:55:08 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/34] sequencer (rebase -i): update refs after a successful
 rebase
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <8dc2674ad2f2a0e0d751e876e1ace743d04eba0f.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TOPE1BzpFoTaYR4Ikva8yhzkckxkzTVTWQiOeLFNlU7jCQ2Kxwz
 OXz2bq1IxzDmzm3fXBUOvrL3BSweF+e3c6Gd3j7d7K/fGdNiT5N5CJDBb/FKuib+fsDyMby
 rGD+kDgtSdi2CHbP78LOPp79Zs9hoRM82b6yd0bUbtptzEftEbSeeoLsE7dGZags35jdMqC
 BT696WTdRuOSFQ6VcxQUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wa9lrBk7658=:rUzXqPHRa6aloepimtk6Er
 RqZwPp41MiVM3byhXkDQApodtKPG0it8/6RcW57ezPtqWUixB21yeb+qpqbRw6/M4iC1seAAz
 veK19OVwv1XqxdBF/oXrioZfn70JIq7SYHdChbbcNx3AlJX3DN2fseGDargLpVSRcLpGfZ14F
 rpbhKPWl01oa2d8640U6YhuTz6Wm8XdWDA2R3ezPbmJKcVVOQX4DGTrvLyFL3ciMLu7KnEgA5
 xMtlVbNaaE/zUQTvPfZvPxcPTcHzmp9aGwaSPZa8eIAzIrtIsflitBCew29YRQQthH0A3iYtu
 gSX52D7MTOSBlrd86Oamhxw3H54exy0s+yu5la5ZHfsbipLTf88m5fMo5oV9HtDYt4jp1sHCf
 hmZakmqdRgNOsGP2V/V2bMQvkRzZhdnVvzLnqhkSaxCaaOZtvAisL0zr1hoWopAof3P5QLfsL
 32+6ZypG7Cw1J4dqtItTlsSWoSRSmsv1kh8qlogFh84Z0Kp5n08+cwUBvZdnm08m3cD5G0POH
 tiqjOpWN8wMQw9zbdkAILlsspukHqwpewwdQkqyicBwEgIoYv/nF0W3KIUlrouBZh2uoxBfbd
 rd9utARtxPrOB121K/QhXOyIeLxj1Na3qCDrLPxmhyYBue/Nl7neHNWIX/ZdTeSjnUQ3OZET0
 txC7C1a4E2d9VyI6o5EdY0Dz4Tk7h9rbPnZacBlf+o5eH8OgfS7E8TVxPtNh8uCJ0ac69Kl/8
 rG+CDStgpaboczmyihcjY6FOJJIjoSAoMW/LkvUX7YxWQV/nZ9OpFJSp3ao/Dgn8G7Hg3wqSw
 Vp/UA1c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An interactive rebase operates on a detached HEAD (to keep the reflog
of the original branch relatively clean), and updates the branch only
at the end.

Now that the sequencer learns to perform interactive rebases, it also
needs to learn the trick to update the branch before removing the
directory containing the state of the interactive rebase.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d4437f5..7662222 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -100,6 +100,8 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
+static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
+static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
 
 /* We will introduce the 'interactive rebase' mode later */
 static inline int is_rebase_i(const struct replay_opts *opts)
@@ -1769,12 +1771,39 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 	}
 
 	if (is_rebase_i(opts)) {
-		struct strbuf buf = STRBUF_INIT;
+		struct strbuf head_ref = STRBUF_INIT, buf = STRBUF_INIT;
 
 		/* Stopped in the middle, as planned? */
 		if (todo_list->current < todo_list->nr)
 			return 0;
 
+		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
+				starts_with(head_ref.buf, "refs/")) {
+			unsigned char head[20], orig[20];
+
+			if (get_sha1("HEAD", head))
+				return error("Cannot read HEAD");
+			if (!read_oneliner(&buf, rebase_path_orig_head(), 0) ||
+					get_sha1_hex(buf.buf, orig))
+				return error("Could not read orig-head");
+			strbuf_addf(&buf, "rebase -i (finish): %s onto ",
+				head_ref.buf);
+			if (!read_oneliner(&buf, rebase_path_onto(), 0))
+				return error("Could not read 'onto'");
+			if (update_ref(buf.buf, head_ref.buf, head, orig,
+					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+				return error("Could not update %s",
+					head_ref.buf);
+			strbuf_reset(&buf);
+			strbuf_addf(&buf,
+				"rebase -i (finish): returning to %s",
+				head_ref.buf);
+			if (create_symref("HEAD", head_ref.buf, buf.buf))
+				return error("Could not update HEAD to %s",
+					head_ref.buf);
+			strbuf_reset(&buf);
+		}
+
 		if (opts->verbose) {
 			const char *argv[] = {
 				"diff-tree", "--stat", NULL, NULL
@@ -1789,6 +1818,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			strbuf_reset(&buf);
 		}
 		strbuf_release(&buf);
+		strbuf_release(&head_ref);
 	}
 
 	/*
-- 
2.10.0.rc2.102.g5c102ec


