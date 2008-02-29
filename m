From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH] pretty format now configurable
Date: Sat,  1 Mar 2008 03:44:23 +0800
Message-ID: <1204314263-8072-1-git-send-email-crquan@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 20:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVBAh-0003Ou-QB
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 20:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbYB2Tog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 14:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbYB2Tog
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 14:44:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:64372 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758390AbYB2Tof (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 14:44:35 -0500
Received: by ug-out-1314.google.com with SMTP id z38so464265ugc.16
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=A5DAV2VjMm9yML09SB0Y7G6tFcSVRkIDStBA8PBMzwA=;
        b=SVBqysfxmjmSWbu93sjcoGQCSGD0AjwBXqPwwNhZJsG1bF4HHJ7S3zqQUdVb99mWxDBGFmXK6D6rWkuMGy2tzySjc0NBMxd0xPDKfEg5Z07VYFmzDPfsOxPcXd1GjglK5Ox3mDxJm26Rfn7fudEOiNzPKWSUOhMLULV/yHq84YY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=m+H33zH9N3OS3vyi4n/3xhOtxONQwqKRo9nc5/OdrVLPKp9wCFkSLUZwxsWvD34Yl/Sx6OKiRju+HDJpcRU0h7UuYtA5RzxSRiTaRNwvZmBKTawBEJlXFIdt5D42ua2D3ZXaXqSIo8XnmeGCnVqhxbvpjw4GlHT0TgKhHYLXGoE=
Received: by 10.114.106.1 with SMTP id e1mr752871wac.95.1204314272480;
        Fri, 29 Feb 2008 11:44:32 -0800 (PST)
Received: from tux ( [58.61.13.56])
        by mx.google.com with ESMTPS id n22sm17943200pof.1.2008.02.29.11.44.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Feb 2008 11:44:30 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Sat,  1 Mar 2008 03:44:23 +0800
X-Mailer: git-send-email 1.5.3.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75553>

 * New configuration variable "format.pretty" can be used
    in git log/show/whathappened.

Signed-off-by: Denis Cheng <crquan@gmail.com>
---
 builtin-log.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index bbadbc0..0f7ee1f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -20,6 +20,7 @@
 
 static int default_show_root = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
+static const char *fmt_pretty;
 
 static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
 {
@@ -53,7 +54,8 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	int decorate = 0;
 
 	rev->abbrev = DEFAULT_ABBREV;
-	rev->commit_format = CMIT_FMT_DEFAULT;
+	if (fmt_pretty)
+		rev->commit_format = get_commit_format(fmt_pretty);
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->show_root_diff = default_show_root;
@@ -221,6 +223,12 @@ static int cmd_log_walk(struct rev_info *rev)
 
 static int git_log_config(const char *var, const char *value)
 {
+	if (!strcmp(var, "format.pretty")) {
+		if (!value)
+			config_error_nonbool(var);
+		fmt_pretty = xstrdup(value);
+		return 0;
+	}
 	if (!strcmp(var, "format.subjectprefix")) {
 		if (!value)
 			config_error_nonbool(var);
-- 
1.5.4.2

