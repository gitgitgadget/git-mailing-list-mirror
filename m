From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg.sh: simplify cat_file
Date: Mon,  4 Oct 2010 20:43:12 +0200
Message-ID: <85c8c215f362c4b57e7646d536ef1ca77ade1591.1286217707.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:43:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2q0T-0002AG-Cf
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146Ab0JDSnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:43:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41067 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab0JDSnT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:43:19 -0400
Received: by bwz11 with SMTP id 11so3864013bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 11:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=AWG6wn3dET1TtNbA0CbcC/loJhkC3pN1ItLw0G6jikA=;
        b=uDbWTpoJ7Vp3oWRcTpIJhNhLf/AA3+bDg+Gww09iYCWiUwW67WaaPjMHsHynPlLZNw
         bDmLkzrCXB/F85ILwGDlGLjPSI4OKoe3Dzrm6kZRF8QNnVoVT3lG5nKybYRWQDzyUXm/
         KUqYlffjkxD9aTeM48OAqea1JwUl7b0YMZzyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=f01TV9ZnW+jf4Rq/TGoKMrEE6+b8rPo2ZplPSfmCA9a/nRBdzScVDw0MTrslDeABia
         ZrxRlDk14gypQpgJ6iz6H6RyMTPanHKl5QIXDlrRYH9UZQAbxSsku1f+bANBvk1Pdj3f
         eUhfV8Vpb9cpPDnl0nOVZ+VDpB45d52cdCWVc=
Received: by 10.204.72.134 with SMTP id m6mr7336148bkj.163.1286217797131;
        Mon, 04 Oct 2010 11:43:17 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id f18sm4031457bkf.15.2010.10.04.11.43.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 11:43:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158088>

Use shell parameter expansion to strip the leading (w): and (i)

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg.sh |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tg.sh b/tg.sh
index 9d08d63..d320956 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -25,17 +25,15 @@ cat_file()
 	arg="$1"
 	case "$arg" in
 	'(w):'*)
-		arg=$(echo "$arg" | tail --bytes=+5)
-		cat "$arg"
-		return
+		cat "${arg#????}"
 		;;
 	'(i):'*)
 		# ':file' means cat from index
-		arg=$(echo "$arg" | tail --bytes=+5)
-		git cat-file blob ":$arg"
+		git cat-file blob "${arg#???}"
 		;;
 	*)
 		git cat-file blob "$arg"
+		;;
 	esac
 }
 
-- 
1.7.1.1067.g5aeb7
