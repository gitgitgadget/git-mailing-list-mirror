From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 18/20] t/t9814-git-p4-rename.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:56:01 -0700
Message-ID: <1402066563-28519-19-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZM-0001vC-Oq
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbaFFO40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:26 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:41495 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbaFFO4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:25 -0400
Received: by mail-pb0-f51.google.com with SMTP id ma3so2587492pbc.10
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yGVuoJQy2DQVyBqH+CggdrO6fHW4CP+3khW/vDtxISQ=;
        b=oql5jc/KBIaId5mtrGGomaml4TjXzu6po1xbgYbLLPjfg/Kj7p9LNYiu9EoGJoNQDq
         VUdC7PJK7CHi8XJlIoh41xYzuud81lXOqnzqvGF9fCUXTv21cXsFIlkcyei/kLZZL1C1
         1PPVmM9Pt/6YeJ28Y1x//WUFuTJ8C04fJsnl5Jr9fLXn6T43+ZtMWzextEpQlONBjeuL
         5/VsK4uh0bn67YL9A2cS7tfaSpDKh90gnyGIzQ1Hlu1KgiD69TB5JiN56QEK31SK0DGX
         CKZzkpo/jicyCeyz7iS8rqo0YmnQ13PasenJud/+NciYrqAX2B42jM3LUNXa0LvLRsEa
         n4Mw==
X-Received: by 10.68.254.70 with SMTP id ag6mr7617892pbd.33.1402066584753;
        Fri, 06 Jun 2014 07:56:24 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250925>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t9814-git-p4-rename.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index be802e0..1fc1f5f 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -177,7 +177,7 @@ test_expect_success 'detect copies' '
 		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
 		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 -o "$src" = file11 &&
+		test "$src" = file10 || test "$src" = file11 &&
 		git config git-p4.detectCopies $(($level + 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file12 &&
@@ -191,7 +191,7 @@ test_expect_success 'detect copies' '
 		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
 		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 -o "$src" = file11 -o "$src" = file12 &&
+		test "$src" = file10 || test "$src" = file11 || test "$src" = file12 &&
 		git config git-p4.detectCopies $(($level - 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file13 &&
-- 
1.7.10.4
