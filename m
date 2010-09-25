From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] stash show: fix breakage in 1.7.3
Date: Sat, 25 Sep 2010 12:54:33 +1000
Message-ID: <1285383273-28378-1-git-send-email-jon.seymour@gmail.com>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: robbat2@gentoo.org, git@vger.kernel.org,
	brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Sat Sep 25 04:51:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzKrT-0004cb-BA
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 04:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab0IYCve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 22:51:34 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41274 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab0IYCvd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 22:51:33 -0400
Received: by pwj6 with SMTP id 6so775029pwj.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 19:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bStJVR2M/v8XNHSCbYgBQNb7KlCGCxmHmswOCXMx2gU=;
        b=gQhqNe1rxC9OC7sIF53d4XNELZU19DPxn6fwnLhBQNHCtwa4GzgT0nQRzuDXbwrqfv
         0zZiP4yMh8HuXFDICzgVzdOio5KFYnOZx3+4hmqQbmmbdU+qbKdpm6JsyvF2WuQ4bCHL
         5QTE11mFsK/XXVVs4OVMu21dbSmt6JD/Mtj1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UawK/CvQDuugHjgP+M/QIAYfF+5h+iLfWJpApwBJjJ09P+QAihriokHAWOvoQIiccn
         BSw8GSSvVtdOAIRRaqioDXjxAIOAqHu52R5wdhcKKX6z0sN/4XtH0aZutP7qi/CWW9On
         +CLVfoV3emiLZPlKT963lDINrydIGSiC/3mhA=
Received: by 10.142.225.19 with SMTP id x19mr3522357wfg.322.1285383093222;
        Fri, 24 Sep 2010 19:51:33 -0700 (PDT)
Received: from localhost.localdomain (124-169-4-134.dyn.iinet.net.au [124.169.4.134])
        by mx.google.com with ESMTPS id v3sm3145862wfv.23.2010.09.24.19.51.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 19:51:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.12.g8788e.dirty
In-Reply-To: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157107>

The detached-stash series regressed support for
   git stash show stash@{0}

due to a faulty assumption that
git rev-parse --no-revs stash@{0} would treat
stash@{0} as a revision reference and thus
not display it.

This patch restores the behaviour of git stash show
so that only flag like options are assigned
to the FLAGS variable and thus does not
depend git rev-parse behaviour so strongly.

It has been tested with Brandon Casey's improved t3903 tests.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Apologies for the breakage.
 Brandon: thanks for improving the tests.

 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 7ce818b..c2f1b2a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -282,7 +282,7 @@ parse_flags_and_rev()
 			--)
 				:
 			;;
-			*)
+			-*)
 				FLAGS="${FLAGS}${FLAGS:+ }$1"
 			;;
 		esac
-- 
1.7.2.12.g8788e.dirty
