From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 10/22] worktree: improve worktree setup message
Date: Fri, 17 Jul 2015 19:00:05 -0400
Message-ID: <1437174017-81687-11-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:02:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdj-0002al-VF
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbbGQXBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:24 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38750 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbbGQXBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:22 -0400
Received: by iggf3 with SMTP id f3so47294852igg.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bxbwrkKkVdQbVsi6+6+P7fwF7aSkzNNfbBIh5D1mRJI=;
        b=dcAa2EI9ND0Yv2Ga8eFOun3NEJPHYvH/UAR4SF1gJwpJfVPazQSJM1s32HAffLK5zf
         9bqkYEZFe+k0V8kjhnn5nJ70QbI2/r5HPKvpndxXwTt0T7u2zdjpFRrBoAp22hrnWNaV
         P9OzZ5d4HG7KGfeci2LbdqkYDk/cBjdVzhEvY65//qyxDIAM99SFs51o+zn7IZnc+lLV
         nn4awkjQWlaIVRlNFDB9Itw7UUi0AKnTVbso6IS/PhHn36nxmh4mEEteQcv2xvPXst8R
         cV7jzUHDMCYxBuEiiF3pZ50JneL3LZTcGvcE/5vxbvXssdUha2TuwO0WM1gHr3j0Jacc
         Bleg==
X-Received: by 10.107.10.148 with SMTP id 20mr21612057iok.89.1437174081603;
        Fri, 17 Jul 2015 16:01:21 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.20
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:21 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274143>

When git-worktree creates a new worktree, it reports:

    Enter "<path>" (identifier <tag>)

which misleadingly implies that it is setting <path> as the working
directory (as if "cd <path>" had been invoked), whereas it's actually
preparing the new worktree by creating its administrative files, setting
HEAD, and populating it. Make this more clear by instead saying:

    Preparing "<path>" (identifier <tag>)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

New in v3.

 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 69248ba..5f0e3c2 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -245,7 +245,7 @@ static int add_worktree(const char *path, const char **child_argv)
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, 1, "../..\n");
 
-	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
+	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
 
 	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
 	setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
-- 
2.5.0.rc2.378.g0af52e8
