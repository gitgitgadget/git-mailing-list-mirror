From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] add test case for rebase of empty commit
Date: Wed, 27 Jun 2012 09:22:01 -0700
Message-ID: <1340814121-23813-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 18:22:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjv0V-0002Bx-8d
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 18:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543Ab2F0QWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 12:22:15 -0400
Received: from mail-ey0-f202.google.com ([209.85.215.202]:44616 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab2F0QWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 12:22:14 -0400
Received: by eaao13 with SMTP id o13so74899eaa.1
        for <git@vger.kernel.org>; Wed, 27 Jun 2012 09:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=dMkyqoG9xJFFgI+Kuw3XzeOuPLCRlLFSbMOMoQsci9g=;
        b=S6VG3Ar7yGKxkUta5tuLtMflFUmkNTdKA+6ij5rZ4HIy2tMH5T3zUCPhXZC1WzkXaE
         9znnHXCYeRnf0JINK/9OrYXsZE65b4jUqmwC6tmjuS4R0sVpIMdD+CrliQfx9BkI0CQk
         NsAhcjI0yo1fwuXeVNOVWc4Ne3SBsFdO8bxDsQd9HIgCHN2V3FscNNZjUt+frFTga8Je
         v+L/JS7vdtlpkT/YykZ78/4ezcM8ncATfavo63r3tXY3uSmSuYbT+oj1hgT1d9dNK0fh
         hI6ToC5GI/7arJzKFSzfBv4X68WwY7AShxWXrLiTGPEAA8L6IMQQZ3XVQCUHYwZStLcn
         wd8Q==
Received: by 10.14.48.73 with SMTP id u49mr2489441eeb.9.1340814131941;
        Wed, 27 Jun 2012 09:22:11 -0700 (PDT)
Received: by 10.14.48.73 with SMTP id u49mr2489436eeb.9.1340814131839;
        Wed, 27 Jun 2012 09:22:11 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id v14si40286783eef.2.2012.06.27.09.22.11
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 27 Jun 2012 09:22:11 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 9FF2A200057;
	Wed, 27 Jun 2012 09:22:11 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 46F5BC2078; Wed, 27 Jun 2012 09:22:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.3.327.g2980b
X-Gm-Message-State: ALoCoQnQazgrwwd304IeUE84ZmfnHkkPRrzjP6Z4xgxwporVSassYjTeauGJiJTRSR/fSgYejBqOGGw9PFg1PMu4diKhoL/IpbWzbTrI8q37p3lWmMa5IUM3QdqtpO2PTRnYEtUC7y51z8Rbr/YmpAgI+gVASzjyCsWWuSka8bAR2iC62gig8Z18vChrRU5LBhljqP/dPePw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200727>

---
 t/t3401-rebase-partial.sh |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 7ba1797..7f8693b 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -42,4 +42,12 @@ test_expect_success 'rebase --merge topic branch that was partially merged upstr
 	test_path_is_missing .git/rebase-merge
 '
 
+test_expect_success 'rebase ignores empty commit' '
+	git reset --hard A &&
+	git commit --allow-empty -m empty &&
+	test_commit D &&
+	git rebase C &&
+	test $(git log --format=%s C..) = "D"
+'
+
 test_done
-- 
1.7.9.3.327.g2980b
