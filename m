From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 08/19] rebase -i: Root commits are replayed with an unnecessary option
Date: Wed,  2 Jul 2014 19:48:00 +0200
Message-ID: <606af9e165c447b59076046a4d84aecf8b4cd2b0.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:50:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Ofj-0006xe-13
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785AbaGBRuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:50:04 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:59309 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbaGBRtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:49:50 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so969088wiv.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Kcaejan7aWt4E6WBtqb7Srku6psbTrSc55QL55DSGk=;
        b=lgcPEvgEsKD3kCVgUfVdJUPI9x8076TVDRXgeLl0wYht3M/I7Tzaz5k/Yj3sOLzTQd
         rNtR+4KY5SEM0JFWOJN14HKyx9tV1reRRB1r9AT6sAOEX9+mkBxO2PUvyPd/km/tl7mX
         6zUCvUXKCu6WZdhHq1SSO9+M4r+qzNsJSGcuzZSDGN9IvqifHRCiJdgdH2Sv6nu60grt
         MOTZE6sAPcf4udrDg2EgznzI5dImibv/TzesEobh3y1J13t6PkN+NOtdhjMbiSbyUU6n
         eOjPhulhXW4aS8qRuEnO+RzdnKliEhKGM4rBRFs4GVIyRxRSBAtdRBRKZuqZqzzMn+5w
         Kflw==
X-Received: by 10.194.185.238 with SMTP id ff14mr38321361wjc.9.1404323389502;
        Wed, 02 Jul 2014 10:49:49 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.49.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:49:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252814>

The command line used to recreate root commits specifies the
effectless option `-C`. It is used to reuse commit message and
authorship from the named commit but the commit being amended here,
which is the sentinel commit, already carries the authorship and log
message of the processed commit. Note that the committer email and
commit date fields do not match the root commit either way. Remove
the option. However, `-C` (other than `-c`) does not invoke the
editor and the `--amend` option invokes it by default. Disable editor
invocation again by specifying `--no-edit`.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ff04d5d..17836d5 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -511,7 +511,7 @@ do_pick () {
 			   --no-post-rewrite -n -q -C $1 &&
 			pick_one -n $1 &&
 			git commit --allow-empty \
-				   --amend --no-post-rewrite -n -C $1 \
+				   --amend --no-post-rewrite -n --no-edit \
 				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
 			die_with_patch $1 "Could not apply $1... $2"
 	else
-- 
2.0.0
