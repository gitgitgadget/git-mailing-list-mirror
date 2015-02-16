From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 1/3] request-pull: fix expected format in tests
Date: Mon, 16 Feb 2015 19:16:06 +0100
Message-ID: <1424110568-29479-2-git-send-email-bonzini@gnu.org>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 19:16:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNQDa-00089z-4d
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 19:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076AbbBPSQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 13:16:21 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:65500 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069AbbBPSQT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 13:16:19 -0500
Received: by mail-we0-f182.google.com with SMTP id m14so24817056wev.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 10:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lzh/d3Sily4YY22eFDNjW5vqGHoaL9NWqgYKC/x3BwY=;
        b=s+KyLBZ5bjAbP3aGbmUiuiEtgo6mS6XNISm9dJy/vFuWICY4AR2xywomxMbt4nm3I2
         Fmx1sxYnjaTBcJ+LA+28i9LAJ2p2XhgPkGjWgiWIHynEkwrfuchbstSJ7AWcPQRwYNZB
         2+c5XsKDXIxhCWpQ8khO02xmGUwXHibdBgLM+ksHehtPw6Kmg0WaIamAa71EiG+gbt55
         onebi4n9WuEEDfi1bi9OW5Fl2rq9zOdVHnG71n2hmBrZq5dkeVMmpWkgujGyaXinSF3a
         LvnG07bmHxu8igAKkONk5+ArJIvPrt6S2mq00tAduTNrxnnhLFpM1UGnrMfN3PIH8vdS
         hSvQ==
X-Received: by 10.180.84.100 with SMTP id x4mr39199464wiy.89.1424110578769;
        Mon, 16 Feb 2015 10:16:18 -0800 (PST)
Received: from donizetti.redhat.com (net-93-66-73-217.cust.vodafonedsl.it. [93.66.73.217])
        by mx.google.com with ESMTPSA id et4sm23920115wjd.15.2015.02.16.10.16.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2015 10:16:17 -0800 (PST)
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263907>

From: Paolo Bonzini <pbonzini@redhat.com>

"tag foo" in requests has been replaced with "tags/foo" (commit f032d66,
request-pull: do not emit "tag" before the tagname, 2011-12-19).  Adjust
the parsing script to match; since the new format does not have spaces,
doing nothing is fine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 t/t5150-request-pull.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 82c33b8..8b19279 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -67,11 +67,10 @@ test_expect_success 'setup: two scripts for reading pull requests' '
 
 	cat <<-\EOT >read-request.sed &&
 	#!/bin/sed -nf
-	# Note that a request could ask for "tag $tagname"
+	# Note that a request could ask for "tags/$tagname"
 	/ in the git repository at:$/!d
 	n
 	/^$/ n
-	s/ tag \([^ ]*\)$/ tag--\1/
 	s/^[ 	]*\(.*\) \([^ ]*\)/please pull\
 	\1\
 	\2/p
-- 
2.3.0
