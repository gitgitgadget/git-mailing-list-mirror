From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 4/4] rev-parse test: use standard test functions for setup
Date: Tue, 3 Sep 2013 10:15:46 -0700
Message-ID: <20130903171546.GF29921@google.com>
References: <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
 <20130903071256.GD3608@sigill.intra.peff.net>
 <20130903075107.GA25540@goldbirke>
 <20130903080358.GA30158@sigill.intra.peff.net>
 <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
 <20130903111006.GJ29840@goldbirke>
 <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
 <20130903150855.GK29840@goldbirke>
 <20130903170419.GA29921@google.com>
 <20130903171137.GE29921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:15:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGuCp-0000Zn-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710Ab3ICRPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:15:52 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37122 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab3ICRPv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:15:51 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so6727400pad.33
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mjUHVeHs/9w2JyHJ5dhxR3Ds30PdH4HZRznTo0vdtpg=;
        b=FfVNnQYB5m3j/EuXiQoecl/CvdjFNr8cmdDY4cVeKsWBxzcnulTHP8Rkmw8F8kQVNF
         S9PSVP9/vRp/BODxqnF6J0ugoW4MLAZnSUzoUiZFIUa3DFyZm6FMHZh4ikKmC9q9p30S
         pSn4D1uTCeuaU2nGvvigfChDsafwz5cL7Okra5PMPKriKOHODekNHQd5+UgNPSgcGx7A
         1Dd4YyBl8GoLZVVuQGHvAU4Avnr9idMVNHw4d+LbpfBF7pNfgYx1SWzEhzGG/zx/RWkD
         JN1YgFmYRQDZrGDkQuHIWoYOkJweAm4tOgpVsr5iI/qXvHklO52fPU/9lCNuOlDtAHnP
         fMIw==
X-Received: by 10.66.119.202 with SMTP id kw10mr8475791pab.118.1378228551075;
        Tue, 03 Sep 2013 10:15:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yk1sm24160627pac.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Sep 2013 10:15:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130903171137.GE29921@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233743>

From: Felipe Contreras <felipe.contreras@gmail.com>

Save the reader from learning specialized t6* setup functions
where familiar commands like test_commit, "git checkout --orphan",
and "git merge" will do.

While at it, wrap the setup commands in a test assertion so errors can
be caught and stray output suppressed when running without --verbose
as in other tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Lost a line from the patch last time (removal of the
'. "$TEST_DIRECTORY"/lib-t6000.sh' directive.  Sorry about that ---
fixed now.

 t/t6101-rev-parse-parents.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 8a6ff66..7ea14ce 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -6,7 +6,6 @@
 test_description='Test git rev-parse with different parent options'
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
 
 test_cmp_rev_output () {
 	git rev-parse --verify "$1" >expect &&
@@ -14,14 +13,15 @@ test_cmp_rev_output () {
 	test_cmp expect actual
 }
 
-date >path0
-git update-index --add path0
-save_tag tree git write-tree
-hide_error save_tag start unique_commit "start" tree
-save_tag second unique_commit "second" tree -p start
-hide_error save_tag start2 unique_commit "start2" tree
-save_tag two_parents unique_commit "next" tree -p second -p start2
-save_tag final unique_commit "final" tree -p two_parents
+test_expect_success 'setup' '
+	test_commit start &&
+	test_commit second &&
+	git checkout --orphan tmp &&
+	test_commit start2 &&
+	git checkout master &&
+	git merge -m next start2 &&
+	test_commit final
+'
 
 test_expect_success 'start is valid' '
 	git rev-parse start | grep "^[0-9a-f]\{40\}$"
-- 
1.8.4
