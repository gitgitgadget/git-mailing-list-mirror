From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 12/23] Introduce --checked-out
Date: Sat, 23 Apr 2011 17:22:41 +1000
Message-ID: <1303543372-77843-13-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:25:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXDO-0005Sr-SV
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470Ab1DWHYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46605 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab1DWHYX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:23 -0400
Received: by pwi15 with SMTP id 15so594299pwi.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=tjBzPFcUIPnP4JNRvQHsftJclAjXqIHTOWZJWQChs60=;
        b=q40DJyPl0s4nl9usAhoFc5lU5sxQeE3KMBQr1H8+E/z5CsmD4WPbPT3nsz90355ce/
         EphGcMF20zW1e1s+whSM9jWYWUFAzBGcLwi3tRG9oVbVSKtDqdz+jUFpdfkbHgEYgUJl
         6ofZqvHbaExWsxBTxhK4HOGAIB5grohvRLgmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SyHjp85S0YADSL+a5m+A6evuouBWD9q34U/eoLeQ23Cv7BbKA2/Ecjwk6xpugTjrfV
         FxAyWiep7lp7mUuizqwzQGDj7parVZt+YWlbr6P0uyAo7aEwjXj4Y5RB80cVaNls4o7K
         DU86kPCVi7E88nmN3GZ+p8KFqATKWZrKgGCVM=
Received: by 10.68.48.228 with SMTP id p4mr604196pbn.490.1303543462565;
        Sat, 23 Apr 2011 00:24:22 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171977>

---
 Documentation/git-test.txt |    2 ++
 git-conditions-lib.sh      |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index 9a4e06f..f76aa38 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -84,6 +84,8 @@ CONDITIONS
         Tests if the specified reference does (not) exist.
 '--commit-exists'|'--not-commit-exists commit'::
 	Tests if the specified commit does (not) exist.
+'--checked-out'|'--not-checked-out branch'::
+        Tests if the specified branch is (not) checked out.
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index af376d1..3eccc19 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -122,5 +122,19 @@ check_commit_exists_1()
 	fi
 }
 
+check_checked_out_1()
+{
+	branch="$(git rev-parse --quiet --symbolic-full-name --verify "$1")"
+	headref="$(git symbolic-ref HEAD)"
+	if test "${headref}" = "${branch}" -a -n "${branch}"
+	then
+		echo "'$1' is checked out."
+	else
+		echo "'$1' is not checked out."
+		false
+	fi
+
+}
+
 
 fi
-- 
1.7.5.rc1.23.g7f622
