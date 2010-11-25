From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 11/20] rebase -i: remove now unnecessary directory checks
Date: Thu, 25 Nov 2010 20:57:54 +0100
Message-ID: <1290715083-16919-12-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:59:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLnb0-00026e-UC
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab0KZB6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:52 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62199 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200Ab0KZB6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:18 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so347969vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=F7JbMk2dWm/KLP1jZR+LYfOmdTRhLkh5qZCN52h9KpA=;
        b=sJwGT0HPdqUMfcvdmB3I90csyw1GinRv15HAgiaPvCGyQztC1JQyRb/xnT+yW4L+5x
         g6KplO2EX/0bZfYPOS+6wFo6XArMtuWueq5mWWYRAOd70VaPS61VqxEiv7m7uPNOM69C
         7WlIzWJxFvulZh5F3Ud1x24J1GzsTqmHcWutk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vF+ar7cigQlh7C6+Io3iXx/Ro+iUJxHmzclqbq72DtHCq/lZgWeLC4sm3vVIwARFK/
         yNXIm/NZrirWdtvRd916DApaipYp7HzRirDwVQf6syP/NrzU04SD/Bvv1dBBnS5zJEQH
         mRqjMuL7zzxVvw8xyQtye9G1aXTV6qEyU+/Ow=
Received: by 10.220.181.65 with SMTP id bx1mr430214vcb.19.1290736697889;
        Thu, 25 Nov 2010 17:58:17 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:17 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162178>

Remove directory checks from git-rebase--interactive.sh that are done in
git-rebase.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |    6 ------
 git-rebase.sh              |    3 ++-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6389a9f..07c10f3 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -706,8 +706,6 @@ continue)
 	get_saved_options
 	comment_for_reflog continue
 
-	test -d "$DOTEST" || die "No interactive rebase running"
-
 	# Sanity check
 	git rev-parse --verify HEAD >/dev/null ||
 		die "Cannot read HEAD"
@@ -749,7 +747,6 @@ abort)
 	comment_for_reflog abort
 
 	git rerere clear
-	test -d "$DOTEST" || die "No interactive rebase running"
 
 	HEADNAME=$(cat "$DOTEST"/head-name)
 	HEAD=$(cat "$DOTEST"/head)
@@ -767,7 +764,6 @@ skip)
 	comment_for_reflog skip
 
 	git rerere clear
-	test -d "$DOTEST" || die "No interactive rebase running"
 
 	output git reset --hard && do_rest
 	;;
@@ -781,8 +777,6 @@ test -n "$strategy" && strategy="-s $strategy"
 
 test -z "$rebase_root" -a $# -ge 1 -a $# -le 2 ||
 test ! -z "$rebase_root" -a $# -le 1 || usage
-test -d "$DOTEST" &&
-	die "Interactive rebase already started"
 
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
diff --git a/git-rebase.sh b/git-rebase.sh
index df4e184..2b19d2f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -324,7 +324,8 @@ then
 	test -z "$onto" &&
 	test -z "$preserve_merges" ||
 	usage
-	test -d "$merge_dir" -o -d "$apply_dir" || die "No rebase in progress?"
+	test -d "$apply_dir" -a -z "$interactive_rebase" ||
+	test -d "$merge_dir" || die "No rebase in progress?"
 else
 	# Make sure we do not have $apply_dir or $merge_dir
 	if test -z "$do_merge"
-- 
1.7.3.2.864.gbbb96
