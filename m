From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/7] rebase -i: don't error out if $state_dir already exists
Date: Sun, 12 May 2013 17:26:36 +0530
Message-ID: <1368359801-28121-3-git-send-email-artagnon@gmail.com>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 12 13:56:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbUtG-0002DN-9H
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 13:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594Ab3ELL4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 07:56:15 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:58905 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab3ELL4M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 07:56:12 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so3040016dad.23
        for <git@vger.kernel.org>; Sun, 12 May 2013 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=JgUBAZV1IinbS+8P2mBBzHEf8qUYj+DpGlru9kTwjbw=;
        b=fJUqvyyXXucnXlUAC3K+dCLtmbaq1/qpHn1QCbeju/g1/QjdX4hnUfQS6/wZ/nYeGi
         KFqXoqAh+Nlw2KzJTQK23um30BgmsZTbcoEFrpGqaFpVi4rm1RtVdpE+TgmuD3knMnp/
         TONXujwaLIvYA3Jltl2IuoH7s6OBwmRWNb3zYJcxdZ7wZbn6mrd0oTDsoyuSso+PDoZl
         u+dY4kHwz/kCvXHGt+ndHrmpdPqP45MTPXWRHOhyIMQNOx1XkgaQJXr6UIKw0nvwFS+6
         ZBCcUFVxNTBRWYjmG6tIqdxxVLxOhW8wa/h7byBvZnQJRCy+J4I0a1FIkU520daWLLwr
         NYCw==
X-Received: by 10.68.201.39 with SMTP id jx7mr2519090pbc.186.1368359771903;
        Sun, 12 May 2013 04:56:11 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.41])
        by mx.google.com with ESMTPSA id iy2sm9911078pbb.31.2013.05.12.04.56.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 May 2013 04:56:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.51.gd7a04de
In-Reply-To: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224041>

In preparation for a later patch that will create $state_dir/autostash
in git-rebase.sh before anything else can happen, change a `mkdir
$state_dir` call to `mkdir -p $state_dir`.  The change is safe,
because this is not a test to detect an in-progress rebase (that is
already done much earlier in git-rebase.sh).

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5822b2c..3411139 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -842,7 +842,7 @@ then
 fi
 
 orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
-mkdir "$state_dir" || die "Could not create temporary $state_dir"
+mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
 
 : > "$state_dir"/interactive || die "Could not mark as interactive"
 write_basic_state
-- 
1.8.3.rc1.51.gd7a04de
