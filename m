From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/3] remote: handle the config setting
 branch.*.rebase=interactive
Date: Wed, 13 Jan 2016 07:57:55 +0100 (CET)
Message-ID: <dc6d942106bdaf373fe232313523ed36567601b1.1452668201.git.johannes.schindelin@gmx.de>
References: <cover.1452612112.git.johannes.schindelin@gmx.de> <cover.1452668201.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:58:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJFNp-00073J-Dh
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 07:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbcAMG6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 01:58:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:50740 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbcAMG57 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 01:57:59 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lj61K-1ZlZK13v38-00dDLW; Wed, 13 Jan 2016 07:57:56
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452668201.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:BLTeWMpBvPEVJYCvJpYgoPgsxwtw2MVvA8hYCoNyDcwCmy3UyJb
 qmMJH9hy1oE4hHL40itB+3hWXJnUSPSrcsDty5IT3vkIhFJ85MDkPKuEy1/8KxEs+l9RbIT
 b9mK6zqJGddoASnS9Qt5SP9GDMj4ZVW6uvq1Kp/eueCe1NbXO+cRJSUcpRRiGE84h5kdbWL
 TGOcV3W/ei4C7NyFAkBbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q89I6dgLYbY=:AF19dbJDilaIolyAEo+89j
 h8ffyzLeyUcPRKodMH7tiBdcwHzbQg/lfsAJufCnP8nHKoZIKPATULvcW075egVltvOk/C5Hs
 4a7quynW+s/m2UxQnlKBVoDhUxcD9At2RcfIs8kJ4w2WGKl8gaViy4rXZZxJHfyTBImi+lp5R
 50vx7BkYxPuMKpGAhDMqHSHMVpDCUK3KGcie1ztIbOTaYc54+zN/kpX5u8WW5gJVUNOE9EGpB
 mINbfPn6iI0NWOZN0wpVPuLmgnBynWOPudEeQBBrJ7naEE12X7vdL1aFbyZlvkjVqsXp7rr8F
 p5A9ziV39V/FxKFp0bT+gWLsy3EBd2AJQBCzV24MfWC0MqVRefp0NEXCq70OBX/zAx55nXrVU
 VkHh3R4rC3eQs7D+r7ewo1PlX1mbm04rQ2MD4kqs1a7M23dM9ppge7DYNLSrrmmNSxAx6jxRg
 6Ryrok6My3XT+3hq3wFWNHUxcuZFEV7nVqqZI334AlfuX3THTyv2fb9WYKVX4W9CUsO5cn7F7
 6vONs5OZHlIjlBuTXChu6xvG28xAV1Xuq8/tZvMd0EC+T8/CflLJnfft4+GZLfv1fNPkMUktf
 OJQNeQlZnQpEBGbWbgJZrU+/N2I5rpdGvRgXpDSQykTZzRJhX/yl5z/VPXrr/lTYmU9lTIE2m
 tWx/Z/4i9o6HPeON9bHZM6sQhuy732jmQ8Q465cMWbVygvMmGL5EFOJeB/jsvm/53SL1iyJzc
 n9PRs5htERFWOpcUfwN/GyjRAhbT7PYU+EogkyiW9pr+Ch33aVHeOfynLE+sqenb7yVxu4uh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283887>

The config variable branch.<branchname>.rebase is not only used by `git
pull`, but also by `git remote` when showing details about a remote.
Therefore, it needs to be taught to accept the newly-introduced
`interactive` value of said variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/remote.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 6694cf2..2b2ff9b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -251,7 +251,7 @@ static int add(int argc, const char **argv)
 struct branch_info {
 	char *remote_name;
 	struct string_list merge;
-	int rebase;
+	enum { NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE } rebase;
 };
 
 static struct string_list branch_list;
@@ -311,7 +311,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			if (v >= 0)
 				info->rebase = v;
 			else if (!strcmp(value, "preserve"))
-				info->rebase = 1;
+				info->rebase = NORMAL_REBASE;
+			else if (!strcmp(value, "interactive"))
+				info->rebase = INTERACTIVE_REBASE;
 		}
 	}
 	return 0;
@@ -980,7 +982,9 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 
 	printf("    %-*s ", show_info->width, item->string);
 	if (branch_info->rebase) {
-		printf_ln(_("rebases onto remote %s"), merge->items[0].string);
+		printf_ln(_(branch_info->rebase == INTERACTIVE_REBASE ?
+			"rebases interactively onto remote %s" :
+			"rebases onto remote %s"), merge->items[0].string);
 		return 0;
 	} else if (show_info->any_rebase) {
 		printf_ln(_(" merges with remote %s"), merge->items[0].string);
-- 
2.6.3.windows.1.300.g1c25e49
