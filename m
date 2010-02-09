From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 1/3] test for add with non-existent pathspec
Date: Tue,  9 Feb 2010 17:30:48 -0500
Message-ID: <1265754650-25438-2-git-send-email-judge.packham@gmail.com>
References: <a038bef51002091417o1048c098x898517596115ed90@mail.gmail.com>
 <1265754650-25438-1-git-send-email-judge.packham@gmail.com>
Cc: peff@peff.net, szeder@ira.uka.de, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 23:33:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neyds-0001yP-Gm
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 23:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850Ab0BIWdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 17:33:06 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54288 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab0BIWdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 17:33:04 -0500
Received: by vws12 with SMTP id 12so445537vws.19
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 14:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UY1LfJ0DXzIvcROnQJV86Him0HMIcNS44kUtGbXNUhU=;
        b=qZUbwaaG8EADEOk52gQ2TieNRVFifo6IqzAUCpRo+FOD/39hJRdfEQItcuSDBahSrt
         K5JRPi1XMtecdMB9WhVsDuZOBJmxS7YAgLDValQxucRJyUjy2wblkdhRBrbeVEJ7DgCZ
         xnbXuY597OlHHVr6ylVEfJuEdwRw1JjP8HSns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=v5MiuSmFWC91I8KlejySVeNGESk4iuNE+DGPFb0tNpVC5Zwh9dTIU43SToQlcxk7PQ
         WeTxeVg8wz/jwLlg7xhHNCQsaBagZw6VZvOe69ygbC1avGFX9Vs6DhnC5/guFITqLKP9
         ckQpdz/CH6VHBHHldUM3lh6meGzLMv2a68bT0=
Received: by 10.220.89.205 with SMTP id f13mr1003437vcm.137.1265754782916;
        Tue, 09 Feb 2010 14:33:02 -0800 (PST)
Received: from localhost.localdomain ([66.193.66.34])
        by mx.google.com with ESMTPS id 26sm4516876vws.21.2010.02.09.14.33.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 14:33:02 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1265754650-25438-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139451>

Add a test for 'git add -u pathspec' and 'git add pathspec' where
pathspec does not exist. The expected result is that git add exits with
an error message and an appropriate exit code.

This adds 1 expected failure to t/t2200-add-update.sh.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 t/t2200-add-update.sh |    5 +++++
 t/t3700-add.sh        |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 9120750..dbabc3c 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -176,4 +176,9 @@ test_expect_success 'add -u resolves unmerged paths' '
 
 '
 
+test_expect_failure 'error out when attempting to add -u non-existent pathspec' '
+	test_must_fail git add -u non-existent &&
+	! (git ls-files | grep "non-existent")
+'
+
 test_done
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 85eb0fb..c77bb71 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -255,4 +255,9 @@ test_expect_success 'git add to resolve conflicts on otherwise ignored path' '
 	git add track-this
 '
 
+test_expect_success 'error out when attempting to add non-existent pathspec' '
+	test_must_fail git add non-existent &&
+	! (git ls-files | grep "non-existent")
+'
+
 test_done
-- 
1.6.4.2
