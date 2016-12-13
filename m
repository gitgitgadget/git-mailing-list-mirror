Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 153542042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934076AbcLMPb6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:31:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:63322 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933800AbcLMPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McDl1-1c1DSi2sIZ-00Jcn2; Tue, 13
 Dec 2016 16:30:47 +0100
Date:   Tue, 13 Dec 2016 16:30:47 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 13/34] sequencer (rebase -i): the todo can be empty when
 continuing
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <3e44043dec45fe197098308e80992684688382f9.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iKf1U9MElIORgp+3wngPE07MmmurGyPDo5txjv5Sahr9U7rJDeX
 4UsKDD/shQAU2dieYXZ6mOjncBNF/nml9XvqKrUQJWJZu6r3zZri+HfCHwuAs56G/yH6ll7
 kCOvvmHLRqV539jO33P2QQWxa6MJGeLUe5aqXsiVVgYG/FZRxTpkVQgeUFZ6ipReW902814
 SAPGVW3e27G8/1egjwKDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/jwGO4+sA38=:QGOjq01TCDtGmxku5rF0Ry
 WB4R92LD/qM3eSFFBViEAlLLGgZQLehmJUDciL5kPTvh1qJ3nO12SoiUdLcfce47uux8Bm6gy
 OMdhkQPT+iEB7/tJ99527/j1Yg9O8qqMDvb+x7L2PnOHaudzutxC16VqxCvU5GZO5RZzWtbgm
 Y9iXk8UqF7Bi0hzIbdOEHqvaQxZAG/JmEGRfulCzdjn4Tj9OYOSRg5hTpqnxUX/P0WBp9VrEz
 TC0awV8C9ATi+2J42VobOMCrIOh41CjD068Pbm7aJ2cv5+Pl9pwaFE0EnI4P7MYePlwCaMMvl
 EmjpAn7k0mB9P6cUwSCImqOf0WJNvaVpGgBboeifYPua0kORZmy0LgyirvA7YpSsbqVS/cx4T
 rokW4f6Jr03x1CEkfst6AdPapyPLH1zXevtqhZTDY1MlfmHyYPBhCn6V6Xx+SYVcEmtIzU16C
 dg4Frq+QKKke2L6hNVOUAE8VGfSxPCD2uXLhRZbIK81zap2fOZSmwp0PFuEb3eGyAElKoi5WW
 IVcRkiVHzg3gUstaqBz5mg9Mq+mx+eHSSCCIkdtkguOoHiFn3Di4ogLeCB8Yc9jI1HtRrn7xt
 RNbBZVZahPPfzBoERYabr2wEqRiYXoEIJyj68stx8d4gkEg58sP9i1vFFF9yn1YB3Ol2CHOew
 CKXzHO1XcKGRAP1xoQ7jiClyI2nZrrE8LEWyoM5MJJ1MsObNzeldLq0xr1X0hjEGFTGc9oOhd
 eNmD0x7mN1Kf1OMZtMNmm2Yq37pQqG/8fOk12byvjpQF65hMSNtXkJ5jnzxkzvBWK42BWw+QK
 arvrPFG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the last command of an interactive rebase fails, the user needs to
resolve the problem and then continue the interactive rebase. Naturally,
the todo script is empty by then. So let's not complain about that!

To that end, let's move that test out of the function that parses the
todo script, and into the more high-level function read_populate_todo().
This is also necessary by now because the lower-level parse_insn_buffer()
has no idea whether we are performing an interactive rebase or not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4ceb6f3ac5..a6625e765d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1255,8 +1255,7 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 		else if (item->command != TODO_NOOP)
 			fixup_okay = 1;
 	}
-	if (!todo_list->nr)
-		return error(_("no commits parsed."));
+
 	return res;
 }
 
@@ -1280,6 +1279,10 @@ static int read_populate_todo(struct todo_list *todo_list,
 	if (res)
 		return error(_("unusable instruction sheet: '%s'"), todo_file);
 
+	if (!todo_list->nr &&
+	    (!is_rebase_i(opts) || !file_exists(rebase_path_done())))
+		return error(_("no commits parsed."));
+
 	if (!is_rebase_i(opts)) {
 		enum todo_command valid =
 			opts->action == REPLAY_PICK ? TODO_PICK : TODO_REVERT;
-- 
2.11.0.rc3.windows.1


