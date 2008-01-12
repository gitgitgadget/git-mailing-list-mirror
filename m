From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 5/5] git-status: configurable submodule summary size
Date: Sat, 12 Jan 2008 15:37:15 +0800
Message-ID: <576f7d00c7ecb2cf92fe22592f04b8b1ea6512f7.1200122041.git.pkufranky@gmail.com>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
 <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
 <62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
 <bce0ee9fde688c27fc788fab91a571184918da67.1200122041.git.pkufranky@gmail.com>
 <b220c31f973576dfc1a90ee588bbfd01cd8f6409.1200122041.git.pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 08:53:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDbBh-000493-3I
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759028AbYALHxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 02:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758598AbYALHxI
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:53:08 -0500
Received: from mail.qikoo.org ([60.28.205.235]:51692 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758933AbYALHwt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 02:52:49 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 9393D47099; Sat, 12 Jan 2008 15:37:15 +0800 (CST)
X-Mailer: git-send-email 1.5.4.rc2.9.gf5146-dirty
In-Reply-To: <b220c31f973576dfc1a90ee588bbfd01cd8f6409.1200122041.git.pkufranky@gmail.com>
In-Reply-To: <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
References: <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70292>

Add config variable status.submodulesummary which is passed as
the arg for '--summary-limit' of 'git submodule' to limit the
submodule summary size.

The summary function is disabled by default by this config
(say status.submodulesummary is 0 by default).

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 wt-status.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index df5be80..25ce58b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -11,6 +11,7 @@
 
 int wt_status_relative_paths = 1;
 int wt_status_use_color = 0;
+int wt_status_submodule_summary = 0;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	"",         /* WT_STATUS_HEADER: normal */
 	"\033[32m", /* WT_STATUS_UPDATED: green */
@@ -275,10 +276,14 @@ static void wt_status_print_changed(struct wt_status *s)
 static void wt_status_print_submodule_summary(struct wt_status *s)
 {
 	struct child_process sm_summary;
+	char summary_limit[64];
+	sprintf(summary_limit, "%d", wt_status_submodule_summary);
 	const char *argv[] = {
 		"submodule",
 		"summary",
 		"--cached",
+		"--summary-limit",
+		summary_limit,
 		s->amend ? "HEAD^" : "HEAD",
 		NULL
 	};
@@ -424,6 +429,10 @@ void wt_status_print(struct wt_status *s)
 
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
1.5.4.rc2.9.gf5146-dirty
