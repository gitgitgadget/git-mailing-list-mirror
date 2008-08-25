From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git diff/diff-index/diff-files: call setup_work_tree()
Date: Mon, 25 Aug 2008 16:43:03 +0200
Message-ID: <1219675383-1717-1-git-send-email-vmiklos@frugalware.org>
References: <fcaeb9bf0808250652p3d0f483dt714cd68d3122d7c9@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Karl Chen <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 16:43:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXdIA-0003v7-86
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 16:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbYHYOmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 10:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbYHYOmc
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 10:42:32 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:51571 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbYHYOmc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 10:42:32 -0400
Received: from vmobile.example.net (dhcp-116.st.wlan.bme.hu [152.66.147.116])
	by yugo.frugalware.org (Postfix) with ESMTP id DBFD41DDC5C;
	Mon, 25 Aug 2008 16:42:30 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 78F2396F8; Mon, 25 Aug 2008 16:43:03 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc3.17.gc14c8.dirty
In-Reply-To: <fcaeb9bf0808250652p3d0f483dt714cd68d3122d7c9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93630>

This makes it possible to use git diff when we are outside the repo but
--work-tree and --git-dir is used.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Mon, Aug 25, 2008 at 08:52:11PM +0700, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Because "git diff" did not call setup_work_tree(). The same happens
> for "git diff-index" that someone reported recently. IIRC "git
> diff-files" has the same problem.

Thanks, that was the problem.

 builtin-diff-files.c |    1 +
 builtin-diff-index.c |    1 +
 builtin-diff.c       |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

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
index 17d851b..b8e0656 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -16,6 +16,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	int i;
 	int result;
 
+	setup_work_tree();
 	init_revisions(&rev, prefix);
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;
diff --git a/builtin-diff.c b/builtin-diff.c
index 7ffea97..86f9255 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -244,6 +244,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	int nongit;
 	int result = 0;
 
+	setup_work_tree();
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
 	 * Also there could be M blobs there, and P pathspecs.
-- 
1.6.0.rc3.17.gc14c8.dirty
