From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v5 0/2] Worktree: for-each function and list command
Date: Sat, 22 Aug 2015 17:51:32 -0400
Message-ID: <1440280294-50679-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Aug 22 23:51:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTGhh-0001LV-PB
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 23:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbbHVVvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 17:51:40 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32954 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbHVVvj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 17:51:39 -0400
Received: by qkch123 with SMTP id h123so42578929qkc.0
        for <git@vger.kernel.org>; Sat, 22 Aug 2015 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2tR5ADFxHENF1VhpL72SSWLeujj6qy7xL31j40kYjbY=;
        b=Ajg6Tf838X/7wLAknCu1tl8lgGm2qOxNvltrh4ximOo9OGRaGr9ibRPnvYsrqL1ri1
         vXjA6GThZUXNycywGSlFcNDQ1sWb6iXg1TCQrfbrX4fJnj0AsxyJygSxyBSGP7msmTc4
         1Vbre8DqZZ8VnAx7fo5qZs80VSXh4dsczfXvURN7ol4GwzHiqLkD68w0snLobRYZcN8M
         m9m7Ry1a/ltOLZjmNfJi2PW5/ME327ilDcCAVUXUaJmqSKEJuCmMrnMdSzWK+qIK3bIk
         dL1KP1ltSBlD1vZ7MJCh92zYbq7OwNXev2QT7G0EaYkc6OvoCHPNx3tfZ2wlKqsT94nJ
         faGQ==
X-Received: by 10.55.214.196 with SMTP id p65mr34019726qkl.102.1440280298597;
        Sat, 22 Aug 2015 14:51:38 -0700 (PDT)
Received: from Macbook-wireless.gtnexus.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by smtp.gmail.com with ESMTPSA id v22sm982607qkv.45.2015.08.22.14.51.37
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Aug 2015 14:51:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276397>

Changes since v4:
 - reduced memory usage by reusing string buffer variables
 - re-scoped variables in the for-each function
 - added tests for 'worktree list' with bare repos

Notes from previous discussion:
 - The following snippet:

> +	/* If the common_dir DOES NOT end with '/.git', then it is bare */
> +	main_is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");

This code is run when the current dir is in a linked worktree (not the primary 
worktree).  In that context, the git config _does_ report that 'core.bare' is
true when the primary repo is bare, however `is_bare_repository()` returns
false.  The worktree_path also needs to the "/.git" removed from it.  
Therefore, I opted to keep the code like this.


Michael Rappazzo (2):
  worktree: add 'for_each_worktree' function
  worktree: add 'list' command

 Documentation/git-worktree.txt |  11 +++-
 builtin/worktree.c             | 138 +++++++++++++++++++++++++++++++++++++++++
 t/t2027-worktree-list.sh       |  81 ++++++++++++++++++++++++
 3 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100755 t/t2027-worktree-list.sh

-- 
2.5.0
