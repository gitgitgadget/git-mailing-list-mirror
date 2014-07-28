From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 07/19] rebase -i: log the replay of root commits
Date: Tue, 29 Jul 2014 01:18:07 +0200
Message-ID: <7389745946359e0d9d8c6f1e8f2ebc78033132e6.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:21:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuEa-0006U3-8p
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbaG1XVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:21:30 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:37586 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbaG1XUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:48 -0400
Received: by mail-we0-f172.google.com with SMTP id x48so8059370wes.17
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RyDt9tjDTa0VVzuk2Yw/z5YiCEWOJ2jC8LCtZQ5LCzw=;
        b=VvDuAYUrJaCN5zZS4T+Ujuzoh4oi79zbt4v1ND8mlTHKcKrzflwzxUD2Es99zeelaT
         R9/CD0ZsDHbFR7fZRnZ8IB2H7iIKfrYQt+pCH0CUrh9cb9w9PlRlbkYkjEgEKCPF9Brv
         qPJYUdc5RvQHpPUQpO2Km9ABwFH5BtX0Jy4fbWaeyYThBf597/3EIVwWeCY8hmIEyuR1
         cdw1yktufRdRhKZm8kRy8bQGYO/7uXD0+MfJaCmkEt/T8gI9sJYS6uM/K3kWyZMsxE9B
         78/fOEnNxjeBCFjtTmZZRT7fagidRaKrIBgyzWdcdfak60f/z4ofDJTkg8qRNvEvo2o/
         okyQ==
X-Received: by 10.194.192.201 with SMTP id hi9mr54690840wjc.28.1406589646869;
        Mon, 28 Jul 2014 16:20:46 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254380>

The command line used to recreate root commits specifies the option
`-q` which suppresses the commit summary message. However,
git-rebase--interactive tends to tell the user about the commits it
creates in the final history, if she wishes (cf. command line option
`--verbose`). The code parts handling non-root commits and squash
commits all output commit summary messages. Do not make the replay of
root commits an exception. Remove the option to make the report of
the rebased history complete.

It is OK that the commit summary is still suppressed when git-commit
is used to initialize the authorship of the sentinel commit because
this additional commit is an implementation detail hidden from the
final history. The removed `-q` option was probably introduced as a
copy-and-paste error stemming from that part of the root commit
handling code.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6e2c429..576e0b1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -511,7 +511,7 @@ do_pick () {
 			   --no-post-rewrite -n -q -C $1 &&
 			pick_one -n $1 &&
 			git commit --allow-empty --allow-empty-message \
-				   --amend --no-post-rewrite -n -q -C $1 \
+				   --amend --no-post-rewrite -n -C $1 \
 				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
 			die_with_patch $1 "Could not apply $1... $2"
 	else
-- 
2.0.1
