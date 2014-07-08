From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 2/4] test-dump-cache-tree: invalid trees are not errors
Date: Mon,  7 Jul 2014 17:33:43 -0700
Message-ID: <1404779625-16972-2-git-send-email-dturner@twitter.com>
References: <1404779625-16972-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 02:34:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4JMY-00081w-Fs
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 02:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbaGHAeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 20:34:17 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:59068 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbaGHAeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 20:34:07 -0400
Received: by mail-qa0-f45.google.com with SMTP id s7so259228qap.18
        for <git@vger.kernel.org>; Mon, 07 Jul 2014 17:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5CtD3/BLkZVb7f30z6OgIhJRvnqz5cgQFgxg1ANEcKc=;
        b=D1kyby4cYjY+iue9WQMb/hJMnPcZ0fr5mTCd7/4gkX07Vg8R7K3tDZxS3lTn5qaAHS
         lKq0G2wKFytM8Yp+oOx/jXGQ6BdAGmS5w3hYV88FR+W6frdfLZGi+L48XOxFop5aBLvJ
         CE+a3REnf5C3GWPW7Vk84NuUksAlOLQF4/S5B+0oaMDo3e7+89atCSnKqogu1Cj5Ki7E
         XMo2d0C4rwiPMtc5wqN5pJDTjQfAsKBeHH7ElC8FOXYnoYijlzwGE3O6NWzjJK3XqMJA
         k8CXH3XjpEPcjOtNI9JjWmJlUWRYFjKkk4wXeJsasPY5U+q9t5qhOAjjJ/8D4+IB3sXy
         ksuA==
X-Gm-Message-State: ALoCoQkiLR0NWpZlpJxwsl1aYVqRu0NgG/IKnGGJdOSbV1HwXRoza9iFOhVIed4MI3MeyI5hoWQn
X-Received: by 10.140.108.99 with SMTP id i90mr52117099qgf.56.1404779646313;
        Mon, 07 Jul 2014 17:34:06 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id z14sm77426952qaw.7.2014.07.07.17.34.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jul 2014 17:34:05 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1404779625-16972-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253000>

Do not treat known-invalid trees as errors even when their subtree_nr is
incorrect.  Because git already knows that these trees are invalid,
an incorrect subtree_nr will not cause problems.

Add a couple of comments.

Signed-off-by: David Turner <dturner@twitter.com>
---
 test-dump-cache-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index 47eab97..cbbbd8e 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -26,16 +26,16 @@ static int dump_cache_tree(struct cache_tree *it,
 		return 0;
 
 	if (it->entry_count < 0) {
+		/* invalid */
 		dump_one(it, pfx, "");
 		dump_one(ref, pfx, "#(ref) ");
-		if (it->subtree_nr != ref->subtree_nr)
-			errs = 1;
 	}
 	else {
 		dump_one(it, pfx, "");
 		if (hashcmp(it->sha1, ref->sha1) ||
 		    ref->entry_count != it->entry_count ||
 		    ref->subtree_nr != it->subtree_nr) {
+			/* claims to be valid but is lying */
 			dump_one(ref, pfx, "#(ref) ");
 			errs = 1;
 		}
-- 
2.0.0.390.gcb682f8
