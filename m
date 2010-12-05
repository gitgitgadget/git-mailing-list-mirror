From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH] parse-remote: handle detached HEAD
Date: Mon,  6 Dec 2010 00:47:15 +0100
Message-ID: <1291592835-29949-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 00:47:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPOIp-0003yv-AO
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 00:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab0LEXrc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 18:47:32 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42330 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab0LEXrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 18:47:24 -0500
Received: by wyb28 with SMTP id 28so11463054wyb.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 15:47:23 -0800 (PST)
Received: by 10.216.155.68 with SMTP id i46mr3976595wek.92.1291592843235;
        Sun, 05 Dec 2010 15:47:23 -0800 (PST)
Received: from localhost.localdomain (189.194.19.95.dynamic.jazztel.es [95.19.194.189])
        by mx.google.com with ESMTPS id w84sm2068581weq.20.2010.12.05.15.47.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 15:47:22 -0800 (PST)
X-Mailer: git-send-email 1.7.3.3.399.gea47f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162965>

In get_remote_merge_branch 'git for-each-ref' is used to know the
upstream branch of the current branch ($curr_branch). But $curr_branch
can be empty when in detached HEAD, so the call to for-each-ref is
made without a pattern.

Quote the $curr_branch variable in the git for-each-ref call to always
provide a pattern (the current branch or an empty string) Otherwise it
would mean all refs.

This fixes a bug reported by Sverre Rabbelier. The overall results
were correct but not the output text.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
Hi *,

Sorry Sverre, but the patch you tested fixed your case but broke all
the others :(

Hope you can also test it. Now it passes the test suite.

Thanks,
Santi
 git-parse-remote.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5f47b18..07060c3 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -68,7 +68,7 @@ get_remote_merge_branch () {
 	    test -z "$origin" && origin=3D$default
 	    curr_branch=3D$(git symbolic-ref -q HEAD)
 	    [ "$origin" =3D "$default" ] &&
-	    echo $(git for-each-ref --format=3D'%(upstream)' $curr_branch)
+	    echo $(git for-each-ref --format=3D'%(upstream)' "$curr_branch")
 	    ;;
 	*)
 	    repo=3D$1
--=20
1.7.3.3.399.gea47f
