From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: [PATCH] difftool: silence warning
Date: Tue, 21 Aug 2012 08:59:18 +0200
Message-ID: <1345532358-11742-1-git-send-email-rosslagerwall@gmail.com>
Cc: Ross Lagerwall <rosslagerwall@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 08:59:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3iRK-0005lR-7e
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 08:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab2HUG7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 02:59:44 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44138 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab2HUG7n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 02:59:43 -0400
Received: by wgbdr13 with SMTP id dr13so5998285wgb.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 23:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=bh96r5EQweXJRdpvjaaLIsB9KRNo9QBuGQQ6I5zH3F4=;
        b=YsyI0DLWRG6fmyxLRR52qvo7D5ziAETlDVKxgbVWgPJA20qUhnsptryg/J3Ft1ws/S
         kXF8gdK7e5b8qWP6YjT8Q8QOeVTrxlibcHHdEP5GlxI3eSUGLUwwdwX+dCTv9rstbZQM
         5byjD6WufRYKVPN3CizhyWYl5J71kxa7/5eaerdw/spJLSk+EBP73DSQjFtyy2tKsjD0
         4pihEbof0YKuCft3qQBG2AJjVlIeyuiXKUHUoSXotXOKaM6zvrUZqrmmdaTDwMS4BqEn
         Kr6HAmVP5qohybthfWbz983KPBbrDOTUBYA+Usma3zcwWlCSl5yo1WZ0728BHmzhuFlg
         yzTQ==
Received: by 10.216.228.80 with SMTP id e58mr1611141weq.128.1345532382212;
        Mon, 20 Aug 2012 23:59:42 -0700 (PDT)
Received: from localhost.localdomain (41-135-222-244.dsl.mweb.co.za. [41.135.222.244])
        by mx.google.com with ESMTPS id cu1sm32170614wib.6.2012.08.20.23.59.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 23:59:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203947>

Silence a warning given when running git difftool --dir-diff and
there are no changes.
This is because command_oneline returns undef when the command has no
output, not ''.

Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
---
 git-difftool.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index ae1e052..1cfcbb3 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -117,7 +117,7 @@ sub setup_dir_diff
 	# by Git->repository->command*.
 	my $diffrepo = Git->repository(Repository => $repo_path, WorkingCopy => $workdir);
 	my $diffrtn = $diffrepo->command_oneline('diff', '--raw', '--no-abbrev', '-z', @ARGV);
-	exit(0) if (length($diffrtn) == 0);
+	exit(0) unless defined($diffrtn);
 
 	# Setup temp directories
 	my $tmpdir = tempdir('git-diffall.XXXXX', CLEANUP => 1, TMPDIR => 1);
-- 
1.7.11.4
