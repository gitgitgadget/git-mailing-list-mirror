From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] fixup! rebase: implement --[no-]autostash and rebase.autostash
Date: Wed, 29 May 2013 16:41:20 +0530
Message-ID: <1369825880-8608-1-git-send-email-artagnon@gmail.com>
References: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 13:12:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UheJI-0000mU-Q5
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 13:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965697Ab3E2LMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 07:12:48 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39788 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965579Ab3E2LMr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 07:12:47 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so8709579pdi.21
        for <git@vger.kernel.org>; Wed, 29 May 2013 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GM+TjwL6qiBJAxBDscZph3dnuam6ZFP4rpVLwoMg/tI=;
        b=Zu+UhaCVqYpPSfWN/f9jM0zf+cjc524pu8/wHfQLT5nz3dh2y/X7sauCQLB72c5Bl8
         LfvJwerSSjGBWom7FPz3MPi75ZUHPeFtee9fhqNHfa5HIsPpbiZvDn03clDzO8Ez3eI3
         l7gcaQtb6m9CLBTqClVus70h5ljU4ZoB6VnCkEOhscUyBUZiar7kZ1mwuZUw0CUvWzWa
         vwVAf9vYuiPHTpy++lvmn+SzqU6IRPoLS1bxh6pn6yN802gmxtkOAiievxma75nn1FIj
         6bxxTH5ndfjAnR09PTeDm/Pjxz2fU+LqvIZI4P83dDN8SwDzoHrSK/BU9m66l5OrBvmj
         khtw==
X-Received: by 10.68.177.33 with SMTP id cn1mr2268463pbc.189.1369825967463;
        Wed, 29 May 2013 04:12:47 -0700 (PDT)
Received: from localhost.localdomain ([122.164.41.150])
        by mx.google.com with ESMTPSA id k8sm32733755pag.18.2013.05.29.04.12.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 04:12:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.8.g8321729
In-Reply-To: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225785>

For rr/rebase-autostash, which is stalled in pu.  See $gmane/225689.

This is a super-minor fix anyway: if you disagree with something, change
it; there's no need to ask me.

As for the follow-up introducing a 'stash store', I will submit it in
good time: there's no hurry.  I'm working on some other interesting
things in the meantime (see hot-branch and @{push}).

Thanks.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 709ef6b..5906757 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -151,16 +151,16 @@ finish_rebase () {
 		stash_sha1=$(cat "$state_dir/autostash")
 		if git stash apply $stash_sha1 2>&1 >/dev/null
 		then
-			echo "Applied autostash"
+			echo "$(gettext 'Applied autostash.')"
 		else
 			ref_stash=refs/stash &&
 			: >>"$GIT_DIR/logs/$ref_stash" &&
 			git update-ref -m "autostash" $ref_stash $stash_sha1 \
 				|| die "$(eval_gettext 'Cannot store $stash_sha1')"
-			echo "
-$(gettext 'Applying autostash resulted in conflicts.
+			gettext 'Applying autostash resulted in conflicts.
 Your changes are safe in the stash.
-You can apply or drop it at any time.')"
+You can run "git stash pop" or "git stash drop" it at any time.
+'
 		fi
 	fi
 	git gc --auto &&
-- 
1.8.3.rc3.11.geb5ebca
