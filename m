From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 2/3] builtin-status: configurable submodule summary size
Date: Wed, 12 Mar 2008 10:21:51 +0800
Message-ID: <1205288512-20435-2-git-send-email-pkufranky@gmail.com>
References: <1205288512-20435-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 03:22:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZGcD-0003AZ-6L
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 03:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbYCLCWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 22:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbYCLCWD
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 22:22:03 -0400
Received: from mail.qikoo.org ([60.28.205.235]:55354 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751367AbYCLCV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 22:21:59 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 3F4E7470AB; Wed, 12 Mar 2008 10:21:53 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1205288512-20435-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76911>

Add config variable status.submodulesummary which is passed as
arg for '--summary-limit' of 'git submodule summary' to limit the
submodule summary size.

status.submodulesummary is 0 by default which disables the summary.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 wt-status.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 6d36e54..6a58057 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -12,6 +12,7 @@
 
 int wt_status_relative_paths = 1;
 int wt_status_use_color = -1;
+int wt_status_submodule_summary = 0;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	"",         /* WT_STATUS_HEADER: normal */
 	"\033[32m", /* WT_STATUS_UPDATED: green */
@@ -223,6 +224,8 @@ static void wt_status_print_changed(struct wt_status *s)
 static void wt_status_print_submodule_summary(struct wt_status *s)
 {
 	struct child_process sm_summary;
+	char summary_limit[64];
+	sprintf(summary_limit, "%d", wt_status_submodule_summary);
 	const char *argv[] = {
 		"submodule",
 		"summary",
@@ -374,6 +377,10 @@ void wt_status_print(struct wt_status *s)
 
 int git_status_config(const char *k, const char *v)
 {
+	if (!strcmp(k, "status.submodulesummary")) {
+		wt_status_submodule_summary = atoi(v);
+		return 0;
+	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		wt_status_use_color = git_config_colorbool(k, v, -1);
 		return 0;
-- 
1.5.4.3.347.g5314c
