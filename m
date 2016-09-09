Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD67F20705
	for <e@80x24.org>; Fri,  9 Sep 2016 14:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbcIIOiY (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:38:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:59934 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753229AbcIIOiA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:38:00 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MA9FV-1btfSo05fd-00BNYi; Fri, 09 Sep 2016 16:37:51
 +0200
Date:   Fri, 9 Sep 2016 16:37:50 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 13/17] sequencer: lib'ify save_todo()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <4ea0065f8f064f56840b446c30758b9873479ae0.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ClBjA8P7DzBZrLKsby1eTIHk2iijyaPf8+SnpYVv4muDvO70K8j
 fQZnRYAp6Bvt0ylM33PAQFSABBbojSIIvIg3+5X3P9Nx3+w1FmNdn7/9CXGuH3v/pXfYxEC
 9L9yN86ml9qYCrEzMQP/SbTXBKQzzmvjQTRS8UaDS4yb4ltClZ0X8dvH49IAms3olrsy6lZ
 xgs9kbX47tQjX9B34vT9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R8ijJgycHLo=:Vnrbb2WJ0t1ISnTmSxV+D8
 n02XVHCSi6Y+jPuYFJHTb8YQwnfYQ/Khp/7JcgOSoXQc+FwQZsDprNx7SEm04fy/6LBYSCmzl
 htd6MCyfAZURtDaWk0lL8S2Kz/pNk0pgxUFVw1Vw7pfEFvFgp3cSERnORvr4s1tReKo+SnloU
 Exh8fubpvbUAtAxTyUCdGBei5QjuQylkF0Z0gzqmXmEiUnqv7xWWqB6UZUrk4F8q56+cyPiUb
 +oMpPo/0WgVsj0stvB5XOvaVlERHiYExaCVkYED19Zyn6TVX6tohK0o3LfhyTUA1QcOroXFs3
 +20Niteo5O/DoAkKBvp5nW12F8MHDqlvJnZmoAZFh/bsuru7ybFEuBcYkJoQEHDgatiCo9TzO
 Y6F71DNbElI+ysuHSLj33jry+CvIuwy6lG6LZlCua75kyYC2PYeWR98W2QtPvJeca6rnwlQcM
 9L32scGmw146jz62hkrplUjGcX1rCAExEHDVKFH/EORh9+ug0WM97MhGDfGkjbAoagX4CCMRR
 Z/2JvzlgYDOvIx6mHxp0DLggzAilhTdzOqAX1Bj6bNTaPTPJanW+lbUqFEx3mvQaBChMj9wu9
 JsU94cc3WccMil57wRpcmC69j0dpRIEqBUac5ZAZLjyJhHfWn+C1BGoUEcaRLZP3BsMgH5A6q
 IY5Y2PtsoiE4Gh8S+Ersm1nfiloSbQaIMkAHdhnwfJAsMZuxTUHCwImOybalRmd44kR559waK
 hMAi558x6BhA32l9hD5ZluhAlREZs1/QVJX4JLcHb+OHZAAcF8Ka3eMwQKZBcr5TDlABLqbYM
 gjMEgZq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain notice
the error and handle it (by dying, still).

The only caller of save_todo(), pick_commits() can already return
errors, so its caller must be already prepared to handle error
returns, and with this step, we make it notice an error return from
this function.

So this is a safe conversion to make save_todo() callable
from new callers that want it not to die, without changing the
external behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7a1561e..32c53bb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -943,24 +943,31 @@ static int sequencer_rollback(struct replay_opts *opts)
 	return -1;
 }
 
-static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+static int save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 {
 	static struct lock_file todo_lock;
 	struct strbuf buf = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), LOCK_DIE_ON_ERROR);
-	if (format_todo(&buf, todo_list, opts) < 0)
-		die(_("Could not format %s."), git_path_todo_file());
+	fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), 0);
+	if (fd < 0)
+		return error_errno(_("Could not lock '%s'"),
+				   git_path_todo_file());
+	if (format_todo(&buf, todo_list, opts) < 0) {
+		strbuf_release(&buf);
+		return error(_("Could not format %s."), git_path_todo_file());
+	}
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_release(&buf);
-		die_errno(_("Could not write to %s"), git_path_todo_file());
+		return error_errno(_("Could not write to %s"),
+				   git_path_todo_file());
 	}
 	if (commit_lock_file(&todo_lock) < 0) {
 		strbuf_release(&buf);
-		die(_("Error wrapping up %s."), git_path_todo_file());
+		return error(_("Error wrapping up %s."), git_path_todo_file());
 	}
 	strbuf_release(&buf);
+	return 0;
 }
 
 static void save_opts(struct replay_opts *opts)
@@ -1009,7 +1016,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 		return -1;
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		save_todo(cur, opts);
+		if (save_todo(cur, opts))
+			return -1;
 		res = do_pick_commit(cur->item, opts);
 		if (res)
 			return res;
-- 
2.10.0.windows.1.10.g803177d


