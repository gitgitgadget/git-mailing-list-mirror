From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] rebase -i: fix reword when using a terminal editor
Date: Thu, 15 Oct 2009 23:32:33 -0700
Message-ID: <1255674753-13949-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 08:36:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MygQQ-00017J-Gg
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 08:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbZJPGdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 02:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbZJPGdo
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 02:33:44 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:2865 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbZJPGdn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 02:33:43 -0400
Received: by qw-out-2122.google.com with SMTP id 9so527000qwb.37
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 23:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=0mz/rknK7W+BcQMGiZJRG9090WKfBTwja5Dji15YS/0=;
        b=DL7xyM/8stUFSuOpHV6fUMFP9xQ73iGuVStvHurULZw6xMy0j9bzLsaj9xs7MC1HZp
         WQeFy9XLiTw6iF+QuYIe88Cq4tyTMfvKifPu9t9qg2J0+JVF5LAOJjN1ccXMxCFjaz2L
         fB5EnYHDdCWeikxIO9GhHpfpLTOa96lnKpRmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Of/z9NBVxnIGTEVnx6Rvo0I+4bsQuNNcH+C2/jEcH+8vsMs19/9vXSh8nxoVjZ2Kfm
         PsRG7js4E7KqWKeayXQ5FegbBu1nrWeEKRQ2s9N3IecCz3IrSqyG5W2sHlBx1r4mtaEU
         v4OofKb9xvTaUOsVkxw7Xaeif5LBFswoh1tGA=
Received: by 10.224.73.30 with SMTP id o30mr772706qaj.329.1255674757167;
        Thu, 15 Oct 2009 23:32:37 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 7sm1957958qwb.32.2009.10.15.23.32.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 23:32:36 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 15 Oct 2009 23:32:33 -0700
X-Mailer: git-send-email 1.6.5.103.g6b436.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130459>

We don't want to use output() on git-commit --amend when rewording the
commit message. This leads to confusion as the editor is run in a
subshell with it's output saved away, leaving the user with a seemingly
frozen terminal.

Fix by removing the output part.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

On top of next.

I think this is right, although I'm not really experienced in the rebase -i
code

 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a43ee22..a1879e3 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -346,7 +346,7 @@ do_next () {
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		output git commit --amend
+		git commit --amend
 		;;
 	edit|e)
 		comment_for_reflog edit
-- 
1.6.5.103.g6b436.dirty
