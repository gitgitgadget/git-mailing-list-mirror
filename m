From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/6] completion: remove zsh hack
Date: Wed, 30 Apr 2014 06:07:43 -0500
Message-ID: <1398856065-2982-5-git-send-email-felipe.contreras@gmail.com>
References: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 13:18:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfSXA-0003UH-GU
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 13:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758781AbaD3LSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 07:18:35 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:61398 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758585AbaD3LSe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 07:18:34 -0400
Received: by mail-yk0-f172.google.com with SMTP id 131so1321752ykp.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jmXDYGbug7i7FxVbilN+Plh8+jUZppbmvaMdDIOXieA=;
        b=KxQNUDwEOaCQBxZyGmdW93Z7jL2Wr3DviO6MlP5049gfXtqoUrtPIljGamxFlUD1rA
         dN32T+P35FusXM4K5T0NhBTWHs/AgNP7Whg9CWhjTkbUqzEuWOMVnXUpIx47uo+rQ1Wj
         SiWufL+DtUZKydz99Gl4o/72/lxMv6dMjb4m8ktrAl7nsezcpov8iOuIWLeiz81I05Xh
         FHVQUysF4xWreMlAD0W4+Ph1ZuNwWIwxeFBMXBO1V4allsYMhCQpjLlS+qigGNqJ2G12
         MD+EjFCmJFZFZcQ4ThD7pjQKBIlZBGsisBfOSjP45KUxRDH68Mw/7qF2vJTqfqkyhuaz
         jI3Q==
X-Received: by 10.236.62.195 with SMTP id y43mr4618065yhc.137.1398856713728;
        Wed, 30 Apr 2014 04:18:33 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b45sm42276386yhl.31.2014.04.30.04.18.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 04:18:32 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.11.g71fb719
In-Reply-To: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247701>

We don't want to override the 'complete()' function in zsh, which can be
used by bashcomp.

Reported-by: Mark Lodato <lodato@google.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 contrib/completion/git-completion.zsh  | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index be0ea36..f1ce962 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2586,6 +2586,7 @@ __git_func_wrap ()
 # This is NOT a public function; use at your own risk.
 __git_complete ()
 {
+	test -n "$ZSH_VERSION" && return
 	local wrapper="__git_wrap${2}"
 	eval "$wrapper () { __git_func_wrap $2 ; }"
 	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6432b3f..e71896a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -16,12 +16,6 @@
 #
 #  fpath=(~/.zsh $fpath)
 
-complete ()
-{
-	# do nothing
-	return 0
-}
-
 zstyle -T ':completion:*:*:git:*' tag-order && \
 	zstyle ':completion:*:*:git:*' tag-order 'common-commands'
 
-- 
1.9.2+fc1.11.g71fb719
