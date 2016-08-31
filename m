Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEBC01F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbcHaIzu (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:61376 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933876AbcHaIzs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:48 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MVvDo-1bctjp42VE-00X4he; Wed, 31 Aug 2016 10:55:42
 +0200
Date:   Wed, 31 Aug 2016 10:55:41 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 19/34] sequencer (rebase -i): set the reflog message
 consistently
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <4c90d25df32e296dbace2b47e6f985c283ee23b4.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Qf3GAH6Ug4PSQfz6KZap6UYYb6JWxnUVLA5qoalY2prNFRFiLeb
 z4BCuyf8xKAbTiWXeP9+LpDIc0gyb0xL84PRKMuIMAjWv7oIp7yECuZHl+LfZuPMi/M1QX2
 QQQum0FKMLdaGPaAho27qsfHGHwft36DRodQoCbMN0+MzyPDgSpQX+I6iPoD10JbcOcq7JL
 3xI+UZ2gcuo22n6qXCL7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lkNwC+dZFWI=:kI1ruWzE7CrytkrIOhe22D
 1Obgi+Bbgx8HOxHsoz64IMmfgRQrfP1oLreeC92JZrYvBJcfrDgYfJohfG0lWXZMo1IxFzMU2
 6dnnRn7xKcVwcS9fYN3NJaKFmx1EzHw7VDNbiZ+yMNcRH3o6nKdY0fgnoOPN9dVTQbDgZbraN
 oT2xVOsjdpl3hsqHRrCCr654hWyAuGk10C+SSAtsvlEzYL03PnwwZA6mz50yzZvBnG7GpN/JH
 J66D0n5RJneurEvx+hp1L7DCbVFH/kXWzukePZjB/MV0A6dwgeUf/itFXeymRm5CbvFbYMvmE
 rGKHwOCJjMLMaiPJg39LmB9yLDjaKgcsOF16a8jxW1Prds0USSP/GSMjzebk6SCHEQzKsHOq5
 zO2CHmWBsaSPb36WqLb1W1wmUBLNTcXuPaZUzim5sdjK40Rqq0Zogu7jNOX4Y4bmaTksomya8
 LK9o1hQyQ07jakq8pY58yeERy2C+421j5m77bCHc+QyVbNL2KbNgDSkptJANRAWaGudadJ0Um
 TQdoP8ExwuGZleYbJ2LEkv+A2armcQ3TDTt/113cFXMoDTHMP8U9HkQM16xpMqE3ny9V+k0GW
 3uVH8RuioOwQjaDwWhR6FPdBkcqDVwkkRwhM/vnGD61/Jt/F/Bz8Dg8V52wywy8bCMfsrzfXs
 BJg/U3fxC5n+SKfMMKx27CND3qahgP0LDh/7RzgyuCOFhOue/O8APakUYK5MJ3UP5OuyG6klo
 BEhu1MMUnb/J7mLwntCVcZluUeyIGvw0u3KsyjemDd4/N6Pu7yO7+6oL1l9mupDo3q4L/0xpa
 gshXiax
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already used the same reflog message as the scripted version of rebase
-i when finishing. With this commit, we do that also for all the commands
before that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 71730e6..54f654c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1768,6 +1768,10 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			unlink(rebase_path_amend());
 		}
 		if (item->command <= TODO_SQUASH) {
+			if (is_rebase_i(opts))
+				setenv("GIT_REFLOG_ACTION", reflog_message(opts,
+					command_to_string(item->command), NULL),
+					1);
 			res = do_pick_commit(item->command, item->commit,
 					opts, is_final_fixup(todo_list));
 			if (item->command == TODO_EDIT) {
-- 
2.10.0.rc2.102.g5c102ec


