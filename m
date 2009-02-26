From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 14:49:05 -0500
Message-ID: <1235677745-939-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 20:50:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcmFr-0001Ob-Kq
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 20:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbZBZTtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 14:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbZBZTtO
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 14:49:14 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:23935 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbZBZTtM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 14:49:12 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1228071qwi.37
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 11:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=c1MofQPtrhEhqLuFguzw/Lw7TlaWC0WiMz9xBGN1n9I=;
        b=gEfblZRRJu4MlVQWNIVZe3FgX/jvD33zjdaKvm1kBXOLRfN9khv2hGEnHwP480tDZu
         su8B/Pu4V6l5jQ04Mdn+mR68aqwGq4DF4viZneS/XmJXX0qe2pjjqw3DF8nv4G7It37b
         2l6h7JmB1qIB/a+Ngq5Bwqw1LEMs40tySGCz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=uDEibsPr3oMAO1uBsKYAXXh1CdCXhbbkt+Nsphp5LBX3mTflnDBEP6svgfe8Vhj12q
         Av3EmV71hUVEt5RqM58EfiBI8BXx1crKNZ9wuvdOK9LxIyeQoMvf9LGFQNjQb3MuVNxq
         hYU66LSMYDq0GE5WIs4pfk/+DFhjwpJbHC6aA=
Received: by 10.224.54.76 with SMTP id p12mr2791486qag.207.1235677749163;
        Thu, 26 Feb 2009 11:49:09 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 2sm1329221qwi.48.2009.02.26.11.49.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Feb 2009 11:49:08 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.309.g5f417
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111590>

OS X's GNU grep does not support -P/--perl-regexp; use egrep instead,
avoiding non-portable braces ({}) as well.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 t/t5540-http-push.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 11b3432..6a255a6 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -94,9 +94,15 @@ test_expect_success 'MKCOL sends directory names with trailing slashes' '
 
 '
 
+x1="[a-z0-9]"
+x2="$x1$x1"
+x5="$x1$x1$x1$x1$x1"
+x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"
+x40="$x38$x2"
+
 test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
 
-	grep -P "\"(?:PUT|MOVE) .+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{40} HTTP/[0-9.]+\" 20\d" \
+	egrep "\"(PUT|MOVE) .+objects/$x2/${x38}_$x40 HTTP/[0-9.]+\" 20[0-9]" \
 		< "$HTTPD_ROOT_PATH"/access.log
 
 '
-- 
1.6.2.rc1.309.g5f417
