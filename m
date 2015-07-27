From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 1/2] t/t7509: remove unnecessary manipulation of reflog
Date: Mon, 27 Jul 2015 18:57:07 -0400
Message-ID: <1438037829-2642-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 00:57:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJrKr-0000LM-RM
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 00:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbbG0W5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 18:57:25 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35150 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbbG0W5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 18:57:25 -0400
Received: by qgii95 with SMTP id i95so63314881qgi.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 15:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ryZQJzOIMLCwu2LIjzm4RA93563f6pqQeJwuzW3ehjk=;
        b=gXb0EcQEt2zg0Bo7ROWrO51JZ+5Tq+nA1O3Xbuo31yWoW9OEGNBps1cvVUVIMcem7s
         kbcbOKyIRY0VrdrG7hTQYxOZTz6eBXDAhkeut1c4LupWr0u1XrBYqmu0R7G4bOGYVHMU
         /jWCWQ77OlFupRI1t5iGqTUJHUnZ2JeDp/JadjFArF8j/LfJ1pAuoTNWLrU0r1/Rv5Aw
         xMSA7rmL4E9MuuDj+inwtmpkxZkcXpTJ70+QijJQ4jlOXQ/IK+qnM4p8KqncrXUcwCWo
         6ol13k6VN/OtnqVlX9MkkRHftqSpX1dJKm4VhOauyJV4y+gFsy8vRkBFq5pRHgFC1L/t
         yVGQ==
X-Gm-Message-State: ALoCoQlza8tKk67WTu2ZAFBU3dnLdLKip7t1Q77kljTiAc3ZRZ2RGrkVGtRZwquQ8aJyfWqhbtl3
X-Received: by 10.140.94.196 with SMTP id g62mr44678711qge.72.1438037844585;
        Mon, 27 Jul 2015 15:57:24 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id k135sm10054542qhc.31.2015.07.27.15.57.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 15:57:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274719>

Remove unnecessary reflog manipulation.  The test does not rely in any
way on this reflog manipulation, and the case that the test
exercises is unrelated to reflogs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
This version of the patch series addresses Junio's comments on v1.

---
 t/t7509-commit.sh | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
index 9ac7940..db9774e 100755
--- a/t/t7509-commit.sh
+++ b/t/t7509-commit.sh
@@ -90,22 +90,10 @@ sha1_file() {
 remove_object() {
 	rm -f $(sha1_file "$*")
 }
-no_reflog() {
-	cp .git/config .git/config.saved &&
-	echo "[core] logallrefupdates = false" >>.git/config &&
-	test_when_finished "mv -f .git/config.saved .git/config" &&
-
-	if test -e .git/logs
-	then
-		mv .git/logs . &&
-		test_when_finished "mv logs .git/"
-	fi
-}
 
 test_expect_success '--amend option with empty author' '
 	git cat-file commit Initial >tmp &&
 	sed "s/author [^<]* </author  </" tmp >empty-author &&
-	no_reflog &&
 	sha=$(git hash-object -t commit -w empty-author) &&
 	test_when_finished "remove_object $sha" &&
 	git checkout $sha &&
@@ -119,7 +107,6 @@ test_expect_success '--amend option with empty author' '
 test_expect_success '--amend option with missing author' '
 	git cat-file commit Initial >tmp &&
 	sed "s/author [^<]* </author </" tmp >malformed &&
-	no_reflog &&
 	sha=$(git hash-object -t commit -w malformed) &&
 	test_when_finished "remove_object $sha" &&
 	git checkout $sha &&
-- 
2.0.4.315.gad8727a-twtrsrc
