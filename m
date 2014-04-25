From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 05/14] rm: add --staged option
Date: Fri, 25 Apr 2014 13:12:38 -0500
Message-ID: <1398449567-16314-6-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Apr 25 20:23:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdkmo-0006WE-0Y
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbaDYSXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:23:40 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:59386 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbaDYSXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:23:38 -0400
Received: by mail-ob0-f170.google.com with SMTP id vb8so4698633obc.29
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eTWUJ0tOlzqnEwrD7E7tPbeFAIM4XdY/2vpmbzvBoo0=;
        b=lWbzy6q49SERWfgkcGuLyHDmDZGmYadZRK0B5ZWn5Px7TW9Vv7boKU1e+FscuwPTf2
         KXEcj9nUKk5c3OgJCHMEr6i4pzVd2h7YYg3/T/oNEm+M2DN0iUsDeRpwy1FGdx9c43ZR
         WATSTZA6WkPXTZHcgG8zeQdiChCVQehRGf+1Ke7YWxJWRH20IyWqXcuhPUunBzmX7EH0
         DMAqhwd9tPzi9HQJkkW3iMT/v+0xH8llDL/A2IoJ4onjxLKRYND17who3NoCXnGAPaYI
         q7MAg49Ep9Bvh1MVrUh0JZuwUa8NqhQjagIb363lXqFAsab8tQO4O0+KdpzPlqWv6ia5
         OxBA==
X-Received: by 10.60.54.228 with SMTP id m4mr8035849oep.29.1398450217998;
        Fri, 25 Apr 2014 11:23:37 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d9sm34744180oen.3.2014.04.25.11.23.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:23:36 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247078>

Synonym for --cached.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-rm.txt | 5 ++++-
 builtin/rm.c             | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index f1efc11..458880b 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -8,7 +8,7 @@ git-rm - Remove files from the working tree and from the index
 SYNOPSIS
 --------
 [verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...
+'git rm' [-f | --force] [-n] [-r] [--cached | --staged] [--ignore-unmatch] [--quiet] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -60,6 +60,9 @@ OPTIONS
 	Working tree files, whether modified or not, will be
 	left alone.
 
+--staged::
+	Synonym for --cached.
+
 --ignore-unmatch::
 	Exit with a zero status even if no files matched.
 
diff --git a/builtin/rm.c b/builtin/rm.c
index 0564218..657314e 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -269,6 +269,7 @@ static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__QUIET(&quiet, N_("do not list removed files")),
 	OPT_BOOL( 0 , "cached",         &index_only, N_("only remove from the index")),
+	OPT_BOOL( 0 , "staged",         &index_only, N_("only remove from the index")),
 	OPT__FORCE(&force, N_("override the up-to-date check")),
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
-- 
1.9.2+fc1.2.gfbaae8c
