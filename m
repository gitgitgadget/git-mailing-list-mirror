Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A83F91F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759513AbcHaI4J (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:62413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbcHaI4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:56:06 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LbxQO-1bDQFq17Ei-00jHpu; Wed, 31 Aug 2016 10:56:02
 +0200
Date:   Wed, 31 Aug 2016 10:56:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 25/34] sequencer (rebase -i): allow rescheduling commands
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <7e3a0120e1da6ccad814d3ab3826d9ef6faa68e7.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5IyeiQOcwZkg9xInK256c0OZY2i8M9R7wksjLBqSHWWCkfP8Pp3
 auqSqdTUngfYfpueFwUIufkWTZbrWH8gLwL8AReQ3AColhJs8rOdfPPCB/NqxSrltMagtCk
 b4WUal7rcA9xnQwqrEcUadMmofkJlQo2MRPh0rLwogboYBVuF35mI6QmBoNJY9CMGTtfN8g
 xwLyhPErw7o8R+lNl97Hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hJc6TpZn/hE=:L2D6aWbWi//8DHgAUrwdgA
 J+OdElxSxEmAtoNLYm2XGdPXVpdRxrJRyEq7AgOnUeX39tm5oKhD6yZl4l72v3HOlQBlP78fF
 Va6RsYrseMJhOwZxkGK05N+qU9/PyLr8xxu3nlSM2oKv4/L7gDn1xxVtNGL8thePEZL8iKLSD
 VMMV9QhEkhvin99fkFOYoyZB5ml70JREGGAx/7H0JgpXKba6f4YxPeQ+citDEheB/l9GClSZc
 1Ra6EL94oKMwhH5k1asBOxLVeFuucNcsa0LUx6E1fwEi4BFGS3OsiBfE2yk+UWdxsK9ktTkHe
 DQYyW8sQUaBG2X8G5efUfTrG0D6+ZxP8lNPySz519UFZuCMkIhwtPXBVUAELD4AuecAi3KHTJ
 +vKIKRVZMUm/oF8m1AY+/9TGVzdaTWBoCY5ZfK+ZewLGYl3MdsL9ER7ye4eia8L0BrbftXN2G
 PYBNgvlMqTN4bP6sGoa8Z+0lSCnKYAU58tMy4zfpgJ1Mb61QRvJ2c7E7Pk3ucK+pUjVtE3Ttt
 Vql9tyPmXygGypHcWpXQQ9JUDlIbCD9aN2DLHyjk21MIU/l409n7Y2B0WqlELneZPSmhND8ji
 3zhJfmm5hDCEMxtRbrd4g8vm+Mo3Qlgc6cKjkWjx5dzPpbVfcJlkRUnWevGAfNb5uZ+/ZxBUe
 0gELaRz8tMcnV/p3Tw5Ar0Rq4mUP6OX7nIBfPbEdmFsaiutfGq6dSDxTNGvjPo81SHeKu/SrA
 A6Gc5cKdgn7uy+v/W30ixLwiu5yp0YYS8mAJbt436UUW0Og8bmRDZp6eMwCTB1fjKkHU0QSz8
 iT1EMS4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interactive rebase has the very special magic that a cherry-pick
that exits with a status different from 0 and 1 signifies a failure to
even record that a cherry-pick was started.

This can happen e.g. when a fast-forward fails because it would
overwrite untracked files.

In that case, we must reschedule the command that we thought we already
had at least started successfully.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 5f5fb9f..366ee78 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1895,6 +1895,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					1);
 			res = do_pick_commit(item->command, item->commit,
 					opts, is_final_fixup(todo_list));
+			if (is_rebase_i(opts) && res < 0) {
+				/* Reschedule */
+				todo_list->current--;
+				if (save_todo(todo_list, opts))
+					return -1;
+			}
 			if (item->command == TODO_EDIT) {
 				struct commit *commit = item->commit;
 				if (!res)
-- 
2.10.0.rc2.102.g5c102ec


