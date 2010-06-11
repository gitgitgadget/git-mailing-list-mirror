From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH v2] Group the default git help message by topic
Date: Fri, 11 Jun 2010 09:03:44 -0700
Message-ID: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 11 18:03:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON6hz-0002gM-OI
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 18:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab0FKQDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 12:03:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43140 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab0FKQDq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 12:03:46 -0400
Received: by fxm8 with SMTP id 8so805164fxm.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=qDurD7NiImm/QnMD0dmjEqHUC4a+c2cNuDosUikkF4w=;
        b=Vf5KlCcQQJ9BA4Ol9sKC7u1TThMe8NlJqLvUq+c5LwsNaupFdpkw4sVj274rOQPlum
         WpUZRx9gglwbhI+nHYKPJAKt+cctLbI/FUNw7oagci37jnugCZeGEkrZIpf2ChU2XFAN
         vh1im1pTEg86EYOQXRGlsDgazKD4b3gekjndk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=t2gkYwr4SBEZ/ZNGbtnvbkje3v/csCtUscGFBhE0PMfTLXM4M9gu4r08WYQSxM9g4S
         xxTiEhRhgmBKDMVQOnC1klV4NVJcgtCsSMEgrEZ91Bp49whFsnbqCJA2qPSikzSlmHuz
         E/nlFD6PBrzkX/iiZSF0TmTovmRjTziPF/G4g=
Received: by 10.216.172.80 with SMTP id s58mr101853wel.60.1276272224656; Fri, 
	11 Jun 2010 09:03:44 -0700 (PDT)
Received: by 10.216.23.71 with HTTP; Fri, 11 Jun 2010 09:03:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148957>

It's difficult to process 21 commands (which is what is output
by default for git when no command is given).  They have been
re-grouped into 4 groups of 5-6 commands each, which is clearer
and easier for new users to process.  More advanced commands
such as bisect and rebase have also been removed as this should
be output for beginners.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---

Here is the second version of this patch.  Instead of hard-coding
all the descriptions, I'm just pulling them from the common-cmds.h
file.

 builtin/help.c |   54 ++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 3182a2b..2975b3d 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -269,23 +269,53 @@ static int git_help_config(const char *var,
const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }

-static struct cmdnames main_cmds, other_cmds;
-
-void list_common_cmds_help(void)
+void print_command(const char *s)
 {
-	int i, longest = 0;
+	int i = 0;
+	int longest = 10;

 	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		if (longest < strlen(common_cmds[i].name))
-			longest = strlen(common_cmds[i].name);
+		if (!strcmp(s, common_cmds[i].name)) {
+			printf("   %s   ", common_cmds[i].name);
+			mput_char(' ', longest - strlen(common_cmds[i].name));
+			puts(common_cmds[i].help);
+		}
 	}
+}

-	puts("The most commonly used git commands are:");
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %s   ", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(common_cmds[i].help);
-	}
+static struct cmdnames main_cmds, other_cmds;
+
+void list_common_cmds_help(void)
+{
+	puts("The most commonly used git commands are:\n");
+
+	puts("Basic Commands:");
+	print_command("init");
+	print_command("clone");
+	print_command("add");
+	print_command("status");
+	print_command("commit");
+	puts("");
+
+	puts("Branch Commands:");
+	print_command("branch");
+	print_command("checkout");
+	print_command("merge");
+	print_command("tag");
+	puts("");
+
+	puts("History Commands:");
+	print_command("log");
+	print_command("diff");
+	print_command("reset");
+	print_command("show");
+	puts("");
+
+	puts("Remote Commands:");
+	print_command("remote");
+	print_command("fetch");
+	print_command("pull");
+	print_command("push");
 }

 static int is_git_command(const char *s)
-- 
1.7.0.1
