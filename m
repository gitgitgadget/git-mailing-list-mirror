From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 05/20] contrib/examples/git-repack.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:48 -0700
Message-ID: <1402066563-28519-6-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:57:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZm-0002Aq-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbaFFO44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:56 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:41718 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbaFFO4M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:12 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so2513149pde.18
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBz0AEY6+EyrDyXp5DSvZpY8rFBTcY1lZ4jf8t3yBxI=;
        b=fWA5SvgelmRN81td6kE0LTLl+KM+MVpiaHteEmatnCK7p+3GWI7enFQjbUTO8oYYxP
         IK9TK3+rr3AFe5e5xb9etVGWJJ481No9jMB8PG/nwKR9PGKluEw4hr1TvKqSZXU+YQBz
         owgYpMfgDCJBu2Oh+xCUqFk9eGTIRvUBmvl8fx2O6qe4lwk9YbxKfIQ4ksBgMKCCGpSB
         726J0p3fX1FwKoW2sidixf7C0PVcZLSLe8/+pBbtX9lF41MrxoKVL5DkL0IIlG5UlN2i
         ReDfF/80MPyJKeBlTN/+luZBByEKMw3uCb2am5w9oicnCsPzjv9dtM2m6UdtC2A3mftw
         yBEg==
X-Received: by 10.68.164.67 with SMTP id yo3mr1629159pbb.104.1402066572474;
        Fri, 06 Jun 2014 07:56:12 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250936>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/examples/git-repack.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-repack.sh b/contrib/examples/git-repack.sh
index f312405..96e3fed 100755
--- a/contrib/examples/git-repack.sh
+++ b/contrib/examples/git-repack.sh
@@ -76,8 +76,8 @@ case ",$all_into_one," in
 				existing="$existing $e"
 			fi
 		done
-		if test -n "$existing" -a -n "$unpack_unreachable" -a \
-			-n "$remove_redundant"
+		if test -n "$existing" && test -n "$unpack_unreachable" && \
+			test -n "$remove_redundant"
 		then
 			# This may have arbitrary user arguments, so we
 			# have to protect it against whitespace splitting
-- 
1.7.10.4
