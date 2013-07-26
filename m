From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Fri, 26 Jul 2013 23:42:00 +0530
Message-ID: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 26 20:15:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2mYO-0003d1-PD
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 20:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758651Ab3GZSPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 14:15:44 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:62712 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab3GZSPo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 14:15:44 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so2339839pbb.28
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=EVlgiQw2PJ4srllIjzoazG+nK58Bbn9sDg23N2dtFBo=;
        b=E59BXaqknD6M4UHLa7uaB6Dx1LKpIQLG098qnzrVW3shCPvSZSP03kRs6xtxV13LxQ
         cIA+Gb+4rpTCerNw845V9bUrfOBHIPJgUWxYvTdta1pY6JofTrxzM4on5HCYlWJraw7T
         qvLF+RJ2bWsb7RKJNeHfBJhueFYIFmxwag6dP9pHvYn64yANnIqbXCNund5MXnPzNweQ
         2In5k5OdX0Tlcmp/wXRCwM2GTe00Cvf1TL2W0Ol/4eZXOXQQ8UKwSe1k4g6h1WHkEc/f
         hSGojhu5MuEHIfYY9CLrCm+gyLQ9EE/Ze4a8dmGjjegpxz8Nhxr1C6lIRTul3yViFpqz
         bDXw==
X-Received: by 10.68.255.1 with SMTP id am1mr54857017pbd.68.1374862543743;
        Fri, 26 Jul 2013 11:15:43 -0700 (PDT)
Received: from localhost.localdomain ([122.164.210.116])
        by mx.google.com with ESMTPSA id nv6sm61465047pbc.6.2013.07.26.11.15.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 11:15:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231193>

When a cherry-pick results in an empty commit, git prints:

  The previous cherry-pick is now empty, possibly due to conflict resolution.
  If you wish to commit it anyway, use:

      git commit --allow-empty

  Otherwise, please use 'git reset'

The last line is plain wrong in the case of a ranged pick, as a 'git
reset' will fail to remove $GIT_DIR/sequencer, failing a subsequent
cherry-pick or revert.  Change the advice to:

  git cherry-pick --abort

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Another candidate for maint?

 I'd also really like to squelch this with an advice.* variable; any
 suggestions?

 builtin/commit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 003bd7d..1b213f7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -64,7 +64,10 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
 "\n"
 "    git commit --allow-empty\n"
 "\n"
-"Otherwise, please use 'git reset'\n");
+"Otherwise, use:\n"
+"\n"
+"    git cherry-pick --abort\n"
+"\n");
 
 static const char *use_message_buffer;
 static const char commit_editmsg[] = "COMMIT_EDITMSG";
-- 
1.8.4.rc0.1.g8f6a3e5.dirty
