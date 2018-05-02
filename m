Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6756B21847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753615AbeEBA1j (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37824 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753498AbeEBA0z (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 843C66046C;
        Wed,  2 May 2018 00:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220815;
        bh=edls/cLhmzO2WF5IW/XkgGTYh6PwpC7NnHgt9qqRE3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ddG0h7tUGvOyhKtGF58CvaGq+CtV0dtM0RswXYUebtkKqJ/MrZOQTu01Ok79BdI8e
         NRjvVZ34OwUkUca7R33uluX4ok9TjoXTLkulQ548laTDorLUW9HV5Yt1BJ+yfAyMff
         pDERc50s+ppVeJweL5DfVKoLi0z+uxB31hz0/Z/19sHkIRoa5S8cV07hPUYZqWrCSp
         745Xa64PamFRidedIx4oi9LdIlsdE7m31NlCnldYBbyOy73y10/M3pA7j4LmeR+zv0
         YWfxMqXTthGEeopdkB/BG4TAJ+m7/6CWIofXvYg++Upsem2ZD80VGSNzXYdoKlEsRV
         WNRCHtOvAGKMQcbursQZfZHQ1MoED5+t04S6F8mkAqN/VtcDcVUgRGQ9cm/b3GKgn4
         aHBLzNyrLC4Tb29ElltPNonuVPkFEoLMPtZlC2IN5TjZfVnNtut3mEvFcUWW3K0Ek5
         8u3O0BeR/Zaz75WBETtibz/7iVVk5qSvHGYJuS04iN4ogKLXlWX
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 32/42] wt-status: convert two uses of EMPTY_TREE_SHA1_HEX
Date:   Wed,  2 May 2018 00:26:00 +0000
Message-Id: <20180502002610.915892-33-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert two uses of EMPTY_TREE_SHA1_HEX to use empty_tree_oid_hex to
avoid a dependency on a given hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 wt-status.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 50815e5faf..e44115b3be 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -603,7 +603,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 
 	init_revisions(&rev, NULL);
 	memset(&opt, 0, sizeof(opt));
-	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
+	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.flags.override_submodule_config = 1;
@@ -981,7 +981,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	rev.diffopt.ita_invisible_in_index = 1;
 
 	memset(&opt, 0, sizeof(opt));
-	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
+	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
