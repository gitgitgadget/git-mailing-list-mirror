From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/3] Teach 'git remote' that the config var branch.*.rebase
 can be 'interactive'
Date: Tue, 12 Jan 2016 16:22:16 +0100 (CET)
Message-ID: <8c98523f8a3f2c6f2f3db1e4572e05c28f94688d.1452612112.git.johannes.schindelin@gmx.de>
References: <cover.1452612112.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 16:22:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ0mE-0000R9-Uw
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 16:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762744AbcALPWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 10:22:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:62882 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762707AbcALPWY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 10:22:24 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M4GRv-1a1tSk2NpT-00rrl3; Tue, 12 Jan 2016 16:22:17
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452612112.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Mea1qS3HU/A1dQtIOqfnpu9+sBCWkiKah1MmZ7rsxXj0UuynUJo
 f+ohgjWhnc03KtoiUD3c6JUj3EP/ElDszsYi0SrodileCAr8s5vzBPI26zNJJB2WxRXL9p5
 M42gmjmc7ct5WIwLIvc9K565vmsZmIufTPfHV1MjLC3fuYM5zJgGVNzFvTmULJKemi/tnz7
 ORNOybg6p95jgw2iznbpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:peBTHzUcxTw=:oF1N0ogb1KN2vrXhW5Z9Qd
 iqUHL8V4/ww+ngHISWrKHeeLTAwsYP9k7cSqoUuI71TpkLR7tDXUIT79np5izGCmY7bWG5SuH
 cHCmxCqCVXS5vxLM9oqfwR0au2nOopGX+w2kJElfpJwXjZG1u1dOQoGRYZNqXM6pYvRA4V/Cb
 g0KsIcZp0XpjC5jUOJq4jDdxywxYA7nm9OHIMdWCbX+/f1qNlX41Vhof7xQleys4XKS5S5sZw
 mudlEuRwk2hX1KOC4qKQbdtvBci9Dz9T9GL9bvauKaSBgxIPLdYKTkwfvCYT1z/Q2/9FdMrDS
 W+70m1eGrV1a4PMEW0K8KPmTUrWgBiERrSouaTzEcCh7UfaIsKVBoCAxZNCCvma6XYKgUE7zp
 gXLVkYTMeJsZVI8cDCTl20lx7brRIhB2l3aF5f4t4Koff1M/AExfXLvf3zMjWqQ6ZrAgER8Aq
 uhaZ3CZqAQk/FdFy/Ig26o1yXqRgySaAcavISuqEJtYGGzezXi6Sm17Ko7gr6I8Ga33RBG3Dr
 do/fbyRT8dJABdbh1hseyxwvnVjrI6e7J6NEgudZ3rTnveBrBPoxQHfThLU/HjJqCq2rkrIc9
 b0riIRDEdmTc66+Aqma0JBVZoqhAg+9XehSaTss1CWUBXSp7KHPRPk/ETFfc03nqtjPIvbm4L
 VR0KD+75JNI09XiLO7wSkgCzF4YgpxfqCbiubCjG6CqygvIuwki4qLxiGF/lv9OyFgNmhu75g
 PjLQPgW0jTxb7RCDeU87HIdeV9RRLX+Z6xF1CJGTonVkCNtCwz3IekJVmMI0TQb9UdvisJ/h 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283818>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/remote.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 6694cf2..0af8300 100644
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
@@ -312,6 +312,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				info->rebase = v;
 			else if (!strcmp(value, "preserve"))
 				info->rebase = 1;
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
