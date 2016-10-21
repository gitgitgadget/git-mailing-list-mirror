Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD51120229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932750AbcJUM0X (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:26:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:56986 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754368AbcJUM0U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:26:20 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LpL4H-1cch0t09pN-00f7T5; Fri, 21 Oct 2016 14:26:14
 +0200
Date:   Fri, 21 Oct 2016 14:26:13 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 23/27] sequencer: remove overzealous assumption in rebase
 -i mode
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <cf906a605dbd2f1c5ffe06877b1fa4602ff4a1f5.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4umIlLTIyZvRvBAuz14AZGVL+O+81L/VzRSmSEdzB23Zs0+Nw42
 zmViFJRK9VbH2w32O71t2DFideXFjtP9IISqmpdkcDmd+qtgZUbfMGEp2T+HbiX7rCjRT9X
 JZvMFtkLAB/MEvTis3IlWPr3lbCxjuyakVSf+G6BoZvSvjqBncXrbYOAgk7QOEQYI0Ak9Hq
 3TCW2Ks0fO35Jy5gQzvpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nAUkARAyIiw=:bFCBKjApT9jznMqM+Hrwda
 fPFkOPYS+ueZQeD3zCZmwujQLWe7bkGLIsk8nx3AxMvm+QebLt0pilinDeau0ZpngpKwJScnH
 oi3+YCVNr9sefr/BxRdBs7Vnq34YhvhSYRD0E4qg5Mim1/jANbtyMkw3u0j7SRF459RoVHiWD
 CRvrUXv5SIiNCoguDTKzzfj/nYPCs1YgYIcVZuFCjpl99I9x5f2SDmFSTLAMUg+V4PzFBS4Cv
 bSpo64fZXPxGnyNHAx6bZhPMBB/eoEeVvKtjcV2vo3/YMVzzgT3lAvTN/FZf2AfdYA2n3EL/U
 BSzLzl+8vPX81KjdAezeV6HKZxfIvP3jwjXTsiNE7+IgwCODem7Y6rnNr1ux5glYYSAM41wtr
 BwYF4xauBIXfI6NOXR6YsSzsL0/3rc9x8q/VyW5GoTKWJ+brB6MgXO1NVFzOtG/yj/SxdSLGS
 Nls+C+h7MmOxZFPPWVYi17Ql6PJAlf37dsRJGj+Z2nMxe7sNqh4XVfUp2jrNceFE9wCm6iHSv
 qPWQM5HLKZUKtWjYNaag1+BBSq6wZPXqNDU9q8xOf7qDhGbyqJaJ7xUDve/dxye5J1cJnbW13
 vKlr64LcIHgW4y86L5mqSm6Cj9PiHDnVfXmKrh9WNGKttVSZ+uZya6BzFcNTTHX3uFGgjRmfL
 kPHl4DkMf+HlpU+uwyY70LiSHZeSBeqvgzFie3YGpnnUPmiKrFoAY6GKt/D4xSKLWetqa6f/L
 QP7BWdNEW7j6+mNOiVYyVLxbn9RQlR2Hm718vvMgnWPkrxTennMA+oy0w/+e2HSiplyJ67CuE
 0NyXfFp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer was introduced to make the cherry-pick and revert
functionality available as library function, with the original idea
being to extend the sequencer to also implement the rebase -i
functionality.

The test to ensure that all of the commands in the script are identical
to the overall operation does not mesh well with that.

Therefore let's disable the test in rebase -i mode.

While at it, error out early if the "instruction sheet" (i.e. the todo
script) could not be parsed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 000ce3e..bd11db4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -962,7 +962,10 @@ static int read_populate_todo(struct todo_list *todo_list,
 	close(fd);
 
 	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
-	if (!res) {
+	if (res)
+		return error(_("Unusable instruction sheet: %s"), todo_file);
+
+	if (!is_rebase_i(opts)) {
 		enum todo_command valid =
 			opts->action == REPLAY_PICK ? TODO_PICK : TODO_REVERT;
 		int i;
@@ -976,8 +979,6 @@ static int read_populate_todo(struct todo_list *todo_list,
 				return error(_("Cannot revert during a cherry-pick."));
 	}
 
-	if (res)
-		return error(_("Unusable instruction sheet: %s"), todo_file);
 	return 0;
 }
 
-- 
2.10.1.583.g721a9e0


