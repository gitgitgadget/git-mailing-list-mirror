From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/5] Always initialize xpparam_t to 0
Date: Sat, 25 Oct 2008 15:30:37 +0200
Message-ID: <49031F7D.2010908@lsrfire.ath.cx>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net> <1219360921-28529-2-git-send-email-bdowning@lavos.net> <48AFC73F.2010100@lsrfire.ath.cx> <20080824081254.GI31114@lavos.net> <48BF0FBF.3010104@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 15:32:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtjFd-0000Mb-8V
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 15:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbYJYNal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 09:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbYJYNak
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 09:30:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:56962 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbYJYNak (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 09:30:40 -0400
Received: from [10.0.1.100] (p57B7B97B.dip.t-dialin.net [87.183.185.123])
	by india601.server4you.de (Postfix) with ESMTPSA id A5AD92F80D4;
	Sat, 25 Oct 2008 15:30:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48BF0FBF.3010104@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99108>

From: Brian Downing <bdowning@lavos.net>

We're going to be adding some parameters to this, so we can't have
any uninitialized data in it.

Signed-off-by: Brian Downing <bdowning@lavos.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Taken from pu.  This patch series doesn't add anything to the struct,
but it's a good idea to future-proof its initialization anyway.

 builtin-blame.c  |    1 +
 builtin-rerere.c |    1 +
 combine-diff.c   |    1 +
 diff.c           |    5 +++++
 merge-file.c     |    1 +
 5 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 593b539..5ca7065 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -523,6 +523,7 @@ static struct patch *compare_buffer(mmfile_t
*file_p, mmfile_t *file_o,
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
index 5aa1104..ec8df39 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -213,6 +213,7 @@ static void combine_diff(const unsigned char
*parent, mmfile_t *result_file,

 	parent_file.ptr = grab_blob(parent, &sz);
 	parent_file.size = sz;
+	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = XDF_NEED_MINIMAL;
 	memset(&xecfg, 0, sizeof(xecfg));
 	memset(&state, 0, sizeof(state));
diff --git a/diff.c b/diff.c
index e368fef..1918b73 100644
--- a/diff.c
+++ b/diff.c
@@ -400,6 +400,7 @@ static void diff_words_show(struct diff_words_data
*diff_words)
 	mmfile_t minus, plus;
 	int i;

+	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
 	minus.size = diff_words->minus.text.size;
 	minus.ptr = xmalloc(minus.size);
@@ -1416,6 +1417,7 @@ static void builtin_diff(const char *name_a,
 		if (!pe)
 			pe = diff_funcname_pattern(two);

+		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path = lbl;
@@ -1489,6 +1491,7 @@ static void builtin_diffstat(const char *name_a,
const char *name_b,
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;

+		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
@@ -1535,6 +1538,7 @@ static void builtin_checkdiff(const char *name_a,
const char *name_b,
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;

+		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xecfg.ctxlen = 1; /* at least one context line */
 		xpp.flags = XDF_NEED_MINIMAL;
@@ -2958,6 +2962,7 @@ static int diff_get_patch_id(struct diff_options
*options, unsigned char *sha1)
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
@@ -61,6 +61,7 @@ static int generate_common_file(mmfile_t *res,
mmfile_t *f1, mmfile_t *f2)
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;

+	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = XDF_NEED_MINIMAL;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
-- 
1.6.0.3.514.g2f91b
