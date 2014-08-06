From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 12/23] rebase -i: root commits are replayed with an unnecessary option
Date: Thu,  7 Aug 2014 01:59:19 +0200
Message-ID: <310132fa864bc7ec6d0268bb37dc1afbee7c8be8.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB9C-0004ur-LT
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbaHGAB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:01:29 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:60341 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbaHGAAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:45 -0400
Received: by mail-qa0-f52.google.com with SMTP id j15so3186339qaq.25
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cIu75/Hb1PAbp8D3fwfxUeSCZiP78hcd+lbV6y6zvdw=;
        b=hKtzr2IcOyXmADHa2cRuqX9Jc5vi8XqjoYkq7cqOqDWdX2G6PbOxjKOudVsfr7HUXa
         tfcTm7foiQIKPwyD3TaVLhOB5kOaBQ61K+3nMI0qPy/Ru5+dZ3JeStcW4B42NsWHesse
         aZPSYDZpbcULyx4D1wg15Lva6tWGFjwvoDrXltc1MVZap15Qn5uqb8FQKonVPZZIxCRw
         anQZn/hYf/0CYwOtBYfVXFlkqlm4K8u7ZUSxsmnYfw4DxgUmzy5eRQ6UPiaGE5LAR3ZN
         MV5tcqbZJ2RopNupZkZBUKPhK+5qaIWLBbasdXJrFRbjldncr9tE6pOYgkR+55CSFYa6
         xgOg==
X-Received: by 10.140.33.200 with SMTP id j66mr8009587qgj.81.1407369644967;
        Wed, 06 Aug 2014 17:00:44 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254939>

The command line used to recreate root commits uses `-C` to suppress
the log message editor. This is unnecessarily confusing, though,
because that suppression is a secondary effect of the option. The
main purpose of `-C` is to pull the metadata from another commit, but
here we know that this is a noop, since we are amending a commit just
created from the same data.

At the time `-C` was introduced, git-commit did not yet have a
documented `--no-edit`, and this was a reasonable way to get the
desired behavior. Switch it to use `--no-edit` to make the intended
effect more obvious.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 91ef0f7..71571c8 100644
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
