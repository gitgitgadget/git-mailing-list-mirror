From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 02/20] contrib/examples/git-clone.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:45 -0700
Message-ID: <1402066563-28519-3-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZ9-0001nQ-46
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbaFFO4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:12 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:42615 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbaFFO4K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:10 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so2578012pbb.13
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1kkBTyRWAvNKPLvU7dO/90H+NnxMWM0LGRqJymKgHzU=;
        b=CRmuaMqUjoiw368RyL21D5g6sYoddNNj1WmBOAZfjhcurUvcrSwX57Xq5QMljAEgXK
         7NJCiuPSZxfdH/mh7KrsLuaz4xsDKUQ/X5UHr5R8QrICSdApambszZkbd9lQEUCC50fU
         /9SOhvCM1Im3gasu76QYW1gjJ7yXye7gMKS+IUmzx1gjRYGEBFXUJtYvpicr9KyMN/ph
         tjHizq+otrW6mZzvKRxfpTfCBP0EUtpiFp5tY/0nhWz+RUiCUlWH/AX5kr/GNl8U9r8/
         gFn7z9+8/vkpnOU7bRe7LvRytokHM1AyYibD8o6vel2cOCbxSJQKyEGom/k3LXLg8K3X
         95fw==
X-Received: by 10.68.231.7 with SMTP id tc7mr1759286pbc.32.1402066569583;
        Fri, 06 Jun 2014 07:56:09 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250921>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/examples/git-clone.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/examples/git-clone.sh b/contrib/examples/git-clone.sh
index b4c9376..08cf246 100755
--- a/contrib/examples/git-clone.sh
+++ b/contrib/examples/git-clone.sh
@@ -516,7 +516,7 @@ then
 
 	case "$no_checkout" in
 	'')
-		test "z$quiet" = z -a "z$no_progress" = z && v=-v || v=
+		test "z$quiet" = z && test "z$no_progress" = z && v=-v || v=
 		git read-tree -m -u $v HEAD HEAD
 	esac
 fi
-- 
1.7.10.4
