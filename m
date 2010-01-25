From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] t5541-http-push: make grep expression check for one line only
Date: Mon, 25 Jan 2010 15:42:23 +0800
Message-ID: <1264405343-2984-1-git-send-email-rctay89@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 08:42:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZJaq-000576-KA
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 08:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136Ab0AYHmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 02:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118Ab0AYHmh
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 02:42:37 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:54524 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab0AYHmg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 02:42:36 -0500
Received: by ywh6 with SMTP id 6so2898143ywh.4
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 23:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ErxkdfyPVSQySjFFlzaXqD/uPxo5SnmZ+xA0uIM25ts=;
        b=vfTlQzuW2f5bBX9z9LSUav1fslgNjuMYWp9V9Xo7Kc4NWNGfVPYS4a87KiQgYgevIe
         xsY9xjQ1Pi2rk8vU0inYhl5i8Fgu5FShSxe2GPfYmN4ai0QtVqpLOegNbfie5czh2FzB
         CHuflN4bmTI9K53ph7pbp7ONf4O06WtNeYO5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=beBCKuzxuEQ334QourHUw1AcYEppqj6RSm6xZf9swwSyDi75Y0nqcmTDKJRLrlLIwB
         acfUDYIylPZ6HxlkdO92k5RTXhhvPS7kGm5kYxNHyCX51781Ntb2tGkrt/tqgVpDoEQi
         yRnT15G3yqerfKRywGui6MqqdE214j4Hjht6A=
Received: by 10.90.133.11 with SMTP id g11mr5260389agd.121.1264405355101;
        Sun, 24 Jan 2010 23:42:35 -0800 (PST)
Received: from localhost.localdomain (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 14sm2758948gxk.6.2010.01.24.23.42.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 23:42:34 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1.436.gaba7d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137941>

Simplify the grep expressions in the non-fast-forward tests to check
only for the first line of the non-fast-forward warning - having that
line should be enough assurance that the full warning is printed.

In the first place, grep can't deal with expressions for multiple
lines.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5541-http-push.sh |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 83a8e14..53f54a2 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -105,10 +105,8 @@ test_expect_success 'non-fast-forward push show ref status' '
 '
 
 test_expect_success 'non-fast-forward push shows help message' '
-	grep \
-"To prevent you from losing history, non-fast-forward updates were rejected
-Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
-section of '"'git push --help'"' for details." output
+	grep "To prevent you from losing history, non-fast-forward updates were rejected" \
+		output
 '
 
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper' '
@@ -126,10 +124,8 @@ test_expect_success 'push fails for non-fast-forward refs unmatched by remote he
 	grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *master -> master (forced update)$" output &&
 	grep "^ ! \[rejected\] *master -> retsam (non-fast-forward)$" output &&
 
-	grep \
-"To prevent you from losing history, non-fast-forward updates were rejected
-Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
-section of '"'git push --help'"' for details." output
+	grep "To prevent you from losing history, non-fast-forward updates were rejected" \
+		output
 '
 
 stop_httpd
-- 
1.6.6
