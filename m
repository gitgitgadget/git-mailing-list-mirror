From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCH] test for add with non-existent pathspec
Date: Tue,  9 Feb 2010 16:31:40 -0500
Message-ID: <1265751100-21558-1-git-send-email-judge.packham@gmail.com>
References: <a038bef51002090643g23b35bb6xaa765ff13b80f5bb@mail.gmail.com>
Cc: peff@peff.net, szeder@ira.uka.de,
	Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 22:34:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nexid-00089S-5q
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 22:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556Ab0BIVdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 16:33:55 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64341 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab0BIVdy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 16:33:54 -0500
Received: by vws12 with SMTP id 12so429852vws.19
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 13:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pVDNf8kGGvROmUrVt6NJPbLOJZZCHItaQVrnra1s1mE=;
        b=oAKGLzEvSOAyJayeUAwDvw5TYDkTsgA89lzbTJU/G8SNTUbZGHqBGDo4BZ+Gm9cRV/
         KFFCb9zoSgDOL9pIMpQyORDygkhEh8NImR2iszbIREfcvMeCyKsnojh9dLe2SVionqZu
         hjh1Tgqh6YeURuls/klWmL9Nr8LH2MEvzS6W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SIVXgT47wAdiwJengXNMQ5nb+34IigJokF2DCzUNRZqR1U8af/qXzXgpVDqslfsrlf
         jUxZiBuuTy9sgX17H3MRy0pfABRp9y93uIJaeXqJk4PJT0lpEOKtErIeN3XDYARefOSJ
         Mg+iu8jhxAX0ETqFEOFvMf28Zxr5UoINmB8/0=
Received: by 10.220.124.135 with SMTP id u7mr959655vcr.231.1265751233336;
        Tue, 09 Feb 2010 13:33:53 -0800 (PST)
Received: from localhost.localdomain ([66.193.66.34])
        by mx.google.com with ESMTPS id 36sm4315762vws.6.2010.02.09.13.33.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 13:33:52 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <a038bef51002090643g23b35bb6xaa765ff13b80f5bb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139443>

Add a test for 'git add -u pathspec' and 'git add pathspec' where
pathspec does not exist. The expected result is that git add exits with
an error message and an appropriate exit code.

This adds 1 expected failure to t/t2200-add-update.sh.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

If anyone feels like pursuing this heres a patch to two simple tests around
this behaviour. I made an initial attempt to change builtin-add.c to print an
error message and set the exit code to a non-zero value but my naive attempt
broke the normal usage of 'git add pathspec'.

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
