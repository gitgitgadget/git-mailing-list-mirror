From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Skip Perl interface (Git.pm) tests if requirements not fullfilled
Date: Sun, 29 Jun 2008 22:32:40 +0200
Message-ID: <1214771560-14005-1-git-send-email-jnareb@gmail.com>
References: <alpine.LFD.1.10.0806291241210.27776@hp.linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Lea Wiemann <LeWiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 29 22:33:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD3af-0005iv-MM
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 22:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329AbYF2Ucp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 16:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754843AbYF2Ucp
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 16:32:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:18431 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbYF2Ucp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 16:32:45 -0400
Received: by nf-out-0910.google.com with SMTP id d3so353964nfc.21
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 13:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SMZSLanmH6UWZSJ6/pFUEgMl1Vt6MTzhO3yTMUzbGNc=;
        b=LCtVmvJFF3wVwQ8MeV0TmHXCUek0P4f2gHdnHaTTBRk4oztORNW0UZ9sNOQhspLZJL
         Uu3WcK0+Po7Z67ggftfiPq8DgyVhgT6QFM1Rm7Yp10MIcypby3WPJAaovq/zUHPEDM+G
         Ubn50cezcbSEq0CdKLZ9IY76T/+4BVrRRBjDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b+XB/tKbGFFn/KoPqiiu+yOZ9U2ZokQaSS6qSmCGPJmK/0gL6y+A7S7WdOb0KEDnDC
         JVoDLIKA3utg3Iv3/kJJekyKDg4Nw3fPIdK5IdFD79jLYP5hl6yd7iRr5G6dqOeJ8SGK
         E5ISUkRa/z6SgFrGT/qwJC80lRHVf5CBQbBLc=
Received: by 10.210.28.4 with SMTP id b4mr3456298ebb.40.1214771563433;
        Sun, 29 Jun 2008 13:32:43 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.214.210])
        by mx.google.com with ESMTPS id f8sm2909928nfh.35.2008.06.29.13.32.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Jun 2008 13:32:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5TKWgfk014027;
	Sun, 29 Jun 2008 22:32:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5TKWe9I014026;
	Sun, 29 Jun 2008 22:32:40 +0200
X-Mailer: git-send-email 1.5.6
In-Reply-To: <alpine.LFD.1.10.0806291241210.27776@hp.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86831>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Linus Torvalds wrote:

> Wouldn't it be a lot more polite to just not run the test when the 
> Test::More stuff doesn't exist? Rather than failing the testsuite? From a 
> quick "git grep", this test is the only one that uses Test::More...

Would this be enough?

 t/t9700-perl-git.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index b2fb9ec..81ff84d 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -6,6 +6,18 @@
 test_description='perl interface (Git.pm)'
 . ./test-lib.sh
 
+perl -MTest::More -e '' >/dev/null 2>&1 || {
+	test_expect_success 'skipping Git.pm tests, Test::More module not found' :
+	test_done
+	exit
+}
+
+perl -e 'use 5.006002;' >/dev/null 2>&1 || {
+	test_expect_success 'skipping Git.pm tests, Perl version too old' :
+	test_done
+	exit
+}
+
 # set up test repository
 
 test_expect_success \
-- 
1.5.6
