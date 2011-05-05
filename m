From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH] fast-import: fix option parser forno-arg options
Date: Thu,  5 May 2011 20:56:00 +0200
Message-ID: <1304621760-22261-1-git-send-email-srabbelier@gmail.com>
References: <7v7ha59icw.fsf@alter.siamese.dyndns.org>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 19:56:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI2n5-0007QJ-3H
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 19:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab1EER4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 13:56:38 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44315 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab1EER4h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 13:56:37 -0400
Received: by eyx24 with SMTP id 24so749328eyx.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=NtIkthhg4G0ZwKahDaMZHPIzbN5Z/U8ZB+v77b+rf+8=;
        b=Tzi+4/Nb0GwLjqCyolIwMZk8xySr8bsPH86UHqpDhcs06DeX7E8tSuLQH6eeSwOfVc
         8Zm2McHUUdgNlQ44INe2XOUSVBGSnC5hlUlwwknT43dAFFfMubnuEBzeI2WlDxfOCwbl
         uj90t8UO3L3NDyYxIGzKoV5c0pnPaCiVF7S9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EskUTfBOiBbkkFMXPkpRmehcKdrQQXrEq5AaheFvdVmvLvWrg1PuIh4OIYYEwZVZ2R
         O7K3l3uJqPHedS/dvagT92F1MUGRWrA+VIi7Of6hO59LKwKXqJkewdOZRbr1lTegbuSe
         6xDVK4Wg8Of2OnuVa5fjtS/jEj77+XTjrDW6o=
Received: by 10.213.23.91 with SMTP id q27mr452948ebb.68.1304618196373;
        Thu, 05 May 2011 10:56:36 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id e32sm649067eee.19.2011.05.05.10.56.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 10:56:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <7v7ha59icw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172860>

While refactoring the options parser in bc3c79a (fast-import: add
(non-)relative-marks feature, 2009-12-04), it was made too lenient
for options that take no argument, fix that.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  I noticed that force was also wrong. All other option parsing
  checks are made using the right version though.

 fast-import.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3e4e655..78d9786 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3135,11 +3135,11 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_export_marks(feature + 13);
 	} else if (!strcmp(feature, "cat-blob")) {
 		; /* Don't die - this feature is supported */
-	} else if (!prefixcmp(feature, "relative-marks")) {
+	} else if (!strcmp(feature, "relative-marks")) {
 		relative_marks_paths = 1;
-	} else if (!prefixcmp(feature, "no-relative-marks")) {
+	} else if (!strcmp(feature, "no-relative-marks")) {
 		relative_marks_paths = 0;
-	} else if (!prefixcmp(feature, "force")) {
+	} else if (!strcmp(feature, "force")) {
 		force_update = 1;
 	} else if (!strcmp(feature, "notes") || !strcmp(feature, "ls")) {
 		; /* do nothing; we have the feature */
-- 
1.7.5.1.292.g728120
