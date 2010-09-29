From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] diff: trivial fix for --output file error message
Date: Wed, 29 Sep 2010 09:26:23 +0200
Message-ID: <1285745183-7809-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 29 09:35:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0rCV-0005RV-Py
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 09:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab0I2Hff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 03:35:35 -0400
Received: from imag.imag.fr ([129.88.30.1]:56986 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995Ab0I2Hfe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 03:35:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8T7QSOZ023620
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 29 Sep 2010 09:26:28 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1P0r3Y-0007rt-Pb; Wed, 29 Sep 2010 09:26:24 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1P0r3Y-00022X-Lc; Wed, 29 Sep 2010 09:26:24 +0200
X-Mailer: git-send-email 1.7.3.2.g257b5f
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 29 Sep 2010 09:26:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157541>

Since we use parse_long_opt(), the option argument is either after
--output=... or in the next command-line argument. optarg is the reliable
way to access it.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

On my system, it seems --output file works, probably because the
argument array is stored as "--output\0file", but we should definitely
not rely on that ...

 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 276e029..38f5f9c 100644
--- a/diff.c
+++ b/diff.c
@@ -3315,7 +3315,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if ((argcount = parse_long_opt("output", av, &optarg))) {
 		options->file = fopen(optarg, "w");
 		if (!options->file)
-			die_errno("Could not open '%s'", arg + strlen("--output="));
+			die_errno("Could not open '%s'", optarg);
 		options->close_file = 1;
 		return argcount;
 	} else
-- 
1.7.3.2.g257b5f
