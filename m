From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] rev-parse test: use standard test functions for setup
Date: Tue, 3 Sep 2013 10:11:37 -0700
Message-ID: <20130903171137.GE29921@google.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
 <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
 <20130903071256.GD3608@sigill.intra.peff.net>
 <20130903075107.GA25540@goldbirke>
 <20130903080358.GA30158@sigill.intra.peff.net>
 <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
 <20130903111006.GJ29840@goldbirke>
 <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
 <20130903150855.GK29840@goldbirke>
 <20130903170419.GA29921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:11:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGu8p-0007QZ-H6
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab3ICRLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:11:43 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:41005 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab3ICRLm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:11:42 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so6699341pad.16
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0m2176DxRwRv41TB4S5sx1jdTNKqZUOe6Df9Iu0JayE=;
        b=yx5uKA/4K42BkiWZ+ZRFPwapgigBzka87F9esv82UUNmhctUtLeeNZL1PZWK1dMBtG
         si6SbgQNCrxw/esOoqaKSYtLTWHHGKcJ7pg1Jt73y7oyNnX6t+h1RBFdmLoXoiiJJdg3
         9gL2NTuRCBFv92Xcs/SzhPL4I+GQMlCNdnAyeoieiumT+FArMtUcfxeWmBE0IWzalHB+
         FXhwhjP+iLSMmIsP2XTo6GWoM51x3babDxnBHWxH8r9m84dyn+SwDybEJ7SEu+8zr+4V
         0/mlvAr9WYjOk7sKgz1vNPKpudCwee94enaZbN7DtdPgKkq8nND/Ln7EljoLLJbW8bpz
         CXmw==
X-Received: by 10.66.25.232 with SMTP id f8mr33633551pag.25.1378228302265;
        Tue, 03 Sep 2013 10:11:42 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xn12sm25265552pac.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Sep 2013 10:11:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130903170419.GA29921@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233741>

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
Thanks for reading.

 t/t6101-rev-parse-parents.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 8a6ff66..b5fa9e4 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -14,14 +14,15 @@ test_cmp_rev_output () {
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
