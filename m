From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/7] checkout: prevent checking out a branch being rebased in another worktree
Date: Sun, 17 Apr 2016 19:59:25 +0700
Message-ID: <1460897965-486-8-git-send-email-pclouds@gmail.com>
References: <CACsJy8BOwzJSmS3PPeeRuaRwq=+kYLH8NX0i7P_wfDW9gLt6bA@mail.gmail.com>
 <1460897965-486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 15:00:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1armJc-0007VU-TX
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 15:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbcDQNAh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2016 09:00:37 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34724 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbcDQNAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 09:00:36 -0400
Received: by mail-pa0-f67.google.com with SMTP id hb4so13793366pac.1
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8AMVjCL836CmGdHxJ4vl0gihw3DJF+bD76qDO00f6uI=;
        b=D7Y1bEtuJymjW5kyYbaoKmnMlJezsYYmXo4AKhcP6OPWl1yAnPerhz2Gahaow44Sl/
         XY0XQXQpcLWgQ8weAaobkQ8ubDSLChY2wxhFfjpAXg3N5fOBRG38ScwWPNdjqzmqubbP
         FgxxWXqS3KP+5xZBOBx7Ep/71miReFD112vN3bq+73ucxSeyDAR34FAwWv8TYZRQjsHx
         OOS/OYxD+GRm8WpGRrxl4AvJUTg1wZHzt7oAvApwU8R1c6nrBibBi668b3Zv+w7PnCsF
         zl1g9maVJszsqhO7EykPuGg8Tt+ddVnrJ7uEViN3h5qu+xKcBDJrmC2Tgq3Nsu/9Mksn
         0wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AMVjCL836CmGdHxJ4vl0gihw3DJF+bD76qDO00f6uI=;
        b=WQyBItpQbrkcZzFUUNV1tsxiW4qu4kWUoelxM3j9a1ZLeWNcjqWKUHFNAjsM6Uey7O
         uKtHtydokCH1QqYMkUYv5C/XCuoxtkyB9TEHrokLdwhW0AkUn4VE3X4Y2b3jufX1n34y
         ax/f/oi09cU9pzDZIHxsocLRG+sg1LwKgCwUvWuWQiOTFHYBQSl7Wu3qzLTRzBHLddOP
         hNa2j8lvtwzozUYfsMYyl4Iz5WUMfYclmK7vkfoPZWa2PuVlFXsTXx3Ce7GPZQcqrGkP
         +bUhl/3filUXevp2EGD6ZDd3ACX0Y51e10T7dq0KohsnnN75Qo02tIORpEYtXME/voyE
         Jnlw==
X-Gm-Message-State: AOPr4FU+0tsanhUZmuf6wNVOAuBenYp68C7XqOW4s+J3rtKJRjzAq7RNCxQ01YtKe1q+Cw==
X-Received: by 10.67.6.10 with SMTP id cq10mr42740384pad.120.1460898030884;
        Sun, 17 Apr 2016 06:00:30 -0700 (PDT)
Received: from lanh ([171.232.186.84])
        by smtp.gmail.com with ESMTPSA id q26sm76869536pfi.57.2016.04.17.06.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 06:00:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 17 Apr 2016 20:00:39 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460897965-486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291757>

We failed to detect this case because the rebase-in-progress worktree
has HEAD in detached state. Some more poking around is needed to
determine if a rebase is in progress.

Note that even though bisect can also put a worktree in detached state
and hide the real branch, we allow to checkout anyway. This is because
unlike rebase, bisect does not update the branch. Yes it's still a bit
confusing when the user doing the bisecting realizes that the branch is
updated elsewhere, but at least we do not lose any valuable ref update.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/worktree.c b/worktree.c
index 3b7c6f2..6dc40c2 100644
--- a/worktree.c
+++ b/worktree.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "strbuf.h"
 #include "worktree.h"
+#include "wt-status.h"
=20
 void free_worktrees(struct worktree **worktrees)
 {
@@ -202,6 +203,28 @@ char *find_shared_symref(const char *symref, const=
 char *target)
 	for (i =3D 0; worktrees[i]; i++) {
 		struct worktree *wt =3D worktrees[i];
=20
+		if (wt->is_detached) {
+			struct wt_status_state wss;
+			int found;
+
+			memset(&wss, 0, sizeof(wss));
+			wss.wt =3D wt;
+			wt_status_get_state(&wss, 0);
+			found =3D (wss.rebase_in_progress ||
+				 wss.rebase_interactive_in_progress) &&
+				wss.branch &&
+				starts_with(target, "refs/heads/") &&
+				!strcmp(wss.branch,
+					target + strlen("refs/heads/"));
+			free(wss.branch);
+			free(wss.onto);
+			free(wss.detached_from);
+			if (found) {
+				existing =3D xstrdup(wt->path);
+				break;
+			}
+		}
+
 		strbuf_reset(&path);
 		strbuf_reset(&sb);
 		strbuf_addf(&path, "%s/%s",
--=20
2.8.0.rc0.210.gd302cd2
