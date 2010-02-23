From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 4/5] shell setup: clear_local_git_env() function
Date: Wed, 24 Feb 2010 00:35:35 +0100
Message-ID: <1266968136-11129-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 00:36:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4J8-0001ZG-Af
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767Ab0BWXgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 18:36:20 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43945 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab0BWXf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:35:56 -0500
Received: by mail-wy0-f174.google.com with SMTP id 21so876637wya.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 15:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bSI0/BxKn92AkcAJnMuXmIx1odwFpGiuFkWE+sKKDe4=;
        b=gc46RSKLphjFWWtIZ5zvUclliFXi83x8PvAvdnwWTHet2CqqJ2ueJ4UlZoRNeLoRi9
         AtS0rp/PLHV7RyGF5O66tASs4DAih39tN64n4HJkQertNXxiL7r+y9yS+vNVYKBSC1TB
         AVy6KaYwuwH9dQ185psIs0yHtZLoflQ2If1M0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Mw3F6Cg4D+DV234srvaUlIFRNYSdbBjpFVyaMhrI8PgplNzgfH41qnb4hGFzsXaIEA
         Va30vX67jKTZ2A6RZk58DpS0ALJUC9oIEoil3Dv8rqGyhjTCkKFiUphqwAHXjsXxdST5
         b3LuJ4QXOoyKmeutRu+x+ApXSN0rl1a+oId8k=
Received: by 10.216.90.142 with SMTP id e14mr701605wef.85.1266968155848;
        Tue, 23 Feb 2010 15:35:55 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id j8sm20118404gvb.11.2010.02.23.15.35.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 15:35:55 -0800 (PST)
X-Mailer: git-send-email 1.7.0.200.g5ba36.dirty
In-Reply-To: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140874>

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
1.7.0.200.g5ba36.dirty
