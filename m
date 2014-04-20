From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 6/8] sha1_name: cleanup interpret_branch_name()
Date: Sun, 20 Apr 2014 14:45:04 -0500
Message-ID: <1398023106-25958-7-git-send-email-felipe.contreras@gmail.com>
References: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:56:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbxqe-0006hB-NG
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545AbaDTT4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:56:06 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:55156 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbaDTTzo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:55:44 -0400
Received: by mail-yh0-f54.google.com with SMTP id f73so2957797yha.13
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PY8lMq35kx0zXfCpffFlh+Aq6Kg5yK2e/Zkidgo3BPo=;
        b=JkyWwpJGC46LmjiUsua5OBfVVC1qcZ/ML9ufJyWbkGy0BeZOuihJKXufAy5A7rt9sC
         G/BcsjZ2MIBxscaZOzibfhtQMpT0nBMu3euEw3QmxDalEEiVK5/zbAZSYx1YRIKq5XCE
         6c1qhaRKyeoVaWljt3XNGuxj2uzmtLdlPaBj2+DFCepLgW/q3TD0naUZV28QGTzHqKrp
         li58zp7+x3XKxMAFk3O0MCpWwJdGezuHxKR6K7ButzQY4/CLKxl3tt9i9diQz1ht9OjV
         GOWvOVEX4WH75CHb0Wz7HRhuZ5dqRU4chY1M6CfFC82c//SjrEKUItdDmb+cOz692O//
         lTzw==
X-Received: by 10.236.63.103 with SMTP id z67mr47301506yhc.2.1398023744285;
        Sun, 20 Apr 2014 12:55:44 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e70sm65588210yhk.9.2014.04.20.12.55.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:55:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246573>

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
1.9.1+fc3.9.gc73078e
