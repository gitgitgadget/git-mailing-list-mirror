Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 283B92023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909AbcGELYM (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:49248 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932899AbcGELX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:23:58 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lip2P-1bs4iL3Lgb-00d2tl; Tue, 05 Jul 2016 13:23:44
 +0200
Date:	Tue, 5 Jul 2016 13:23:42 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 08/17] merge-recursive: allow write_tree_from_memory() to
 error out
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <0e54b56c7cd04e9f58ebf886c4f3d536f989a36c.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ij5uQNGn5pFCtg1uz9LHimEZQs+KJO0ONfismF9HgXCDAziBkF8
 LJJuTknm8t3AlLIb8tH6NoaEjTBPnpyBDoc6NxxZod2bJretAplLMNCJ2WL5Tz7zdaRpzWj
 KIDT+3jWczZO0ZTRMQsSNm8PY4B5Vo6h1f593+Zkle3StqAFFwXU908FOWlawKWYQB0t5O5
 EXcEGPNqXqlAM/5qryUow==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:bqbpJ/oGBGs=:FfEDfuj98snUuSiuw2PxR6
 6qYtfrwmGDb/h9h8oDb9zFAbkpIqsVj49mPhQLvJ8eGJ4RSxZTilHyhCviuqhvz4f+S2Mv5Qo
 GSuYjZgfg9mpmz0olgnuFb7aqKvROZ5n8XupKBfK6Za+oV4BgoeKWGYMhokAC8tJtv1nOTjRi
 qsWf0Ih0cujuzsnOhkqKoh/Cj+yk4bSX/VPgpgfRzrfeUB+KvEL3kj7++DubOOmk9+M6UI6uE
 yZtdqSK3ptXAl1skHzwI0BWbEWNITSf+1sYr8Yx0kJzEAlt8lXUe1rK1Y9oU1n0bfLpXmYeDd
 G1TdKaEHjqHyAMgkCDRjFqpg//aFGMpdA+XcKXx9YLl7bC7o4LZfRMbeJNoBzrag8eHLgKsEe
 2tYqeZMQh3mC763jVdIskbw7Y9jCWPGYxBm2lQ0GzxSDAI/NkUDc1db1LqW9OC4L343mejwXd
 vN8QmopFHytlwVtEtuFOAZe4odRCKueoWQ3VTCUvElscIr8lkiKkaNRcWxxeju3+eq1WI4KQy
 ihSDrpAmtWn6/9PeRadZYObpma0CkkMd8U1Ofd3sVWNomIjyHJvzBWCpbj7r6HAra4nXcoT1Q
 ekMdIEeoBTk0wbn+vKr3ZSxwUUPiOxLQeYDnbdCmJ0cwnagMLcP11wQRCvNzS81zPoTON8/mQ
 CuRnV+5wq3hILvsOSTDTwDjh/6qe687XijiUJv2f9V3+CTdG0eXNTdACMevs+Uc4TDTf/4q5R
 6yYatH/6w0KnET5ZWC+D6JSk+oOkBbgg70xBglB+HUh29qJfy54AZQ+w8egJz7Y+IPHXVAz6g
 H57gMFz
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It is possible that a tree cannot be written (think: disk full). We
will want to give the caller a chance to clean up instead of letting
the program die() in such a case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3e3667f..99f4202 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1873,8 +1873,8 @@ int merge_trees(struct merge_options *o,
 	else
 		clean = 1;
 
-	if (o->call_depth)
-		*result = write_tree_from_memory(o);
+	if (o->call_depth && !(*result = write_tree_from_memory(o)))
+		return -1;
 
 	return clean;
 }
-- 
2.9.0.280.g32e2a70


