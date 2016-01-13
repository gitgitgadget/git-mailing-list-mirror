From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/3] remote: handle the config setting
 branch.*.rebase=interactive
Date: Wed, 13 Jan 2016 13:17:19 +0100 (CET)
Message-ID: <4e9ef3bba31f6d1d2327684c859a10678af9b1b5.1452687410.git.johannes.schindelin@gmx.de>
References: <cover.1452668201.git.johannes.schindelin@gmx.de> <cover.1452687410.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 13:17:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJKMr-00021l-4k
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 13:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbcAMMRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 07:17:32 -0500
Received: from mout.gmx.net ([212.227.15.15]:57260 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855AbcAMMR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 07:17:29 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Ld0jY-1Zt6Mh3A2K-00iBoe; Wed, 13 Jan 2016 13:17:19
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452687410.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Gk7C6KJsjMga5LkH+m2wzDPMxPyxk2dHTlIYDL2PJmQ1LUL1OOk
 RtMtY7nuQOt+7jEfQYYSXhatHEoYiM/MtQ3IfHdWG4anbAizeW+gVnAey0o1HUuJSm4V3Ce
 SNLViMBsE8n1Ie3jyZs6nw7HjXtE1qHEH0SS/4UilS8oywvQ9AkvAegiETgins/ctHo9lJX
 5e8lL2+9TzLWP/1/Fe8pA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/kn1wveY4ww=:HE9q4bKgFrwSDD1bRVMDZM
 fhXCYyuay1SSnSkIp8F34u9DnY+eHBv50CJ14qB0/ad3Y5Az6iLUCqjUomAjFu93UB7v9erSF
 vjw1A7pFUfqZa22fJqmVN0u0iFKup0KwCYG4UojwKDdQlF/aTxkat1haGnNR440CKHR+OOGIu
 7/NzulsT2Kd1CHLFE43s0Ot2qE/q/mb9hmsc6gu4cJNoq3S5gnZVQH9DfSa2kUtT/EXA3Engv
 JkBkQLPw2q+1aPg/igbaR/9cSS2jN7yrx0CwLrQkYceyGcaBJkeZKwC2FpqWFD01OkcVMg+an
 zrvlhwFH+eCAQve7ngnmCo6IpnkJNTjy6QRPnnPQ0DF0y7J6eKOimRaBGEd8IUKF8YjC/Uyb2
 NnGmjQU6yO8SMmSKPMXz4h23DLZe9+/t8HfNG/wbZWpkhGNFN7m6RIzEtm3xWGE5MYqzHGl/L
 ovi/m/dWlg7Q1dLaOX7UQSjPZDnUqgWUHaJeFErASbuqPjEMkYE2ZiCypC95AOnyP3Qbnw8uD
 CN6QymVvW/MSUp8ge+pkim+RduUrfbJOmyUNCFxRfpz0A2YimQNi6qUZ0YmXerJ+78Od+oEFt
 PD9plJg6yltgS+Abv7RN4QpvoPwu2x/2igDKa/3ipBuJmUioFg+E2HUJCK+FDPc79KIGh8+Kq
 jUwiHHMODWaTxGMdocbAS1ub/QA7vvp2ktic5HDYXksQvqW9w3x68OLVY+0aUd3d7T6buJJoH
 MoXat9Bt0/ubjlIWc8UsVbwTpXF4EKis01IzwGpHLbhK0bGrsv6ksJzAWM1TNaOTzrQUW1zc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283906>

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
