From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] git-svn: forward -q to git-rebase
Date: Tue, 12 Jun 2012 17:43:35 +0200
Message-ID: <1339515815-10752-1-git-send-email-kusmabite@gmail.com>
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 17:44:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeTGT-0003nu-1h
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 17:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab2FLPnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 11:43:43 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63427 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab2FLPnl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 11:43:41 -0400
Received: by bkcji2 with SMTP id ji2so4632380bkc.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Q9199d/7RNsdjMpvUPOlHPO4FjvY/vpx4u/323syaWA=;
        b=MFUswLP6rENJkCCNHoUkIDRwtYi1zceyj2sD/9jcw0dnq59a1KbGZE1eKZzzn3bgbL
         TMnYSDakWvEY9Nporlx8F3u3pd+dIeJyP6FDYu4rzHRoH01FsTWTB2Ie+u9YHaMVwnTB
         WADES0OgACO14suhWi4vSQUBcluQ1oG3NLcP0o3rQD6/rTwyoM0l4qcJhHIOCASr7yZK
         O0ovNi43eC+FpznHiV3CIjn37rAM12z1EbdthLjd/3t6VnWFuMSC9G1DBE/fYfXuxv6i
         eigqF2SnyC2hNSHzK9ztOolkKWyX7CGgQ4/+cI/VL0Ylm6q3hHL5TTMnkFIzn1i50TS3
         O/CQ==
Received: by 10.204.151.200 with SMTP id d8mr12376639bkw.82.1339515819822;
        Tue, 12 Jun 2012 08:43:39 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id m2sm20971367bkm.2.2012.06.12.08.43.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 08:43:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc0.6836.gdf573d9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199805>

When calling "git svn rebase -q", we still get the message
"Current branch BRANCHNAME is up to date." from git-rebase, which
isn't quite as quiet as we could be.

Fix this by forwarding the -q flag to git-rebase.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

I just set up a cronjob that did a "git svn rebase -q", and noticed
it triggered cron to send me an e-mail every time.

Since I'm not really interested in getting an e-mail every time the
script does nothing, but I'd like the option to get an e-mail whenever
it does something useful, perhaps something like this can benefit
other people as well?

 git-svn.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-svn.perl b/git-svn.perl
index 0b074c4..34baa43 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1590,6 +1590,7 @@ sub cmd_gc {
 sub rebase_cmd {
 	my @cmd = qw/rebase/;
 	push @cmd, '-v' if $_verbose;
+	push @cmd, '-q' if $_q;
 	push @cmd, qw/--merge/ if $_merge;
 	push @cmd, "--strategy=$_strategy" if $_strategy;
 	push @cmd, "--preserve-merges" if $_preserve_merges;
-- 
1.7.11.rc2.5.g68f532f.dirty
