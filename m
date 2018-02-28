Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 511311F404
	for <e@80x24.org>; Wed, 28 Feb 2018 04:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeB1Esi (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 23:48:38 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:33778 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbeB1Esi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 23:48:38 -0500
Received: from [2a02:a312:c201:ce80::6] (helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1eqtfA-00033D-R3; Wed, 28 Feb 2018 05:48:27 +0100
Received: from kilobyte by umbar.angband.pl with local (Exim 4.90_1)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1eqtfA-0000H4-1Z; Wed, 28 Feb 2018 05:48:20 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Miklos Vajna <vmiklos@suse.cz>
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Wed, 28 Feb 2018 05:48:07 +0100
Message-Id: <20180228044807.1000-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.16.2
X-SA-Exim-Connect-IP: 2a02:a312:c201:ce80::6
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH] hooks/pre-auto-gc-battery: allow gc to run on non-laptops
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Desktops and servers tend to have no power sensor, thus on_ac_power returns
255 ("unknown").

If that tool returns "unknown", there's no point in querying other sources
as it already queried them, and is smarter than us (can handle multiple
adapters).

Reported by: Xin Li <delphij@google.com>
Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
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

