Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0437F2023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbcGELXq (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:23:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:50089 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755089AbcGELXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:23:33 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MeMOx-1awWLL3jRv-00QCZ8; Tue, 05 Jul 2016 13:23:17
 +0200
Date:	Tue, 5 Jul 2016 13:23:16 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 03/17] Avoid translating bug messages
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <dec17f8412357d5c99cd29f6cc2bd4fefa2971de.1467717729.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AX3+YOgJu0K3jJqu3YtpdVYC65WguXi07EUyNU20Q98AsFumqBe
 LLbWOUKIzpOHukCGO7dooWd4OzfVs+S/8AvDEsIHTYtvmO+vi1Jj9GVBZEdyV+YOZUmy6lH
 ldus2v2+Buq6AB57apYweZKILz7aVBGcoMA1OE7b91UjoL7qkQY7I0bkBi+tbEe237UZ4f/
 cDuSYSXo0t3gzEgjrpA0A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:UCx3ZB32IEw=:7BUBWEO0cEUsYIk1WMKxGw
 J3aeKvh8LGcEzeBNXaB3oiY4J/HInCVV6OsaXOPahDJTxFu1d6fVl1zuQQdeNo6rEQVJoVjbp
 fHLJt97EroiBc1Ivn0laC2MV0Z/f9A06MBtm6YMhwJrtyP2pY0eM9sirX+AMoUv17FOB0s9jV
 wgH1rV9IYHYJ8mHNLOsw3q7/WR6K3rPq4l+64Fv3DCTTMbJ23Ssa4KqnfQKdTPe4pujkthlnt
 //uaNyGmf6gbkeRWGXNjtLPQl7C71YM6tRUpy+aUzt2O6W4Sm8FK4dhv7nymn5A8GdAaoHGOa
 Im8zUVhd/32mDewZRSufi5hOEASi9Cfg0dojb5IOMJsPLSAu98TWhyLrZbz84n7LEgwlqk7ZW
 g5+8II6JoTkcDF9W2d0js7imw8eG4saW0hZoBLfyS4kjTdcRoS2+4h9UOTQUFU/em1vFSpRTc
 o/EQqsL0DYxQYs4N3gs4ET9Jo9V7WieV9qKcCEpqjHNVpaAxNJw0MeezxWUWHFk45hOm8aX41
 02PXtHGv9B7HLe/q+Yc8k9/e2N2F+Vh3qIZy5CYU3CZMFfba6WvpbofYgQlXu7q30LqsiKgD9
 Mdnpg8fr32w1nj9R7AcnBFqqYpYtsDt0G2adX03OkmLo0vbAdGyA9StReNlGo5UQNvt5hDHOe
 r/IKb3wS7vpibUfXAsKNZHwZbRJk4HbXWotxv0qB+QadDfs4Xc7pjTsZZTiEjHzodnbluVRx6
 1UZOMAyC7IC5KnNHw5w6oJ9ycSQtupAzAFA/erx9uJ3oyIp94Sg2eYdeVR2Xwgqx5apzwIDUq
 CPAgaVy
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
 wt-status.c       | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9849439..e51f8fc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -956,7 +956,7 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			if (!sha_eq(a->sha1, b->sha1))
 				result.clean = 0;
 		} else
-			die(_("BUG: unsupported object type in the tree"));
+			die("BUG: unsupported object type in the tree");
 	}
 
 	return result;
@@ -1794,7 +1794,7 @@ static int process_entry(struct merge_options *o,
 		 */
 		remove_file(o, 1, path, !a_mode);
 	} else
-		die(_("BUG: fatal merge failure, shouldn't happen."));
+		die("BUG: fatal merge failure, shouldn't happen.");
 
 	return clean_merge;
 }
@@ -1852,7 +1852,7 @@ int merge_trees(struct merge_options *o,
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
-				die(_("BUG: unprocessed path??? %s"),
+				die("BUG: unprocessed path??? %s",
 				    entries->items[i].string);
 		}
 
diff --git a/wt-status.c b/wt-status.c
index 311ae7c..75c1162 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -263,7 +263,7 @@ static const char *wt_status_unmerged_status_string(int stagemask)
 	case 7:
 		return _("both modified:");
 	default:
-		die(_("BUG: unhandled unmerged status %x"), stagemask);
+		die("BUG: unhandled unmerged status %x", stagemask);
 	}
 }
 
@@ -388,7 +388,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	what = wt_status_diff_status_string(status);
 	if (!what)
-		die(_("BUG: unhandled diff status %c"), status);
+		die("BUG: unhandled diff status %c", status);
 	len = label_width - utf8_strwidth(what);
 	assert(len >= 0);
 	if (status == DIFF_STATUS_COPIED || status == DIFF_STATUS_RENAMED)
-- 
2.9.0.280.g32e2a70


