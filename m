Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BFC220C11
	for <e@80x24.org>; Tue, 28 Nov 2017 03:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbdK1DBX (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 22:01:23 -0500
Received: from avasout01.plus.net ([84.93.230.227]:36799 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753276AbdK1DBW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 22:01:22 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id JW99eUQ3rtcSrJW9AekiEm; Tue, 28 Nov 2017 03:01:20 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=eflNR/MH c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8 a=UIkaN_qTPh2NxLfjCwMA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] repository: fix a sparse 'using integer as NULL pointer'
 warning
Message-ID: <69fdc850-da71-6df3-5299-eb67ef5d74df@ramsayjones.plus.com>
Date:   Tue, 28 Nov 2017 03:01:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBhcUIVgMFmU4BZO83dt6pwLa1g4nI/UvoBKXIF1edYJMK/YuxF9WSv5zRf1K0IgHwnPx1ZH6VQDpVmymL2mpivjp9BdAlVNljO4a7O33zR8ajoUg7zQ
 /L6D3nNX4MqqP1T2CQ5xjSjgR0M9ECUfTDwsJKaFZipYtmcmDBUjfIbOzOEfIGkFdNE0gX4R0b+OjA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit 78a6766802 ("Integrate hash algorithm support with repo setup",
2017-11-12) added a 'const struct git_hash_algo *hash_algo' field to the
repository structure, without modifying the initializer of the 'the_repo'
variable. This does not actually introduce a bug, since the '0' initializer
for the 'ignore_env:1' bit-field is interpreted as a NULL pointer (hence
the warning), and the final field (now with no initializer) receives a
default '0'.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

I don't recall Brian doing a re-roll of the 'bc/hash-algo' branch[1], but
now that it has been merged into the 'next' branch, sparse is barking on
that branch too. This patch (slightly different to the last one) applies
on top of 'next'.

ATB,
Ramsay Jones

[1] https://public-inbox.org/git/%3C91150cfc-3271-16b0-33d3-9a4e149dc9fe@ramsayjones.plus.com%3E/

 repository.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index c6ceb9f9e..998413b8b 100644
--- a/repository.c
+++ b/repository.c
@@ -5,7 +5,7 @@
 
 /* The main repository */
 static struct repository the_repo = {
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, 0, 0
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0
 };
 struct repository *the_repository = &the_repo;
 
-- 
2.15.0
