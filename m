From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] completion: add support for backwards compatibility
Date: Sat, 19 May 2012 04:41:35 +0200
Message-ID: <1337395295-29162-3-git-send-email-felipe.contreras@gmail.com>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Carsten Mattner <carstenmattner@googlemail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 04:42:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVZcR-0000jm-AX
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 04:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030560Ab2ESCmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 22:42:00 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62649 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030533Ab2ESCl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 22:41:58 -0400
Received: by wibhj8 with SMTP id hj8so677918wib.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=80BjK5WvU5bSk2H7WdoWKgvyzQRlS89KcMBzAbjVkL8=;
        b=oHcuad6r8if+MCdrbQOiHDf2N48oONcOIcrtcwn5dHd4lwafoOhwewH6/F0xRCljvU
         z76xzb6mVWQ2X+ljQt5zKm6SYsctzkJyLKEhXi8LUxeO0T6a31PGxWlNfMFJro6aV/43
         oDhBCRZ/H1DhrLrFxsMlBl3K1R+4R3L+REoPH9eRI8MWkFSwODdq3GWql+7ux0WbYNtp
         tNRgFSWCeYJrAuj0xK/XP2q2jCN5Pj7IADCiXNuKa8zrsfJPa63GfKhWyxk2jpATgnsB
         FqcHmcGeGRTuC4diSfQ1JfqSXoIaSAoYmRE1papszBcsmljv7O+WVul0jdlvHwzJiabY
         KVkw==
Received: by 10.180.86.194 with SMTP id r2mr6768101wiz.15.1337395317204;
        Fri, 18 May 2012 19:41:57 -0700 (PDT)
Received: from localhost (ip-109-43-0-59.web.vodafone.de. [109.43.0.59])
        by mx.google.com with ESMTPS id k8sm8626984wia.6.2012.05.18.19.41.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 19:41:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198007>

Some people might be relying on _git and _gitk to define custom aliases,
unfortunately, commit 6b179ad (completion: add new __git_complete
helper) broke that support.

  "bash: [: 1: unary operator expected"

This can be easily fixed by using __git_complete, but it's not meant to
be public.

Although _git and _gitk are probably not meant to be public, it's easy
to keep having support for them by having a wrapper to the proper
new function that is fully functional.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3cb106e..1689f99 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2700,6 +2700,18 @@ __git_complete ()
 		|| complete -o default -o nospace -F $wrapper $1
 }
 
+# wrapper for backwards compatibility
+_git ()
+{
+	__git_wrap_main_git
+}
+
+# wrapper for backwards compatibility
+_gitk ()
+{
+	__git_wrap_main_gitk
+}
+
 __git_complete git _main_git
 __git_complete gitk _main_gitk
 
-- 
1.7.10.2
