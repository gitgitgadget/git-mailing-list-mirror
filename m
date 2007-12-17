From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Actually add config variable diff.external
Date: Mon, 17 Dec 2007 13:42:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171341110.9446@racer.site>
References: <E6DFE65BB5ADFE44BE13CCC976124447D5BB8D@fue-email2.ad.mc.com>
 <Pine.LNX.4.64.0712171220540.9446@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Schuberth, Sebastian" <sschuberth@visageimaging.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 14:43:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4GFH-000278-56
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 14:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbXLQNmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 08:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753907AbXLQNmf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 08:42:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:35128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753477AbXLQNme (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 08:42:34 -0500
Received: (qmail invoked by alias); 17 Dec 2007 13:42:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 17 Dec 2007 14:42:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CoORR/P1C1EPRxnfLhe4gE1r8QzVkmdKaAmRAsO
	/mdWNUfC0QUubw
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712171220540.9446@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68564>


We had the diff.external variable in the documentation of the config
file since its conception, but failed to respect it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 17 Dec 2007, Johannes Schindelin wrote:

	> Subject: [PATCH] Document diff.external and mergetool.<tool>.path
	> 
	> There was no documentation for the config variables 
	> diff.external and mergetool.<tool>.path.

	Heh.  Missed that diff.external was actually never implemented...

	Also noticed by Sebastian.

 diff.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 7d17754..a49c36a 100644
--- a/diff.c
+++ b/diff.c
@@ -20,6 +20,7 @@
 static int diff_detect_rename_default;
 static int diff_rename_limit_default = 100;
 static int diff_use_color_default;
+static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 
 static char diff_colors[][COLOR_MAXLEN] = {
@@ -163,6 +164,10 @@ int git_diff_ui_config(const char *var, const char *value)
 		diff_auto_refresh_index = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.external")) {
+		external_diff_cmd_cfg = xstrdup(value);
+		return 0;
+	}
 	if (!prefixcmp(var, "diff.")) {
 		const char *ep = strrchr(var, '.');
 
@@ -209,6 +214,8 @@ static const char *external_diff(void)
 	if (done_preparing)
 		return external_diff_cmd;
 	external_diff_cmd = getenv("GIT_EXTERNAL_DIFF");
+	if (!external_diff_cmd)
+		external_diff_cmd = external_diff_cmd_cfg;
 	done_preparing = 1;
 	return external_diff_cmd;
 }
-- 
1.5.4.rc0.59.g1d10d
