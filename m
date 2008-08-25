From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git diff/diff-index/diff-files: call setup_work_tree()
Date: Mon, 25 Aug 2008 17:11:35 +0200
Message-ID: <1219677095-21732-1-git-send-email-vmiklos@frugalware.org>
References: <20080825145044.GE23800@genesis.frugalware.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Karl Chen <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 17:13:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXdjv-0005A9-CN
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 17:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbYHYPLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 11:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbYHYPLH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 11:11:07 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:44099 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbYHYPLG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 11:11:06 -0400
Received: from vmobile.example.net (dhcp-116.st.wlan.bme.hu [152.66.147.116])
	by yugo.frugalware.org (Postfix) with ESMTP id A0EC71DDC5B;
	Mon, 25 Aug 2008 17:11:03 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id CDCEE9C6A; Mon, 25 Aug 2008 17:11:35 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc3.17.gc14c8.dirty
In-Reply-To: <20080825145044.GE23800@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93634>

This makes it possible to use git diff when we are outside the repo but
--work-tree and --git-dir is used.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-diff-files.c |    1 +
 builtin-diff-index.c |    2 ++
 builtin-diff.c       |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 9bf10bb..4802e00 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -19,6 +19,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	int result;
 	unsigned options = 0;
 
+	setup_work_tree();
 	init_revisions(&rev, prefix);
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 17d851b..5510291 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -29,6 +29,8 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		else
 			usage(diff_cache_usage);
 	}
+	if (!cached)
+		setup_work_tree();
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 
diff --git a/builtin-diff.c b/builtin-diff.c
index 7ffea97..57da6ed 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -279,6 +279,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	diff_no_index(&rev, argc, argv, nongit, prefix);
 
 	/* Otherwise, we are doing the usual "git" diff */
+	setup_work_tree();
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
 
 	if (nongit)
-- 
1.6.0.rc3.17.gc14c8.dirty
