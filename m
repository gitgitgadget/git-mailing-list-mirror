From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 3/4] completion: fix branch.autosetup(merge|rebase)
Date: Sun,  5 Jan 2014 15:48:04 +0530
Message-ID: <1388917085-18701-4-git-send-email-artagnon@gmail.com>
References: <1388917085-18701-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 05 11:18:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzkmi-0002oW-9b
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 11:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbaAEKSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 05:18:12 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:55278 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbaAEKSL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 05:18:11 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so17317850pbb.14
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 02:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=95dmZbb0Fi7iXO4a1aQ3q0t2FDQpFD2jacGpp+21Hv8=;
        b=pUChN2Zk9Li9SL5K31j6RgYA60y/31VRbmGpi5/Bhbmd9AfDcz56eJj475zIb2SI2l
         463HN60iZcaItHdP8cdpSL8VfJd0Mnxl+0wosb84LtKfTWY7Hr3X5p5n19/K3WQJspqy
         gj/ywOe5ZN5azOY5Nk2v/3HHuj+XiQFZQzOIiSOH5lyx1FC/2WYIqkT7pwOLJ2/PTr6l
         fmUAQF+0Z9vKSMCMCEpZOvo6+p2LSZwONet/CDZDJBjeTUktMf6uUK0ckwGobYSV4GaS
         FxL+MwgCYR1wjM7oKrBnLapIGrrMjYqyI0T5gnh8OGNgtybP0c2iBEYviZeIsK+CBVfn
         dNXw==
X-Received: by 10.69.19.161 with SMTP id gv1mr112925805pbd.134.1388917090703;
        Sun, 05 Jan 2014 02:18:10 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id fk4sm25113615pab.23.2014.01.05.02.18.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jan 2014 02:18:10 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388917085-18701-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239964>

When attempting to complete

  $ git config branch.auto<TAB>

'autosetupmerge' and 'autosetuprebase' don't come up. This is because
"$cur" is matched with "branch.*" and a list of branches are
completed. Add 'autosetupmerge', 'autosetuprebase' as candidates for
completion too, using __gitcomp_nl_append ().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 20febff..a57bcbe 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1841,6 +1841,7 @@ _git_config ()
 	branch.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
 		__gitcomp_nl "$(__git_heads)" "$pfx" "$cur_" "."
+		__gitcomp_nl_append $'autosetupmerge\nautosetuprebase\n' "$pfx" "$cur_"
 		return
 		;;
 	guitool.*.*)
-- 
1.8.5.2.227.g53f3478
