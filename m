From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 2/2] difftool: handle uninitialized variable on empty diff
Date: Thu, 28 Jun 2012 15:39:55 -0400
Message-ID: <1340912395-16990-2-git-send-email-tim.henigan@gmail.com>
References: <1340912395-16990-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 28 21:40:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkKaD-0001LO-BV
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 21:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999Ab2F1Tks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 15:40:48 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:63540 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab2F1Tks (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 15:40:48 -0400
Received: by ghrr11 with SMTP id r11so2180107ghr.19
        for <git@vger.kernel.org>; Thu, 28 Jun 2012 12:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QXrLPxiiT/7aIIB5ILizz6q2/2hUNfPU4OH+gMiJU38=;
        b=Yjj6D0bLz7MUT9tDrAz0NSS7b/UL8+qTU2LuBq6/Vvx1lJfT8EceCEkgM9lgLWTrHN
         Hx7M2dmvlh0B2xIrQZ8uoy5CVPJn6fCOzncB39aZ5TGUTTOkeZvOTiDhGO93pkeUgnEk
         /An13wC978rrfFcBFaqTTDx6sm1/At9f7wmdjghU/oefIBueY2Gj43OVGF7oTqn6LRx4
         f8W4H1yQADGGvYXYe7jWfoQPteCqAweYEfhg3qIO2hfrFbOrtkCpHgNwZLd3G3PjVXwN
         jid9aw+ITIikPBNi39audndatIK27BZRKdB/hCbhGVE0ScDV/e7Lr57yTXhYWl1jPcmR
         pYrw==
Received: by 10.50.161.199 with SMTP id xu7mr483879igb.68.1340912447352;
        Thu, 28 Jun 2012 12:40:47 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id bo7sm261373igb.2.2012.06.28.12.40.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jun 2012 12:40:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.134.gda62046
In-Reply-To: <1340912395-16990-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200792>

When 'difftool --dir-diff' finds no changes, it results in an
uninitialized variable warning.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 679a56d..c94557d 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -117,7 +117,7 @@ sub setup_dir_diff
 	# by Git->repository->command*.
 	my $diffrepo = Git->repository(Repository => $repo_path, WorkingCopy => $workdir);
 	my $diffrtn = $diffrepo->command_oneline('diff', '--raw', '--no-abbrev', '-z', @ARGV);
-	exit(0) if (length($diffrtn) == 0);
+	exit(0) if ((not defined($diffrtn)) or (length($diffrtn) == 0));
 
 	# Setup temp directories
 	my $tmpdir = tempdir('git-diffall.XXXXX', CLEANUP => 1, TMPDIR => 1);
-- 
1.7.11.1.134.gda62046
