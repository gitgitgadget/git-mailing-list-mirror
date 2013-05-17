From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] remote-hg: tests: fix hg merge
Date: Fri, 17 May 2013 16:10:08 -0500
Message-ID: <1368825008-2815-3-git-send-email-felipe.contreras@gmail.com>
References: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 17 23:11:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdRwP-0000bW-7a
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 23:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447Ab3EQVLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 17:11:47 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:34072 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab3EQVLq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 17:11:46 -0400
Received: by mail-yh0-f48.google.com with SMTP id f35so1100111yha.7
        for <git@vger.kernel.org>; Fri, 17 May 2013 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XMp3XURLYJoTC2vLCHpBvSn+9iF3WG5W8lHBF42GVC0=;
        b=SZXyH0nJLc5NdNgL9WoJbega9sGBvgXNjShGy2/qk0sNqz/NVtMcjtp6eZla92Q2pa
         4UBW2TAsuYYxQYtcMrR+MvbLHbHrKPrkhpr061Axpk21IYUHQ+3jhjgXCF2PO32scAvv
         yaki61lB0fhu9IBwBYsHOXzosVpVsNkZGK0ahXaKNT0+hC30HOtE7PN+OHYQF7v6iS50
         D+qW0tVrhtpuGMbjNYpPEsMVjbHA/xRzgAfOjhHT/pXj3X0Vhh7cYQhV+oBjbGgXN4rH
         QX+7O8j5sucC4ss2x+Wp8LBBgzIABHQjvHyhSpe78rdMc7oh9ZC14krq0U+5RABUfSgH
         3YFQ==
X-Received: by 10.236.119.13 with SMTP id m13mr28735223yhh.155.1368825105695;
        Fri, 17 May 2013 14:11:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id v27sm19994203yhk.5.2013.05.17.14.11.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 14:11:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224740>

Let's specify a merge tool, otherwise mercurial might open one and hang
our tests waiting for user input.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg-hg-git.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index fbad2b9..f18e26f 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -103,11 +103,12 @@ setup () {
 	git config --global receive.denycurrentbranch warn
 	git config --global remote-hg.hg-git-compat true
 
-	HGEDITOR=/usr/bin/true
+	HGEDITOR=true
+	HGMERGE=true
 
 	GIT_AUTHOR_DATE="2007-01-01 00:00:00 +0230"
 	GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
-	export HGEDITOR GIT_AUTHOR_DATE GIT_COMMITTER_DATE
+	export HGEDITOR HGMERGE GIT_AUTHOR_DATE GIT_COMMITTER_DATE
 }
 
 setup
@@ -197,7 +198,7 @@ test_expect_success 'merge conflict 1' '
 	echo C > afile &&
 	hg ci -m "A->C" &&
 
-	hg merge -r1 || true &&
+	hg merge -r1 &&
 	echo C > afile &&
 	hg resolve -m afile &&
 	hg ci -m "merge to C"
-- 
1.8.3.rc2.542.g24820ba
