From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] test: do not rely on US English tracking-info messages
Date: Fri, 13 Apr 2012 23:45:31 -0500
Message-ID: <20120414044531.GB1791@burratino>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
 <20120413233010.GA16663@sigill.intra.peff.net>
 <20120413234607.GE13995@burratino>
 <20120414022452.GA17535@sigill.intra.peff.net>
 <20120414044413.GA1791@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 06:45:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIurm-0003NR-G0
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 06:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169Ab2DNEpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 00:45:38 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41398 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab2DNEph (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 00:45:37 -0400
Received: by iagz16 with SMTP id z16so5106700iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 21:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZPWfsRDRpIRY6cFsLVkeS7Z2VnOUdRoEmxJzmNe0vGA=;
        b=ydddcqdeIe68eQU9da33J2OFdoPLPIbvVezwqlzl99m+rVf1EX0LzwC8gfJ80N3Kq3
         090t7Im26G1BW555nFhPc0kyQnDBEDWHul7QPwVlLCLnu7Wn336K+2MhywjPvGmUqP1X
         vF4NHjtshNFUiGJHiI+x0xla9oijhNN57y71Q4wfp/SpS7PKESJGDD/Gh5iJ60MQWVnW
         ki/05YcjLmEGFJ1XYXpS93h6urjpOblJhPnHyRpQ8fVDSJtjk32oDNCqia+e0gW93PdS
         MH859VVrDoO02OIwBuLvMsOz3sG4hoDthLX2c/rk1yuGSVq51D1gZqlaXJUKIyPv1i+M
         jhYQ==
Received: by 10.50.57.199 with SMTP id k7mr426905igq.25.1334378737443;
        Fri, 13 Apr 2012 21:45:37 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id de2sm1067508igc.4.2012.04.13.21.45.35
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 21:45:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120414044413.GA1791@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195466>

When v1.7.9.2~28^2 (2012-02-02) marked "Your branch is behind" and
friends for translation, it forgot to adjust tests not to check those
messages when tests are being run with git configured to write its
output in another language.

With this patch applied, t2020 and t6040 pass again with
GETTEXT_POISON=YesPlease.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Explained-by: Jeff King <peff@peff.net>
---
 t/t2020-checkout-detach.sh |    2 +-
 t/t6040-tracking-info.sh   |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 068fba4c..b37ce25c 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -148,7 +148,7 @@ test_expect_success 'tracking count is accurate after orphan check' '
 	git config branch.child.merge refs/heads/master &&
 	git checkout child^ &&
 	git checkout child >stdout &&
-	test_cmp expect stdout
+	test_i18ncmp expect stdout
 '
 
 test_done
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 19272bc5..ec2b516c 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -71,13 +71,13 @@ test_expect_success 'checkout' '
 	(
 		cd test && git checkout b1
 	) >actual &&
-	grep "have 1 and 1 different" actual
+	test_i18ngrep "have 1 and 1 different" actual
 '
 
 test_expect_success 'checkout with local tracked branch' '
 	git checkout master &&
 	git checkout follower >actual &&
-	grep "is ahead of" actual
+	test_i18ngrep "is ahead of" actual
 '
 
 test_expect_success 'status' '
@@ -87,14 +87,14 @@ test_expect_success 'status' '
 		# reports nothing to commit
 		test_must_fail git commit --dry-run
 	) >actual &&
-	grep "have 1 and 1 different" actual
+	test_i18ngrep "have 1 and 1 different" actual
 '
 
 test_expect_success 'fail to track lightweight tags' '
 	git checkout master &&
 	git tag light &&
 	test_must_fail git branch --track lighttrack light >actual &&
-	test_must_fail grep "set up to track" actual &&
+	test_i18ngrep ! "set up to track" actual &&
 	test_must_fail git checkout lighttrack
 '
 
@@ -102,7 +102,7 @@ test_expect_success 'fail to track annotated tags' '
 	git checkout master &&
 	git tag -m heavy heavy &&
 	test_must_fail git branch --track heavytrack heavy >actual &&
-	test_must_fail grep "set up to track" actual &&
+	test_i18ngrep ! "set up to track" actual &&
 	test_must_fail git checkout heavytrack
 '
 
-- 
1.7.10
