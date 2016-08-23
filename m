Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90ED32018E
	for <e@80x24.org>; Tue, 23 Aug 2016 16:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753917AbcHWQHr (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:07:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:50081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752212AbcHWQHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:07:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lzc5y-1b801p0kwk-014jxY; Tue, 23 Aug 2016 18:06:43
 +0200
Date:   Tue, 23 Aug 2016 18:06:41 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/15] sequencer: lib'ify do_recursive_merge()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <e00df1449af0d8c55000a93c734d8a241b1cb5f0.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KeAq0Yj/nXtrEfu9Y7dgkCnB9SSzATlkYMwiPrL8sDsVSQFGTOH
 0G97fnUsEnl06flivEVp5DFqWQpwuGJYV2Urf+MyS7xwKZ8NXHNMC5B/4ObQ1h7YqEkT9v/
 4M817+TDmpMXrs7PIGmMREK0nfbJjo3ptiZRFYZOhIggQAAu5CQMxAzV11nvsrxGiDQPhv+
 VTADshcgM9KpNLzr03mQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cwXHoCloAzQ=:FTO90dua9LFj7XyVMZJrcu
 UCrSSaBcqIuWoX1FdynLAF0u0Yp5lHJkGv/YLEgpB7dQ62zWuIOLBu2aqio2s3/ytgnok216q
 mJex30oRJ5/guO9OtEAEQlQAl1XbCQC5g5NmAoUnExiJr3KHVdtBWoYTzI4d+cwWtlxABwP11
 qWonEq0Oio8YJ4++Zca9FWDNvAbn5mrgdWILC9ZX9G8hwjPJstCNBqwz6QvC8p/3DCBo50BrD
 sBA0Tl4rYAO2AUhI/VirZlALzqdPFsx81esyMeN1eqQa+0sJXHih52a7PWtSSzcItndP7HiSM
 tFUcdaSn0bNb/ipJPo0IEkwsHwCBDheJ0Zu6AocoFSw+p9Wfvk25L5YnGE4jeKGXo1J0qoIPJ
 bHeV/CQCQzlo0bVIkXY0u8w394zfYxxO4uzVmJLUulgI9AOC2MvlFvGS8j5++UeHAix9gIfMG
 7H6gxq0i9S5Rb59zpr+uxWgkAb4NW8vLpeH7m5fyKtyjEUorjdwtVElLe4ayG0oSeGIr/1g6G
 hQOrbPhB/+HDK716KOe3Es86tpjfk4ezVqbZoifLe0U1+HWeWG45pCjiTxYbN+puUYPNdHYjG
 oVpFtaLBEOy2plgAnhmtQI1DNbaoLiEBpgr0fddVFFflW1XneEBaOFcSWAhZUFDA62kDjf/1Z
 WH1u5UoOC3ZDHaMsnIvC8MOevGdAyCQ/CUuIUaWr2Y9hSUSHvV3wDT6XDw66p/QqdQnPqDWqT
 socjmw772DBL5MT7IrFOyTvpJ3Lzmjyu4QMTcmww8GErn72J6HRq2aRofCpp83NTfK3h20bhB
 exNIbyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index c75296c..0c8c955 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -303,7 +303,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-		die(_("%s: Unable to write new index file"), action_name(opts));
+		return error(_("%s: Unable to write new index file"),
+			action_name(opts));
 	rollback_lock_file(&index_lock);
 
 	if (opts->signoff)
-- 
2.10.0.rc1.99.gcd66998


