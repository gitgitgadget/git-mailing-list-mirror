From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/2] shell setup: clear_local_git_env() function
Date: Tue, 23 Feb 2010 00:31:57 +0100
Message-ID: <1266881518-11213-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <7vsk8s274t.fsf@alter.siamese.dyndns.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 00:32:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjhlB-00056i-Gg
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 00:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161Ab0BVXcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 18:32:10 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:65315 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab0BVXcH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 18:32:07 -0500
Received: by ewy28 with SMTP id 28so3404811ewy.28
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 15:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rg5cVeY10nqcZ2o83GQpU4insS3WHKQkMwPQsIRe/fo=;
        b=NqhSySes5oUX794ozQKKicmljbQz1P/qx3LccVqKwQGBKoZcakwRptfCv7s+ghIkuf
         OLdpOIfzZi/Fcgoo2D3gTCj7MgsAjCD8RUPVpRHK4A1WXGzmPHnRsTREIWolnmASfH1k
         BmKZxuBU2KIretFLhcz41zi6+Yp/wSAvywSCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=anNvornvMWk7bc7SCYCoMKymTt6PfiYXgNRnxfirZ4IemerdXUeYi3N86JqGijhGW8
         Lonp376XVsxo0pgJ/YTmGpaqnZSkJpRKVwvALzb4fcsh4R2Qr8/KT3Phs8GBP3Hg0SrS
         sld7QK7XKcC4yfn7GOdxZtM6fLbFbzY8e0qY8=
Received: by 10.216.87.194 with SMTP id y44mr3857394wee.157.1266881525545;
        Mon, 22 Feb 2010 15:32:05 -0800 (PST)
Received: from localhost ([151.60.177.169])
        by mx.google.com with ESMTPS id m5sm16180475gve.12.2010.02.22.15.32.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 15:32:04 -0800 (PST)
X-Mailer: git-send-email 1.7.0.200.g5ba36.dirty
In-Reply-To: <7vsk8s274t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140740>

Introduce an auxiliary function to clear all repo-local environment
variables. This should be invoked by any shell script that switches
repository during execution, to ensure that the environment is clean
and that things such as the git dir and worktree are set up correctly.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-sh-setup.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 7a09566..d382879 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -172,6 +172,15 @@ get_author_ident_from_commit () {
 	LANG=C LC_ALL=C sed -ne "$pick_author_script"
 }
 
+# Clear repo-local GIT_* environment variables. Useful when switching to
+# another repository (e.g. when entering a submodule)
+clear_local_git_env() {
+	unset	GIT_DIR GIT_WORKTREE GIT_OBJECT_DIRECTORY \
+		GIT_INDEX_FILE GIT_GRAFT_FILE GIT_CONFIG \
+		GIT_NO_REPLACE_OBJECTS
+
+}
+
 # Make sure we are in a valid repository of a vintage we understand,
 # if we require to be in a git repository.
 if test -z "$NONGIT_OK"
-- 
1.7.0.200.g5ba36.dirty
