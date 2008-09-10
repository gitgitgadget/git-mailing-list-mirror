From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] t7501: always use test_cmp instead of diff
Date: Wed, 10 Sep 2008 19:32:44 +0200
Message-ID: <1221067964-12287-1-git-send-email-vmiklos@frugalware.org>
References: <7vljy03m2m.fsf@gitster.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 19:34:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdTZh-0001w0-G7
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 19:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbYIJRcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 13:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbYIJRcq
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 13:32:46 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:40163 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbYIJRcp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 13:32:45 -0400
Received: from vmobile.example.net (dsl5401CEA5.pool.t-online.hu [84.1.206.165])
	by yugo.frugalware.org (Postfix) with ESMTPA id 11531149C5E;
	Wed, 10 Sep 2008 19:32:44 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C7E8384CA; Wed, 10 Sep 2008 19:32:44 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <7vljy03m2m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95541>

This should make the output more readable (by default using diff -u)
when some tests fail.

Also changed the diff order from "current expected" to "expected
current".

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Tue, Sep 09, 2008 at 05:02:09PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > We seem to use the convention of
> >
> >   test_cmp <expected> <actual>
> >
> > elsewhere, rather than
> >
> >   test_cmp <actual> <expected>
> >
> > as you have here.  Most noticeably, that means the diff will show
> > deviations from expected, rather "what should be done to make this
> > as expected".
>
> Yes, please.

Here is an updated patch that does this as well.

 t/t7501-commit.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 469bff8..63bfc6d 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -141,7 +141,7 @@ EOF
 
 test_expect_success \
     'validate git rev-list output.' \
-    'diff current expected'
+    'test_cmp expected current'
 
 test_expect_success 'partial commit that involves removal (1)' '
 
@@ -151,7 +151,7 @@ test_expect_success 'partial commit that involves removal (1)' '
 	git commit -m "Partial: add elif" elif &&
 	git diff-tree --name-status HEAD^ HEAD >current &&
 	echo "A	elif" >expected &&
-	diff expected current
+	test_cmp expected current
 
 '
 
@@ -160,7 +160,7 @@ test_expect_success 'partial commit that involves removal (2)' '
 	git commit -m "Partial: remove file" file &&
 	git diff-tree --name-status HEAD^ HEAD >current &&
 	echo "D	file" >expected &&
-	diff expected current
+	test_cmp expected current
 
 '
 
@@ -171,7 +171,7 @@ test_expect_success 'partial commit that involves removal (3)' '
 	git commit -m "Partial: modify elif" elif &&
 	git diff-tree --name-status HEAD^ HEAD >current &&
 	echo "M	elif" >expected &&
-	diff expected current
+	test_cmp expected current
 
 '
 
@@ -187,7 +187,7 @@ test_expect_success 'amend commit to fix author' '
 		expected &&
 	git commit --amend --author="$author" &&
 	git cat-file -p HEAD > current &&
-	diff expected current
+	test_cmp expected current
 
 '
 
@@ -256,7 +256,7 @@ test_expect_success 'amend commit to fix author' '
 		expected &&
 	git commit --amend --author="$author" &&
 	git cat-file -p HEAD > current &&
-	diff expected current
+	test_cmp expected current
 
 '
 
-- 
1.6.0.1
