From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] t3508 (cherry-pick): futureproof against unmerged files
Date: Mon, 14 Jun 2010 00:28:50 -0500
Message-ID: <20100614052850.GA1737@burratino>
References: <20100614032251.20121.83253.chriscool@tuxfamily.org>
 <20100614052027.GA1509@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 07:29:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO2EW-0006Nd-J7
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 07:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305Ab0FNF3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 01:29:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39319 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab0FNF3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 01:29:03 -0400
Received: by iwn9 with SMTP id 9so2912579iwn.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 22:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YjcDmuuDSQEZGchx3lNMG+tqZFL7bAFhQlDD8HZJ5xw=;
        b=vOHE+LyQFRZ4LIcYVx6Bo1twQtu+WCwPaWg8JOcHMCEIKt5xiZcM+ktlg4KqC9uXDM
         OPBtKA86GkCLeRlIbxqv7TRVfZVaW2/R83W3/aXk8zGMK6+39iG3wa7EVTYR9X1h01Wg
         TNXQ99bx5Gl6SJ8jOyA0tUtCh5RT3udwWbwB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GkrhynVAdMJSCD5B29s131jFfm+ZUYV8CtHrzy4Rc28kKQmRJxIDTTxYhd2tbjBhui
         2c147liacXuKei5eqf6Fgr1zpbmj9cv9G+KQLFQ5jpt+U45urJ8evLJmYxs1tBPnn9kR
         O9UkYeSH6t61npWv0/mXm2GR3LaSr959gQgCs=
Received: by 10.231.170.1 with SMTP id b1mr5256188ibz.13.1276493342943;
        Sun, 13 Jun 2010 22:29:02 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a8sm18975145ibi.11.2010.06.13.22.29.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 22:29:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100614052027.GA1509@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149070>

Each of the tests in t3508 begins by navigating to a sane state:

	git checkout master &&
	git reset --hard $commit

If a previous test left unmerged files around, they are untouched and
the checkout fails, causing later tests to fail, too.  This is not a
problem in practice because no test except the final one produces
unmerged files.

But as a futureproofing measure, it is still best to avoid the problem
with 'checkout -f'.  In particular, this is needed for new tests to be
added to the end of the script.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3508-cherry-pick-many-commits.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 3b87efe..26a8730 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick first..fourth works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick first..fourth &&
@@ -33,7 +33,7 @@ test_expect_success 'cherry-pick first..fourth works' '
 '
 
 test_expect_success 'cherry-pick --ff first..fourth works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick --ff first..fourth &&
@@ -43,7 +43,7 @@ test_expect_success 'cherry-pick --ff first..fourth works' '
 '
 
 test_expect_success 'cherry-pick -n first..fourth works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick -n first..fourth &&
@@ -53,7 +53,7 @@ test_expect_success 'cherry-pick -n first..fourth works' '
 '
 
 test_expect_success 'revert first..fourth works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard fourth &&
 	test_tick &&
 	git revert first..fourth &&
@@ -63,7 +63,7 @@ test_expect_success 'revert first..fourth works' '
 '
 
 test_expect_success 'revert ^first fourth works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard fourth &&
 	test_tick &&
 	git revert ^first fourth &&
@@ -73,7 +73,7 @@ test_expect_success 'revert ^first fourth works' '
 '
 
 test_expect_success 'revert fourth fourth~1 fourth~2 works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard fourth &&
 	test_tick &&
 	git revert fourth fourth~1 fourth~2 &&
@@ -83,7 +83,7 @@ test_expect_success 'revert fourth fourth~1 fourth~2 works' '
 '
 
 test_expect_failure 'cherry-pick -3 fourth works' '
-	git checkout master &&
+	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick -3 fourth &&
-- 
1.7.1.246.g398e5.dirty
