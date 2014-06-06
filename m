From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 06/20] contrib/examples/git-resolve.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:49 -0700
Message-ID: <1402066563-28519-7-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZA-0001nQ-6c
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbaFFO4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:19 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:54361 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbaFFO4O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:14 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so2580675pbc.29
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6cf7rxWuDlygDMiv2Sx3oWvTWPJJo9YpSFv6ihNDb/w=;
        b=NVFXUz+kyXdDoptxpgFRm/5oM6z/R82FEwsF+AHHwEyDK9JIfEJa0EonOznDXmHR7u
         OHyS4SimS7oQXyYbKNUes3R6KleuqwIHOIWa1eRqRhC1UHRGAy1fLnpjAuQRa9LCV/Kw
         tG54m2Igj5jSyZskwX6aHxy78oTdLcU86rRjl4J7ulME40rgtXEK3sAdLKpsxD13DBnK
         YmB6L99HSSkjPUWvBHL9jD9NUMaD8An0QvTHxLN8+ZmhXXuBOBE6DRbiKpl72zvjljzd
         KlRnKbUbFLDK/zxzK87U1JYiIQydMbN+xLRBTlHcVEoChuLaySs2+jk+b7wGkAae4Da+
         Kq/w==
X-Received: by 10.68.254.70 with SMTP id ag6mr7616230pbd.33.1402066573394;
        Fri, 06 Jun 2014 07:56:13 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250920>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/examples/git-resolve.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/examples/git-resolve.sh b/contrib/examples/git-resolve.sh
index 48d0fc9..70fdc27 100755
--- a/contrib/examples/git-resolve.sh
+++ b/contrib/examples/git-resolve.sh
@@ -76,7 +76,7 @@ case "$common" in
 			2>/dev/null || continue
 		# Count the paths that are unmerged.
 		cnt=$(GIT_INDEX_FILE=$G git ls-files --unmerged | wc -l)
-		if test $best_cnt -le 0 -o $cnt -le $best_cnt
+		if test $best_cnt -le 0 || test $cnt -le $best_cnt
 		then
 			best=$c
 			best_cnt=$cnt
-- 
1.7.10.4
