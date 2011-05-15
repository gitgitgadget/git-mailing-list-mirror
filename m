From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [RFC PATCH 1/2] sh-setup: Make die take the error code as param.
Date: Sun, 15 May 2011 14:42:20 +0200
Message-ID: <1f45f5634f08cb0f63d61d8b734a2cf7bebf591b.1305462132.git.iveqy@iveqy.com>
References: <cover.1305462132.git.iveqy@iveqy.com>
Cc: jens.lehmann@web.de, hvoigt@hvoigt.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 14:42:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLaeX-0004e6-Db
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 14:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645Ab1EOMmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 08:42:23 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42702 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab1EOMmW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 08:42:22 -0400
Received: by eyx24 with SMTP id 24so1045468eyx.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references:in-reply-to:references;
        bh=2hI/kbwhtodXfkUzpegZY+fekwQEXvRL7galBHxEQx8=;
        b=YXGXk89PZE2vDYU6RPnV3op1NYkg4GNxNSiOb4JAX5KjV181cx8r4gzmLrKhnXWtBg
         D+zbluqan6X7c62XF5H4u+fArFPhlQMAiJwsjtDwXBBvFnBJuJ9zryWoeic55VbnAPWH
         8W0mqwLZ/JKQlVJ7hSsrIXbKKM0SJut1t8mGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=YiUef5D0RelmHSo47do1YtFJdFu3PLnUOTQFdjLLDm9r6VGo0IvRSvjA2w2lnRMtcx
         9nMxdoK/va1oopFNjlmCf82KZvXCA26y0QLp0sI5vOHzjoYvzL2fh0iYhsIhe/hRcnTY
         rZu2e2ipdffDk+fhvX/nWdbKYham2XbgGX2ME=
Received: by 10.213.16.199 with SMTP id p7mr1390768eba.99.1305463340890;
        Sun, 15 May 2011 05:42:20 -0700 (PDT)
Received: from kolya (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id y3sm2717502eeh.19.2011.05.15.05.42.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 May 2011 05:42:20 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QLaeL-0005CF-Te; Sun, 15 May 2011 14:42:21 +0200
X-Mailer: git-send-email 1.7.5.1.219.ge2152.dirty
In-Reply-To: <cover.1305462132.git.iveqy@iveqy.com>
In-Reply-To: <cover.1305462132.git.iveqy@iveqy.com>
References: <cover.1305462132.git.iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173627>

die used to print all parameters and then exit with code 1. Now die
prints the first parameter and uses the optional second parameter as the
exit code. The default exit code is 1.

This allows scripts to control the exit code when they call die.

All current git-code only uses the first parameter of die today so this
change has no impact on them.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-sh-setup.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index aa16b83..6aa6c59 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -40,7 +40,11 @@ git_broken_path_fix () {
 # @@BROKEN_PATH_FIX@@
 
 die() {
-	echo >&2 "$@"
+	echo >&2 "$1"
+	if test $2
+	then
+		exit $2
+	fi
 	exit 1
 }
 
-- 
1.7.5.1.219.ge2152.dirty
