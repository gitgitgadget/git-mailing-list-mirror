From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 1/3] git am: Set cmdline globally
Date: Wed,  2 Jun 2010 10:33:35 +0200
Message-ID: <1275467617-23065-2-git-send-email-artagnon@gmail.com>
References: <1275467617-23065-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 10:39:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJjU2-0002Eb-2w
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 10:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305Ab0FBIjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 04:39:23 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:40100 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab0FBIjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 04:39:22 -0400
Received: by ewy23 with SMTP id 23so553452ewy.1
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 01:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=t/AEY89+uFn7J+l2+2pC6kvHVVaTy2WcRMcdB6FaTfI=;
        b=LQJfWMhRpKTCC2D6/P7juRWbmKy8xSRgOkThJ93nqnTHmpV+RAmALdSgl0/TYI9yB1
         P37o9ncFYrj3LQ0W/ZKrLVAMijIz5JNU2zGHjJnwct3hxLFEWaP7FnKevIk2c3X4hc1y
         xxAROcKvcVtxEUiq20MUt6UOthTbDJtLn3a/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s1f1waX4uZH5fngKiMMplIoyJFSnGaQtvRE/v8nBA5Tsht4MpshyOQeve2UPcQnUlc
         NwhtFGKtQRR9B0wOpL/GFvDoKnWwuiAWm3hqCxrePND+NqfKw+Z0qspIg11UDklfL12/
         ajg66EbtVrtbj0aQ0ehw3Nx0haHvxkApuktIA=
Received: by 10.213.35.72 with SMTP id o8mr4611185ebd.51.1275467538513;
        Wed, 02 Jun 2010 01:32:18 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 15sm4266349ewy.8.2010.06.02.01.32.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 01:32:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275467617-23065-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148228>

Set the $cmdline variable globally, and not in stop_here_user_resolve
so it can be used in other code fragments as well.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 87ffae2..b75358b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -52,6 +52,16 @@ else
 	HAS_HEAD=
 fi
 
+cmdline="git am"
+if test '' != "$interactive"
+then
+	cmdline="$cmdline -i"
+fi
+if test '' != "$threeway"
+then
+	cmdline="$cmdline -3"
+fi
+
 sq () {
 	git rev-parse --sq-quote "$@"
 }
@@ -66,15 +76,6 @@ stop_here_user_resolve () {
 	    printf '%s\n' "$resolvemsg"
 	    stop_here $1
     fi
-    cmdline="git am"
-    if test '' != "$interactive"
-    then
-        cmdline="$cmdline -i"
-    fi
-    if test '' != "$threeway"
-    then
-        cmdline="$cmdline -3"
-    fi
     echo "When you have resolved this problem run \"$cmdline --resolved\"."
     echo "If you would prefer to skip this patch, instead run \"$cmdline --skip\"."
     echo "To restore the original branch and stop patching run \"$cmdline --abort\"."
-- 
1.7.1
