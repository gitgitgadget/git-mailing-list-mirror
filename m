From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 37/45] builtin-am: invoke post-applypatch hook
Date: Mon, 20 Jul 2015 00:10:29 +0800
Message-ID: <1437322237-29863-38-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCW-0006gw-R9
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbbGSQMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:21 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35988 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbbGSQMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:19 -0400
Received: by pachj5 with SMTP id hj5so89288705pac.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nt5diYdjnmTymwH50jYuKq8vcdxPMqnBi3PZVel61Kg=;
        b=CFfrY2bdKZAL/q2bjiuV+B5e7jYGm7/lllVek7xFI6A2nDwfNh0yW1+TmF075FKu8P
         Qbmfi98Cr1emKMAiyLnfDEtiP5SNa5n3+Dmbtvdx8LCHTclYFTkXLtXXYKKfGGXWXdsg
         I9J1TozlZd6vY6uezSCnTxMqnG916bzRmNEVyFRHcaUgafjvATL4PwbiJaqBKcpb2Mzk
         mJF5CuRNisB2t1ihY3J4ga5vIVBDXNoiiL5w6fJZUKHvzt7vGKjHHOsctHNlwexfKOhO
         mj7b4sDcjkkiSGeswqG41NU0gHlirBjeavaBfIq/di9q26WxFDPxTm4GrnxRilz/igfL
         FNQg==
X-Received: by 10.66.186.195 with SMTP id fm3mr49016612pac.91.1437322339292;
        Sun, 19 Jul 2015 09:12:19 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:18 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274255>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh will invoke the post-applypatch hook after the patch is
applied and a commit is made. The exit code of the hook is ignored.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index fdba3b0..638b6d3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1380,6 +1380,8 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
+	run_hook_le(NULL, "post-applypatch", NULL);
+
 	strbuf_release(&sb);
 }
 
-- 
2.5.0.rc2.110.gb39b692
