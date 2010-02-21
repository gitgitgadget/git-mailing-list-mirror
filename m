From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/7] t5541-http-push: check that ref is unchanged for non-ff test
Date: Sun, 21 Feb 2010 11:08:22 +0800
Message-ID: <1266721708-1060-2-git-send-email-rctay89@gmail.com>
References: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Cc: "Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:59:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2Bo-0004jO-Gy
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071Ab0BUDIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:08:44 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:48037 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756468Ab0BUDIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:08:43 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so352982qyk.21
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 19:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=j4SdSVtXyHC/Ay8S9ykWUVSi5h0pFa8WCbKVhJj88Q0=;
        b=EQt3sLceyu+bMuhBWBXeXQgq0HuXn30tifpxtv+G5WJouX3C8PW5rqAUpVm9GOboyd
         phXFNq5A1zwt1aiKzVC70x68ZUO8Y9rHl7ukcN9e3FB7+60OLytkAgNDlyIxS/XCCH/V
         a4pI2XeEe1brWjM/qtqm79rjZQlPdBsNzL5WE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Hk7UNT0EKJmPPe2A42Be1rJA8aGSbE0gaT2+iQFOHQrYG0pAk8W7iRvxS5eg9PRLrK
         3Swier7ZySNPhljaeesZk9EfZQ//iEQem3+EgVzZU2IdIh8NboWGYQesvvsbxsrcQnvB
         EI7WXrXXjz8CL5X1A0KlTrQA+h845qsuktbvs=
Received: by 10.224.80.87 with SMTP id s23mr1893913qak.70.1266721722886;
        Sat, 20 Feb 2010 19:08:42 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 22sm1412717qyk.14.2010.02.20.19.08.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 19:08:42 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140588>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5541-http-push.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 53f54a2..ff947f3 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -89,15 +89,17 @@ test_expect_success 'used receive-pack service' '
 '
 
 test_expect_success 'non-fast-forward push fails' '
+	cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	HEAD=$(git rev-parse --verify HEAD) &&
+
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout master &&
 	echo "changed" > path2 &&
 	git commit -a -m path2 --amend &&
 
-	HEAD=$(git rev-parse --verify HEAD) &&
 	!(git push -v origin >output 2>&1) &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
-	 test $HEAD != $(git rev-parse --verify HEAD))
+	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
 test_expect_success 'non-fast-forward push show ref status' '
-- 
1.7.0.26.gbfa16
