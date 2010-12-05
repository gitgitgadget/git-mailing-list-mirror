From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv2] parse-remote: handle detached HEAD
Date: Mon,  6 Dec 2010 00:58:37 +0100
Message-ID: <1291593517-4406-1-git-send-email-santi@agolina.net>
References: <AANLkTi=yfuiFuatshYuS2Q0EV0Ytj-QFKpuXAWeGerQB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 00:58:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPOTm-0007dh-Ac
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 00:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199Ab0LEX6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 18:58:46 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58347 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab0LEX6p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 18:58:45 -0500
Received: by wyb28 with SMTP id 28so11469090wyb.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 15:58:44 -0800 (PST)
Received: by 10.227.136.146 with SMTP id r18mr4872390wbt.98.1291593524079;
        Sun, 05 Dec 2010 15:58:44 -0800 (PST)
Received: from localhost.localdomain (189.194.19.95.dynamic.jazztel.es [95.19.194.189])
        by mx.google.com with ESMTPS id h29sm3026767wbc.9.2010.12.05.15.58.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 15:58:43 -0800 (PST)
X-Mailer: git-send-email 1.7.3.3.399.gea47f
In-Reply-To: <AANLkTi=yfuiFuatshYuS2Q0EV0Ytj-QFKpuXAWeGerQB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162967>

In get_remote_merge_branch 'git for-each-ref' is used to know the
upstream branch of the current branch ($curr_branch). But $curr_branch
can be empty when in detached HEAD, so the call to for-each-ref is
made without a pattern.

Quote the $curr_branch variable in the git for-each-ref call to always
provide a pattern (the current branch or an empty string) Otherwise it
would mean all refs.

Reported-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
Tested-by: Sverre Rabbelier <srabbelier@gmail.com>
---
Changes since v1:
  Tags for Reported-by and Tested-by.

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
