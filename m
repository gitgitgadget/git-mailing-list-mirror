From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] show-branch: use argv_array for default arguments
Date: Sat, 31 Oct 2015 20:06:45 +0100
Message-ID: <56351145.1060100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 20:12:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsbZJ-000441-8g
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 20:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbbJaTL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 15:11:56 -0400
Received: from mout.web.de ([212.227.15.3]:65452 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbbJaTLz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 15:11:55 -0400
Received: from [192.168.178.36] ([79.253.163.201]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Lj88M-1aTbWz0laQ-00dJiv; Sat, 31 Oct 2015 20:06:47
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
X-Provags-ID: V03:K0:JRogaqKBWnjzm3d0tTLsxEphvqL6IMs414zJ4Wr+gocpv6lC58F
 02PvXecH/c32/kboh70p2MJYHdG2ZUFmg/4FgQ4kZ00MRJPfp9UzPLKDQg+luWOjjOx/V9J
 iLmSiqWr7TkDlY9OrtQTRQ3fSxGDHI2T6mtEoz6GT35DlmOEMTJ69Cgh4MXptnWOizTYOeF
 80zZwRqrU9mqOIAdLKiFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fe6AU6tUcIw=:9kL4Ivk4ZjdSFksN89Y3Uu
 wcQOzD5lxiOUlDtT6jjx3Zn8NRGBrjBMQPuzcXZtQco/66tYat/noVaNoctsyAeXTAI9PQKUx
 DLXEZHOmId69DaZQyaXZkA6uzBBbIk4XNnAkjw/s9EPHmOqaK5WUMqZhzKJWN66OV8e/co0Vl
 Zye4vOkB8sNdMjtwhxzwb01vY0mYG5TluryptOcdHjr28q1TQnqDjH78GLJ0TSYwoFeOdXJ6d
 NY7DQioXmrn4VBwdl8t8jL375Pjkg1ggXSHAeRTG2v5MJBKQAe2eF/bmpSIaU8wRy97n6PllP
 xyTzuun6cv+GT6PTjeXvD249wPSjtcCOn/f66BBB2pJPqAGyhGOA9C4ZlLid6xZgJEBbiL7EE
 +NjutEbAvhsUHLGn0SSrEbC0EqHwL02Tm2qLx8i3RFaca0tCQbNqEP9guExOkUCsQJmIezAPo
 KcBEseOsRBgl3Uf2aATiFrBZxCCoN5t+ah9o8RtJEE4oipjU64Jwhn8WidsODIR8KP95sKKuj
 eCouMzvq7XtBDSKDLYxWdO01OCnDbwgqLGYbblvBNS93q80nMj67W412a9uQ18kcdPcii9jGI
 Pop2kUchlnfG3RlW1El0WPYiHgvD+qFGDlTCctwl2Kwbi90T6kVvwsJ/Y+Kr3dM5qc152ra4c
 qag+uYxogHXOG2EvzF/WTWrcbq/V8Rra1LDxJgvV0OCReaCj8MBA/IYcTMOWsNutL53JUmPUa
 e92no5Q3HVMBXsTtcA9QtrXCt+rgkndkEu8Bql3rM87nR2laV6u+cWiXZnEye0yr61/q3lXW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280599>

Use argv_array instead of open-coding it.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/show-branch.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index ac5141d..e17744b 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -3,6 +3,7 @@
 #include "refs.h"
 #include "builtin.h"
 #include "color.h"
+#include "argv-array.h"
 #include "parse-options.h"
 
 static const char* show_branch_usage[] = {
@@ -16,9 +17,7 @@ static const char* show_branch_usage[] = {
 
 static int showbranch_use_color = -1;
 
-static int default_num;
-static int default_alloc;
-static const char **default_arg;
+static struct argv_array default_args = ARGV_ARRAY_INIT;
 
 #define UNINTERESTING	01
 
@@ -556,16 +555,9 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 		 * default_arg is now passed to parse_options(), so we need to
 		 * mimic the real argv a bit better.
 		 */
-		if (!default_num) {
-			default_alloc = 20;
-			default_arg = xcalloc(default_alloc, sizeof(*default_arg));
-			default_arg[default_num++] = "show-branch";
-		} else if (default_alloc <= default_num + 1) {
-			default_alloc = default_alloc * 3 / 2 + 20;
-			REALLOC_ARRAY(default_arg, default_alloc);
-		}
-		default_arg[default_num++] = xstrdup(value);
-		default_arg[default_num] = NULL;
+		if (!default_args.argc)
+			argv_array_push(&default_args, "show-branch");
+		argv_array_push(&default_args, value);
 		return 0;
 	}
 
@@ -685,9 +677,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	git_config(git_show_branch_config, NULL);
 
 	/* If nothing is specified, try the default first */
-	if (ac == 1 && default_num) {
-		ac = default_num;
-		av = default_arg;
+	if (ac == 1 && default_args.argc) {
+		ac = default_args.argc;
+		av = default_args.argv;
 	}
 
 	ac = parse_options(ac, av, prefix, builtin_show_branch_options,
-- 
2.6.2
