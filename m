From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv2 2/2] pull: support rebased upstream + fetch + pull --rebase
Date: Thu, 16 Jul 2009 10:12:01 +0200
Message-ID: <1247731921-2290-2-git-send-email-santi@agolina.net>
References: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com>
 <1247731921-2290-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:11:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRM41-0003gZ-Oq
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 10:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbZGPILb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 04:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbZGPIL3
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 04:11:29 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:50834 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbZGPIL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 04:11:27 -0400
Received: by fxm18 with SMTP id 18so3927518fxm.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 01:11:26 -0700 (PDT)
Received: by 10.103.181.2 with SMTP id i2mr4654965mup.20.1247731886439;
        Thu, 16 Jul 2009 01:11:26 -0700 (PDT)
Received: from localhost (p5B0D3A8D.dip.t-dialin.net [91.13.58.141])
        by mx.google.com with ESMTPS id e10sm19208847muf.44.2009.07.16.01.11.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Jul 2009 01:11:25 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc0.19.g1b31.dirty
In-Reply-To: <1247731921-2290-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123383>

  and here the interdiff between v1 and v2.

Santi

diff --git a/git-pull.sh b/git-pull.sh
index f5bef53..31d3945 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -125,13 +125,13 @@ test true = "$rebase" && {
 	die "refusing to pull with rebase: your working tree is not up-to-date"
 
 	. git-parse-remote &&
-	reflist="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
+	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
 	num=0 &&
-	while oldremoteref="$(git rev-parse -q --verify "$reflist@{$num}")"
+	while oldremoteref="$(git rev-parse -q --verify "$remoteref@{$num}")"
 	do
 		test $oldremoteref = $(git merge-base $oldremoteref $curr_branch) &&
 		break
-		num=$((num+1))
+		num=$(( $num + 1 ))
 	done
 }
 orig_head=$(git rev-parse -q --verify HEAD)
