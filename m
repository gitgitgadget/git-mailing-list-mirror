From: Dinesh Polathula <dpdineshp2@gmail.com>
Subject: [PATCH] branch.c: Allow "-" as a short-hand for "@{-1}" in "git branch -d @{-1}"
Date: Sat,  5 Mar 2016 16:42:46 +0530
Message-ID: <1457176366-14952-1-git-send-email-dpdineshp2@gmail.com>
Cc: Dinesh <dpdineshp2@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 12:13:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acA8o-0001l3-DG
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 12:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760525AbcCELMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 06:12:54 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35876 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759899AbcCELMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 06:12:52 -0500
Received: by mail-pf0-f171.google.com with SMTP id 63so50544109pfe.3
        for <git@vger.kernel.org>; Sat, 05 Mar 2016 03:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LRe34dNe32BDI51HFmfeK7zuTPsmyv3xksWJATNUoyg=;
        b=zko+WgUFZitSZS7SAfHPXp4s7JI+q5gR9sIThs/Tz7RdPBHjrmEFWub4JwDN3SZzv5
         mr7x1DzfJj7bwIs4o4oOBF6lx8JL0tFSk50krWGq6zu77S/VOG6Dg3sXh8pZH3mVSe7v
         V83hOCY8zxgJSEJ24uHhc8ZXMgG1rzZGMBdKyANgh2P/9EHS9dKuRg5tGiyLtayU2j1Y
         m2aDTjHZNKP7xZPiSQtU/TqGiDMabYJYMpaVLvmbytDDoBg2zPIr9HKz81JL/BV4ovAZ
         GuaD7phTkYlbBVeRMwUIR15x9QTJCuM0i/p/qEzHK9jOsofR8kU8t/Hr7eydPHhyd5gQ
         6gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LRe34dNe32BDI51HFmfeK7zuTPsmyv3xksWJATNUoyg=;
        b=Us+FcvcajyK1f53fDWJFRoL/VWh4lY1ljNuKz3nH8Fw3GvM3YQKkOn0sOB0WYbmeDh
         EefLlTe2THJiAFQN2AAB5dxEJNQlsPIy1S5OiUuCRyd9NdHKEB+eLVb4YdPpmBa4pH1C
         It9Dn2bdAXG/Edbr8MRTXwjjtiLchK9nUScOhEEyLFLfJTVJnhkTXJrPujwS+p+e4awa
         vt8nS8BFclzIu5uG85a/S8yFBSMdpmdzySLM3NGDhMXOTXOA3ZUbrOYEX9F4APQy6eRa
         8hrK8J2PvSeyqEwyfMeFxER9IEJXnbP3GCVESDNOXLT0vzueoJoqvZHUJ7+f7DtB16ek
         EBng==
X-Gm-Message-State: AD7BkJI6OzW+JBnnTj9Ke9jIteUXkn9/rs9JrFyZhdxmqCWaiGX0vVxuoYpa0v/Edtm2HQ==
X-Received: by 10.98.34.18 with SMTP id i18mr11542142pfi.26.1457176371960;
        Sat, 05 Mar 2016 03:12:51 -0800 (PST)
Received: from dinesh-pc.local.lan ([117.221.85.13])
        by smtp.gmail.com with ESMTPSA id f65sm11761670pfd.47.2016.03.05.03.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Mar 2016 03:12:51 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288312>

From: Dinesh <dpdineshp2@gmail.com>

The "-" shorthand can be used as a replacement for "@{-1}" to refer to 
the previous branch the user was on in the "git branch -d @{-1}" 
command. Replace "-" argument with "@{-1}" when the command line 
arguments are parsed.

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
