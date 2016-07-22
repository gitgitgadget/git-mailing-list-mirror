Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E55A20195
	for <e@80x24.org>; Fri, 22 Jul 2016 12:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbcGVMZQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:25:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:57935 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876AbcGVMZO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:25:14 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LiTF6-1aup7r0zls-00cf9L; Fri, 22 Jul 2016 14:25:03
 +0200
Date:	Fri, 22 Jul 2016 14:24:59 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 03/16] Avoid translating bug messages
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <20433a69119e46ee6816ef3028f939399c2e5cf9.1469187653.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fxNlKqj++bY6SEvehsgnA6MtlF68NBtygi298kgZ6tsttW18GPM
 e3O9ND2IvONeZyo9KPBXlRdXP0nKkipvQfgTDWb3jEHmn4TB9anFo/a7/IU3rfb53VH6rHp
 Wbdc/IukQc0doqN7ja2rL1jCqQ72JGiQ2GL21qJy/lYf+/7NjutGIDJ+xr6FAH0F19HkkaJ
 CC/7/3Db38P3VoVbFAhVA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:mmfFoBo96ZE=:24cIQj7XkbrfR8zzORNnwN
 brfYVgcsdMt7b8S8BNiPCCUh/QUaP1hpkFJ8DM/1H0sHDsHYLOzoXyKcFFa0m3mCteMYi/gjM
 W5qtWZj0qKPlnk2RNWHt57++Uf6rdVa4p3Zx912S+k/HakRARkOrKwBdPAP92AT5cd7oDGTjA
 KEoezJfrI/shx89Syp4HbObZKUSQfKKlxtQpyvt8GV3kiQ/U3O7Yjw8JeIYs/NpmfrW8zIbg7
 wv+DoOUyKO+r6/7AgB8u5fA2HCyhFsiu6B2IB49o7E6tQxovvH2atCOCifJZQT+1gFVj9oJXh
 ea4286Ugr5VxF+8NHvFjlV9BeE17uT6B8DysYRuWdPvffSVrzOxZyaq3cKOMR5NFFx1w+pXBy
 IJHwv1xb9niORYtQH29U0GwoDfeJSyKuRNUENnF1nibXLEZ2G90pivtWM6T8PcBs1a7LxFFoo
 Zwg286KxxFVOdwdG/iK/9UgWvqSCIlXbfszYxyzjDLV9gmBsKdBu0B8f5kN+5yflgLI+OH/iq
 xa3Cxg59lq4ymGLemxxXLnyg2Dzw2uhb8kixuZeW/uHxRlPZa6fQOj74nEzA2GRgmV2cMXpqP
 23QzOX6e4ZrSPokRwHVdvVwd3NXTf5xs84jnXK/KWoHg4wSzM6naDDNtvlHL59Nn2DXEQ7L7d
 LG+KCAVrFRDpnV/C1XX4eRDzl/MrsYnXPK7r7dh0OlbV77ODtv2dUIY8ogMweBlteBqwB2LMp
 QPCyN9sYCp/3qFnzlkGXrAn17IVoy5BATYMkhQABSs9jyEkNQu2lFpOLLy36yKwKPgCBll/t+
 borP4Qc
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

While working on the patch series that avoids die()ing in recursive
merges, the issue came up that bug reports (i.e. die("BUG: ...")
constructs) should never be translated, as the target audience is the
Git developer community, not necessarily the current user, and hence
a translated message would make it *harder* to address the problem.

So let's stop translating the obvious ones. As it is really, really
outside the purview of this patch series to see whether there are more
die() statements that report bugs and are currently translated, that
task is left for another day and patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7400034..e0d5a57 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -958,7 +958,7 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			if (!oid_eq(&a->oid, &b->oid))
 				result.clean = 0;
 		} else
-			die(_("BUG: unsupported object type in the tree"));
+			die("BUG: unsupported object type in the tree");
 	}
 
 	return result;
@@ -1802,7 +1802,7 @@ static int process_entry(struct merge_options *o,
 		 */
 		remove_file(o, 1, path, !a_mode);
 	} else
-		die(_("BUG: fatal merge failure, shouldn't happen."));
+		die("BUG: fatal merge failure, shouldn't happen.");
 
 	return clean_merge;
 }
@@ -1860,7 +1860,7 @@ int merge_trees(struct merge_options *o,
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
-				die(_("BUG: unprocessed path??? %s"),
+				die("BUG: unprocessed path??? %s",
 				    entries->items[i].string);
 		}
 
-- 
2.9.0.281.g286a8d9


