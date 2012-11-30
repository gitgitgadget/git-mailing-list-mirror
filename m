From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 1/4] t4041 (diff-submodule-option): don't hardcode SHA-1 in expected outputs
Date: Fri, 30 Nov 2012 17:07:33 +0530
Message-ID: <1354275456-11104-2-git-send-email-artagnon@gmail.com>
References: <1354275456-11104-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 12:38:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeOv6-0002nU-E7
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 12:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757753Ab2K3Lhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 06:37:46 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55701 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab2K3Lhp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 06:37:45 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so291681pad.19
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 03:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kdqKYky++REoOrxNt67+DKT/Srd4SQhgkNR1It5LGt4=;
        b=MkW2Updif4WtcDUHXlgegIblQVnKuF6ai2Hd5UPfS5qYRRjiu6Se9Ti9fr7XC9E4ik
         37UEZTIc8GlccwFgEuIzgibY4zCnTm8q3XlNFbHHkvQimx9tQG2FO66d0v0FSswsiWeT
         UzrTzIz3x3fuslQ/nubGI1EARhuDXT1Gp8LuP94trLgiwLy3UUP9Hbz8gMozwYFwBEaW
         /z3XmjRxmcBtD7/fQ1MqONvGitaS2ITKgznmZ/Ju0JBhpFba0N2Lws6HIqgwoFjFMrzx
         hmvis3PjuGYudrgE51+WTULLxPqmeDL4Mk57tKkpA+POqMbdsE77yXDr8LYBrZVfeaoI
         3HzA==
Received: by 10.66.73.225 with SMTP id o1mr2390836pav.70.1354275464797;
        Fri, 30 Nov 2012 03:37:44 -0800 (PST)
Received: from fran.foss.conf ([59.90.224.156])
        by mx.google.com with ESMTPS id ok8sm2923120pbb.42.2012.11.30.03.37.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Nov 2012 03:37:44 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1354275456-11104-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The expected SHA-1 digests are always available in variables.  Use
them instead of hardcoding.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t4041-diff-submodule-option.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 57e8a9d..5377639 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -62,7 +62,7 @@ test_expect_success '--submodule=short overrides diff.submodule' "
 	cat >expected <<-EOF &&
 diff --git a/sm1 b/sm1
 new file mode 160000
-index 0000000..a2c4dab
+index 0000000..$head1
 --- /dev/null
 +++ b/sm1
 @@ -0,0 +1 @@
@@ -77,7 +77,7 @@ test_expect_success 'diff.submodule does not affect plumbing' '
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
 	new file mode 160000
-	index 0000000..a2c4dab
+	index 0000000..$head1
 	--- /dev/null
 	+++ b/sm1
 	@@ -0,0 +1 @@
@@ -173,10 +173,10 @@ mv sm1-bak sm1
 test_expect_success 'typechanged submodule(submodule->blob), --cached' "
 	git diff --submodule=log --cached >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 41fbea9...0000000 (submodule deleted)
+Submodule sm1 $head4...0000000 (submodule deleted)
 diff --git a/sm1 b/sm1
 new file mode 100644
-index 0000000..9da5fb8
+index 0000000..$head5
 --- /dev/null
 +++ b/sm1
 @@ -0,0 +1 @@
@@ -190,7 +190,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' "
 	cat >expected <<-EOF &&
 diff --git a/sm1 b/sm1
 deleted file mode 100644
-index 9da5fb8..0000000
+index $head5..0000000
 --- a/sm1
 +++ /dev/null
 @@ -1 +0,0 @@
-- 
1.7.8.1.362.g5d6df.dirty
