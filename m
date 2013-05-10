From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/8] rebase -i: don't error out if $state_dir already exists
Date: Fri, 10 May 2013 19:56:39 +0530
Message-ID: <1368196005-5354-3-git-send-email-artagnon@gmail.com>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:26:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoGl-0007jS-US
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378Ab3EJOZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:25:46 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:55041 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756200Ab3EJOZO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:25:14 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so2980055pab.13
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4yLs62652bdOaJhpXMrUQG0uDAoQWq2m8Ctul0TPfy0=;
        b=fnRK4JjymL6W7njebMEGjTHB9c4jQeJmdguOvMCgnvbZ9HucjElUby3SGfdE8C2/0j
         u9LTigtbwJ36tFjRezCrYBJCLI5afc2Jfm2zy97nsPpsRYNLP5sZNq8DxR9IMax77lJw
         Jd6L5dIiJhXzDDBcNWeDDVTqRvfO5AdgQ8UvCjJqsJ/PWX46MTax9ovmIa8TcmRC/BY8
         mmU+qyz8kL8HuNTVxnipEeKaYlmxw26UR367dOlb+umtdPE8KsHo8qnxM+WNmqvlB9PO
         F5WUt/Px9PZEF+sBSbYWzhd/jhV5vdRk5KrGtdoRf5lTBdLsw2TnrE/uQ8u9Qkpg6GK4
         8UNg==
X-Received: by 10.66.248.68 with SMTP id yk4mr18376097pac.137.1368195914232;
        Fri, 10 May 2013 07:25:14 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id nt2sm2915928pbc.17.2013.05.10.07.25.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:25:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
In-Reply-To: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223847>

In preparation for a later patch that will create $state_dir/autostash
in git-rebase.sh before anything else can happen, change a `mkdir
$state_dir` call to `mkdir -p $state_dir`.  The change is safe,
because this is not a test to detect an in-progress rebase (that is
already done much earlier in git-rebase.sh).

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5822b2c..3411139 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -842,7 +842,7 @@ then
 fi
 
 orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
-mkdir "$state_dir" || die "Could not create temporary $state_dir"
+mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
 
 : > "$state_dir"/interactive || die "Could not mark as interactive"
 write_basic_state
-- 
1.8.3.rc1.52.gc14258d
