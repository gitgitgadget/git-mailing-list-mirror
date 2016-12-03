Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85E091FF40
	for <e@80x24.org>; Sat,  3 Dec 2016 21:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbcLCVBN (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 16:01:13 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:35919 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750942AbcLCVBM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 16:01:12 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 5E370C346F;
        Sat,  3 Dec 2016 22:01:08 +0100 (CET)
Received: from drbeat.li (215-243-153-5.dyn.cable.fcom.ch [5.153.243.215])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 3C56EC3460;
        Sat,  3 Dec 2016 22:01:08 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
        id ECB10201ED; Sat,  3 Dec 2016 22:01:07 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v4 2/3] update-unicode.sh: strip the plane offsets from the double_width[] table
Date:   Sat,  3 Dec 2016 22:00:48 +0100
Message-Id: <1480798849-13907-2-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1480798849-13907-1-git-send-email-dev+git@drbeat.li>
References: <835c0328-e812-1cb7-c49e-714ff0e9ffb3@drbeat.li>
 <1480798849-13907-1-git-send-email-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function bisearch() in utf8.c does a pure binary search in
double_width. It does not care about the 17 plane offsets which
unicode/uniset/uniset prepends. Leaving the plane offsets in the table
may cause wrong results.

Filter out the plane offsets in update-unicode.sh.

Reviewed-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 update_unicode.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/update_unicode.sh b/update_unicode.sh
index 3c84270..4c1ec8d 100755
--- a/update_unicode.sh
+++ b/update_unicode.sh
@@ -30,7 +30,7 @@ fi &&
 		  grep -v plane)
 	};
 	static const struct interval double_width[] = {
-		$(uniset/uniset --32 eaw:F,W)
+		$(uniset/uniset --32 eaw:F,W | grep -v plane)
 	};
 	EOF
 )
-- 
2.7.2
