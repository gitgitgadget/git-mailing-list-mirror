From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 1/2] lib-rebase.sh: fake-editor.sh: Allow checking of commit header(s) in $GIT_EDITOR
Date: Mon, 12 Jul 2010 09:04:22 +0800
Message-ID: <1278896663-3922-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon Jul 12 03:04:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OY7Ru-0005V3-AR
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 03:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab0GLBEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 21:04:31 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55338 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab0GLBEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 21:04:30 -0400
Received: by pwi5 with SMTP id 5so1565028pwi.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 18:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BV8jislZXe0yMw60OGfR33D5yEJZploxYCg1dlFTRlA=;
        b=hYckdLNb6brSPGguwJT1FUxVzm7nOBWYmOKeyyQG3e0N1czSbMNE4PclcSfx6Al6YM
         V4ko0ysomcNzP2atQsNF/PWcKpsC98ustYPGa2BIZtkKHRKhWHNHq7uQ+9gcgS7PbMmi
         tCeRFPmlE0o7Z9JRIWxLGiMxM4eQo6/uzYqJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gtHA33CiW8shVWWBXVJN97G9G3Mr95mZbL896QtpTIlnPAi3Dr0dHvXsPhzlTHmR8j
         oqJs1uN0Z96thk5RFIIzQ/dOJoKyRKX6+bcGT/rSv1Yct/J7Q3XtJQC9En7jkqLf/0aY
         7+ucwVGfxfyLeyWjCG6C4tThq/DaZbhWbWASc=
Received: by 10.142.234.11 with SMTP id g11mr16134702wfh.201.1278896669958;
        Sun, 11 Jul 2010 18:04:29 -0700 (PDT)
Received: from localhost.localdomain ([115.134.249.89])
        by mx.google.com with ESMTPS id f20sm3854387rvb.20.2010.07.11.18.04.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 18:04:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150787>

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
 t/lib-rebase.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6aefe27..5804d23 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -4,6 +4,8 @@
 #
 # - override the commit message with $FAKE_COMMIT_MESSAGE
 # - amend the commit message with $FAKE_COMMIT_AMEND
+# - check that commit header(s) in the editor matches that in the
+#   file $EXPECT_HEADER.
 # - check that non-commit messages have a certain line count with $EXPECT_COUNT
 # - check the commit count in the commit message header with $EXPECT_HEADER_COUNT
 # - rewrite a rebase -i script as directed by $FAKE_LINES.
@@ -34,6 +36,12 @@ case "$1" in
 	exit
 	;;
 esac
+test -z "$EXPECT_HEADER" ||
+	(
+		grep '^pick' < "$1" | cut -d' ' -f3- > commit_headers.$$ &&
+		diff "$EXPECT_HEADER" commit_headers.$$ > /dev/null
+	) ||
+	exit
 test -z "$EXPECT_COUNT" ||
 	test "$EXPECT_COUNT" = $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
 	exit
-- 
1.7.2.rc2
