From: Dinesh Polathula <dpdineshp2@gmail.com>
Subject: [PATCH] branch.c: Allow "-" as a short-hand for "@{-1}" in "git branch -d @{-1}"
Date: Sat,  5 Mar 2016 16:36:16 +0530
Message-ID: <1457175976-14732-2-git-send-email-dpdineshp2@gmail.com>
References: <1457175976-14732-1-git-send-email-dpdineshp2@gmail.com>
Cc: Dinesh <dpdineshp2@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 12:06:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acA2e-0007TA-Gt
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 12:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760592AbcCELGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 06:06:32 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35659 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760507AbcCELGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 06:06:30 -0500
Received: by mail-pf0-f172.google.com with SMTP id x188so26873582pfb.2
        for <git@vger.kernel.org>; Sat, 05 Mar 2016 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IckoKDhJCN09Z2tPzJt7HW+Uq1iqcwfR2fgLddThqk=;
        b=kFuhhBsmtOLyQbTXw4X6llgcO18etD5D+O0BuAICS9EU5iw/oNnLUBPco4Q/Jf+4U4
         kc50oaYjrHe/0hF9ICTA7uNKQl8r7S1H3CW0VUcp2TLTEpObZ2i3YxK31lrzs438ijJD
         pIvIMe3ladRVrFbw7TitTsa0dYu0Mi2qj2MffbmtyrI7c4tldiOj9ZdGXBoR9axIsPbt
         rKYAN5T9HL71N8qVB9hjcvo8Gpg8830DR6X9QFjfZ/WxcHOHBXoxiXThq0AXUxZxH7CF
         3wxkc/W7Fq2yGS0xB/YHDJEWXwe/NlcU05y1Y894dDdzLgqCiaH42Mu8o2eNEHt3ktEI
         6keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IckoKDhJCN09Z2tPzJt7HW+Uq1iqcwfR2fgLddThqk=;
        b=AVAjrWk7C+6X7AC3FBuW8cQR1UXgltkw/OUJ4LCHeDXgzlugqRLwpckOLVqtDKzQGH
         7erAD9ZWHVTLiHj1G+QjorQCIGYaiUYnjProrxFJ31TfwVPMsxWQGkztUJbV+aHGLSlS
         aN7jxKpMkj79VjaIotWlNL75nCgS/aUShswNZIsf2YKA8g5DaOPZ3uI+z1l6tlxXINSj
         HtzbCPL2AOJWSTqdLZ27tUgSQYgifCy2LMw0mzxJUCicTLwkw0IASyhAhjZ4mZItsc+P
         TDGEJSRUmQmRJZ+dkCfki0I8d08R8DhS/oXmYL3wSxWmKibtGPv7BLjenqj9lJCWfp4p
         1UAg==
X-Gm-Message-State: AD7BkJLLCl8npOkDQKHLfGvBus+ITT33UNO3a/0oHvEn3EyWMXDrNM6bmADNfTw+QXF6yA==
X-Received: by 10.98.70.139 with SMTP id o11mr19134259pfi.123.1457175990164;
        Sat, 05 Mar 2016 03:06:30 -0800 (PST)
Received: from dinesh-pc.local.lan ([117.221.85.13])
        by smtp.gmail.com with ESMTPSA id sj4sm11676466pab.43.2016.03.05.03.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Mar 2016 03:06:29 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0
In-Reply-To: <1457175976-14732-1-git-send-email-dpdineshp2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288311>

From: Dinesh <dpdineshp2@gmail.com>

The "-" shorthand can be used as a replacement for "@{-1}" to refer 
to the previous branch the user was on in the "git branch -d @{-1}" 
command.Replace "-" argument with "@{-1}" when the command line 
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
