From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 5/9] stash: teach git stash drop to fail early if the specified revision is not a stash reference
Date: Tue, 10 Aug 2010 10:04:44 +1000
Message-ID: <1281398688-21008-6-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 02:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OicMl-0001dO-Gd
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 02:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362Ab0HJAGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 20:06:31 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45353 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316Ab0HJAGa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 20:06:30 -0400
Received: by pvg2 with SMTP id 2so974893pvg.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 17:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PryZ8kGLfjXD5m6PikYQRnM1TCWUeHWyfMQMk6IRZyU=;
        b=qozwvzZ8Mu6RVIjSnKM3aTGCA8jyWLhETKecu0UDUaGexr4YcJ8P2OxPhKkFR2QbxH
         n0JgNN2rRg6Sb86N9gBhdSF6GKw5E/705Ao/Y6lQW+2IM1/B1CEl/xWqM/zYNyc3mJ4h
         cyr6Kc+mArfpRABDQVlQ7xE+tzlYvCgkHRf/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rCy3w6yLc5V6VQQ6UjtIwVDm64YvKXoZ1Y8PaR3IQMwbqkWvCVyK6idwvWWKho8L5i
         0cvicTF/xd/69m3eQ1wAKLZFUnkuNuMFDCE6G5C+trvsspjX6PcsrjJf+NO1SH0Sp2cM
         XrRh8cCCKM8vdA+b8eNOpiT59Db0jOo4dF4VQ=
Received: by 10.142.185.12 with SMTP id i12mr3230673wff.195.1281398790091;
        Mon, 09 Aug 2010 17:06:30 -0700 (PDT)
Received: from localhost.localdomain ([120.16.203.103])
        by mx.google.com with ESMTPS id x18sm7096974wfd.8.2010.08.09.17.06.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 17:06:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.53.gddb82
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153066>

Previously, git stash drop would fail noisily while executing git reflog
delete if the specified revision argument was not a stash reference.

Now, git stash drop fails with an error message which more precisely
indicates the reason for failure.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4f28c09..86cd446 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -379,6 +379,7 @@ drop_stash () {
 		shift
 	fi
 
+	assert_stash_ref "$@"
 	assert_stash_like "$@"
 
 	git reflog delete --updateref --rewrite "$@" &&
-- 
1.6.5.rc3.8.g8ba5e
