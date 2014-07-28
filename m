From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 08/19] rebase -i: root commits are replayed with an unnecessary option
Date: Tue, 29 Jul 2014 01:18:08 +0200
Message-ID: <7ed1b44ae05860a556d86c8b90ac6fff0906128d.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:20:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuDx-0006Bf-4V
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbaG1XUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:20:52 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:51871 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbaG1XUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:49 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so8021456wes.29
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbgjdXD3Q58nOhesgbJuAhJlua7LfDUs+HyV/Vtuyo8=;
        b=CL/h/7xPJHTox02h/A1Em7oLPDG6Bjno4IvGlKgZLCMsD6Il8ynZtzacoptyq1IW5a
         xddoSTwgRForqxMqih8caww+jJUpqCVujkP0vD78AjLEuz1NljFR4aLonsHpETzKFwGV
         eJ2zycJtnaUpW46rJ+HltPnL9xRtPQDnMFOPsimNCFX/0SH17WBrpzrIv9DNrsiQQcZb
         guZ9Nk0mCrJRBy3M4CLWxJ9Pk94fWWU4SNI0X4C6M3OBt5Zq0ILaov+nTPEsmxOXRWqv
         3OY7GMFTAnGTKi6JBnZt7PdD+V8Q3E01X8/gjO6kqZJ18m5rez6ixzns5Rwk+rD35fyU
         0wSw==
X-Received: by 10.180.212.113 with SMTP id nj17mr34932422wic.46.1406589648326;
        Mon, 28 Jul 2014 16:20:48 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254368>

The command line used to recreate root commits specifies the
effectless option `-C`. It makes git-commit reuse commit message and
authorship of the named commit. However, the commit being amended
here, which is the sentinel commit, already carries the authorship
and log message of the commit being replayed. Remove the option.

Since `-C` (in contrast to `-c`) does not invoke the editor and the
`--amend` option invokes it by default, disable editor invocation
again by specifying `--no-edit`.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 576e0b1..46f436f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -511,7 +511,7 @@ do_pick () {
 			   --no-post-rewrite -n -q -C $1 &&
 			pick_one -n $1 &&
 			git commit --allow-empty --allow-empty-message \
-				   --amend --no-post-rewrite -n -C $1 \
+				   --amend --no-post-rewrite -n --no-edit \
 				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
 			die_with_patch $1 "Could not apply $1... $2"
 	else
-- 
2.0.1
