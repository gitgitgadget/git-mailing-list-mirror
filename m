From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 14/20] rebase: factor out clean work tree check
Date: Thu, 25 Nov 2010 20:57:57 +0100
Message-ID: <1290715083-16919-15-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:58:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLna9-0001kp-9G
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab0KZB6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:33 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62199 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab0KZB6W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:22 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so347969vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fThPuQIc61VEeqUzF2deqTVeGTeQFAFbXMo6gaRz8ss=;
        b=PcZY6X6sZuuGUeeI/xR5WUjI25U0nyiO3HdjFxRzupSVZNXR0FPtM/TAf/JToiSezW
         xIOVPDStYj0YZig7+MHdjd5CiFBy3WMuezDFc1Wh6e5JcVsIHR7+Tbq6S7mKDS6chvmo
         UJYlOi+XOS4xJFECAmkjkmfq3LHUWlwKCryPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n9G0IREYpbzn1kP9v0+ShMdfTTxeZRPMYAq89/Y0bDYoSK2TxA1W/m7fdsEROAXmUc
         nX34xN84jTTj6nVn7+o2O/aypEFWaiAzVdet283RSb9wiDjjlsq8UnCnWj+ukuKCc1fj
         I2Xv6K1BkoHlwshquIop8M3pzfJPIhcUGfdpI=
Received: by 10.220.179.204 with SMTP id br12mr428945vcb.25.1290736701792;
        Thu, 25 Nov 2010 17:58:21 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:21 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162167>

Remove the check for clean work tree from git-rebase--interactive.sh and
rely on the check in git-rebase.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |    2 --
 git-rebase.sh              |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index fe56d98..36bf259 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -755,8 +755,6 @@ test -n "$strategy" && strategy="-s $strategy"
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
-require_clean_work_tree "rebase" "Please commit or stash them."
-
 run_pre_rebase_hook "$upstream_arg" "$@"
 
 comment_for_reflog start
diff --git a/git-rebase.sh b/git-rebase.sh
index 17b5042..9d398eb 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -495,10 +495,10 @@ case "$#" in
 esac
 orig_head=$branch
 
-test -n "$interactive_rebase" && run_interactive_rebase "$@"
-
 require_clean_work_tree "rebase" "Please commit or stash them."
 
+test -n "$interactive_rebase" && run_interactive_rebase "$@"
+
 # Now we are rebasing commits $upstream..$branch (or with --root,
 # everything leading up to $branch) on top of $onto
 
-- 
1.7.3.2.864.gbbb96
