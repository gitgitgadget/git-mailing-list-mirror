From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 1/5] correct argument checking test for git hash-object
Date: Sun,  3 Aug 2008 18:36:18 +0400
Message-ID: <1217774182-28566-1-git-send-email-dpotapov@gmail.com>
References: <20080803055602.GN7008@dpotapov.dyndns.org>
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 16:37:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPeiF-0007u3-82
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 16:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbYHCOg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 10:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755254AbYHCOg3
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 10:36:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:5157 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591AbYHCOg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 10:36:28 -0400
Received: by nf-out-0910.google.com with SMTP id d3so606841nfc.21
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=my9ZUiDPPePrKoCV8KrqWic6F1Xsk3DXTkQ7LzdCRcw=;
        b=Q7hxhpLUHBWSZaBzIpl0E/7ThwYoktELMEnu10wi4KaOYqmStbtvTQtY0Ef4GyXA4h
         88n2+5HQ1GExR4b35vmU3TrSVfy/j3oumnTsj8hpt96Ttbuyc8pi2hUY8r44hBO8JD9P
         Sw/lpQpl7Bk4FJt71En9K84ZzZBe5tvlAmizM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TVfr1QVgF02SoRcM6t9z3xsF3ZhLZqIWWhVeZdfqjAXoVg0fjc1r1wy8Emzc+zYG2w
         2Bv6YIKP/U6aRoxoG/qJ4grPoZCO8URPZu8MJPxKJH4RZaSIV42+sgmCZQJBOYfg9e/a
         sbGMu6ppUSssZLqZ6Eq6LwZl85fHkJj+IzWew=
Received: by 10.210.24.7 with SMTP id 7mr15685113ebx.178.1217774186896;
        Sun, 03 Aug 2008 07:36:26 -0700 (PDT)
Received: from localhost ( [85.141.191.110])
        by mx.google.com with ESMTPS id c4sm7354459nfi.13.2008.08.03.07.36.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 07:36:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.58.gacdf
In-Reply-To: <20080803055602.GN7008@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91244>

Because the file name given to stdin did not exist, git hash-object
will fail to open it and exit with non-zero error code even if there
is no check of arguments. Thus the test may pass despite the obvious
error in argument checking.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 t/t1007-hash-object.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 1ec0535..6d505fa 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -49,16 +49,16 @@ setup_repo
 # Argument checking
 
 test_expect_success "multiple '--stdin's are rejected" '
-	test_must_fail git hash-object --stdin --stdin < example
+	echo example | test_must_fail git hash-object --stdin --stdin
 '
 
 test_expect_success "Can't use --stdin and --stdin-paths together" '
-	test_must_fail git hash-object --stdin --stdin-paths &&
-	test_must_fail git hash-object --stdin-paths --stdin
+	echo example | test_must_fail git hash-object --stdin --stdin-paths &&
+	echo example | test_must_fail git hash-object --stdin-paths --stdin
 '
 
 test_expect_success "Can't pass filenames as arguments with --stdin-paths" '
-	test_must_fail git hash-object --stdin-paths hello < example
+	echo example | test_must_fail git hash-object --stdin-paths hello
 '
 
 # Behavior
-- 
1.6.0.rc1.58.gacdf
