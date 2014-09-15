From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 2/3] t1503: use test_must_be_empty
Date: Mon, 15 Sep 2014 12:07:38 -0700
Message-ID: <1410808059-1459-2-git-send-email-davvid@gmail.com>
References: <1410808059-1459-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Fabian Ruch <bafain@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:07:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTbci-0000aV-Lu
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 21:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbaIOTHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 15:07:34 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:52226 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbaIOTHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 15:07:30 -0400
Received: by mail-pa0-f47.google.com with SMTP id ey11so7056606pad.6
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uXIcJYRI08riT1tYr6cheD/CbI6RUai4cpxce0a7vuY=;
        b=niSMyka/PHoUQZmmEF30oTvMoxMD755qmutNtmk8ZRXUHxVjlUMkfV5ZoGCG4+1IM/
         QZyXZTBlDgOCookeU5t+qSihKwGoHBYgDGJ+2w1h/0Gm54REyA2y09jo1HjHTvhCm4zD
         RP8ZkJhzdzYbD4NB5OO1u9XW/yABo9fw2yeced+lQmOwdLEJi0wagIGqH7S/lmepg43g
         HK1ut9lOJhwIwr7++5CAgdsX+2/erTgmWfXo1xB4wFe2XqrA/muc2nG/H2oiSBJOEELq
         BJEE/F1emkNdOhb60WYG4k+9KTy6pdH6ItZW+CmSnMiq7d82D8sfw9LqnUKnLF4rqbvU
         rT1w==
X-Received: by 10.70.50.170 with SMTP id d10mr44508085pdo.33.1410808049804;
        Mon, 15 Sep 2014 12:07:29 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id cm8sm12023824pdb.95.2014.09.15.12.07.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Sep 2014 12:07:29 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.30.g05c535b.dirty
In-Reply-To: <1410808059-1459-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257071>

Use `test_must_be_be_empty <file>` instead of `test -z "$(cat <file>)"`.

Suggested-by: Fabian Ruch <bafain@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Unchanged since last time, but rebased for the change in the
previous patch.

 t/t1503-rev-parse-verify.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index fd9d0c3..4fe9f0e 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -72,15 +72,15 @@ test_expect_success 'fails with any bad rev or many good revs' '
 
 test_expect_success 'fails silently when using -q' '
 	test_must_fail git rev-parse --verify --quiet 2>error &&
-	test -z "$(cat error)" &&
+	test_must_be_empty error &&
 	test_must_fail git rev-parse -q --verify foo 2>error &&
-	test -z "$(cat error)" &&
+	test_must_be_empty error &&
 	test_must_fail git rev-parse --verify -q HEAD bar 2>error &&
-	test -z "$(cat error)" &&
+	test_must_be_empty error &&
 	test_must_fail git rev-parse --quiet --verify baz HEAD 2>error &&
-	test -z "$(cat error)" &&
+	test_must_be_empty error &&
 	test_must_fail git rev-parse -q --verify $HASH2 HEAD 2>error &&
-	test -z "$(cat error)"
+	test_must_be_empty error
 '
 
 test_expect_success 'fails silently when using -q with deleted reflogs' '
@@ -89,7 +89,7 @@ test_expect_success 'fails silently when using -q with deleted reflogs' '
 	git update-ref -m "reflog message for refs/test" refs/test "$ref" &&
 	git reflog delete --updateref --rewrite refs/test@{0} &&
 	test_must_fail git rev-parse -q --verify refs/test@{0} >error 2>&1 &&
-	test -z "$(cat error)"
+	test_must_be_empty error
 '
 
 test_expect_success 'no stdout output on error' '
-- 
2.1.0.30.g05c535b.dirty
