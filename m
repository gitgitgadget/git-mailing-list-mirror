From: Phil Pennock <pdp@spodhuis.org>
Subject: [PATCH] zsh completion: 5.0.3 compat, use emulate
Date: Mon, 16 Dec 2013 03:32:25 -0500
Message-ID: <EMXW5CZ-001FUQ-3S@ilmenite.field.spodhuis.org>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 16 09:55:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsTxV-0002Oi-5T
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 09:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab3LPIzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 03:55:21 -0500
Received: from redoubt.spodhuis.org ([94.142.241.89]:58600 "EHLO
	mx.spodhuis.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3LPIzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 03:55:20 -0500
X-Greylist: delayed 976 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2013 03:55:19 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=spodhuis.org; s=d201210;
	h=Message-Id:Subject:Date:Cc:To:From; bh=TDCCc9RB0MhGd0ku9MYAfpjoN9S81gCr0yOlgtMl0Xs=;
	b=AewwxfXfg5rfwo14Fna2NGHvVYTPElN9qwz8bVmqPQev8PjJbt9wBQa+zXt3/cLD9RKWppAN6y80yEXHd2hgr1MIrGeyxe+CJtaB11/abtZXRPG0vTrXj2o4ZTtQmdv+ygk66MbBcytrlyBUmF+KCjdmmTANPoEMP6kQjq3RKLQ=;
Received: from authenticated user by smtp.spodhuis.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	id 1VsThd-0006HQ-9t; Mon, 16 Dec 2013 08:39:01 +0000
Received: from authenticated user by ilmenite.field.spodhuis.org with local 
	id MXW5CZ-001FUQ-3S; Mon, 16 Dec 2013 08:38:59 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239332>

The bash completion pulled into zsh was being pulled in _as_ zsh, but
used patterns which relied on falling through as unhandled.  In zsh
5.0.3 this no longer works, resulting in:

    __git_complete_remote_or_refspec:33: bad pattern: +*

Fix by telling zsh to emulate sh while sourcing the bash config file,
which stickily preserves compatibility options in the function context.
This usage of "emulate" came in with zsh 4.3.10, released 2009-06-01.

Signed-off-by: Phil Pennock <pdp@spodhuis.org>
---
nb: I am not on the git mailing-list, please keep me CC'd.
    I have read SubmittingPatches but let me know if I've missed something.
    Fix applies (unmodified) to both master and maint.
    Thanks.

 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index fac5e71..d898b65 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -39,7 +39,7 @@ if [ -z "$script" ]; then
 		test -f $e && script="$e" && break
 	done
 fi
-ZSH_VERSION='' . "$script"
+emulate sh -c 'ZSH_VERSION="" . "$script"'
 
 __gitcomp ()
 {
-- 
1.8.5.1
