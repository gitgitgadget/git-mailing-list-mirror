From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/7] sha1_name: cleanup interpret_branch_name()
Date: Sat,  7 Dec 2013 23:56:59 -0600
Message-ID: <1386482220-18558-7-git-send-email-felipe.contreras@gmail.com>
References: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 07:06:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpXVF-0004iR-75
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 07:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600Ab3LHGFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 01:05:55 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:49231 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab3LHGEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 01:04:48 -0500
Received: by mail-oa0-f44.google.com with SMTP id m1so2575412oag.31
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 22:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HjGVxK6f+sQYnQ1Oog8INWIZDJm3gwOj/ENxE3aNz/8=;
        b=JjQLG8I0e0nZAzcsx/IsijUmb0WiF3QxguTdNdwwW02Ez6P7mcQvDfIoUMCdPd/vhP
         d8wYvgaLe2luZ8Z69h8ZGTu7hrkZl0HvPNnycuegXzIYaAgNRw2Ci1AOf5a+rig2pcho
         f13DfzNYqySXtZgBKSP8xW66Qv+qLDAFWjI9ONO4OGL1G+BvGntY+K3FbhkKofELjg7Z
         hwztXTAQSyTA6LGIGUrNe23KJ+0E4mJrqC94BeCZyRxnQLxmGs9UahVxObYndnf8T2bz
         LSZf9OTfhPhbhAveezftYXNQb+UAwErMuouHAa/GvVasLWGRCUrRRG3pWZGjgh8EjA14
         Yieg==
X-Received: by 10.60.68.135 with SMTP id w7mr8668379oet.37.1386482687734;
        Sat, 07 Dec 2013 22:04:47 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u9sm10736378oey.0.2013.12.07.22.04.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 22:04:47 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1.2.gebd1fb1
In-Reply-To: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239040>

The 'upstream' variable doesn't hold an "upstream", but a branch, so
make it clearer.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index e9c2999..e27db88 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1072,7 +1072,7 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
 int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 {
 	char *cp;
-	struct branch *upstream;
+	struct branch *branch;
 	int len = interpret_nth_prior_checkout(name, buf);
 	int tmp_len;
 
@@ -1102,26 +1102,26 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 
 	len = cp + tmp_len - name;
 	cp = xstrndup(name, cp - name);
-	upstream = branch_get(*cp ? cp : NULL);
+	branch = branch_get(*cp ? cp : NULL);
 	/*
 	 * Upstream can be NULL only if cp refers to HEAD and HEAD
 	 * points to something different than a branch.
 	 */
-	if (!upstream)
+	if (!branch)
 		die(_("HEAD does not point to a branch"));
-	if (!upstream->merge || !upstream->merge[0]->dst) {
-		if (!ref_exists(upstream->refname))
+	if (!branch->merge || !branch->merge[0]->dst) {
+		if (!ref_exists(branch->refname))
 			die(_("No such branch: '%s'"), cp);
-		if (!upstream->merge) {
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
 	free(cp);
-	cp = shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
+	cp = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
 	strbuf_reset(buf);
 	strbuf_addstr(buf, cp);
 	free(cp);
-- 
1.8.5.1+fc1.2.gebd1fb1
