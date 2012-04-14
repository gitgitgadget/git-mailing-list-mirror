From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: git bug: moved file with local unstaged changes are lost during
 merge
Date: Sun, 15 Apr 2012 01:15:17 +0200
Message-ID: <20120414231515.GB18137@ecki>
References: <CAAZnV3Einocd4TJ0iqcxPJNsr44j3RwhczS9OhyURX0faGWgBQ@mail.gmail.com>
 <CAAZnV3EwZ6kminW7D3ssn_Rtj2SsMHd++VCx7w14K5rQKba4_g@mail.gmail.com>
 <20120413064941.GC27214@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Angell <joe.d.angell@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 01:16:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJCCt-0006eU-U1
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 01:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417Ab2DNXQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 19:16:34 -0400
Received: from smtpout14.highway.telekom.at ([195.3.96.79]:6179 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754925Ab2DNXQd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 19:16:33 -0400
Received: (qmail 14579 invoked from network); 14 Apr 2012 23:16:30 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL605.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub79.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <peff@peff.net>; 14 Apr 2012 23:16:30 -0000
Content-Disposition: inline
In-Reply-To: <20120413064941.GC27214@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195531>

On Fri, Apr 13, 2012 at 02:49:41AM -0400, Jeff King wrote:
> 
> t6042 and t6036 detect some of them. But I thought we managed to clean
> up all of the overwriting bugs.

I could not find an existing test for this.

-->o--
Subject: [PATCH] merge overwrites unstaged changes in renamed file


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t7607-merge-overwrite.sh |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index aa74184..6547eb8 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -92,6 +92,15 @@ test_expect_success 'will not overwrite removed file with staged changes' '
 	test_cmp important c1.c
 '
 
+test_expect_failure 'will not overwrite unstaged changes in renamed file' '
+	git reset --hard c1 &&
+	git mv c1.c other.c &&
+	git commit -m rename &&
+	cp important other.c &&
+	git merge c1a &&
+	test_cmp important other.c
+'
+
 test_expect_success 'will not overwrite untracked subtree' '
 	git reset --hard c0 &&
 	rm -rf sub &&
-- 
1.7.9.6
