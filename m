Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 035031FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbcHWQOI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:14:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:60193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbcHWQOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:14:07 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MHH3P-1bPo371w1L-00E1bz; Tue, 23 Aug 2016 18:07:30
 +0200
Date:   Tue, 23 Aug 2016 18:07:28 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/15] sequencer: lib'ify save_todo()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <fff4cdfa36355af7917a06be9f67b50b56bfce99.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Y9i4v5c9IflraTJsSLEYX/bXprDMcPLHsjNkwjvu1IWASI0HFGN
 aOGEyEA8v9lQS8eWbleWmDqMwKh46HjrNkj+diZ7twcJoaD2iZUaB84FhJCf8XqL1Ir7fuM
 EumdyUQbLQWc99wF6QbeQ3tRvLVxJHbZRYjwO+CKzoB987Sg6am9xa6UWZO3NIztYE0QJ2v
 TOTmCe6hmIXHM292WPRkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hbrWjV9xPHE=:EAAdFwYlr6exOhV6H7Xnaz
 OXWsWb31RzW68eHBJpdkLO5jmixBw9yRwT+R3wO/O8Jng9RkyQr8BbNEFmGCWhQtNswVr9nNk
 ViI2x9omaTCQJn7eGLL4g4nULmmYAO3S4nOOg9fVdbgQivPPVGnLtTqm2CJY8FXxHDGZLY1dZ
 irgcAc23pRloaN37VodOEOswvgQ8kmMd/gkoA0GPSp+x2zZB9+rOyG0DDoxJi0lfqk7SgsuR0
 iI8kTUk9bGBfRSO83k8vdtVsK+V8vgFT1Mmdz2CcVLfsQGUn9lezoxkcXAYsKqHq4Ev/14dKD
 VfhO94qTgxj1SNznjAxGXHlyaqrtelhgEhHDfcgdq7WwDpiOCel61lYyXcL99uh7f0mJt178G
 UTy0ZaBIS9bg7Hch9NMpU3ZDZIsME5TeiqBNXjjkH6mDwpslDwE1pOVag6ehCiyZJaiZYo4de
 MNKB24a6xE8IUFnkdnURhui2rAA8kHy7DQV6ctT0NiVPLa4dq2387wd4VOuvCzSS0sYYtexyG
 j90si2pptuyN5V2lxIXpBpgSnrcd4dSZECaBwIfkp3NxKSPkXASP3Q0MlVxODUu3Re7MIyf7w
 Z5O95Kb6aY+q3zzxYKMhkDdskIYji9WDTgie0aK4G1fLq40RXGntFncjSVmy+FFSzTsNHFb8i
 VXIbADt01mh6pMf8b1iPVPFuRFW82QZvweNoxFAh6piKc3WayD48cRdFwB9pY2MgwIi7buDvF
 zqRx4iiSmGHhrItpPv3wk9H63Cs+uBKXwcOzDQOMEm1xxzyNcJ5C4z7+/m5e/5l29FCv3Raxl
 lmg8yDL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3e07aa0..17f2c8b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -929,24 +929,29 @@ static int sequencer_rollback(struct replay_opts *opts)
 	return -1;
 }
 
-static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+static int save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 {
 	static struct lock_file todo_lock;
 	struct strbuf buf = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), 0);
+	if (fd < 0)
+		return error_errno(_("Could not lock '%s'"),
+				   git_path_todo_file());
 	if (format_todo(&buf, todo_list, opts) < 0)
-		die(_("Could not format %s."), git_path_todo_file());
+		return error(_("Could not format %s."), git_path_todo_file());
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
@@ -995,7 +1000,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 		return -1;
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		save_todo(cur, opts);
+		if (save_todo(cur, opts))
+			return -1;
 		res = do_pick_commit(cur->item, opts);
 		if (res)
 			return res;
-- 
2.10.0.rc1.99.gcd66998


