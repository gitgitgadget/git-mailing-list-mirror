From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/9] t1508 (at-combinations): test with symbolic refs
Date: Thu,  2 May 2013 19:09:31 +0530
Message-ID: <1367501974-6879-7-git-send-email-artagnon@gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:38:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXtiQ-0002D0-KA
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759572Ab3EBNiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:38:18 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:60308 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab3EBNiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:38:17 -0400
Received: by mail-da0-f46.google.com with SMTP id e20so315034dak.5
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=VeVspXx2OP5DpF0FWA43aTrF+Df/7ckiICwUEb9mnAg=;
        b=wqGQDziUjSNs+Y5vqoXY5kSu3mYnl5CtqHTp8Qg5GnS3lxfEnxVQJGnS2oHu+tNL0o
         1y8kuHWnjQ42YlD6isucVe3TJUHxTYIdQrtsQLVYli6P8RJq3E+8XToPj3z0plpUXWG/
         TO1MvA/l8rrj1cNGkDek13EDQ1qEoia4JZFejByYOc8lhEQ8026HJfZC3mybzfnKqwiq
         Teg3zYl8dxYcIO8tuN9FoXG0zo3pCdhC7e7apc8rR/Yzgv4fReMYJTk1kwnG4uyd0oUK
         4daWgQ30CH790JAIvGYgMPFf0uF18fitTowKLh+nuD6e8AbX8C+exM03WwbX9O5hnJe2
         Oj4g==
X-Received: by 10.66.121.169 with SMTP id ll9mr7025117pab.126.1367501896580;
        Thu, 02 May 2013 06:38:16 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm7392889pbc.22.2013.05.02.06.38.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:38:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.40.g09a0447
In-Reply-To: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223201>

Symbolic refs don't work with @{u}.  Document this failure.  Also
create a symbolic-ref @ (which is a valid ref name), and test
everything with it to make sure that there is no bug in the @-parser.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1508-at-combinations.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 29ffd73..bb86c79 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -59,6 +59,19 @@ nonsense "@{1}@{u}"
 nonsense "HEAD@{-1}"
 nonsense "@{-1}@{-1}"
 
+# Symbolic refs
+git symbolic-ref H HEAD
+check "H@{1}" commit new-one
+check "H@{now}" commit new-two
+check "H@{u}" ref refs/heads/upstream-branch failure
+
+# To make sure that the @-parser isn't buggy, check things with the
+# symbolic-ref @
+git symbolic-ref @ HEAD
+check "@@{1}" commit new-one
+check "@@{now}" commit new-two
+check "@@{u}" ref refs/heads/upstream-branch failure
+
 # Document differences between @{N} and HEAD@{N}.  The former resolves
 # HEAD to a branch and looks up the logs for that branch, while the
 # latter looks for the logs of HEAD.
-- 
1.8.3.rc0.40.g09a0447
