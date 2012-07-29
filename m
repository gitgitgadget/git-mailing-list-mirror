From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 2/3] cherry: don't set ignored rev_info options
Date: Sun, 29 Jul 2012 16:25:35 -0700
Message-ID: <1343604336-7966-3-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1343604336-7966-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 01:26:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvcsS-00047j-SP
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 01:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab2G2XZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 19:25:56 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:62524 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795Ab2G2XZn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 19:25:43 -0400
Received: by fat25 with SMTP id 25so192836fat.1
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=JnMoai7Niygeog1fdAOywRaO6rLOxhqxbeTtnKS2+gM=;
        b=jLrIguvozrgu8dA167UqEbKbZIL3chlwkwO4s7dSnRfD8k/d3LfsBTkMJ0l8q5R/RY
         UJ/y8iXJDWjWuf62JITr0HD7gXiH6KDXKGk8Q47jIUpuJqjTevHLuL9Z2kRF8k5Yr6Dj
         W6SB44aUWLLw8us5Edonq3IrHwvg1q1s+jIuUDgMqP3yT5iT1erG2BPB33U1R4ztvUQa
         Pkveln2u0fAtpdoTgZNFBOWL4AhzulUjjH2wYTsvcN+Oq3qWlTKct40hPLUWDzhw2sOz
         wmxQgt01zd1gjCTvvIK0fbeNqWfmWToS/A/OcQwGlHspJ0ky2kurgnXaaBebciwZ4oXl
         mIdA==
Received: by 10.14.184.71 with SMTP id r47mr1223658eem.4.1343604342228;
        Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: by 10.14.184.71 with SMTP id r47mr1223655eem.4.1343604342177;
        Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id 46si12594903eed.1.2012.07.29.16.25.42
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 011A2200059;
	Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 5B1A8C1A32; Sun, 29 Jul 2012 16:25:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1343604336-7966-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQmjgiyjq3rARdjGh/73/codOpwxO2HcO0bDIVr4jDAqDuTX7ytU2baR3ukIcHmP46HS7HDAfBTIACdz4eaDwsOXbtnnS3d/nVFX3UW+3d9r+D9jznUSWMjEXw3BEL//gN6TCTiLud5dksYwAuBrOiQvy1L3MUyML+oE1CbAHRQVSLod/mI2DjZWze21q8NjvKFLO+Ri
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202507>

Ever since cherry was built-in in e827633 (Built-in cherry,
2006-10-24), it has set a bunch of options on the the rev_info that
are only used while outputting a patch. But since the built-in cherry
command never needs to output any patch (it uses add_commit_patch_id
and has_commit_patch_id instead), these options are just distractions,
so remove them.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 builtin/log.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7a92e3f..8cea1e5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1508,10 +1508,6 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	}
 
 	init_revisions(&revs, prefix);
-	revs.diff = 1;
-	revs.combine_merges = 0;
-	revs.ignore_merges = 1;
-	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
 
 	if (add_pending_commit(head, &revs, 0))
 		die(_("Unknown commit %s"), head);
-- 
1.7.11.1.104.ge7b44f1
