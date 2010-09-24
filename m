From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 10/16] t5602 (clone-remote-exec): add missing &&
Date: Fri, 24 Sep 2010 16:22:50 -0600
Message-ID: <1285366976-22216-11-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGeo-0000n6-Fq
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758273Ab0IXWVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:39 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60844 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758264Ab0IXWVh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:37 -0400
Received: by mail-qw0-f46.google.com with SMTP id 6so2090828qwh.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5qTGlEhN/lxRmEl7GyepDpcO55nq0eLKqT4eEJ3+WsU=;
        b=nCHq4eDOo35RO8b5mkeR9H+6cqfWw27tE0F+UHvwdt1tf32R4jQMB0oChSqoX7CjEz
         qRLRzUbx8fjc8ETDG/8UQq7AKm8/dzcmA/JCG4Z9TBlEwabY9U2H37hqiIMtQTHJ3whm
         2WkvuS+plOgSZvXL8UEJVH/DJ6XHyjyThb3b8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TnpquokNSWtSyaVWmk/omS2/DKjrNMa5Qmyg2zxefZLEpAhms28Bxyb60g25QwQjjJ
         HqeHGfoS3q6F9CIcsvkUhZwLe6W1uxfIi/XfuDFl2mp+8qBmstXy1cWe5wvd8DeLR836
         Q4E8xbesbC4ZiAXlUrIVjmaWrAvtz3cAPXAB4=
Received: by 10.220.200.194 with SMTP id ex2mr573408vcb.0.1285366897204;
        Fri, 24 Sep 2010 15:21:37 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157081>

I also had to add a couple test_must_fail invocations as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5602-clone-remote-exec.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.sh
index deffdae..6aa6e0d 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -5,21 +5,21 @@ test_description=clone
 . ./test-lib.sh
 
 test_expect_success setup '
-	echo "#!/bin/sh" > not_ssh
-	echo "echo \"\$*\" > not_ssh_output" >> not_ssh
-	echo "exit 1" >> not_ssh
+	echo "#!/bin/sh" > not_ssh &&
+	echo "echo \"\$*\" > not_ssh_output" >> not_ssh &&
+	echo "exit 1" >> not_ssh &&
 	chmod +x not_ssh
 '
 
 test_expect_success 'clone calls git upload-pack unqualified with no -u option' '
-	GIT_SSH=./not_ssh git clone localhost:/path/to/repo junk
-	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected
+	GIT_SSH=./not_ssh test_must_fail git clone localhost:/path/to/repo junk &&
+	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected &&
 	test_cmp expected not_ssh_output
 '
 
 test_expect_success 'clone calls specified git upload-pack with -u option' '
-	GIT_SSH=./not_ssh git clone -u ./something/bin/git-upload-pack localhost:/path/to/repo junk
-	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''" >expected
+	GIT_SSH=./not_ssh test_must_fail git clone -u ./something/bin/git-upload-pack localhost:/path/to/repo junk &&
+	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''" >expected &&
 	test_cmp expected not_ssh_output
 '
 
-- 
1.7.3.95.g14291
