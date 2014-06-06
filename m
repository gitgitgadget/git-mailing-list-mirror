From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 17/20] t/t5538-push-shallow.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:56:00 -0700
Message-ID: <1402066563-28519-18-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZX-000227-H1
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbaFFO4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:38 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:54798 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbaFFO4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:24 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so2556919pbb.41
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sHSQJfm+EBeQKQb9vwussKted11AomwBjPiZJM2eIp8=;
        b=j86GIbsiHa1F4xQtBFUiGks0+OgMlISW+kGqrB6+4c+H/PYSBDr5Pt+6Wsyd/nA/Z5
         0TnxB+6GplwSgcxB+54tnO7P1m04Vv5NUII9ujTB0L14ZdmGzU4ZDnHpWYcLkJlSYd6Q
         SZhlnSBuq5SJKCqQZTFMO+cK4SDkClFwg90rFG/hfYMG1YcfNloZbxNYCCYhzONEx6sM
         gIMtjgOzQPYl9eyrHDqt5dIReBSak28m/7EoFpveSiOUuxcUpeijjpB+AHcV4wHu9avP
         WbnrsayBaqkkA0Lnyy4G4BP0ph2aezYGcs3HO3qAtxabfSIfGg66vfyq+kIVTnrahcsx
         4Ypw==
X-Received: by 10.68.139.194 with SMTP id ra2mr1785768pbb.20.1402066583745;
        Fri, 06 Jun 2014 07:56:23 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250930>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5538-push-shallow.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index 8e54ac5..63d9ca9 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -121,7 +121,7 @@ EOF
 	)
 '
 
-if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
+if test -n "$NO_CURL" || test -z "$GIT_TEST_HTTPD"; then
 	say 'skipping remaining tests, git built without http support'
 	test_done
 fi
-- 
1.7.10.4
