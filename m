From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/6] rebase: use 'git stash store' to simplify logic
Date: Mon, 13 May 2013 18:15:54 +0530
Message-ID: <1368449154-21882-7-git-send-email-artagnon@gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 14:44:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubs7H-0003rq-BN
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 14:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574Ab3EMMod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 08:44:33 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:33030 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab3EMMo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 08:44:29 -0400
Received: by mail-pb0-f41.google.com with SMTP id xb12so443130pbc.0
        for <git@vger.kernel.org>; Mon, 13 May 2013 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ncUYNYonqjkHG+RoHTQtTzfWUaAp6nwEEdYSk+DZju8=;
        b=OI8JUBOE2xP4u0S4WXxZmOslLLfNYgmpbfqkvt8ex0gMkIiQXZrSpBikt9tgY0h8Gn
         EaAVnB6Fwp6rgg6NuSBMv/aL10Roz5YpC928KS4m3K2zcCQa+11HGmigGCAdnFUGmLsP
         DFFpy+yK/tvaS1LSSAaD/yPMoFdgAe0tgKl2aY/Z+wrWW0W5D0z8yLYGhgfwqpCZqUWy
         DhWBYqFt9Zp6dNld2/Ot5CKqiAj5C8wru+/117oo77RYJ0eX05OAlsno9M+fjqr6O4b6
         owGg/9TmmL0QMHHlhhT7025+/E/932QN8pm8QkLXlfsYO+cgK91ZlIMMi8bkuuIH8O2E
         tWjw==
X-Received: by 10.66.161.227 with SMTP id xv3mr29208532pab.82.1368449068753;
        Mon, 13 May 2013 05:44:28 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id rn7sm3050227pbc.12.2013.05.13.05.44.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 05:44:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.57.g4ac1522
In-Reply-To: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224129>

rebase has no reason to know about the implementation of the stash.  In
the case when applying the autostash results in conflicts, replace the
relevant code in finish_rebase () to simply call 'git stash store'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index f4a3a26..7c82f95 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -153,11 +153,7 @@ finish_rebase () {
 		then
 			gettext "Applied autostash."
 		else
-			ref_stash=refs/stash &&
-			: >>"$GIT_DIR/logs/$ref_stash" &&
-			git update-ref -m "autostash" $ref_stash $stash_sha1 ||
-			die "$(eval_gettext 'Cannot store $stash_sha1')"
-
+			git stash store $stash_sha1 "autostash" &&
 			gettext 'Applying autostash resulted in conflicts.
 Your changes are safe in the stash.
 You can run "git stash pop" or "git stash drop" at any time.
-- 
1.8.3.rc1.57.g4ac1522
