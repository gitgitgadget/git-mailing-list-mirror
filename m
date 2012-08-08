From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] add test for 'git rebase --keep-empty'
Date: Wed,  8 Aug 2012 09:48:18 -0700
Message-ID: <1344444498-29328-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Neil Horman <nhorman@tuxdriver.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 18:48:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz9Qz-0000T8-4s
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 18:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758878Ab2HHQsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 12:48:31 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:64915 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab2HHQsa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 12:48:30 -0400
Received: by wibhr14 with SMTP id hr14so48324wib.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 09:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=euQUiUINGkQjy/qneNfmzLhEZ9MsbBGDvaN4tx0NCqI=;
        b=Jq1QkPqIIhW7JqbcSjnCBLS6wgwiYftRP22dq4COAv69e1vKfnMDqr/HUkYRKeyAgr
         ITSJHW6gPWLtRlzz6hg5s2Dd4dEqLA2xx6m3BNubMir1cJO6PD3CkGWmd0drUfJwfiw+
         8F/Mi0erwBmWE7tYzMO/9LRQHGMunvafPDjjfUaU7v0zm/SS7W1QjU0OI4kZ8FVb/HTB
         qgg6OHMZby9LC+iURRXaRqxw3SFonMtbwWiVypgwHQVfJwU/D8A5N2xY3GJqsGHC1lFC
         RyhZCTLwHksZ2AL+inIyLtPUdCJzS5Qwv++cVtAE4FSV4U360I3rB+jhl8u+kyh39B3Z
         WAJQ==
Received: by 10.14.218.199 with SMTP id k47mr15119394eep.5.1344444509270;
        Wed, 08 Aug 2012 09:48:29 -0700 (PDT)
Received: by 10.14.218.199 with SMTP id k47mr15119384eep.5.1344444509198;
        Wed, 08 Aug 2012 09:48:29 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id 46si32494335eed.1.2012.08.08.09.48.29
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 08 Aug 2012 09:48:29 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 061CF5C0063;
	Wed,  8 Aug 2012 09:48:29 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 3EC6FC1A32; Wed,  8 Aug 2012 09:48:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
X-Gm-Message-State: ALoCoQlBMjcQPhAO9ddu+DflPzexW3GjdbI7+LH79ZQiwJAtFmUXb1AJlj5rKh+Ha+j6yBWYhtRVKewZ28LAcw3mDHFuIawOCIMsDV3mGgxuU9hUKFoftUenKVHNRQMmlbDoC9apwSIUbNWcHhp6hH2AL67k+0sRWrcItz1SQFsLTIvNnYwsaDlymP6/++VCsuAffa9DTkQB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203097>

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

While trying to use patch-id instead of
--ignore-if-in-upstream/--cherry-pick/cherry/etc, I noticed that
patch-id ignores empty patches and I was surprised that tests still
pass. This test case would be useful to protect --keep-empty.

 t/t3401-rebase-partial.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 7f8693b..b89b512 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -47,7 +47,14 @@ test_expect_success 'rebase ignores empty commit' '
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
 '
 
 test_done
-- 
1.7.11.1.104.ge7b44f1
