From: Nicolas Dudebout <nicolas.dudebout@gmail.com>
Subject: [patch] color of branches in git status -sb
Date: Wed, 16 Nov 2011 19:39:46 -0500
Message-ID: <CA+TMmKns-9jiedxY4FiJoBg8akkxwkPBib11EmvCD3r7mRA6vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 01:39:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQq1C-0002Si-8s
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 01:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab1KQAjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 19:39:49 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56693 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab1KQAjs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 19:39:48 -0500
Received: by fagn18 with SMTP id n18so2264053fag.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 16:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=C1cmMq2SvvVd1hDLJpe/qYQ/5NcF9KohpEz6UcJqw8o=;
        b=wrXRQGfuLrYRRenvm/cmroOC67V1dAPAvw9079p3ydIVW1+67G6DaSNa7agYJBOD4X
         3WACleQTL+YL7MiDF8d70ObvSKHcjIX716Yv2yG++Dmm1Vr/NVGpE4WtKM69awOuOvNu
         baCe28xZjSXVVdwXW0yUBZI9yA4/Le9k1/4oQ=
Received: by 10.152.109.198 with SMTP id hu6mr21932642lab.11.1321490386978;
 Wed, 16 Nov 2011 16:39:46 -0800 (PST)
Received: by 10.152.13.105 with HTTP; Wed, 16 Nov 2011 16:39:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185563>

The following patch fixes the fact that two colors of the status
output could not be configured in .git/config.

The color of the current branch could not be modified because of the
name WT_STATUS_ONBRANCH having been changed to WT_STATUS_LOCAL_BRANCH.

The color of the remote branch was not defined at all.

By the way, when I do 'git status' instead of git 'status -sb' the
local and remote branch do not get colored. Is this a desired
behavior?

Nicolas

	Modified   Documentation/config.txt
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5a841da..7a0ddd6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -809 +809,2 @@ color.status.<slot>::
-	`branch` (the current branch), or
+	`branch` (the current branch),
+        `remote` (the remote branch) or
	Modified   builtin/commit.c
diff --git a/builtin/commit.c b/builtin/commit.c
index c46f2d1..4674600 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1118 +1118,3 @@ static int parse_status_slot(const char *var, int offset)
-		return WT_STATUS_ONBRANCH;
+		return WT_STATUS_LOCAL_BRANCH;
+	if (!strcasecmp(var+offset, "remote"))
+		return WT_STATUS_REMOTE_BRANCH;
