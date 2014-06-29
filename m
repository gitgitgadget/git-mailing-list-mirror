From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/2] wt-status: simplify building of summary limit argument
Date: Sun, 29 Jun 2014 22:55:44 +0200
Message-ID: <53B07D50.9050805@web.de>
References: <53B07B44.9000406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:56:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1M8r-0001vk-Lh
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 22:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbaF2U4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 16:56:00 -0400
Received: from mout.web.de ([212.227.17.11]:59346 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875AbaF2U4A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 16:56:00 -0400
Received: from [192.168.178.27] ([79.250.179.75]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MVLWc-1X9TTD2nJm-00Yea1; Sun, 29 Jun 2014 22:55:45
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B07B44.9000406@web.de>
X-Provags-ID: V03:K0:jJvlMqXh2Wv/KI0ciC0vhLSrLokIZ3YxDos9/CzEsmEodA6dayE
 Oi4jaeLxB0rX9Meh/mRsAHdJL93SQapzUpcHqG25q++QgiLSOobOlRUe3uADVXwACL5G7Z7
 rEg+Aco3J/3h96Cq0XMa6JtQl3CUQi5FjNgTnSVK8xXHAiZ+yDgY+hB08X+aF21o5GRe8Cf
 EPJvVMKIJhH6quecycZTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252649>

Use argv_array_pushf for building the number string for the option
--summary-limit directly instead of using an intermediate buffer.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 wt-status.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 2c0bff8..882cfe9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -734,7 +734,6 @@ static void wt_status_print_changed(struct wt_status *s)
 static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitted)
 {
 	struct child_process sm_summary;
-	char summary_limit[64];
 	struct argv_array env = ARGV_ARRAY_INIT;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct strbuf cmd_stdout = STRBUF_INIT;
@@ -742,7 +741,6 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	char *summary_content;
 	size_t len;
 
-	sprintf(summary_limit, "%d", s->submodule_summary);
 	argv_array_pushf(&env, "GIT_INDEX_FILE=%s", s->index_file);
 
 	argv_array_push(&argv, "submodule");
@@ -750,7 +748,7 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	argv_array_push(&argv, uncommitted ? "--files" : "--cached");
 	argv_array_push(&argv, "--for-status");
 	argv_array_push(&argv, "--summary-limit");
-	argv_array_push(&argv, summary_limit);
+	argv_array_pushf(&argv, "%d", s->submodule_summary);
 	if (!uncommitted)
 		argv_array_push(&argv, s->amend ? "HEAD^" : "HEAD");
 
-- 
2.0.0
