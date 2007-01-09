From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git-clone: Make sure the master branch exists before running cat on it.
Date: Tue, 09 Jan 2007 21:26:52 +0100
Message-ID: <87bql80wvn.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 21:27:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4NYg-0002ha-Bf
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 21:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbXAIU04 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 15:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbXAIU04
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 15:26:56 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:53725 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280AbXAIU0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 15:26:55 -0500
Received: from adsl-84-226-97-216.adslplus.ch ([84.226.97.216] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1H4NYc-0005Cq-Pe
	for git@vger.kernel.org; Tue, 09 Jan 2007 14:26:55 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id DD80C4F6AD; Tue,  9 Jan 2007 21:26:52 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36395>

Otherwise we get an error like this on stderr:

  cat: [...]/.git/refs/remotes/origin/master: No such file or directory

which makes it look like git-clone failed.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 git-clone.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 3d388de..cf761b2 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -355,7 +355,7 @@ then
 	# The name under $remote_top the remote HEAD seems to point at.
 	head_points_at=$(
 		(
-			echo "master"
+			test -f "$GIT_DIR/$remote_top/master" && echo "master"
 			cd "$GIT_DIR/$remote_top" &&
 			find . -type f -print | sed -e 's/^\.\///'
 		) | (
-- 
1.4.4.4.g37ed

-- 
Alexandre Julliard
julliard@winehq.org
