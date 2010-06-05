From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 2/2] git-gui - provide commit-type to the hooks/pre-commit script
Date: Sat,  5 Jun 2010 13:43:20 -0400
Message-ID: <1275759800-16577-1-git-send-email-mlevedahl@gmail.com>
References: <1275759590-16342-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 05 19:43:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKxPC-0008T8-5p
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 19:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328Ab0FERn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 13:43:29 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35876 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab0FERn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 13:43:28 -0400
Received: by vws5 with SMTP id 5so1258888vws.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BB8jIjqXnea6QKqMnQ4WN/rDrkgddNqp1i3fqnY9NXE=;
        b=wc1Eiq2m6YZuWWPZDyG+VVl+sqRgoR8MxplGYDbCB0zcWoFA2d4mlzIaqR1OaDacq4
         QjkmB3z2K2ErO2A1d8zjScc/JoHFveBVpmAmwdeAP+jlAqg4wNWu0Sme+gxE42fHm8pF
         L53cjnh2SNE0pO9d1fi4QggLjIXjxx8Gck9Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ch8b2Zj1cWg+/FM9B0qDuG4hsXYfNVLHtCz8AO2xciecffPKYXzai6IUnqeToooxLI
         7PJj8OvOpiZfjpMMs9Agad5daFp5tqQrVNVUzR928OuwFL9iGm+ON+nf2d/FEwyUV18Z
         9JjzfCteOjkrbLDI2l2iKjGRw/c9IhlOVzmC0=
Received: by 10.224.96.166 with SMTP id h38mr6980536qan.199.1275759807375;
        Sat, 05 Jun 2010 10:43:27 -0700 (PDT)
Received: from mark-laptop.lan (pool-71-191-167-79.washdc.fios.verizon.net [71.191.167.79])
        by mx.google.com with ESMTPS id 6sm4488252qwk.18.2010.06.05.10.43.26
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 10:43:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.270.g2a29a
In-Reply-To: <1275759590-16342-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148480>

If hooks/pre-commit acts based upon the changes to be checked in
rather than just the resulting content, the script needs to know which
commit to use. For a normal commit, this is HEAD, but when amending this
is HEAD~1. So, this modifies commit.c to pass $1 as normal|amend depending
upon the commit type. Existing scripts are unaffected as they did not
expect any argument so will silently ignore this extra bit of info.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui/lib/commit.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 7f459cd..8150fa6 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -225,7 +225,7 @@ A good commit message has the following format:
 
 	# -- Run the pre-commit hook.
 	#
-	set fd_ph [githook_read pre-commit]
+	set fd_ph [githook_read pre-commit $commit_type]
 	if {$fd_ph eq {}} {
 		commit_commitmsg $curHEAD $msg_p
 		return
-- 
1.7.1.270.g2a29a
