Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 562F320989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbcJJRZA (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:25:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:57844 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753112AbcJJRY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:24:59 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lw2Sj-1ao6xl3kM9-017jC7; Mon, 10 Oct 2016 19:24:45
 +0200
Date:   Mon, 10 Oct 2016 19:24:30 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 03/25] sequencer: avoid unnecessary indirection
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <336cefca0bda214b5b43b1094af13d787d1a79e3.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TWRUVC/UcX0nSSJBSO3sqZdukzE8s2UCtcovMkARpSDZzymOBB4
 dQS9P5Doy2CFpRRWll3QrshHlYrA4BBVOM7bQPE2MUeMFMxYfMVZA5dOHhSBvffwG2Us+Hl
 PVQgot82VxDu9Ov9+2+4YehNJrxqjYsMx9c1brE9gTTkphRXPBVtIWxE9FKz9lr9uQpCOqA
 qu6czKmM7ZdtqH3Spr7Lw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SDeBVMLhC/o=:iGyQ/WL2Ig43Q/nAAXz8GQ
 w48+7iYqvwqVC3oHayjjDgAxQpWFmY/mJucre3HUI8clRZ8EMcg6CGwBwiq+McGrg/0+Tzo42
 4U5Na8zTQK7Vqi5BNVcHSkM9Zj/BYCPwdYBuXqonBO4BQdI2iiGQZJV1L9BB2+oSqB4Tll2Ni
 S/ARvY0CSlY/l6zIdrRtJPCa1CBE7OfLr4sZOeoD46bZbthmo/87qv130CcimP9k7whuehqNE
 LzJYrqQbG44/mqSJQVBUVIx2FuFPAG2gGsfTqlA9wbzTNQYVb4Ujm7D4bfE5KNyCy879lylnG
 a9kX63KjkKKtHJaq+H13JIMH2Is3OxQzVIXPgCA470j035jafuZ3hYnGIiKarZF/wVfBtAkHE
 erRFFawaLQpiOnseej2xcTq0knD+cMxS9t/kHw7pvHlFxmPBJU4tlGjvdCIc0x6dOjVH/jevf
 x3g9z769hD9SbaBuZssbRuoU1l48zQ36ijgi2+Xvp5Z8+5amzu5aIRALZxo4K63JrMZA5BDN0
 PuUvLJGEpIEjW0VD6CSprOME/L1Zg1aBEHod8D39zxt+OJzGbPTVEf2LGJ9i9dGaehTChDaQV
 f+7zgg5Hp40mtlsVmaQMb2nXbLhtOMa/4l5xKZK5YYb1K13DrxoZ3abZoW55FlXdmOtwQJSMg
 lq6mDrmjbyvqDpgpb83oSj2nJ5JwmK4OhC3VQIYQgX1KMYS6w2DLiuLxXvRBygdewvQec8Haf
 Z9SoSVaOBh0rJ5JQPaL3/Xbi55vJL1Y0j2hXJDfZkc229/z7tTKlo5egJHz6W+V1L0uh/mlkZ
 FTaUqSN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We really do not need the *pointer to a* pointer to the options in
the read_populate_opts() function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cb16cbd..c2fbf6f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -813,7 +813,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	return 0;
 }
 
-static int read_populate_opts(struct replay_opts **opts)
+static int read_populate_opts(struct replay_opts *opts)
 {
 	if (!file_exists(git_path_opts_file()))
 		return 0;
@@ -823,7 +823,7 @@ static int read_populate_opts(struct replay_opts **opts)
 	 * about this case, though, because we wrote that file ourselves, so we
 	 * are pretty certain that it is syntactically correct.
 	 */
-	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
+	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), opts) < 0)
 		return error(_("Malformed options sheet: %s"),
 			git_path_opts_file());
 	return 0;
@@ -1054,7 +1054,7 @@ static int sequencer_continue(struct replay_opts *opts)
 
 	if (!file_exists(git_path_todo_file()))
 		return continue_single_pick();
-	if (read_populate_opts(&opts) ||
+	if (read_populate_opts(opts) ||
 			read_populate_todo(&todo_list, opts))
 		return -1;
 
-- 
2.10.0.windows.1.325.ge6089c1


