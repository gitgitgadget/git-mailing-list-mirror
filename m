From: Matthias Asshauer <mha1993@live.de>
Subject: [PATCH 2/2] stash: use "stash--helper"
Date: Thu, 28 Jan 2016 20:36:05 +0000
Message-ID: <0000015289f33e85-713596a1-2718-4c3a-bf3c-4a0f1048d401-000000@eu-west-1.amazonses.com>
References: <0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 21:45:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOtRS-0007U7-3q
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 21:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbcA1UpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 15:45:17 -0500
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:38468
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161142AbcA1UpP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 15:45:15 -0500
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2016 15:45:15 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1454013365;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=JYGqH891ebRFfuEox2PjdPS7+F85UE3PLWUsMG0mOvw=;
	b=h4RUfviNB9W8Q/6my84ITEGrILYPme8a+7sJ/LtTfk9xMrfVaDu/M98ftwbO3ADO
	KjUgcFCkY/Cx9Lz0ycR56pJ83u+z+Gc36AURc6ZBXmXfYinB1oVwWoNX2CS1uWNi0g+
	6W+6SZEKTUKk6T/RqkiiZpE5eD6zvXR/Xto2t7kI=
In-Reply-To: <0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.01.28-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285027>

=46rom: Matthias A=C3=9Fhauer <mha1993@live.de>

Use the new "git stash--helper" builtin. It should be faster than the o=
ld shell code and is a first step to move
more shell code to C.

Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
---
 git-stash.sh | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index c7c65e2..973c77b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -112,15 +112,7 @@ create_stash () {
 	then
=20
 		# state of the working tree
-		w_tree=3D$( (
-			git read-tree --index-output=3D"$TMPindex" -m $i_tree &&
-			GIT_INDEX_FILE=3D"$TMPindex" &&
-			export GIT_INDEX_FILE &&
-			git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
-			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
-			git write-tree &&
-			rm -f "$TMPindex"
-		) ) ||
+		w_tree=3D$(git stash--helper --non-patch "$TMPindex" $i_tree) ||
 			die "$(gettext "Cannot save the current worktree state")"
=20
 	else

--
https://github.com/git/git/pull/191
