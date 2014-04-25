From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 09/14] apply: add --stage option
Date: Fri, 25 Apr 2014 13:12:42 -0500
Message-ID: <1398449567-16314-10-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:24:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdknC-00079k-Kx
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbaDYSXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:23:53 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:55567 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbaDYSXv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:23:51 -0400
Received: by mail-ob0-f182.google.com with SMTP id uy5so4715501obc.27
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uj5lrvjm5uYaBnPkDZVqi/Pksfxuk7SuIi7a2F9MVpk=;
        b=Y0fUvMC6GACNGEUEkBAqLx3c93SQCOxGweCEdNM9cZOv/SbFAzuk+VJzHKctpGAcQu
         1J0KAoi7qr/+PK1Qm/gH9U7RAAlU6561V2aQy6Mq7i2i+eTY8a3UQil0+VK5E83b1IL8
         AxOy8JFAIkvwhr2YJIL68EeOlAyuxIAbqWgcH0DC2E3RYKCP8pK5IkddoLRnBYhYP0i7
         OTfatoc9iCrc2pODzcsahjoQGwjIX5lY+SHQMXc+16hvDn6J8nRF1aGqlT1pMyp2wvLz
         aS4mPekmF+2ppZv1vxLuf/9reCcSzUKQ1lv43c8oPzBMis4sUg/ArpyqDLKfhxhRsvoU
         X3ug==
X-Received: by 10.60.55.97 with SMTP id r1mr8209443oep.5.1398450231505;
        Fri, 25 Apr 2014 11:23:51 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id su13sm34710987oeb.9.2014.04.25.11.23.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:23:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247082>

Synonym for --index.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-apply.txt | 5 ++++-
 builtin/apply.c             | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f605327..8c047ef 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -9,7 +9,7 @@ git-apply - Apply a patch to files and/or to the index
 SYNOPSIS
 --------
 [verse]
-'git apply' [--stat] [--numstat] [--summary] [--check] [--index] [--3way]
+'git apply' [--stat] [--numstat] [--summary] [--check] [--index|--stage] [--3way]
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
@@ -67,6 +67,9 @@ OPTIONS
 	up-to-date, it is flagged as an error.  This flag also
 	causes the index file to be updated.
 
+--stage::
+	Synonym for --index.
+
 --cached::
 	Apply a patch without touching the working tree. Instead take the
 	cached data, apply the patch, and store the result in the index
diff --git a/builtin/apply.c b/builtin/apply.c
index b0d0986..a97363c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4377,6 +4377,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOL(0, "index", &check_index,
 			N_("make sure the patch is applicable to the current index")),
+		OPT_BOOL(0, "stage", &check_index,
+			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOL(0, "cached", &cached,
 			N_("apply a patch without touching the working tree")),
 		OPT_BOOL(0, "apply", &force_apply,
-- 
1.9.2+fc1.2.gfbaae8c
