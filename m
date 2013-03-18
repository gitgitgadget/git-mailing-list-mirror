From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/4] remote.c: introduce branch.<name>.pushremote
Date: Mon, 18 Mar 2013 18:46:15 +0530
Message-ID: <1363612575-7340-5-git-send-email-artagnon@gmail.com>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 14:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHZun-00042U-BT
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 14:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab3CRNPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 09:15:18 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:38738 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab3CRNPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 09:15:16 -0400
Received: by mail-pb0-f54.google.com with SMTP id rr4so6405763pbb.27
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/k53ThdvbOAY104QokLTFudUlmH/o9ylF4R1hl3wxpM=;
        b=AZE6nvELDtmHkA8RY87Ob8RcL3vwJLfF2U5SAI0SkhpjqVPAE+Bh6D9QcuWTg4US2+
         ANSrdK/XvPfcAVoE3RzONSMFxAYwBw37peMU79bKapA++xiD6wJjKomXZt9TsKCxziEP
         RjZqLXs3EQ4Cp9oawhHIaOYFMe70wVq4viHY2AgRI4MYUxAZUWoYTOzjOmc1O0F1XB5K
         DrNBmT5BWMooDGDaWBJx3WqesZKu4GqJuwJhd1GDDNoLouG1AYXc+r8Z3tr3GzFJChXw
         nSKEqVmry3F2A3sWSedBfur5pNdhvnkddzDdNLIO+pKTMocc5ByryiIKSYGNEkHS0MVz
         J01Q==
X-Received: by 10.66.155.67 with SMTP id vu3mr10520683pab.70.1363612516194;
        Mon, 18 Mar 2013 06:15:16 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id y1sm20178280pbg.10.2013.03.18.06.15.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 06:15:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218413>

This new configuration variable overrides `remote.pushdefault` and
`branch.<name>.remote` for pushes.  In a typical triangular-workflow
setup, you would want to set `remote.pushdefault` to specify the
remote to push to for all branches, and use this option to override it
for a specific branch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt | 18 ++++++++++++++----
 remote.c                 |  3 +++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8ddd0fd..d0e36e9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -726,9 +726,18 @@ branch.<name>.remote::
 	When on branch <name>, it tells 'git fetch' and 'git push'
 	which remote to fetch from/push to.  The remote to push to
 	may be overriden with `remote.pushdefault` (for all branches).
-	If no remote is configured, or if you are not on any branch,
-	it defaults to `origin` for fetching and `remote.pushdefault`
-	for pushing.
+	The remote to push to, for the current branch, may be further
+	overriden by `branch.<name>.pushremote`.  If no remote is
+	configured, or if you are not on any branch, it defaults to
+	`origin` for fetching and `remote.pushdefault` for pushing.
+
+branch.<name>.pushremote::
+	When on branch <name>, it overrides `branch.<name>.remote`
+	when pushing.  It also overrides `remote.pushdefault` when
+	pushing from branch <name>.  In a typical triangular-workflow
+	setup, you would want to set `remote.pushdefault` to specify
+	the remote to push to for all branches, and use this option to
+	override it for a specific branch.
 
 branch.<name>.merge::
 	Defines, together with branch.<name>.remote, the upstream branch
@@ -1899,7 +1908,8 @@ receive.updateserverinfo::
 
 remote.pushdefault::
 	The remote to push to by default.  Overrides
-	`branch.<name>.remote` for all branches.
+	`branch.<name>.remote` for all branches, and is overriden by
+	`branch.<name>.pushremote` for specific branches.
 
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
diff --git a/remote.c b/remote.c
index 987edc4..a4d3d22 100644
--- a/remote.c
+++ b/remote.c
@@ -366,6 +366,9 @@ static int handle_config(const char *key, const char *value, void *cb)
 				default_remote_name = branch->remote_name;
 				explicit_default_remote_name = 1;
 			}
+		} else if (!strcmp(subkey, ".pushremote")) {
+			if (branch == current_branch)
+				git_config_string(&pushremote_name, key, value);
 		} else if (!strcmp(subkey, ".merge")) {
 			if (!value)
 				return config_error_nonbool(key);
-- 
1.8.2
