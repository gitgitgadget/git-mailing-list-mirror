From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] Mark tests that use symlinks as needing SYMLINKS prerequisite
Date: Thu, 12 Aug 2010 20:09:12 -0600
Message-ID: <1281665352-10533-3-git-send-email-newren@gmail.com>
References: <1281665352-10533-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Johannes Sixt <j.sixt@viscovery.net>,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 04:02:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojjb6-0007Eq-5e
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 04:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761273Ab0HMCCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 22:02:00 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44275 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761261Ab0HMCBw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 22:01:52 -0400
Received: by gyg10 with SMTP id 10so683320gyg.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 19:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FW0lRY08dh1+SW5Qc0RPOk1CUh8jRKzK6CtECSVbpwE=;
        b=cMvZovVSj2vveZUBMlgrDB8wdCPmAxQ1hGEvF9P8MXTvDPp8j3plfxqSzCQi0oTH9K
         dWMCh0gsJnYP3qKyMfvkHol9tDW8FH0vKVm/yACY2MJtxSgfNzQwjgerRJkOxe227eB1
         2/Ixzgl6Vqy4DfWQsoj+AUnbsIhzCJgXi/vzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z+L3n1ZqYC2m1naUwyKYCQuQWXLrss/kWw6u+0pCUmIjwqCPWwfysVPxybmPbs+3i0
         GhvzBD02DHLduKHoysauV5TA/iXgU1tLXNq1WI/uStsbVvKZp2H+Tu2bCFGQFWrYYqrw
         hjM+bAzHfmSQL21bLvy+8M0ED2acvZDr6e4FI=
Received: by 10.231.146.141 with SMTP id h13mr1018866ibv.1.1281664912211;
        Thu, 12 Aug 2010 19:01:52 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id h8sm625597ibk.21.2010.08.12.19.01.50
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 19:01:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.121.gb1ae7a
In-Reply-To: <1281665352-10533-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153459>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3509-cherry-pick-merge-df.sh |    6 ++++++
 t/t9350-fast-export.sh          |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index 6e7ef84..93ad20d 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -3,6 +3,12 @@
 test_description='Test cherry-pick with directory/file conflicts'
 . ./test-lib.sh
 
+if ! test_have_prereq SYMLINKS
+then
+	skip_all="symbolic links not supported - skipping tests"
+	test_done
+fi
+
 test_expect_success 'Setup rename across paths each below D/F conflicts' '
 	mkdir a &&
 	>a/f &&
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 1ee1461..27aea5c 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -376,7 +376,7 @@ test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
-test_expect_success 'directory becomes symlink'        '
+test_expect_success SYMLINKS 'directory becomes symlink'        '
 	git init dirtosymlink &&
 	git init result &&
 	(
-- 
1.7.2.1.119.gca9fe.dirty
