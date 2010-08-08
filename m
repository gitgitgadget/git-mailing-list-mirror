From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 1/9] stash: refactor - create pop_stash function
Date: Sun,  8 Aug 2010 14:46:03 +1000
Message-ID: <1281242771-24764-2-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, nanako3@bluebottle.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 06:47:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhxnK-0007jr-7x
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 06:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814Ab0HHErb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 00:47:31 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63422 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab0HHEr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 00:47:27 -0400
Received: by pwj7 with SMTP id 7so971854pwj.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 21:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=W9C40u3P8aCPHI4J1rMdXekEzOKBqp0s+64Lp27D4do=;
        b=LrW3Bh/NON6KUsxBbhl79PZfEK/e5IywdYdwsLL2tjQjRg7hjoDmxxPq5UT6tq0xaa
         AZ/Xn/A2yX42sE3ToFZ6UnpfR4Qg6OSH8gycc5Hvon23osTYesJvgQ8Pckq+8mUiTHam
         7tzURv7rcoUNb5L1Mqp0nKECYYiwa/u69jsww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dnJsPIsfieyP4gLWxTRTCGJnsEhode7NgHdNc9/0RidlntSzjberJr1hVxwmLYS9Ja
         kHP67kVe3jYeSGsG/a5mf35tHKEH6N+MFYh2K8+/YtAHxiVSiSwq4nUsNxXlALQ1FYex
         bhgNtB77vls5O1qmFwfvGdwbJHUk+cdjXkOSs=
Received: by 10.142.211.6 with SMTP id j6mr12179131wfg.98.1281242846876;
        Sat, 07 Aug 2010 21:47:26 -0700 (PDT)
Received: from localhost.localdomain ([120.16.216.92])
        by mx.google.com with ESMTPS id n2sm4295884wfl.13.2010.08.07.21.47.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 21:47:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.47.gc532
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152885>

We plan to edit pop_stash later, so let's make it a first class
command by giving its own implementation function.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1d95447..31ea333 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -323,6 +323,13 @@ apply_stash () {
 	fi
 }
 
+pop_stash() {
+	if apply_stash "$@"
+	then
+		drop_stash "$applied_stash"
+	fi
+}
+
 drop_stash () {
 	have_stash || die 'No stash entries to drop'
 
@@ -422,10 +429,7 @@ drop)
 	;;
 pop)
 	shift
-	if apply_stash "$@"
-	then
-		drop_stash "$applied_stash"
-	fi
+	pop_stash "$@"
 	;;
 branch)
 	shift
-- 
1.7.2.1.51.g82c0c0
