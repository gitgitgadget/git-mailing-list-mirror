From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 4/6] shell setup: clear_local_git_env() function
Date: Wed, 24 Feb 2010 08:23:14 +0100
Message-ID: <1266996196-25978-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 08:23:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkBb8-0003WY-3e
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 08:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab0BXHXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 02:23:45 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58154 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097Ab0BXHXn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 02:23:43 -0500
Received: by mail-wy0-f174.google.com with SMTP id 21so1021578wya.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 23:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kEdkpjDbI8kF5AkADnukiSDjEtzuPFmnGvDIzapMGrA=;
        b=Yu9dY7UWykMpkM1PHjz2qbrHWAuZPZBNYapZd5QYPm164jSobKNOLGVMEyyXruMVfO
         GZOTcvWxRyP0AFPqxsabXc5Z2tvbz0AtaYKQZDLLUV8cXER8kSMMomtlZrHzDshSH0on
         nkl0c4mWcrWh5wlXQ+Nx6HkXBd/YbxCzWXJ/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ot7DIoHKQNx6ytUcd78dVOAYziO3ZaJZYiKfNDPxcAyBctnyLhKd+na/q0UdWERuQ9
         L0lbY5cdR3GjLgYhNS/EE3tp8M3nPnabu43fb3avUnVRZMTPySEL2PMZk41/ycgWws0u
         lZ1jfWhKlDS8REYuemx2EwDgXDa7LCeruMZkA=
Received: by 10.216.85.134 with SMTP id u6mr518501wee.213.1266996222532;
        Tue, 23 Feb 2010 23:23:42 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id j8sm21472727gvb.26.2010.02.23.23.23.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 23:23:41 -0800 (PST)
X-Mailer: git-send-email 1.7.0.212.g4e217.dirty
In-Reply-To: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140910>

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
1.7.0.212.g4e217.dirty
