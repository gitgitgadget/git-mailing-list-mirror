From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v5 2/6] help.c: output the typical Git workflow
Date: Sat,  9 May 2015 19:17:32 +0200
Message-ID: <1431191856-10949-3-git-send-email-sebastien.guimmara@gmail.com>
References: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 19:18:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yr8OX-0000Yf-W9
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 19:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbbEIRS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 May 2015 13:18:28 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35851 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbEIRS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 13:18:27 -0400
Received: by wgiu9 with SMTP id u9so96297337wgi.3
        for <git@vger.kernel.org>; Sat, 09 May 2015 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HLw1NOqGwtyzZUWhcjE6qzusB7vSW58mg/m9A3lZO1I=;
        b=Cq2flc7Rne8bgV1mC+Nh27zL5mYjaNXxfUCYGnH6MYUgWXO437Om8PHkpDjWn8Hef8
         isoByGag1UYBoie8qR2awVAM1eUGJZTXOdwIwsUceHtrEyfeX8OIoAHFgV/7ewLDMswc
         hVffGRuxLSMu5LDgBAul8jv9lVBM4BIx/y119JoO09aiJu1n0ym3YvTOsXFUinbU8FO9
         1FY9KqWjSFJBSgvEm06K+QcMzmCdLDYbYhrX/I+gUp64Gs+FiAaaVXYQ2LnWGRlz+Von
         d2inILfN3jVOqmkLY7egQ8TPYuKEhpIdIXq4TAYNcHouu9vc8W6+R1i4hEdcHEMJQpva
         QyWw==
X-Received: by 10.180.99.39 with SMTP id en7mr7287471wib.31.1431191906428;
        Sat, 09 May 2015 10:18:26 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id fo7sm4710675wic.1.2015.05.09.10.18.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 May 2015 10:18:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268703>

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

   * start a working area (see also: git help tutorial):
      clone      Clone a repository into a new directory
      init       Create an empty Git repository or reinitialize [...]

   * work on the current change (see also: git help everyday):
      add        Add file contents to the index
      reset      Reset current HEAD to the specified state

   * examine the history and state (see also: git help revisions):
      log        Show commit logs
      status     Show the working tree status

   [...]

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 help.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 2072a87..1df205f 100644
--- a/help.c
+++ b/help.c
@@ -218,6 +218,18 @@ void list_commands(unsigned int colopts,
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
@@ -227,9 +239,18 @@ void list_common_cmds_help(void)
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
-		printf("   %s   ", common_cmds[i].name);
+		if (common_cmds[i].group !=3D current_grp) {
+			printf("\n   * %s:\n", _(common_cmd_groups[common_cmds[i].group]));
+			current_grp =3D common_cmds[i].group;
+		}
+
+		printf("      %s   ", common_cmds[i].name);
 		mput_char(' ', longest - strlen(common_cmds[i].name));
 		puts(_(common_cmds[i].help));
 	}
--=20
2.4.0
