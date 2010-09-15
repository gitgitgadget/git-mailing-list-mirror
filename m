From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/2] mergetool-lib: combine vimdiff and gvimdiff run blocks
Date: Tue, 14 Sep 2010 21:21:42 -0500
Message-ID: <1284517303-17244-1-git-send-email-dpmcgee@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	David Aguilar <davvid@gmail.com>,
	Charles Bailey <charles@hashpling.org>,
	Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 15 04:22:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovhdi-000201-Q4
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 04:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab0IOCWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 22:22:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34048 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0IOCV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 22:21:59 -0400
Received: by iwn5 with SMTP id 5so6597696iwn.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 19:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WNpckW7q9pe9YKaZyVlWikV6xfNx3D/IN3gFR06OZQo=;
        b=ui5+9laqICri7F0xvGDxBxBPEPNE3jMny5MedFizWPIDt3ejMm40E5gpUjKTMSD86f
         GB2/wAqF1JdkPCv+6NlW+PdcF42QI57kpYUFMvPEAyLQumPeM0znHXe1z/94LXNN+/Ao
         2DJfnoP160XSC3IYYYgjQiawsMb16e+n1/Cvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nflefGnVhhUaGjvcb5AxaMPPrv2rIT6pjJ1vgDqjxGCRDEjHqF4sNfexbHOsLaekhS
         XLHOkiT0IW9XGvMnlwUqH5qfn4a3BWYv6nKZxxrKwfWEbq7yDUuFdeyvYguHjs2MNTlK
         NA13E8DPG++m4CMcGW6H+CF2bhwC8BKMFnz6U=
Received: by 10.231.146.212 with SMTP id i20mr916727ibv.52.1284517319085;
        Tue, 14 Sep 2010 19:21:59 -0700 (PDT)
Received: from localhost (adsl-99-140-187-0.dsl.chcgil.sbcglobal.net [99.140.187.0])
        by mx.google.com with ESMTPS id r3sm687147ibk.1.2010.09.14.19.21.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 19:21:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156221>

They are nearly identical outside of the foreground flag, which can safely
be passed to both vim and gvim. The merge tool itself is named in
$merge_tool_path.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 git-mergetool--lib.sh |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index b5e1943..f9a51ba 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -169,25 +169,14 @@ run_merge_tool () {
 			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
 		fi
 		;;
-	vimdiff)
-		if merge_mode; then
-			touch "$BACKUP"
-			"$merge_tool_path" -d -c "wincmd l" \
-				"$LOCAL" "$MERGED" "$REMOTE"
-			check_unchanged
-		else
-			"$merge_tool_path" -d -c "wincmd l" \
-				"$LOCAL" "$REMOTE"
-		fi
-		;;
-	gvimdiff)
+	vimdiff|gvimdiff)
 		if merge_mode; then
 			touch "$BACKUP"
-			"$merge_tool_path" -d -c "wincmd l" -f \
+			"$merge_tool_path" -f -d -c "wincmd l" \
 				"$LOCAL" "$MERGED" "$REMOTE"
 			check_unchanged
 		else
-			"$merge_tool_path" -d -c "wincmd l" -f \
+			"$merge_tool_path" -f -d -c "wincmd l" \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
-- 
1.7.2.3
