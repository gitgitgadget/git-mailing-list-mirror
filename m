From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 1/2] lib-rebase.sh: fake-editor.sh: Allow checking of commit header(s) in $GIT_EDITOR
Date: Sat, 10 Jul 2010 20:27:00 +0800
Message-ID: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Sat Jul 10 14:27:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXZ9I-0002WC-3Y
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 14:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab0GJM1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 08:27:11 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:55456 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab0GJM1J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 08:27:09 -0400
Received: by pxi14 with SMTP id 14so1231705pxi.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ktdHmxa0BFQPEDrYMlTnVG1XCtn5YJtPlK891dJTC9o=;
        b=iRC8IJ3oxUMXmF4T0ikBry7PgrWBZ0BK/Qz3G1QSwgCYd+9fSCDmCTZKOv+8HSQtsm
         ShXxSJI1DCsjY+LXP3XbTkwefNA1ulspMhJwy6jU5Pa9qM25feHSKG2oHY0auPDjAmKp
         oOaX1QagtFEZCY4uU2fLM37c80KZJJjDiqUrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kVPlxLzkI8AdsYs68pHnmPvS6Ui3esYFiSwqt8Nw0uu0J8WmvRldYzZ/bHlIXRQGeN
         80aHwbWM0DccR3TfX531J0GEvqvmHSXBgqZoDrxxM7JwNJhhQt1a+AGllPwV9rShaa9S
         HhER5N7S4tjJk5LbjAZa1uYqG95gu/tHnSGvU=
Received: by 10.142.188.13 with SMTP id l13mr13127438wff.345.1278764829217;
        Sat, 10 Jul 2010 05:27:09 -0700 (PDT)
Received: from localhost.localdomain ([115.135.170.72])
        by mx.google.com with ESMTPS id l29sm2024013rvb.19.2010.07.10.05.27.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 05:27:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150723>

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
 t/lib-rebase.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6aefe27..21d2fef 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -4,6 +4,8 @@
 #
 # - override the commit message with $FAKE_COMMIT_MESSAGE
 # - amend the commit message with $FAKE_COMMIT_AMEND
+# - check that the commit header(s) text shown in the editor matches that in the
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
