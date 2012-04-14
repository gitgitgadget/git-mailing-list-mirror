From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] test: am of empty patch should not succeed
Date: Fri, 13 Apr 2012 23:48:13 -0500
Message-ID: <20120414044813.GD1791@burratino>
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
	Jiang Xin <worldhello.net@gmail.com>,
	Jim Meyering <jim@meyering.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 06:48:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIuuP-0004uQ-7w
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 06:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab2DNEsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 00:48:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47968 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab2DNEsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 00:48:20 -0400
Received: by iagz16 with SMTP id z16so5108054iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 21:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AQCpm0K4D9MrCytf1xaEg9gNrowpUd5V5hZIX3a4ahk=;
        b=0sEFwP1Zf/oF5c2m6/rnPhheh/Dhf292MXG5NGE7SvWGyXPi607rVmYpub9QAuzddP
         HT1NqErSsaRFIJl1UfGmuG1TBM5ALLuFX4Tq5SfBUkqk4ZJ7Vfy3cBvPVovZ238VAYZz
         sW1LjwYvvDUCc5ZhE5rYA1gyiNN4M+SuMLxm/chpeWdOVEjB6pbw0AoGI6ut/lJCxJUw
         j7+sebIQ23UMb6xzoIenCs8IGz9CfFUO3nxuQ/fKoDPdVaNFbBanXbdxEh8FI38fyJJD
         /mZ7kJSf5RMofLyAJ+UvUFgpUwbvQm+E0KC6Ls/fN3Dxt3iQ3gidc/+fXyqHYpFqIueq
         bVyA==
Received: by 10.50.190.163 with SMTP id gr3mr441821igc.24.1334378899592;
        Fri, 13 Apr 2012 21:48:19 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id fa7sm2428311igb.12.2012.04.13.21.48.18
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 21:48:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120414044413.GA1791@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195468>

The "git am empty" test uses the construct

	git am empty-file && false || :

which unconditionally returns true.  Use test_must_fail instead, which
also has the benefit of noticing if "git am" has segfaulted.

While at it, tighten the test to check that the diagnostic appears on
stderr and not stdout.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Tested this time.  Thanks for reading.

 t/t4150-am.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index ebb4a26a..cdafd7e7 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -525,7 +525,7 @@ test_expect_success 'am empty-file does not infloop' '
 	git reset --hard &&
 	touch empty-file &&
 	test_tick &&
-	{ git am empty-file > actual 2>&1 && false || :; } &&
+	test_must_fail git am empty-file 2>actual &&
 	echo Patch format detection failed. >expected &&
 	test_i18ncmp expected actual
 '
-- 
1.7.10
