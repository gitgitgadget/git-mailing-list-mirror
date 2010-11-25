From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 16/20] rebase -i: support --stat
Date: Thu, 25 Nov 2010 20:57:59 +0100
Message-ID: <1290715083-16919-17-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:58:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLna9-0001kp-Pe
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab0KZB6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:33 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48617 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab0KZB6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:25 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so348001vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tJ/GNYNtdhPiJTv4LgOWqgXWMd4s+HiVOS/MhvZufIY=;
        b=vCvhtkFuHKq93mCBEdEhQB0CwR+sQoSAYLAqDL9xgaMbA24/2xDU+D95UDTm+pez3a
         Q6rvNdq8dDZ4EkbgTv8tFG6Srsnh43NV5IaSYDVubsHJNWccwuPQUIUb21+EMkQBWlfM
         eFSvccKtRISgs4jnaz0jaxR7YjSDC9LTupgC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=udFh7sGujzxCaTXAvil1etBG1CyA4hCbVwJ/baWYGz0OcMECuP3cCkwOLOqFOGbovB
         qUAugkLeWORp/hJ/Zpq2tDUBNaQ1kMfAzka03+u3cSP1zTTfjXFXMI618gsJ+CHpVtg8
         5BV8AeT8QK/lZ/b8QVWHV4jFZorDKhW4hxSfw=
Received: by 10.220.189.136 with SMTP id de8mr360865vcb.30.1290736704808;
        Thu, 25 Nov 2010 17:58:24 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:24 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162170>

Move up the code that displays the diffstat if '--stat' is passed, so
that it will be executed before calling git-rebase--interactive.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 11cea3c..43cab41 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -522,13 +522,6 @@ fi
 # If a hook exists, give it a chance to interrupt
 run_pre_rebase_hook "$upstream_arg" "$@"
 
-test -n "$interactive_rebase" && run_interactive_rebase
-
-# Detach HEAD and reset the tree
-say "First, rewinding head to replay your work on top of it..."
-git checkout -q "$onto^0" || die "could not detach HEAD"
-git update-ref ORIG_HEAD $branch
-
 if test -n "$diffstat"
 then
 	if test -n "$verbose"
@@ -539,6 +532,13 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
+test -n "$interactive_rebase" && run_interactive_rebase
+
+# Detach HEAD and reset the tree
+say "First, rewinding head to replay your work on top of it..."
+git checkout -q "$onto^0" || die "could not detach HEAD"
+git update-ref ORIG_HEAD $branch
+
 # If the $onto is a proper descendant of the tip of the branch, then
 # we just fast-forwarded.
 if test "$mb" = "$branch"
-- 
1.7.3.2.864.gbbb96
