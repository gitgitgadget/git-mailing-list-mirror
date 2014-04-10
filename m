From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 7/9] sha1_name: cleanup interpret_branch_name()
Date: Thu, 10 Apr 2014 14:04:44 -0500
Message-ID: <1397156686-31349-8-git-send-email-felipe.contreras@gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 21:15:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKRs-0006kc-Py
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbaDJTPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:15:32 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54706 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161185AbaDJTP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:15:27 -0400
Received: by mail-ob0-f174.google.com with SMTP id wo20so4892948obc.19
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p5Oszb8ppusKOTVpB19OgZ4OzyQTokLThAF8H5RNMMU=;
        b=m0708xxRzhj62L9JTErdXhtZUXBcG6n68hQZferP1m54/FLcpPTwz1KQ3naZfNispn
         ns2IVdTEqEiISioL5aqAUwUp1tWfsM8/MwW8tygqryZmciSOo7kIpA0FkmcnR90JDOCT
         AC/tlgQIwEaGKZ1dT1Ev0Qd183HUAI2SulXUgBEG3NGtFkJw0BwMl4NpOZ3nfzW7P1RT
         ZsNVI7wRJY5K4H5t5KkglisdhfrhpJFDEwoLoqQUSPMCC6VqPyL8sRQvdKkkRPLli7dv
         S4CsLwpR3fFF0f2DF2l+jjy1EZ4GSL9KD2iilecTWllH/61l2Agn4fBn+0w4k9QNNCmg
         Wlxw==
X-Received: by 10.60.17.132 with SMTP id o4mr4547581oed.34.1397157326755;
        Thu, 10 Apr 2014 12:15:26 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id la3sm8358646obb.19.2014.04.10.12.15.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 12:15:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246045>

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
