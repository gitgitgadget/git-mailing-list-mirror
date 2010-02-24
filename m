From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 3/5] shell setup: clear_local_git_env() function
Date: Thu, 25 Feb 2010 00:34:16 +0100
Message-ID: <1267054458-11877-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1267054458-11877-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 00:34:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkQkf-0002t5-SO
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 00:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758582Ab0BXXej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 18:34:39 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:61827 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758555Ab0BXXeh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 18:34:37 -0500
Received: by mail-ww0-f46.google.com with SMTP id 26so1593994wwf.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 15:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Z8HgOFGDBOKbi0Yb/PeWikLjFVy3SM6Y67dENaGR/Jw=;
        b=IrEkuUyjJ4vsdl9PgaLkYXH3ESMhvvpfqDjFzYZFG0K8A+7WW9LjAf6Np0jg7pL6fN
         U3ySFP21/gzJ9tUkWD+zw8M0FAsfIRjNsfS4tdn+lFXfiLmkbCupU5UECKxObOgRAPiJ
         BDwDUDGIbxTSlsXgmZIRd17FBfLT2hYdqlWdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sHnkOiUR02IuudUgC0hjZ/kaL4MXDdzBTiWIv2NZMM7Kkt4k3Z5KRzsrcgUIuOi1eF
         Yw1ucgpCIFQOY3LgRuEvo4lJkXo9Tuf5bsXlzAfx5MeJYr/F1E7KfHCuADZf9IHCIiIW
         SxdAwsfB87MENvQTCYQneiiy0ONzNGBfwG0Lk=
Received: by 10.216.85.5 with SMTP id t5mr210553wee.176.1267054476437;
        Wed, 24 Feb 2010 15:34:36 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id g9sm23874102gvc.18.2010.02.24.15.34.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 15:34:34 -0800 (PST)
X-Mailer: git-send-email 1.7.0.212.g5b851b.dirty
In-Reply-To: <1267054458-11877-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141005>

Introduce an auxiliary function to clear all repo-local environment
variables. This should be invoked by any shell script that switches
repository during execution, to ensure that the environment is clean
and that things such as the git dir and worktree are set up correctly.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-sh-setup.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 7a09566..6131670 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -172,6 +172,13 @@ get_author_ident_from_commit () {
 	LANG=C LC_ALL=C sed -ne "$pick_author_script"
 }
 
+# Clear repo-local GIT_* environment variables. Useful when switching to
+# another repository (e.g. when entering a submodule). See also the env
+# list in git_connect()
+clear_local_git_env() {
+	unset $(git rev-parse --local-env-vars)
+}
+
 # Make sure we are in a valid repository of a vintage we understand,
 # if we require to be in a git repository.
 if test -z "$NONGIT_OK"
-- 
1.7.0.212.g5b851b.dirty
