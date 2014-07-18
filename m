From: Andrej Manduch <amanduch@gmail.com>
Subject: [PATCH] git-svn: doublecheck if really file or dir
Date: Fri, 18 Jul 2014 06:20:01 +0200
Message-ID: <1405657201-32035-1-git-send-email-amanduch@gmail.com>
Cc: Andrej Manduch <amanduch@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 06:20:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7zeY-0007iu-Q8
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 06:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759986AbaGREUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 00:20:08 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:34205 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbaGREUG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 00:20:06 -0400
Received: by mail-we0-f172.google.com with SMTP id x48so3926493wes.17
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 21:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=IdAKxouAD2rzpelumm3CDFLlB/Wk/prAei1bHXnDhtk=;
        b=xAqJWGBTy33OFenw4YCuCkB719EDmn1fwTYA5mVfdQ5M3fhQtPAejLODAyDS3BNzYH
         7PBz8dAeVbjruFITsdjaQaiI9KVr1avlM2mCxNyoDShSdw836U0MQWLJgpQOhNkm+t1l
         nl5Mw3blY2hpCGGYpNICdJegXEakySr79/5aYMW5n71bvLx8iCU0DL4HuM4KghHvD+xY
         I8ma5x/KIw8rMlibkyntlw+rUj0pwmKZkjIMgAwgnAqCKCXJ9qKgnCCDRYyfMGgfzKku
         eQ2mcwB5qXgvneKW3OSV5bfuq88UBP4xnvG29TUUXGktOnE4trBNPkuWiKCdMBfWb4Fk
         Ynzw==
X-Received: by 10.194.222.230 with SMTP id qp6mr2419567wjc.23.1405657205376;
        Thu, 17 Jul 2014 21:20:05 -0700 (PDT)
Received: from localhost.localdomain ([80.242.44.116])
        by mx.google.com with ESMTPSA id cj8sm11067496wjb.5.2014.07.17.21.20.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jul 2014 21:20:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253794>

* this fixes 'git svn info `pwd`' buggy behaviour

Signed-off-by: Andrej Manduch <amanduch@gmail.com>
---
 git-svn.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0a32372..5bbfecf 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2029,7 +2029,7 @@ sub find_file_type_and_diff_status {
 	my $mode = (split(' ', $ls_tree))[0] || "";
 
 	return ("link", $diff_status) if $mode eq "120000";
-	return ("dir", $diff_status) if $mode eq "040000";
+	return ("dir", $diff_status) if $mode eq "040000" or -d $path;
 	return ("file", $diff_status);
 }
 
-- 
2.0.0.GIT
