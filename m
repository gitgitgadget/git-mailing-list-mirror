From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 04/20] contrib/examples/git-merge.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:47 -0700
Message-ID: <1402066563-28519-5-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZ9-0001nQ-Ku
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbaFFO4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:14 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:60889 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbaFFO4M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:12 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so2516342pde.32
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MDVBQfZMAwUjA6O1Xac924gTkGoR9w6eDMvIxWiVXyA=;
        b=OpefWcGPo0w9G2QkiYQGgVJ15NlM5CP9I3rHrUxrTDd4GXFtHQu+lFsGzI4zLDsfKW
         5bMq7n2DQS/gCXGq0BFkyI1Y1tV+7Pe+Eau0MsichIpjsH+JfnGU5DtiPclxr5DIQOdr
         c9aBhkiWBkR103icNfTO0wUo0mSiekvKHfDmqZjG7db7CC9iCAtts0MUuLiH+QDTfTtW
         sSSzBaIv4BYSALZ4ME8lmKt5JOJe0+ctK5hoiiWxL2ErlQ82YMWFfgSdtwQeaQAXIG/8
         4MxzDzGbdyNC31Qil1r9XOgrJxZfaHiOq3skbIZoJPZ4uxn8KNjdlAE+fscILr90WrD+
         dGuw==
X-Received: by 10.68.139.194 with SMTP id ra2mr1784057pbb.20.1402066571577;
        Fri, 06 Jun 2014 07:56:11 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250922>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/examples/git-merge.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 7e40f40..52f2aaf 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -161,7 +161,7 @@ merge_name () {
 			return
 		fi
 	fi
-	if test "$remote" = "FETCH_HEAD" -a -r "$GIT_DIR/FETCH_HEAD"
+	if test "$remote" = "FETCH_HEAD" && test -r "$GIT_DIR/FETCH_HEAD"
 	then
 		sed -e 's/	not-for-merge	/		/' -e 1q \
 			"$GIT_DIR/FETCH_HEAD"
@@ -527,7 +527,7 @@ do
 		git diff-files --name-only
 		git ls-files --unmerged
 	    } | wc -l`
-	    if test $best_cnt -le 0 -o $cnt -le $best_cnt
+	    if test $best_cnt -le 0 || test $cnt -le $best_cnt
 	    then
 		best_strategy=$strategy
 		best_cnt=$cnt
-- 
1.7.10.4
