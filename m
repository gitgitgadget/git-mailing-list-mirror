Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F2C61F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933782AbcHaIzK (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:53369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933400AbcHaIzF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:05 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Md31i-1bMwBI00kU-00IGwm; Wed, 31 Aug 2016 10:55:02
 +0200
Date:   Wed, 31 Aug 2016 10:55:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/34] sequencer (rebase -i): skip some revert/cherry-pick
 specific code path
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <3a1417a67b17c057fe0c90b30c34e3d14fbf549f.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gWFJEUr/Lj49xUUcxED6CigANsnhv64cQHEkObWiN47v8ue9KbO
 f3g4On7VjLPXC5U2E738UQ+HQKNGFDX2fn/F0JFf0lJ8iVcCbDemXjRC4mwOxA1HSmXm1dN
 ICxmdilXanJYZlMQRR3RsKCeq4RJ311CkK+RnDP0B0uddAYSY4TKoBvi/tcBwO4MIEIPKRi
 a5mjtno/ek/y73BgqrXNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3PJVC3eIJwI=:NawS1MfkLCsNGA8JrJdiv6
 pLrEFzSbDw93fGErpwkdUjxF3ph7oQOhiOgeXaLCjPL9geayv4kFInWAXHWnh6CoHiE9ISnSD
 T5HvVYwWptNgcU2gDOCu9CjbFm5VDeFnJJrs73R+byUUjx9ENs+cZ9OCPSPH3ey/rRg6hO5DM
 3eNNq7L/+dhykuBtDAX6o7ThH+UYHU0vMxO0eTYsDtBG9YCw0iL+vowQdd43OJU6raR0p00k4
 iz7vBXzTSTF1XMYo4IhL0HOR70zEC9B9zXzHZRSchBgTiUz+vLAljO2sM7pFxYTuWufh0YUb8
 CC+6ilmNIsczd/nKsL94B58mOSYHOv/IkIGsvwqY8SydRUdaYN7GKZ7UdIpWXX/lyXE2l4uPW
 N3nbvkZGwiuIICetHRo78sn+TVM3UtD5cEpOZtaJyI76MrnVvBN+wr6/PBZ7KEnIIGGHzVUXr
 4bYKPI4cjGvKXVBON2LMpDNuF7bMjc1M+TFTClp0TpLnDpPqZGj3I+ZYf2FwNVTT3KqRPOKU6
 ras9WrBrHCB7/mr72fMtZX1BpRcQ5BoHdw78E25veW98Ahr5xssCXjBwDdPP7JrPQPwH8qgP4
 celVIXuAEQMGK6fn4Nwi9E8Dk4I3YPJDQu/Go2FzkW7qG0kLQg7oHZiWQtExdxldG0Q/2RomG
 H10utAC239nve+p1as2OMXaciAOhhAwQX/8/lHrSGuedxPtkl9seNm80B2G7/4oPkhzXiDeWe
 PvJQfYku5Syv0DiKRw2OQtzLm/gDYVc07/bOjXyETzt8Pkmp/CIfzYQEV3CUpadG6EAdv4Yf6
 Wes5IiD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a cherry-pick continues without a "todo script", the intention is
simply to pick a single commit.

However, when an interactive rebase is continued without a "todo
script", it means that the last command has been completed and that we
now need to clean up.

This commit guards the revert/cherry-pick specific steps so that they
are not executed in rebase -i mode.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 683b89f..7f017a8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1859,22 +1859,25 @@ int sequencer_continue(struct replay_opts *opts)
 		if (commit_staged_changes(opts))
 			return -1;
 	}
-	if (!file_exists(get_todo_path(opts)))
+	else if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
 	if (read_populate_opts(opts) ||
 			read_populate_todo(&todo_list, opts))
 		return -1;
 
-	/* Verify that the conflict has been resolved */
-	if (file_exists(git_path_cherry_pick_head()) ||
-	    file_exists(git_path_revert_head())) {
-		int ret = continue_single_pick();
-		if (ret)
-			return ret;
+	if (!is_rebase_i(opts)) {
+		/* Verify that the conflict has been resolved */
+		if (file_exists(git_path_cherry_pick_head()) ||
+		    file_exists(git_path_revert_head())) {
+			int ret = continue_single_pick();
+			if (ret)
+				return ret;
+		}
+		if (index_differs_from("HEAD", 0))
+			return error_dirty_index(opts);
+		todo_list.current++;
 	}
-	if (index_differs_from("HEAD", 0))
-		return error_dirty_index(opts);
-	todo_list.current++;
+
 	res = pick_commits(&todo_list, opts);
 	todo_list_release(&todo_list);
 	return res;
-- 
2.10.0.rc2.102.g5c102ec


