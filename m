From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 03/20] contrib/examples/git-commit.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:46 -0700
Message-ID: <1402066563-28519-4-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:57:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZw-0002H4-JD
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbaFFO5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:57:04 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:38627 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbaFFO4L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:11 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so2582478pbb.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nwbbSSe6x9OVW3lomw5VX/Cs9ux5s8q2HQNXQ0kABLI=;
        b=iaNkVPuGRUiDsXq6EgzGBW4yp/HAhonJkwUXqIMRl0ub/Tduesny/ews3PMsauD7ti
         +UZlZI8wd24a+l2pWsI15GM5ordiGi4JQ/Aj+NVvU8/EVk3A656f5B7roqDsCMxpZamU
         dY095q8i36cNuJEu2rg+bXKLhPkHrUCdjE7rSnnQHYO4/tHMFKTRduX/kMNIXOxsIGkA
         A/d/8iJkbVwlnGNrklmSYWJ9MVWQ/hmTEkUMCrViGCny67zfYEYhdQypucobMm1PG6+A
         cqypRSRyFxc2gly4EFl58kUKUXKonPSoBnnfpLBEvQrXrCvm/AxEJFtakQiTxD/8vBo6
         E5uQ==
X-Received: by 10.68.202.194 with SMTP id kk2mr1537231pbc.156.1402066570558;
        Fri, 06 Jun 2014 07:56:10 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250939>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/examples/git-commit.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-commit.sh
index 5cafe2e..934505b 100755
--- a/contrib/examples/git-commit.sh
+++ b/contrib/examples/git-commit.sh
@@ -51,7 +51,7 @@ run_status () {
 		export GIT_INDEX_FILE
 	fi
 
-	if test "$status_only" = "t" -o "$use_status_color" = "t"; then
+	if test "$status_only" = "t" || test "$use_status_color" = "t"; then
 		color=
 	else
 		color=--nocolor
@@ -296,7 +296,7 @@ t,,,[1-9]*)
 	die "No paths with -i does not make sense." ;;
 esac
 
-if test ! -z "$templatefile" -a -z "$log_given"
+if test ! -z "$templatefile" && test -z "$log_given"
 then
 	if test ! -f "$templatefile"
 	then
-- 
1.7.10.4
