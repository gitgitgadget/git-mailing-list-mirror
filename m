From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2] add tests for 'git rebase --keep-empty'
Date: Thu,  9 Aug 2012 08:39:51 -0700
Message-ID: <1344526791-13539-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1344444498-29328-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Neil Horman <nhorman@tuxdriver.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 17:40:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzUqA-000696-59
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 17:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031109Ab2HIPj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 11:39:57 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:57536 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030774Ab2HIPj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 11:39:56 -0400
Received: by obbwc20 with SMTP id wc20so403935obb.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 08:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=LCxiNAf0QxRTbOAlc/ceG5IcEWRvUurYg3WfJICnyAk=;
        b=Z+EbD8xXRMfNrn7L5k25b8hN7u3zOKdjhsXtUjRBJfUNZBlAIdO/WLym7EIa+GkzMC
         vCsy4AScgnx3z6TrXhJs75uwwQMcJNQBCTS702ttye5AM7Vfw2rMGkaH743j7k6adjlu
         KiSiru0iZztoeiNHvLDa6wN/FQ6cSvoqj1x4iAMMQrkp5MUhtugvYiJtqqrrcccTNju0
         rJA1hZxhX7FySGRbT+imgxAfMASgrvAny9nMHJoF5xhnwYLKU+gs8FjJUNS8SrGrioIh
         hDYIxA8skzuVmtFTSH2X5aKFzCZcUwgQoNK+A8i60Kni+geWXhxN0YbSHiUsOEe260/n
         4oUQ==
Received: by 10.43.65.195 with SMTP id xn3mr1776584icb.2.1344526794691;
        Thu, 09 Aug 2012 08:39:54 -0700 (PDT)
Received: by 10.43.65.195 with SMTP id xn3mr1776580icb.2.1344526794654;
        Thu, 09 Aug 2012 08:39:54 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id en7si338540igc.0.2012.08.09.08.39.54
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 09 Aug 2012 08:39:54 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 443571E0043;
	Thu,  9 Aug 2012 08:39:54 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id BFD1DC2661; Thu,  9 Aug 2012 08:39:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1344444498-29328-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQmHN/x3CHXwHqoYUuq7u7oKnAssy/S5IiS6WQ8zgVWfLG2bCQ02AGQNJrBeB+E+XJ9h5F+MCBqqqq76NVn7TdUjHhcXW5VygzYwosablWfIO+0SXonACyo7boedKhRQYFly4wB/ewwKp+T60I0RTN0p7CuNrkhJjBD2Y+JjGHrZbuZCv3grtJQ4U1fzDZCVb6BqT88i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203159>

Add test cases for 'git rebase --keep-empty' with and without an
"empty" commit already in upstream. The empty commit that is about to
be rebased should be kept in both cases.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

Added another test for when the upstream already has an empty
commit. The test case protects the current behavior; I just assume the
current behavior is what we want.

While writing the test case, I also noticed that an interrupted 'git
rebase --keep-empty' can not be continued 'git rebase --continue', but
instead needs 'git cherry-pick --continue'. I guess this shouldn't
really be surprising given that it's implemented in terms of
cherry-pick. This should be fixed once all the different kinds of
rebase use the same way of finding the commits to rebase, so I
wouldn't worry about fixing this specific problem right now.

 t/t3401-rebase-partial.sh | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 7f8693b..58f4823 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -47,7 +47,23 @@ test_expect_success 'rebase ignores empty commit' '
 	git commit --allow-empty -m empty &&
 	test_commit D &&
 	git rebase C &&
-	test $(git log --format=%s C..) = "D"
+	test "$(git log --format=%s C..)" = "D"
+'
+
+test_expect_success 'rebase --keep-empty' '
+	git reset --hard D &&
+	git rebase --keep-empty C &&
+	test "$(git log --format=%s C..)" = "D
+empty"
+'
+
+test_expect_success 'rebase --keep-empty keeps empty even if already in upstream' '
+	git reset --hard A &&
+	git commit --allow-empty -m also-empty &&
+	git rebase --keep-empty D &&
+	test "$(git log --format=%s A..)" = "also-empty
+D
+empty"
 '
 
 test_done
-- 
1.7.11.1.104.ge7b44f1
