From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH 5/5] help.c: output the typical Git workflow
Date: Thu, 14 May 2015 14:59:10 +0200
Message-ID: <1431608351-9413-6-git-send-email-sebastien.guimmara@gmail.com>
References: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 14 15:00:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsskZ-0007Na-Al
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 15:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbbENNAU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2015 09:00:20 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34240 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964812AbbENNAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 09:00:16 -0400
Received: by wicmc15 with SMTP id mc15so14577943wic.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 06:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4sq5xo5weR79cXNyfoe5sU2TxPYXTkx2SO0CExEUT+g=;
        b=fq2860gb1M+UHGD7/zLvptYE8+g0+EuwKUILc83o0rBT9/sZgIJJdCU+HEf6keIM4h
         /ynsNfoi5q8KuO8bbjA2WRc/u05EQcgDAv70XJER/k9xSIfjbyKkSM/KEM4YKZe715wX
         jNzrD9jLhe6hLZvnXqJgG9QwSDmXW+fNadKS068ejUB9LL5p4AZQjsDd7rMzU3NSYJ8W
         MjE9lPvKfZbayJPY7JWs6d5T0aAvA3WJ8lklVybtWpb/nCHEK66QcB9hChvItuEzk3OW
         rv4F9rPMAqtTadQi5XB51zRm3KHBVlYGBi1uPhdsyK65D4CXHsMcSG0IoCLA7kqdDbWB
         Jshg==
X-Received: by 10.180.20.12 with SMTP id j12mr47675153wie.4.1431608415510;
        Thu, 14 May 2015 06:00:15 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id pj5sm32671676wjb.40.2015.05.14.06.00.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 06:00:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269034>

'git help' shows common commands in alphabetical order:

The most commonly used git commands are:
   add        Add file contents to the index
   bisect     Find by binary search the change that introduced a bug
   branch     List, create, or delete branches
   checkout   Checkout a branch or paths to the working tree
   clone      Clone a repository into a new directory
   commit     Record changes to the repository
   [...]

without any indication of how commands relate to high-level
concepts or each other. Revise the output to explain their relationship
with the typical Git workflow:

The typical Git workflow includes:

start a working area (see also: git help tutorial):
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize [...]

work on the current change (see also: git help everyday):
   add        Add file contents to the index
   reset      Reset current HEAD to the specified state

examine the history and state (see also: git help revisions):
   log        Show commit logs
   status     Show the working tree status

   [...]

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 help.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 2072a87..bdb69d1 100644
--- a/help.c
+++ b/help.c
@@ -218,17 +218,39 @@ void list_commands(unsigned int colopts,
 	}
 }
=20
+int cmd_group_cmp(const void *elem1, const void *elem2)
+{
+	const struct cmdname_help *e1 =3D elem1;
+	const struct cmdname_help *e2 =3D elem2;
+
+	if (e1->group < e2->group)
+		return -1;
+	if (e1->group > e2->group)
+		return 1;
+	return strcmp(e1->name, e2->name);
+}
+
 void list_common_cmds_help(void)
 {
 	int i, longest =3D 0;
+	int current_grp =3D -1;
=20
 	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
 		if (longest < strlen(common_cmds[i].name))
 			longest =3D strlen(common_cmds[i].name);
 	}
=20
-	puts(_("The most commonly used git commands are:"));
+	qsort(common_cmds, ARRAY_SIZE(common_cmds),
+		sizeof(common_cmds[0]), cmd_group_cmp);
+
+	puts(_("The typical Git workflow includes:"));
+
 	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
+		if (common_cmds[i].group !=3D current_grp) {
+			printf("\n%s:\n", _(common_cmd_groups[common_cmds[i].group]));
+			current_grp =3D common_cmds[i].group;
+		}
+
 		printf("   %s   ", common_cmds[i].name);
 		mput_char(' ', longest - strlen(common_cmds[i].name));
 		puts(_(common_cmds[i].help));
--=20
2.4.0
