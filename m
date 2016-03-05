From: Dinesh Polathula <dpdineshp2@gmail.com>
Subject: [PATCH] branch.c: Allow "-" as a short-hand for "@{-1}" in "git branch -d @{-1}"
Date: Sat,  5 Mar 2016 13:09:06 +0530
Message-ID: <1457163546-11970-2-git-send-email-dpdineshp2@gmail.com>
References: <1457163546-11970-1-git-send-email-dpdineshp2@gmail.com>
Cc: Dinesh <dpdineshp2@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 08:39:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac6oE-0003dT-2R
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 08:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbcCEHjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 02:39:25 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34391 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbcCEHjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 02:39:24 -0500
Received: by mail-pa0-f49.google.com with SMTP id fy10so47476874pac.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 23:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ydrODJoSSsP9bTmwh9EkEJ5fEjCaj1QFNA086kCy4U=;
        b=m1IJ8TltK4wTkNuIo1O1Ruj4PQCWAZJos9U0URVUf9oy+iaSLGYIXhZdlKPQWUzlYr
         hTtcYKbsV3adFZNJ2i3nrD2qlBAn+Y3TRtCsd+jJALpQl2xLC8PsiKUpRzUUs8bz/HF1
         jJtEs8dO7X0Xu+iLfVV1hvMDMQwkg3AsaSj7QStzh05Yk2RdYgp+2kRWVq0V6wJ2oJX0
         II92ow0fCZIuQvThAuS8YInplwrGV2zrIW/acHsSApOyBHepWOmRno+Y9Gwq5daUYCUv
         4PgTo67BDETdc5tdxReMwdb4VGlffApll4lDsKzEPivdSiuQ9Ji1QRXeTo/sEX5Sd6Nl
         DKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ydrODJoSSsP9bTmwh9EkEJ5fEjCaj1QFNA086kCy4U=;
        b=mbDBTn4p1YOgFLXcvF6tDkFOmppzjlX2mAxmR7nLePn25UWkj764NVIEN3axsmR49E
         p3UGUjgeo8xb4WHF1uSWzvnilIRf4oCydZakdMnHwn8x9EeCpDDFHC+vAjiJuS3hY6xI
         FhnmBU8yu2VOsWOJ+DQfSAHjOiOhGAVkQB8msQrODNiKlt2q597Z1IjWbuSq9cDWsO0h
         YtEd4gjEczHHi3La8lXigI+3eej26AzyHG4APXXCQlNmz2rjALdBTg++1qSVTEg5pAv1
         789ma58MkirC9ivPA/NcQFp5ysqzTe6Ew0Ga4xuJZPQ62S2GhK2VdCPJXGFwQDBDofJo
         p4+A==
X-Gm-Message-State: AD7BkJI1taeeMf5RlUGzQDku6ZKkKsgu+LsMR4MQUXm8W5qyyBuKyU3VqJWJVYYXMzjf5Q==
X-Received: by 10.66.61.204 with SMTP id s12mr18546524par.108.1457163563381;
        Fri, 04 Mar 2016 23:39:23 -0800 (PST)
Received: from dinesh-pc.local.lan ([175.111.137.132])
        by smtp.gmail.com with ESMTPSA id fk9sm10225772pad.9.2016.03.04.23.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 23:39:23 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0
In-Reply-To: <1457163546-11970-1-git-send-email-dpdineshp2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288301>

From: Dinesh <dpdineshp2@gmail.com>

The "-" shorthand can be used as a replacement for "@{-1}" to refer to the previous branch the user was on in the "git branch -d @{-1}" command.
Replace "-" argument with "@{-1}" when the command line arguments are parsed.

Signed-off-by: Dinesh <dpdineshp2@gmail.com>
---
 builtin/branch.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..98d2c4b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -24,7 +24,7 @@
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
 	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
-	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
+	N_("git branch [<options>] [-r] (-d | -D) [-] <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	NULL
@@ -658,8 +658,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	filter.abbrev = -1;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_branch_usage, options);
-
+	{
+		usage_with_options(builtin_branch_usage, options);	
+	}
+	if (argc == 3 && !strcmp(argv[2], "-"))
+	{
+	    argv[2] = "@{-1}";	
+	}
 	git_config(git_branch_config, NULL);
 
 	track = git_branch_track;
-- 
2.8.0.rc0
