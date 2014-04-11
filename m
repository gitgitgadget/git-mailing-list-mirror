From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 6/8] sha1_name: cleanup interpret_branch_name()
Date: Fri, 11 Apr 2014 12:59:09 -0500
Message-ID: <1397239151-2391-7-git-send-email-felipe.contreras@gmail.com>
References: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 20:09:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYftj-0007GN-Sg
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 20:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833AbaDKSJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 14:09:46 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:50646 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbaDKSJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 14:09:29 -0400
Received: by mail-ob0-f179.google.com with SMTP id va2so6439272obc.38
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p5Oszb8ppusKOTVpB19OgZ4OzyQTokLThAF8H5RNMMU=;
        b=abSAunIeaUJulQdb+dl9ob99tdiHYyzekn0xCyOZjFfX0jAmTjgnkh60YzF1zaMDYw
         MsMAzWjjFUoIC68iskzCaTHXeXp8OwnIeSNSgEMPpws8PwZIqg2Kh73LOrilzEVE5j1/
         PNuG2VvTNdkkQ6HbCmNm0KEaMSDGJ/4LvDtYH3vfDJG2Kxqi1QYX0RQpOiKJ/hI3GsVe
         90dkYMvohk0zBH2u+OyiBnPJxRHqrxMw4Jqe3/0na5DpGKC5cWS90iry6MIPF7XRByxy
         15usdV5k8yJNE9Rxu7k0DIfFVvwLgcmHTX/5Oy8PbSa43Tc0BYYo+kSQvDRT3rnjNcNF
         5iRA==
X-Received: by 10.60.103.210 with SMTP id fy18mr1473175oeb.75.1397239768973;
        Fri, 11 Apr 2014 11:09:28 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id la3sm13445804obb.19.2014.04.11.11.09.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 11:09:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246123>

The 'upstream' variable doesn't hold an "upstream", but a branch, so
make it clearer.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 6fca869..906f09d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1057,31 +1057,31 @@ static void set_shortened_ref(struct strbuf *buf, const char *ref)
 	free(s);
 }
 
-static const char *get_upstream_branch(const char *branch_buf, int len)
+static const char *get_upstream_branch(const char *name_buf, int len)
 {
-	char *branch = xstrndup(branch_buf, len);
-	struct branch *upstream = branch_get(*branch ? branch : NULL);
+	char *name = xstrndup(name_buf, len);
+	struct branch *branch = branch_get(*name ? name : NULL);
 
 	/*
 	 * Upstream can be NULL only if branch refers to HEAD and HEAD
 	 * points to something different than a branch.
 	 */
-	if (!upstream)
+	if (!branch)
 		die(_("HEAD does not point to a branch"));
-	if (!upstream->merge || !upstream->merge[0]->dst) {
-		if (!ref_exists(upstream->refname))
-			die(_("No such branch: '%s'"), branch);
-		if (!upstream->merge) {
+	if (!branch->merge || !branch->merge[0]->dst) {
+		if (!ref_exists(branch->refname))
+			die(_("No such branch: '%s'"), name);
+		if (!branch->merge) {
 			die(_("No upstream configured for branch '%s'"),
-				upstream->name);
+				branch->name);
 		}
 		die(
 			_("Upstream branch '%s' not stored as a remote-tracking branch"),
-			upstream->merge[0]->src);
+			branch->merge[0]->src);
 	}
-	free(branch);
+	free(name);
 
-	return upstream->merge[0]->dst;
+	return branch->merge[0]->dst;
 }
 
 static int interpret_upstream_mark(const char *name, int namelen,
-- 
1.9.1+fc1
