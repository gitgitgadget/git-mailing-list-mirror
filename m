From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 14/31] rebase: factor out clean work tree check
Date: Tue, 28 Dec 2010 10:30:31 +0100
Message-ID: <1293528648-21873-15-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:33:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYj-0005Wr-T4
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab0L1Pcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:32:50 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58332 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab0L1Pcs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:48 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so11286158qyj.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZRpqL+ePXpSnDwZ8dbCh4u8tln8fRKn7KbkxL+koYL4=;
        b=b2cT854FU7rgWTSeLLKJy0jxt23ZAcehVjrs37+qoNblp/lNQc7B1o+FL39s38rUxy
         rysvvDGIDIdMREC7bGBm849tO1UvbvxaAPwq/WzVM/TrLpQhaFFrGKX3duZeOZeXSlYa
         3iMMotpzgpkw8DmoPLMJs8F3ef0teQrAyTnYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ih5Dmp4Lt4zkj8i8ixTAWUxl0pzeAIhS6ogoIqgBAUUJrBHLbWIdUnpFnl++8XKwwC
         mjlo0O2jpGtgGE75AQQN5hT6BBwiNiWz+kQH0iToYGbeWh6xz/aqbsRHNsBknCgzOKsC
         99NqV9oOFckUIH3KLzXHlrciyBv4Ky2OXAz0k=
Received: by 10.224.60.194 with SMTP id q2mr12836426qah.128.1293550367666;
        Tue, 28 Dec 2010 07:32:47 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:46 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164252>

Remove the check for clean work tree from git-rebase--interactive.sh and
rely on the check in git-rebase.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |    2 --
 git-rebase.sh              |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c055fc4..edde1e5 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -753,8 +753,6 @@ esac
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
-require_clean_work_tree "rebase" "Please commit or stash them."
-
 run_pre_rebase_hook "$upstream_arg" "$@"
 
 comment_for_reflog start
diff --git a/git-rebase.sh b/git-rebase.sh
index d8c7c8d..e1e5263 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -513,10 +513,10 @@ case "$#" in
 esac
 orig_head=$branch
 
-test "$type" = interactive && run_interactive_rebase "$@"
-
 require_clean_work_tree "rebase" "Please commit or stash them."
 
+test "$type" = interactive && run_interactive_rebase "$@"
+
 # Now we are rebasing commits $upstream..$branch (or with --root,
 # everything leading up to $branch) on top of $onto
 
-- 
1.7.3.2.864.gbbb96
