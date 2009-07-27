From: Tom Grennan <tgrennan@redback.com>
Subject: [PATCH] Make "git request-pull" use the configured remote.REMOTE.uploadpack
Date: Mon, 27 Jul 2009 14:02:43 -0700
Message-ID: <1248728563-23906-1-git-send-email-tgrennan@redback.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 27 23:11:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVXUD-0003Ap-Cb
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 23:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833AbZG0VLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 17:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754831AbZG0VLs
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 17:11:48 -0400
Received: from mgate.redback.com ([155.53.3.41]:53210 "EHLO mgate.redback.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754596AbZG0VLs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 17:11:48 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2009 17:11:48 EDT
X-IronPort-AV: E=Sophos;i="4.43,277,1246863600"; 
   d="scan'208";a="3899909"
Received: from prattle.redback.com ([155.53.12.9])
  by mgate.redback.com with ESMTP; 27 Jul 2009 14:02:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by prattle.redback.com (Postfix) with ESMTP id 247DEC2B2EF;
	Mon, 27 Jul 2009 14:02:15 -0700 (PDT)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16270-04; Mon, 27 Jul 2009 14:02:15 -0700 (PDT)
Received: from localhost (login004.redback.com [155.53.12.57])
	by prattle.redback.com (Postfix) with ESMTP id B84B0C2B2ED;
	Mon, 27 Jul 2009 14:02:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124195>

git-request-pull.sh should use git-parse-remote:get_uploadpack() to
load a configured remote.REMOTE.uploadpack like "git remote show" and
"git fetch". This allows one to specify the path of git-upload-pack on
the remote side.

Signed-off-by: Tom Grennan <tgrennan@redback.com>
---
 git-request-pull.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index a2cf5b8..612e94d 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -25,8 +25,9 @@ headrev=`git rev-parse --verify "$head"^0` || exit
 merge_base=`git merge-base $baserev $headrev` ||
 die "fatal: No commits in common between $base and $head"
 
+upload_pack=$(get_uploadpack "$url")
 url=$(get_remote_url "$url")
-branch=$(git ls-remote "$url" \
+branch=$(git ls-remote --upload-pack="$upload_pack" "$url" \
 	| sed -n -e "/^$headrev	refs.heads./{
 		s/^.*	refs.heads.//
 		p
-- 
1.6.2.1.dirty
