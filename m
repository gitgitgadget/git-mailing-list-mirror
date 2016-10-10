Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D4320989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbcJJRd5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:33:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:65475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752475AbcJJRd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:33:56 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MhiPD-1bWlsJ3T3z-00MuKz; Mon, 10 Oct 2016 19:26:24
 +0200
Date:   Mon, 10 Oct 2016 19:26:23 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 21/25] sequencer: remove overzealous assumption in rebase
 -i mode
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <15032a93b02d8a0f5a0c48d79b933f4e1a6c9ee1.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eLy6HBkuPvNN/kqG1FvK6ReG8piNu7U7//0yxHfr0CumzTJ5UEM
 1K7HY5eYkVci7slNyZ/XL29bVuludOCmrn9RLkKipfbUk+gGIcyfQHmz0/iMX2zcZjvHry2
 QfRb1QJyQPhkApmEEShH5MlBU2sQLgM1ICFYedMyTc2aLQbKcM6lc9kcr87prxEozIBI9qq
 um9YLoOqyYlyQDsJwdBMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e7Yi3S7LV5U=:99LXg0++XM7CBCPTMKnh6C
 lUljddMPsrUgQltYyCffJF8IAIi/G08RSDx1h28A8DjOa5LzpUxlgmP4D9RD2Su8rZsI9KzPf
 87jeGMFrYZqrAn9eV3Wu3X7xR8WPubaNdfipOnZvdj/WBeiVm6wmcF7BgVh0Pt3GJ7ct3lhon
 y50/bYOOrN1YpKMOYyPok3yjASBRKgh9Pspi3irdzT8Y9Bo3L/HjvO61Uvv65QdnXPYfbaCX4
 zn+2V/FyQThRhiT0ZGrPESEgCY8h4J0SrYsbuIjRMeBPNnx7zfDpAotgeQ9wIVDuOjtvYHvYJ
 QocqRJNYRJdkjDFQMuVo0tQfpsp3F20IKWcFYCGtVp8zWu+iWAX/WQrSIyU8HiT7eRahSdItW
 cXl0Ff4tfGPquIE9X+pWFGLPGMi8GvXtPgtnm0WRcp6w+qu2MeSROXg+6IfVBs7RRwwv+giVB
 qwCazcMZ1OHU2epCQcq1uQBEEFZjxaOaZbncGKiE1VkC1SOcg2x28syNquS7PtgSQT3lfsvdH
 asgnYsXyMgdwIZcY2+0YT0Q57DK7rtHVAtRbu7+zgNg1zrz7Aps4Z/gO/2bDV6OW05Q7d8KWK
 u+yVXQDbDjrqO89ZT0I16BulKvElm7qJg064Ja/6AszREplHOAl0lTK3HjNUvshSEEHZjMlyL
 dvM1qEmI6Qk382LbSCmKT/QX7kyL6I6aZDQJZCKkDw/PbMXqO3Jd0iCUBhsnWA3wFa/Ig4juf
 z94hLBPq0YJHBmQCUDhULhZ+M/Qd8C2SD5fL7rmixBOW7IXu5ARgnujtbk5XIZ18xp31SlLJB
 nwZKlWy
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
index 5cca8d8..ffce095 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -971,7 +971,10 @@ static int read_populate_todo(struct todo_list *todo_list,
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
@@ -985,8 +988,6 @@ static int read_populate_todo(struct todo_list *todo_list,
 				return error(_("Cannot revert during a cherry-pick."));
 	}
 
-	if (res)
-		return error(_("Unusable instruction sheet: %s"), todo_file);
 	return 0;
 }
 
-- 
2.10.0.windows.1.325.ge6089c1


