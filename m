Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30028207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755981AbcIKKz6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:55:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:56905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755961AbcIKKz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:55:56 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M3R1g-1asRs80tKC-00qweH; Sun, 11 Sep 2016 12:55:52
 +0200
Date:   Sun, 11 Sep 2016 12:55:51 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 22/25] sequencer: remove overzealous assumption in rebase
 -i mode
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <d0066b1a8dc6d8d6d45161203cd5c08ef8f2216f.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MHiYToMua+pmmXlJ18j+XLjuKq9TYwoh9XhmeozNicnScDOsmKP
 sizvyziw7bJJeQM9vn30+ijNgGDJ2KegNQuoZXxvRtxcw0pQ/+ktA2kWNq6fpqKtlGtMJoN
 UCADsvYiMx4j2IN9q9E6vlF73YXHrTXoginlsLqq1naQQqnU52S7pCJ104ofSZTeIbT8k5q
 BqIFdch8dDsUO3f2G3R1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OPs09OiyvDo=:pswIz+cQx1ZxKbakiDeO0c
 yPReZVN4H8/PtNdFbNC+t/k++NcS8Z+089yQ/Ha4UTrmSR0/bMre368pebVKpD64EqTefdcOR
 mxWgPYz1Dle4WMVruX8oiYDnsY4bQpURus974b8rejIalsPnFSj0sEdQaTsOdHWZhWjS7iag3
 6DigSOe3lyDNm9SdmmP8uo3uzzPlotZcke2pBkF1vvlnMvR9llGjfHO0Z10z0MlefAn5fdLJe
 nnvsLoMxOguIO/ade7w3nHopKnpn+/s8/qveB3Fp3G52VVeWu55osJPWvuUCDDvFEAuTAq7Ji
 9hkHGkORGAHwQfBJra4MiZOLikw10v6H97YbR14D1MFW2RGwACRHX4Kwx6d7j1JLSfjmf8cZL
 dOf0/L4xKcERBnyGbFkU9Tl1FkLZB2imwILf3vi4LQzyPmr+JoRi9M0KUb9RXQWKYkVoIPquK
 YgqRO2Lyy1llQL+oRf/ZzXL/egZn+i+/UzSmo/UpR2XmAqMg8ANnbY83gz/vD8yXvsMbHscMh
 Xoe8ESEfRVmn6/00GILYL61Zggd8MQDtvdRNqyv+bWES6WrjTjYyYrvJEiS5o0Q+60+indyGm
 HRbI/RePLmkYeh9LkBvP6DF3sOzwft9aFlR+RvIcUrwcTdIagjhuDNx4UxJGF6uHSVYNRSqu5
 SMIkzD8Y1R8QtBI4JlvvUo1iJI4H3LO6GPQnD+QPbJ8RKa12cDxoLSavIkrmQ+R2UmrIVpTMm
 SxJOJePd/0LHRc1QCJfEFfMi6RnK4TtW+ITW3zfzilj2tof0WStbGdaV8lhr2DmP90lkOtuUD
 ro/N6qU
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
index aa949d4..5144245 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -963,7 +963,10 @@ static int read_populate_todo(struct todo_list *todo_list,
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
@@ -977,8 +980,6 @@ static int read_populate_todo(struct todo_list *todo_list,
 				return error(_("Cannot revert during a cherry-pick."));
 	}
 
-	if (res)
-		return error(_("Unusable instruction sheet: %s"), todo_file);
 	return 0;
 }
 
-- 
2.10.0.windows.1.10.g803177d


