From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/3] t5523-push-upstream: test progress messages
Date: Thu, 14 Oct 2010 03:31:50 +0800
Message-ID: <1286998311-5112-3-git-send-email-rctay89@gmail.com>
References: <1286998311-5112-1-git-send-email-rctay89@gmail.com>
 <1286998311-5112-2-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 21:32:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P673p-0006Qs-RE
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 21:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606Ab0JMTcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 15:32:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47692 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab0JMTcB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 15:32:01 -0400
Received: by mail-iw0-f174.google.com with SMTP id 9so165884iwn.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hbybPdi5Fk4NsRXo5fY749JDcNMHerQeVTSwRSArCnI=;
        b=TvGJCQEPzv5W8nzSPoFFFgF8UVn8neFWQJmMKcxh+HTkD/w7py8R0D+8FuWcpnEsSz
         V+8uBilZ3vXJRcAvJ1l+ybeqTaxBQQEe/DVBKswC92pBIdlPfRBFYlhKtL8to0qSioLK
         iidFpmjLW3mdcfS22JvXgvUiQEUpDYUEKESTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=C8IA3QO8i4qCUqxtgAMS+WzqO/0Y71ahw02laLFkq8nNyJapit279Cp584ikUx3PNi
         +IstldgjXRKBnh/1mLDv5Br1Ox/GC2E5T+eT5QYX+ZTASCMZwXCmYxHFj1oX52fsb0Zr
         kedU78d/JxBoCkifQwdENZc0/kPjrdhyXAYxM=
Received: by 10.231.13.201 with SMTP id d9mr7499808iba.152.1286998320646;
        Wed, 13 Oct 2010 12:32:00 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id 8sm3050710iba.16.2010.10.13.12.31.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 12:31:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1286998311-5112-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158969>

Reported-by: Chase Brammer <cbrammer@gmail.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5523-push-upstream.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 337a69e..554f55e 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -72,4 +72,20 @@ test_expect_success 'push -u HEAD' '
 	check_config headbranch upstream refs/heads/headbranch
 '
 
+test_expect_failure 'progress messages to non-tty' '
+	ensure_fresh_upstream &&
+
+	# skip progress messages, since stderr is non-tty
+	git push -u upstream master >out 2>err &&
+	! grep "Writing objects" err
+'
+
+test_expect_failure 'progress messages to non-tty (forced)' '
+	ensure_fresh_upstream &&
+
+	# force progress messages to stderr, even though it is non-tty
+	git push -u --progress upstream master >out 2>err &&
+	grep "Writing objects" err
+'
+
 test_done
-- 
1.7.2.2.513.ge1ef3
