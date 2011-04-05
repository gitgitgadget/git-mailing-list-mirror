From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] stash: fix false positive in the invalid ref test.
Date: Wed,  6 Apr 2011 09:21:13 +1000
Message-ID: <1302045673-59982-1-git-send-email-jon.seymour@gmail.com>
Cc: peff@peff.net, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 01:22:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7FZT-0004cf-6U
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 01:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab1DEXV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 19:21:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52315 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab1DEXV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 19:21:57 -0400
Received: by iyb14 with SMTP id 14so868482iyb.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 16:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=xL651Dj6/NvmY88klK7zOG8KmDW0ShPABXuyhPCsQEg=;
        b=cdPbeQk0pa0TVGQ+ZA+AjL70sotVe8G8wXsC0Eosci2j/aMPJza4Kmt0ENwxaLeEFL
         +jf7lkTzwaTcZbvd74b/St4Ch6AoYGS+G0Qo9AlpiZDelBIowo9T5Ni7oUYf+nub27Lb
         1Gl57VIZywLunf/dPgpzcLE6MPBX6xisg2syc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AllA8vxTMB/kxHf1IJ29jjwvcFxCf6FHTT513Cza2/zFGRlTvJmyW8aYxmAB33S7W6
         a2098NamnPNqZmyLjiwG0oje0n2I7ZB1CkzLTF8Ktohw34XjenLv/kTK08oVw+mmacdw
         PkTXyOY+X3IMTsR0lHCMsDyP8QlUjhv4iYpgo=
Received: by 10.42.138.74 with SMTP id b10mr445451icu.367.1302045717341;
        Tue, 05 Apr 2011 16:21:57 -0700 (PDT)
Received: from localhost.localdomain (124-168-187-53.dyn.iinet.net.au [124.168.187.53])
        by mx.google.com with ESMTPS id xi12sm4439935icb.6.2011.04.05.16.21.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 16:21:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc0.132.g4c19c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170938>

Jeff King reported a problem with git stash apply incorrectly
applying an invalid stash reference.

There is an existing test that should have caught this, but
the test itself was broken, resulting in a false positive.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3903-stash.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 11077f0..5263de7 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -543,11 +543,11 @@ test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
 	echo bar6 > file2 &&
 	git add file2 &&
 	git stash &&
-	test_must_fail git drop stash@{1} &&
-	test_must_fail git pop stash@{1} &&
-	test_must_fail git apply stash@{1} &&
-	test_must_fail git show stash@{1} &&
-	test_must_fail git branch tmp stash@{1} &&
+	test_must_fail git stash drop stash@{1} &&
+	test_must_fail git stash pop stash@{1} &&
+	test_must_fail git stash apply stash@{1} &&
+	test_must_fail git stash show stash@{1} &&
+	test_must_fail git stash branch tmp stash@{1} &&
 	git stash drop
 '
 
-- 
1.7.5.rc0.132.g4c19c
