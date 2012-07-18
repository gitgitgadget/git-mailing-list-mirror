From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 6/7] rebase -p: don't request --left-right only to ignore left side
Date: Wed, 18 Jul 2012 00:27:34 -0700
Message-ID: <1342596455-17046-7-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-4-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-5-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-6-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 09:28:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOg2-0008T4-Rs
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784Ab2GRH2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:28:01 -0400
Received: from mail-yw0-f74.google.com ([209.85.213.74]:46107 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab2GRH1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:27:50 -0400
Received: by yhl10 with SMTP id 10so131287yhl.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=btSNcbLLpzLCimWZ2fuCRZ9EJhvbe+/oD1lEo3gxSKk=;
        b=UUP0VUyst8XdvTWRAWTprnIquKCM4HQWZ2CEB+vVJiBrtAzRrWtFH/3UziELbb2UEr
         1uAPGEa8Q6iuwaM9Ecv5IIuNYIaUpIfWL265iBxRM3vtVfJAij1U6ROkFe6fUGnIq9eM
         f528c+N08KMsQfcmJQit+xi92whkhKvOoSVWv3WCGxQrylTS7FOHJTF9P0vyR6lrXU4P
         atCizklqgMCylNiGhTDAKMLlijKYQpfHNnKEuRIW6U9eOlMBH91UI2dtNkAbDkv/TJRo
         /XJLMHN3rPbl6GoNxtvpi5j7qlXwDOGdIRwDJCY9bRv4MlFQ1bC7hMgKYFf2zVC12NxE
         da1A==
Received: by 10.236.185.226 with SMTP id u62mr1005127yhm.3.1342596469778;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by 10.236.185.226 with SMTP id u62mr1005122yhm.3.1342596469739;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id q2si326970yhi.5.2012.07.18.00.27.49
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id A06C9100048;
	Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 44F13C19B7; Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1342596455-17046-6-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQmNHKFE0qXJFnG+BHKnB5hXSTh9HuG1rt6I9SO5xoIPGwRMGLbfRvR6+z6hAQ2SAx5JpIT5OHyGNw3fRmgV8me9PP90bi3b9i9Fim8errFk7T8lSvrHsnDODmFJwwvs3KYeVM0RJaPhBV5UdsBOBey40sIWXBHk215PHFkwVSSLrQlXs/d9a7Zh6WJnPPX4Bu/5aeAs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201661>

While generating the todo file, rebase -p calls 'git rev-list
--left-right a...b' (with 'a' equal to $upstream or $onto and 'b'
equal to $orig_head) and its output is piped through 'sed -n
"s/^>//p"', making it equivalent to 'git rev-list --right-only
a...b'. Change the invocation to exactly that.

(One could alternatively change it to 'git rev-list a..b', which would
be even simpler, if it wasn't for the fact that we already have the
revision range expression in a variable.)
---
 git-rebase--interactive.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 47beb58..cd5a2cc 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -836,8 +836,7 @@ then
 	# No cherry-pick because our first pass is to determine
 	# parents to rewrite and skipping dropped commits would
 	# prematurely end our probe
-	git rev-list $revisions --reverse --left-right --topo-order |
-	sed -n "s/^>//p" |
+	git rev-list $revisions --reverse --right-only --topo-order |
 	while read -r sha1
 	do
 		if test -z "$rebase_root"
-- 
1.7.11.1.104.ge7b44f1
