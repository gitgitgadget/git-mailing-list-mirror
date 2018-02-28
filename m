Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB571F404
	for <e@80x24.org>; Wed, 28 Feb 2018 22:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935258AbeB1WMO (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 17:12:14 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:56050 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935255AbeB1WMN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 17:12:13 -0500
Received: from [2a02:a312:c201:ce80::6] (helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1er9xI-00039k-K1; Wed, 28 Feb 2018 23:12:10 +0100
Received: from kilobyte by umbar.angband.pl with local (Exim 4.90_1)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1er9xH-00078O-HZ; Wed, 28 Feb 2018 23:12:07 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Miklos Vajna <vmiklos@suse.cz>
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Wed, 28 Feb 2018 23:12:04 +0100
Message-Id: <20180228221204.27356-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <xmqq8tbckca1.fsf@gitster-ct.c.googlers.com>
References: <xmqq8tbckca1.fsf@gitster-ct.c.googlers.com>
X-SA-Exim-Connect-IP: 2a02:a312:c201:ce80::6
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH v2] hooks/pre-auto-gc-battery: allow gc to run on non-laptops
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Desktops and servers tend to have no power sensor, thus on_ac_power returns
255 ("unknown").  Thus, let's take any answer other than 1 ("battery") as
no contraindication to run gc.

If that tool returns "unknown", there's no point in querying other sources
as it already queried them, and is smarter than us (can handle multiple
adapters).

Reported by: Xin Li <delphij@google.com>
Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
v2: improved commit message

 contrib/hooks/pre-auto-gc-battery | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
index 6a2cdebdb..7ba78c4df 100755
--- a/contrib/hooks/pre-auto-gc-battery
+++ b/contrib/hooks/pre-auto-gc-battery
@@ -17,7 +17,7 @@
 # ln -sf /usr/share/git-core/contrib/hooks/pre-auto-gc-battery \
 #	hooks/pre-auto-gc
 
-if test -x /sbin/on_ac_power && /sbin/on_ac_power
+if test -x /sbin/on_ac_power && (/sbin/on_ac_power;test $? -ne 1)
 then
 	exit 0
 elif test "$(cat /sys/class/power_supply/AC/online 2>/dev/null)" = 1
-- 
2.16.2
