Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30DD81F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbcIIOie (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:38:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:57431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752850AbcIIOib (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:38:31 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MDn8s-1bpZHX16wY-00H3qG; Fri, 09 Sep 2016 16:38:21
 +0200
Date:   Fri, 9 Sep 2016 16:38:20 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 17/17] sequencer: ensure to release the lock when we could
 not read the index
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <4c7876d88eac80d9cf05847477d4d468a7c01acc.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PjQ534GvY3UL07KDLrT4wYMPsTUfvkapkVoyW4flSRxVVEhiqsX
 sECOXW2fGo+kpirf70dHQYS7DbaAABhIsOkVU4VhLlmB5a4voCCkw9eux1tAWSkscKcdxxS
 F5H9z3CMPdvJ4qk63lUpodug1byEFC4ZxcI6dEH/63E26EWL0D0SHU6b/atX6rroEmlaoUa
 I1hWH7dC5+71YMG4v9c9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nbisFnsAAz4=:UlAw9nRR4THK9muZCEgS5n
 Tktw25XeIURwDwHKlcWEUDl2l0hKG3aCkJopfonTyZVuGHlYY29hIK1MSjAgny6O/lib4BqJR
 cd3B/5b6XIgtkVgRnkHkLPAxs9JLP+uzjIpES3RZt0pPAjM2xItjyrZNkoHdqHgCNWhrczBfC
 LYpsROCmif0Puqcc7g1cqj1UwC+fjldNkDVU96E7ff7k3UEOvSXdPzKd64UYUH1qojGvXHN5Q
 IoAib8cQZvSTz72JqRYGd8ereyhXF+YV3V4VO1+4GJOqaWmdk0i+hi88sA7kKgsv3V/dBMFWN
 gG+PENFsO0j5ljsB6byhtm9ojJsjbpjql3SzvvV6DePHc8V1F+jveSz1B1NjyZFh8X8TMyzIS
 p8xw/Zdqx7e6I4loIzcKo2X/Jirim6MhKylFBjFOjYncDkFza/TJyuReNekN69K5B6rP2vcSG
 LmheZSP9WTDlPHdkEP16Q6qym21M2lLc/2IeKtlERFlzvdBnZYEqfNesMsIuZaCijZByX9iab
 mC9NZb39KY3gydpilysLZssb6F40B1gGQ7scbWXyE/EtjyuHFmD6ansd2aVUZm1yz1tbR57Zk
 9FzR2lHuuAxG962PsxMvUIrNFpo8V6tUrmhtjlAS/aomoBodE4e9C8Kvrwh0hfJAAAQaHZVwQ
 ga6tpafVm5ntOA9xNQGuys39Y/HdVdCPFzfMvkLSXiMA6MBMCNM5MyOfLbLKt1Iav7+OKIZPq
 1Zepi7FXvyz14EkmjtB5/F2PYdxFt0P3NztuHmJ22hL+jC5vBpWhHAWOgFXakHgxVFtQqpF+A
 nvs+tj+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future caller of read_and_refresh_cache() may want to do more than just
print some helpful advice in case of failure.

Suggested by Junio Hamano.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d92a632..eec8a60 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -644,14 +644,18 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 {
 	static struct lock_file index_lock;
 	int index_fd = hold_locked_index(&index_lock, 0);
-	if (read_index_preload(&the_index, NULL) < 0)
+	if (read_index_preload(&the_index, NULL) < 0) {
+		rollback_lock_file(&index_lock);
 		return error(_("git %s: failed to read the index"),
 			action_name(opts));
+	}
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (the_index.cache_changed && index_fd >= 0) {
-		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
+		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK)) {
+			rollback_lock_file(&index_lock);
 			return error(_("git %s: failed to refresh the index"),
 				action_name(opts));
+		}
 	}
 	rollback_lock_file(&index_lock);
 	return 0;
-- 
2.10.0.windows.1.10.g803177d
