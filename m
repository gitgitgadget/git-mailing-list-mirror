From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: fix warning for zsh
Date: Thu, 29 Nov 2012 09:20:57 +0100
Message-ID: <1354177257-5416-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 09:21:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdzNJ-0001OB-Q0
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 09:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141Ab2K2IVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 03:21:18 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44659 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab2K2IVR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 03:21:17 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so6090148bkw.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 00:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=K52g9J7JIAqH/yKWPzWBf445OVtmNnErj0tRU3lDt1A=;
        b=RwH6Jw7g11OWTwkePQU1M5K6ylwOtN96PVtl1r1lzdzqXzDUBKck1OvnLBKbdUrr+N
         Y8A0oxQLYUd3xLNXUXsGrieeojZjzhMCE/14CAzfjGWSK4luGQuoV9EG3K4/IT4HVM6X
         xmoUYhd2EHNYcEU4KhuGEreCo/bADyOONc1XoF8BtOBVe1w31TIFGmYkygMiC+TCxNXN
         N6c7u7VUZ81q+GC8fY9ZMVr6hEMuiSo27lhFbTXaiM1+mW4LSBdkSfq62vqKHy+8HrTy
         F439LptJ7txcamuwbKmlIR7lzZG7KHS18Q/v14ogm7Dj0Ulkfn9d2Rvt6I1YkU8g7/Yq
         JIrA==
Received: by 10.204.127.11 with SMTP id e11mr6629961bks.0.1354177276083;
        Thu, 29 Nov 2012 00:21:16 -0800 (PST)
Received: from localhost (ip-109-43-0-123.web.vodafone.de. [109.43.0.123])
        by mx.google.com with ESMTPS id o7sm279636bkv.13.2012.11.29.00.21.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 00:21:15 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210821>

Otherwise the user might get something like:

  git-completion.sh:2466: command not found: compdef

If this script is loaded before compinit. The script would work either
way, but let's not be more annoying to the user.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index af13fcc..0b77eb1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2404,6 +2404,8 @@ __gitk_main ()
 if [[ -n ${ZSH_VERSION-} ]]; then
 	echo "WARNING: this script is deprecated, please see git-completion.zsh" 1>&2
 
+	autoload -U +X compinit && compinit
+
 	__gitcomp ()
 	{
 		emulate -L zsh
-- 
1.8.0.1
