From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] clone: Make use of the strip_suffix() helper method
Date: Thu, 9 Jul 2015 15:33:46 +0000
Message-ID: <0000014e73738297-cce3a38b-a85d-40be-b501-354686c25eee-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2_290928937.1436456026732"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 17:49:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDE4y-0004PJ-6k
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 17:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbbGIPth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 11:49:37 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:48845
	"EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751885AbbGIPtf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2015 11:49:35 -0400
X-Greylist: delayed 947 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2015 11:49:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1436456026;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Date:Feedback-ID;
	bh=2zvD+/HgmLBYtJkKEIAKpbyP3ebBhk79paE2NM5pa3U=;
	b=WPsMXqRpDxJuEgn4bH3gYGZregJaqfafYVdJe/91cPxvf+3pmQ8EU2u85DAycwlJ
	swON2UrTISEfnpwQBXV5Z+XmE6AkEyAJ7O/7XIgZBYUfVRqTfHteObo1/ftsrccQeYB
	X4ySIn0VFVMAd4UanwcA5srTsI8oy6yAwwFZlJzE=
X-SES-Outgoing: 2015.07.09-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273758>

------=_Part_2_290928937.1436456026732
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 builtin/clone.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 00535d0..d35b2b9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -147,6 +147,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 {
 	const char *end = repo + strlen(repo), *start;
+	size_t len;
 	char *dir;
 
 	/*
@@ -174,19 +175,17 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	 * Strip .{bundle,git}.
 	 */
 	if (is_bundle) {
-		if (end - start > 7 && !strncmp(end - 7, ".bundle", 7))
-			end -= 7;
+		strip_suffix(start, ".bundle", &len);
 	} else {
-		if (end - start > 4 && !strncmp(end - 4, ".git", 4))
-			end -= 4;
+		strip_suffix(start, ".git", &len);
 	}
 
 	if (is_bare) {
 		struct strbuf result = STRBUF_INIT;
-		strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
+		strbuf_addf(&result, "%.*s.git", len, start);
 		dir = strbuf_detach(&result, NULL);
 	} else
-		dir = xstrndup(start, end - start);
+		dir = xstrndup(start, len);
 	/*
 	 * Replace sequences of 'control' characters and whitespace
 	 * with one ascii space, remove leading and trailing spaces.

---
https://github.com/git/git/pull/160
------=_Part_2_290928937.1436456026732--
