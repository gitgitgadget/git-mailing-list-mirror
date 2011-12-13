From: mhagger@alum.mit.edu
Subject: [PATCH 1/6] t5519: push two branches to alternate repo
Date: Tue, 13 Dec 2011 21:06:46 +0100
Message-ID: <1323806811-5798-2-git-send-email-mhagger@alum.mit.edu>
References: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 21:07:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaYd1-0001JV-Dd
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 21:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687Ab1LMUHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 15:07:01 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:37191 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab1LMUHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 15:07:00 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RaYUN-0006aj-Bd; Tue, 13 Dec 2011 20:58:11 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187051>

From: Michael Haggerty <mhagger@alum.mit.edu>

Since each branch in the alternate repo results in an "extra_ref"
named ".have", pushing two of them results in two extra_refs with the
same name.  This change to the test therefore makes sure that we can
handle extra_refs names that are not unique.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

I'm not sure how well this change fits into the other things that the
test wants to do, but it triggers the failure mode in ref-api-D v2
that was predicted by Junio.

 t/t5519-push-alternates.sh |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
index c00c9b0..315f65d 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -17,7 +17,15 @@ test_expect_success setup '
 		>file &&
 		git add . &&
 		git commit -m initial &&
-		git push ../alice-pub master
+		git checkout -b foo &&
+		>file1 &&
+		git add . &&
+		git commit -m file1 &&
+		git checkout master &&
+		>file2 &&
+		git add . &&
+		git commit -m file2 &&
+		git push ../alice-pub master foo
 	) &&
 
 	# Project Bob is a fork of project Alice
-- 
1.7.8
