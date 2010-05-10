From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/8] t7604-merge-custom-message: show that --log doesn't append to -m
Date: Tue, 11 May 2010 01:17:46 +0800
Message-ID: <1273511872-4924-3-git-send-email-rctay89@gmail.com>
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
	id 1OBWcy-0007lB-9n
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851Ab0EJRSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:18:21 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42956 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab0EJRSS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:18:18 -0400
Received: by pxi5 with SMTP id 5so1761347pxi.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=68lLw4NXWGU86rxkXP+bF4vmmDQdkUenN3K9u+x39yM=;
        b=rTn42S/GEFmNjk2KPD/p53R+nB02V7r53obQaNLLgC1gm3acOT5ieFXrrgannTpQlT
         J2St6lQoTrxClaOk0tzIUMjyrMcZ046xQXfnbBgnkisoFh48ptJZ/NH9NxfkrE4d4h4g
         9Qn+Q7xN2z4nIbHgrUXKZQxZFGDyDoefXe9NM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=beKEk6Dm3sMonAZiSrU8KwibaZ9+lSiJkGTZxrby4CmHoOevz6udK3lIHd9V0AuGA7
         eSmNLkRc/xIzDnxfHHpHTiN3T8xAFHtMT8ktemhDJOh0rhBC/Wz5a5L3AMujzu2suEz7
         gZPWPnbwsFRYf7C8GvaMACx9P/S2V0EW3juks=
Received: by 10.115.132.22 with SMTP id j22mr3405491wan.125.1273511897496;
        Mon, 10 May 2010 10:18:17 -0700 (PDT)
Received: from localhost.localdomain (cm71.zeta153.maxonline.com.sg [116.87.153.71])
        by mx.google.com with ESMTPS id v13sm27449213wav.2.2010.05.10.10.18.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 10:18:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
In-Reply-To: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146831>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t7604-merge-custom-message.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index d79542d..af53df1 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -8,6 +8,11 @@ Testing merge when using a custom message for the merge commit.'
 
 create_merge_msgs() {
 	echo >exp.subject "custom message"
+
+	cp exp.subject exp.log &&
+	echo >>exp.log "" &&
+	echo >>exp.log "* commit 'c2':" &&
+	echo >>exp.log "  c2"
 }
 
 test_expect_success 'setup' '
@@ -35,4 +40,11 @@ test_expect_success 'merge c2 with a custom message' '
 	test_cmp exp.subject actual
 '
 
+test_expect_failure 'merge --log appends to custom message' '
+	git reset --hard c1 &&
+	git merge --log -m "$(cat exp.subject)" c2 &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	test_cmp exp.log actual
+'
+
 test_done
-- 
1.7.1.189.g07419
