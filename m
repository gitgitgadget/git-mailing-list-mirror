From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 13/27] rebase -i: do not use -C when --no-edit is sufficient
Date: Mon, 18 Aug 2014 23:22:56 +0200
Message-ID: <eea24286b323e225fac4239a25d4c495e753eea0.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:26:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJURE-0001RZ-Gr
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbaHRVZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:25:49 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:42463 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbaHRVYF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:05 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so4742612lbi.13
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KTwQufVDTvsPHwO6OkWjlZISfROTi5yCar3vm5OlmwY=;
        b=CmQYXX7zF3bMAlJ80sS6LmXl/Gbi+1tTN0r08z3eHK1QwogUujZabAy5tTbgf78eRl
         WFMBj01JkjDBjLuX/ss8BACwwoXRUqpLVpGXskR1ofy1HbnMn5TMXAy59uPbs1fWL3wy
         xRzhoPqUNHYEQ8FGmwHwdW0Ehps0yGd9pC/ToSLW8lyHz64C3yZiKTFNaac/pwEKzDAH
         yRYa8a0puQplL8zC4WdJ8XxJPJGcmjUoRTt+kxpYB15Co7xxuT83wwnTAgx8e8daloWA
         I5ddcpYNgJ9MJoMWGDiG+Bay4MhLAl7WLTxBO94mijHAFEAiFrsY2FgrblkDD7xM8rPF
         nfSw==
X-Received: by 10.112.166.2 with SMTP id zc2mr5137346lbb.98.1408397044160;
        Mon, 18 Aug 2014 14:24:04 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255435>

The command line used to recreate root commits uses `-C` to suppress
the log message editor. This is unnecessarily confusing, though,
because that suppression is a secondary effect of the option. The
main purpose of `-C` is to pull the metadata from another commit, but
here we know that this is a no-op, since we are amending a commit
just created from the same data.

At the time `-C` was introduced, git-commit did not yet have a
documented `--no-edit`, and this was a reasonable way to get the
desired behavior. Switch it to use `--no-edit` to make the intended
effect more obvious.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f4bb822..6561831 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -511,7 +511,7 @@ do_pick () {
 			   --no-post-rewrite -n -q -C $1 &&
 			pick_one -n $1 &&
 			output git commit --allow-empty --allow-empty-message \
-				   --amend --no-post-rewrite -n -C $1 \
+				   --amend --no-post-rewrite -n --no-edit \
 				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
 			die_with_patch $1 "Could not apply $1... $2"
 	else
-- 
2.0.1
