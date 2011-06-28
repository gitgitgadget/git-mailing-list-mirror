From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH] Makefile: Use computed header dependencies if the compiler supports it
Date: Tue, 28 Jun 2011 11:21:25 +0200
Message-ID: <1309252885-14361-1-git-send-email-frekui@gmail.com>
Cc: Fredrik Kuivinen <frekui@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 11:24:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbUWf-0007vn-Mg
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 11:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756843Ab1F1JW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 05:22:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62163 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756823Ab1F1JVs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 05:21:48 -0400
Received: by bwd5 with SMTP id 5so24312bwd.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 02:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=4HFsDvEIVR+qTqd/aKlQbgCedUPPiF5laVhQRGASTdc=;
        b=glanNvctNWR96NFErhLiOVv0AZNXsv0bT04FQa8N/wgj5W+DiGGVKHSc4PXQ4PqhAx
         deWuhKes0EhnwkM9bYsnScHG1dC3P/c1LcRARILcA4dN4RXEVhIxhkxD1RYF3zoeDcUR
         Ran6NmRGYedtvU78bPasaCsHvHyaFxcbBLO3Y=
Received: by 10.204.65.19 with SMTP id g19mr5328609bki.49.1309252906818;
        Tue, 28 Jun 2011 02:21:46 -0700 (PDT)
Received: from localhost.localdomain (c83-250-151-53.bredband.comhem.se [83.250.151.53])
        by mx.google.com with ESMTPS id l24sm517bkw.15.2011.06.28.02.21.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 02:21:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3.368.g8b1b7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176388>

Previously you had to manually define COMPUTE_HEADER_DEPENDENCIES to
enable this feature. It seemed a bit sad that such a useful feature
had to be enabled manually.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---
 Makefile |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index e40ac0c..3b9efac 100644
--- a/Makefile
+++ b/Makefile
@@ -243,10 +243,6 @@ all::
 #   DEFAULT_EDITOR='$GIT_FALLBACK_EDITOR',
 #   DEFAULT_EDITOR='"C:\Program Files\Vim\gvim.exe" --nofork'
 #
-# Define COMPUTE_HEADER_DEPENDENCIES if your compiler supports the -MMD option
-# and you want to avoid rebuilding objects when an unrelated header file
-# changes.
-#
 # Define CHECK_HEADER_DEPENDENCIES to check for problems in the hard-coded
 # dependency rules.
 #
@@ -1211,6 +1207,15 @@ endif
 ifdef CHECK_HEADER_DEPENDENCIES
 COMPUTE_HEADER_DEPENDENCIES =
 USE_COMPUTED_HEADER_DEPENDENCIES =
+else
+dep_check = $(shell sh -c \
+	': > ++empty.c; \
+	$(CC) -c -MF /dev/null -MMD -MP ++empty.c -o /dev/null 2>&1; \
+	echo $$?; \
+	$(RM) ++empty.c')
+ifeq ($(dep_check),0)
+COMPUTE_HEADER_DEPENDENCIES=YesPlease
+endif
 endif
 
 ifdef COMPUTE_HEADER_DEPENDENCIES
-- 
1.7.5.3.368.g8b1b7.dirty
