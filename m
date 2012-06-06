From: vfr@lyx.org
Subject: [PATCH] Add the DEFAULT_HELP_FORMAT option to Makefile
Date: Wed,  6 Jun 2012 18:51:42 +0000
Message-ID: <1339008702-704-1-git-send-email-vfr@lyx.org>
References: <20120606135353.GD2597@sigill.intra.peff.net>
Cc: gitster@pobox.com, peff@peff.net,
	Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 20:52:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScLL1-0006gs-DO
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 20:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603Ab2FFSwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 14:52:06 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48843 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab2FFSwF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 14:52:05 -0400
Received: by wibhn6 with SMTP id hn6so5346696wib.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 11:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=OW73A/Bw1OhNEwN36BYWJWEO166JkIIwpytoyAszdiY=;
        b=R/NbTZMczwUbpL7s09wtv8nP8xsaRQAIucbHROb2MndsvhN/16jtFDh9A/TUm8BP5P
         jBu0yPNXUb+Ha0vVeIEFg2X2qsrhnWFlw51spma/IRrApqGTiYpBniBRJImqzqQrQdyP
         BMUTDpfosjjXnbp+kIhWQDeSndGzF+eHIC5bfcAK5Z3NmMPwEycX6un8pFfo5p1IRMWG
         hY1IIKzWWIS7CYVufaCC+MYoJKcaK3OEPvZHcbp/oeBtDQs9VQ26x4cIEkqFywD3+juZ
         FFANXirCu73PJzPiiyZsGlRg/5LQqy8OOrraCEeb9X3TCdmGFe05xMo/uHxS0NOURzvv
         1BWg==
Received: by 10.216.198.164 with SMTP id v36mr18067187wen.199.1339008723492;
        Wed, 06 Jun 2012 11:52:03 -0700 (PDT)
Received: from localhost (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id z8sm1990229wiy.1.2012.06.06.11.52.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 11:52:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.msysgit.0
In-Reply-To: <20120606135353.GD2597@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQlS4/N+VKscdcif2CkeFkbdZdK/1EOf9KUd8S23kcWEMKwcNrfYII4NnmyGbi98GM0MuWpm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199346>

From: Vincent van Ravesteijn <vfr@lyx.org>

This patch advertises the DEFAULT_HELP_FORMAT compile option in Makefile. It will also allow to call 'make DEFAULT_HELP_FORMAT=info' to specify a different default.

Proposed-by: Jeff King <peff@peff.net>
Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 Makefile |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index ffbd7a4..b21afed 100644
--- a/Makefile
+++ b/Makefile
@@ -296,6 +296,10 @@ all::
 # the diff algorithm.  It gives a nice speedup if your processor has
 # fast unaligned word loads.  Does NOT work on big-endian systems!
 # Enabled by default on x86_64.
+#
+# Define DEFAULT_HELP_FORMAT to "man", "info", "web" or "html"
+# (defaults "man") if you want to have a different default when
+# "git help" is called without a parameter specifying the format.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1238,6 +1242,7 @@ ifeq ($(uname_S),Windows)
 	NATIVE_CRLF = YesPlease
 	NO_INET_PTON = YesPlease
 	NO_INET_NTOP = YesPlease
+	DEFAULT_HELP_FORMAT = html
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -1917,6 +1922,10 @@ SHELL_PATH_CQ_SQ = $(subst ','\'',$(SHELL_PATH_CQ))
 BASIC_CFLAGS += -DSHELL_PATH='$(SHELL_PATH_CQ_SQ)'
 endif
 
+ifdef DEFAULT_HELP_FORMAT
+BASIC_CFLAGS += -DDEFAULT_HELP_FORMAT='"$(DEFAULT_HELP_FORMAT)"'
+endif
+
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
-- 
1.7.9.msysgit.0
