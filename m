From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 05/14] rm: add --staged option
Date: Sat, 12 Oct 2013 02:04:42 -0500
Message-ID: <1381561488-20294-9-git-send-email-felipe.contreras@gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMX-0004MJ-43
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab3JLHLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:16 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:65324 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab3JLHLO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:14 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so3156292oag.0
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cgGNg6iL73Z/eeNgkG+FPWDUhJKSkw8Boo6R9JoegUQ=;
        b=pzvl1cSpdTTrnN+mUBY3kq4vdR2jjrw8Zm38YU6Gay69lY4Dzgjuj9xTxZK1B/aP+m
         9SStgQiS3NMjUgGGk3Kb2MK6cvNdTh/yySssXDbNp6uVlPsFLgjG0c3laguEwvXS4Ric
         cQv2+l4jweoEJcbI3msA1BK5k9ItVHza8ZTqjQM+tUtbNymuJKbzB9cXvoGary1ZK7EN
         fagHLd4e2hk76pYgbaVEJjJbcK5E8UAScp8re0CZnwaWTzyPK/pAY7PzZ7ApdSipcD0Q
         bXCaL2BG0oZAXc3uj3JMCdmrMrI9sQ0XNNL6UaNmpxfTMgXnopU8UdIH/hXq7TCYXIU+
         Lpmw==
X-Received: by 10.182.18.9 with SMTP id s9mr10352457obd.15.1381561873506;
        Sat, 12 Oct 2013 00:11:13 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id j9sm101391112oef.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235976>

Synonym for --cached.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-rm.txt | 5 ++++-
 builtin/rm.c             | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 1d876c2..156b40d 100644
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
index 0df0b4d..919911f 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -268,6 +268,7 @@ static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__QUIET(&quiet, N_("do not list removed files")),
 	OPT_BOOLEAN( 0 , "cached",         &index_only, N_("only remove from the index")),
+	OPT_BOOLEAN( 0 , "staged",         &index_only, N_("only remove from the index")),
 	OPT__FORCE(&force, N_("override the up-to-date check")),
 	OPT_BOOLEAN('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
-- 
1.8.4-fc
