From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] grep: convert to use the new get_pathspec()
Date: Sat,  9 Apr 2011 23:54:20 +0700
Message-ID: <1302368060-23827-6-git-send-email-pclouds@gmail.com>
References: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 18:55:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8bRK-0004vZ-AR
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 18:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945Ab1DIQzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 12:55:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39895 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab1DIQzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 12:55:07 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so4339826iwn.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 09:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=GblzHTHID1kg368/TX80sx/vIjcrhEmIq6U89bO4n0A=;
        b=ZssPOvH3bZMnqCz9HYsBryj+dSoOP9eYbXsmpT1aUxwRVu0mqygjcz1LHNnC93OAQS
         /cglLstYBEGwvlL/MRzHWj+5KEUQSxnOO+0SfayYMUeBR0GNZSmis/pLC2cAtf9YOprU
         5zWsbcq3nm2SEhIozhtgKycQepVW+nOLkq61E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=whtJ1fEIAgx5yYTB4Am+PV2cG1iuGogK44qZPBzTqHx11w6yVe9F/Jqe0Np51dBTaB
         yajvN/vspgh9M/0WUsigJXZ33wZhjwCInXJCnGAvjWrBBqbY+poHENMtCJg8KdOhh0zn
         NvZ4g6W8TuC4ZZEMRC/ipl3BqfSJwiX21WYmY=
Received: by 10.231.195.40 with SMTP id ea40mr3409887ibb.167.1302368107156;
        Sat, 09 Apr 2011 09:55:07 -0700 (PDT)
Received: from tre ([115.73.238.90])
        by mx.google.com with ESMTPS id c1sm2758440ibe.0.2011.04.09.09.55.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 09:55:06 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sat, 09 Apr 2011 23:55:00 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171200>

---
 builtin/grep.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2826ca8..af16deb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -734,7 +734,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	const char *show_in_pager = NULL, *default_pager = "dummy";
 	struct grep_opt opt;
 	struct object_array list = OBJECT_ARRAY_INIT;
-	const char **paths = NULL;
 	struct pathspec pathspec;
 	struct string_list path_list = STRING_LIST_INIT_NODUP;
 	int i;
@@ -956,14 +955,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			verify_filename(prefix, argv[j]);
 	}
 
-	if (i < argc)
-		paths = get_pathspec_old(prefix, argv + i);
-	else if (prefix) {
-		paths = xcalloc(2, sizeof(const char *));
-		paths[0] = prefix;
-		paths[1] = NULL;
-	}
-	init_pathspec(&pathspec, paths);
+	get_pathspec(&pathspec, prefix, argc - i, argv + i);
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
 
-- 
1.7.4.74.g639db
