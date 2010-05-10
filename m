From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/8] t7604-merge-custom-message: shift expected output creation
Date: Tue, 11 May 2010 01:17:45 +0800
Message-ID: <1273511872-4924-2-git-send-email-rctay89@gmail.com>
References: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 19:18:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWcx-0007lB-PH
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab0EJRSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:18:17 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63452 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab0EJRSP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:18:15 -0400
Received: by pwi5 with SMTP id 5so1771315pwi.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7CBau7laMHRH3JzhX54w6xOOfqOCebuyDNGkrm/ncp4=;
        b=t72kzdJ5U4ld6gjjFbVVJBnHxH1OLsUom9oXdKGe6U1FaD9xuBx/MgEvA9ReYQ0WeZ
         7aiOp7yiTBLQ+AvUSzT//pMke5mETt7xZzp2UaNDyedOGRzJYd7Sa9YJgB38I7dsrzTF
         PwZb00ba9fd1OsYDi/bP7X5k+JbSD1+iTl700=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dbdtOb/aFk+bzJkQnnTKzgiP3zTsUFOwAtzRPfH4PTeSPYavY5KV0hhsgDiLyS7/or
         qilTfU2gBUp712QG54YT4sG+4x96ehVI6qFZoXZJ90+pldhonlTMT+WzKMivoSGbIrkr
         HU9Lt6bcyln8diX1dUdKf3yYiqtgU2/rlaB3M=
Received: by 10.115.65.27 with SMTP id s27mr3394263wak.144.1273511895123;
        Mon, 10 May 2010 10:18:15 -0700 (PDT)
Received: from localhost.localdomain (cm71.zeta153.maxonline.com.sg [116.87.153.71])
        by mx.google.com with ESMTPS id v13sm27449213wav.2.2010.05.10.10.18.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 10:18:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
In-Reply-To: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146832>

Squash in a minor rename too.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t7604-merge-custom-message.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index 269cfdf..d79542d 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -6,6 +6,10 @@ Testing merge when using a custom message for the merge commit.'
 
 . ./test-lib.sh
 
+create_merge_msgs() {
+	echo >exp.subject "custom message"
+}
+
 test_expect_success 'setup' '
 	echo c0 > c0.c &&
 	git add c0.c &&
@@ -19,16 +23,16 @@ test_expect_success 'setup' '
 	echo c2 > c2.c &&
 	git add c2.c &&
 	git commit -m c2 &&
-	git tag c2
+	git tag c2 &&
+	create_merge_msgs
 '
 
 
 test_expect_success 'merge c2 with a custom message' '
 	git reset --hard c1 &&
-	echo >expected "custom message" &&
-	git merge -m "custom message" c2 &&
+	git merge -m "$(cat exp.subject)" c2 &&
 	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
-	test_cmp expected actual
+	test_cmp exp.subject actual
 '
 
 test_done
-- 
1.7.1.189.g07419
