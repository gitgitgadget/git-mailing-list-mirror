From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 3/5] Always initialize xpparam_t to 0
Date: Thu, 21 Aug 2008 18:21:59 -0500
Message-ID: <1219360921-28529-4-git-send-email-bdowning@lavos.net>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net>
 <1219360921-28529-2-git-send-email-bdowning@lavos.net>
 <1219360921-28529-3-git-send-email-bdowning@lavos.net>
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 01:33:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWJez-0003Qd-D1
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 01:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbYHUXcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 19:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754216AbYHUXcl
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 19:32:41 -0400
Received: from mail.somat.com ([63.252.84.66]:50096 "EHLO somat1.somat.local"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753661AbYHUXck (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 19:32:40 -0400
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2008 19:32:39 EDT
Received: from silvara.lavos.net ([192.168.0.108]) by somat1.somat.local with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 21 Aug 2008 18:22:01 -0500
Received: (nullmailer pid 28569 invoked by uid 1000);
	Thu, 21 Aug 2008 23:22:01 -0000
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <1219360921-28529-3-git-send-email-bdowning@lavos.net>
X-OriginalArrivalTime: 21 Aug 2008 23:22:01.0257 (UTC) FILETIME=[B6E3A990:01C903E4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93226>

We're going to be adding some parameters to this, so we can't have
any uninitialized data in it.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 builtin-blame.c  |    1 +
 builtin-rerere.c |    1 +
 combine-diff.c   |    1 +
 diff.c           |    5 +++++
 merge-file.c     |    1 +
 5 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 60f70bf..66b7d15 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -502,6 +502,7 @@ static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
 
+	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = xdl_opts;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = context;
diff --git a/builtin-rerere.c b/builtin-rerere.c
index dd4573f..d4dec6b 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -98,6 +98,7 @@ static int diff_two(const char *file1, const char *label1,
 
 	printf("--- a/%s\n+++ b/%s\n", label1, label2);
 	fflush(stdout);
+	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = XDF_NEED_MINIMAL;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
diff --git a/combine-diff.c b/combine-diff.c
index 31ec0c5..70d5aad 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -213,6 +213,7 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 
 	parent_file.ptr = grab_blob(parent, &sz);
 	parent_file.size = sz;
+	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = XDF_NEED_MINIMAL;
 	memset(&xecfg, 0, sizeof(xecfg));
 	memset(&state, 0, sizeof(state));
diff --git a/diff.c b/diff.c
index 5923fe2..52346fe 100644
--- a/diff.c
+++ b/diff.c
@@ -446,6 +446,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	mmfile_t minus, plus;
 	int i;
 
+	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
 	minus.size = diff_words->minus.text.size;
 	minus.ptr = xmalloc(minus.size);
@@ -1508,6 +1509,7 @@ static void builtin_diff(const char *name_a,
 		if (!funcname_pattern)
 			funcname_pattern = diff_funcname_pattern(two);
 
+		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path = lbl;
@@ -1581,6 +1583,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
 
+		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
@@ -1627,6 +1630,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
 
+		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xecfg.ctxlen = 1; /* at least one context line */
 		xpp.flags = XDF_NEED_MINIMAL;
@@ -3072,6 +3076,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 		struct diff_filepair *p = q->queue[i];
 		int len1, len2;
 
+		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		if (p->status == 0)
 			return error("internal diff status error");
diff --git a/merge-file.c b/merge-file.c
index 2a939c9..3120a95 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -61,6 +61,7 @@ static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t *f2)
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
 
+	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = XDF_NEED_MINIMAL;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
-- 
1.5.6.1
