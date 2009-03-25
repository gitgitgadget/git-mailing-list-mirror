From: newren@gmail.com
Subject: Re: [PATCH] git-filter-branch: avoid collisions with variables in eval'ed commands
Date: Wed, 25 Mar 2009 15:51:01 -0600
Message-ID: <1238017861-15292-1-git-send-email-newren@gmail.com>
References: <51419b2c0903251433s75775206x556fc2d65a347d7d@mail.gmail.com>
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Elijah Newren <newren@gmail.com>
To: pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Mar 25 22:54:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmb2v-0003Ct-SL
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966AbZCYVw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756384AbZCYVw1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:52:27 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:27587 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196AbZCYVw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 17:52:26 -0400
Received: by wa-out-1112.google.com with SMTP id j5so134418wah.21
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 14:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=doKt33NDvgnFjHy9Q8OmM2OGZgLaysujFaECB29ndQU=;
        b=kR7aSNfdPjUIRWeTACwE9rjjlPVadFdVdsczXnQZtnGcoGos7vyjxTWunXGRBzropi
         mAACoRNXsPuJaxgo/nFZ/QORiZ9gm0Uz9LKhvDrtMa1qeBNNoCPEAax6byK4giifR2Hi
         cQ9KPvO72+FTIEv60EyGulR/q9n05eowdSzVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ojvbgKyN1Iv2t4tCAcFwUKLWgUUJPoMGaMzTluotPnWnRHLDOK83Zxm1NyANzOnqme
         A9kPSO5B9T63yx7LKUoYO05jWD5ri1nSTCVja4o3zai1B8yqMozl6pwP+6xPjWmIqlg8
         3K47aotqkwV0YQH9MttS6K9QS6e+U/UQUV29c=
Received: by 10.114.182.15 with SMTP id e15mr39195waf.148.1238017944797;
        Wed, 25 Mar 2009 14:52:24 -0700 (PDT)
Received: from localhost.localdomain (c-69-254-130-124.hsd1.nm.comcast.net [69.254.130.124])
        by mx.google.com with ESMTPS id z15sm820655pod.14.2009.03.25.14.52.22
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 14:52:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.317.g3d051
In-Reply-To: <51419b2c0903251433s75775206x556fc2d65a347d7d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114680>

From: Elijah Newren <newren@gmail.com>

Avoid using simple variable names like 'i', since user commands are eval'ed
and may clash with and overwrite our values.

Signed-off-by: Elijah Newren <newren@gmail.com>
---

If you have a different preference for the variable name, I'd be happy to
change it (again).  All I care about is avoiding conflicts with what people
might pass in their scripts.

 git-filter-branch.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 20f6f51..b90d3df 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -272,10 +272,10 @@ test $commits -eq 0 && die "Found nothing to rewrite"
 
 # Rewrite the commits
 
-i=0
+git_filter_branch__commit_count=0
 while read commit parents; do
-	i=$(($i+1))
-	printf "\rRewrite $commit ($i/$commits)"
+	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
+	printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)"
 
 	case "$filter_subdir" in
 	"")
-- 
1.6.0.6
