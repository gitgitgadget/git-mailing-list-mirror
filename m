From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 06/16] t3600 (rm): add lots of missing &&
Date: Sat, 25 Sep 2010 13:06:57 -0600
Message-ID: <1285441627-28233-7-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:06:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza4r-0005Xq-Jm
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620Ab0IYTFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:05:42 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54740 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0IYTFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:41 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so891416pzk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eNZD6tuxTJuRxkf3rqT4kfuuvf2NIgz+Jl4VxJIlmgw=;
        b=IGud1fh5eluBhGorkkN8kUuEwKYGdxKpWmdINZ1ZKMedBo9Dp2ksbXz9P1oGnva0Qy
         5qXlVaHY36FcixD9sfYU2cIiyg3xt3twR4iSqGdE9WgLkrwrlbL+pR6SGN6cOAZL+NbN
         YWsV7K8NLrPzgXPHR6qyK/Yru0DRNDlgdPWPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fWbSmgqFBYRUuXtubjBCJ+KBKRHRM4nIqeMk+G1C0MlUWEf6R2yz7iKr5FTDAMnbNT
         9XE5FGJdczD4C8FIQmjacy9PIKX8aDTzAjlHZvltSP6WUN39C+xThvZx/nsgT8AueXyR
         i5Z+dSqOgWFs3I/ajwCP1VEmjExRThRBtjW28=
Received: by 10.114.132.2 with SMTP id f2mr5654308wad.131.1285441538580;
        Sat, 25 Sep 2010 12:05:38 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.36
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157186>

Also delete unnecessary, failing code and add some test_when_finished
calls to make sure tests clean up after themselves.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3600-rm.sh |   38 +++++++++++++++++---------------------
 1 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b26cabd..b1f9abf 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -38,37 +38,33 @@ test_expect_success \
 
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content > foo
-     git add foo
+    'echo content > foo &&
+     git add foo &&
      git rm --cached foo'
 
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
+    'echo content > foo &&
+     git add foo &&
+     git commit -m foo &&
+     echo "other content" > foo &&
+     test_when_finished "git checkout HEAD -- foo" &&
      git rm --cached foo'
 
 test_expect_success \
     'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
-     echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
-     git add foo
-     echo "yet another content" > foo
+     echo "other content" > foo &&
+     git add foo &&
+     echo "yet another content" > foo &&
+     test_when_finished "git checkout HEAD -- foo" &&
      test_must_fail git rm --cached foo
 '
 
 test_expect_success \
     'Test that git rm --cached -f foo works in case where --cached only did not' \
-    'echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
-     git add foo
-     echo "yet another content" > foo
+    'echo "other content" > foo &&
+     git add foo &&
+     echo "yet another content" > foo &&
      git rm --cached -f foo'
 
 test_expect_success \
@@ -170,7 +166,7 @@ test_expect_success 'but with -f it should work.' '
 	git rm -f foo baz &&
 	test ! -f foo &&
 	test ! -f baz &&
-	test_must_fail git ls-files --error-unmatch foo
+	test_must_fail git ls-files --error-unmatch foo &&
 	test_must_fail git ls-files --error-unmatch baz
 '
 
@@ -183,7 +179,7 @@ test_expect_success 'refuse to remove cached empty file with modifications' '
 
 test_expect_success 'remove intent-to-add file without --force' '
 	echo content >intent-to-add &&
-	git add -N intent-to-add
+	git add -N intent-to-add &&
 	git rm --cached intent-to-add
 '
 
@@ -201,7 +197,7 @@ test_expect_success 'Recursive without -r fails' '
 '
 
 test_expect_success 'Recursive with -r but dirty' '
-	echo qfwfq >>frotz/nitfol
+	echo qfwfq >>frotz/nitfol &&
 	test_must_fail git rm -r frotz &&
 	test -d frotz &&
 	test -f frotz/nitfol
-- 
1.7.3.95.g14291
