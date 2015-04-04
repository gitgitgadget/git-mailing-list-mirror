From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: [PATCH v2 2/5] log: honor log.merges= option
Date: Sat,  4 Apr 2015 03:21:58 +0200
Message-ID: <1428110521-31028-2-git-send-email-koosha@posteo.de>
References: <266077>
 <1428110521-31028-1-git-send-email-koosha@posteo.de>
Cc: sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 03:23:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeCnw-0008AK-BX
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 03:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbbDDBXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 21:23:04 -0400
Received: from mx02.posteo.de ([89.146.194.165]:60062 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134AbbDDBXD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 21:23:03 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id B9FA725AF528;
	Sat,  4 Apr 2015 03:23:00 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3lJgP035DXz5vN5;
	Sat,  4 Apr 2015 03:23:00 +0200 (CEST)
X-Mailer: git-send-email 2.3.3.263.g095251d.dirty
In-Reply-To: <1428110521-31028-1-git-send-email-koosha@posteo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266753>

From: Junio C Hamano <gitster@pobox.com>

[kk: wrote commit message]

Helped-by: Eris Sunshine <sunshine@sunshineco.com>
Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
---
 builtin/log.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index dd8f3fc..c7a7aad 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -36,6 +36,7 @@ static int decoration_given;
 static int use_mailmap_config;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
+static const char *log_merges;
 
 static const char * const builtin_log_usage[] = {
 	N_("git log [<options>] [<revision range>] [[--] <path>...]"),
@@ -386,6 +387,9 @@ static int git_log_config(const char *var, const char *value, void *cb)
 			decoration_style = 0; /* maybe warn? */
 		return 0;
 	}
+	if (!strcmp(var, "log.merges")) {
+		return git_config_string(&log_merges, var, value);
+	}
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
 		return 0;
@@ -628,6 +632,8 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
+	if (log_merges && parse_merges_opt(&rev, log_merges))
+		die("unknown config value for log.merges: %s", log_merges);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 	opt.revarg_opt = REVARG_COMMITTISH;
-- 
2.3.3.263.g095251d.dirty
