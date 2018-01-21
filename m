Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277191F576
	for <e@80x24.org>; Sun, 21 Jan 2018 23:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbeAUXmV (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 18:42:21 -0500
Received: from sonic317-31.consmr.mail.bf2.yahoo.com ([74.6.129.86]:46261 "EHLO
        sonic317-31.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750972AbeAUXmU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Jan 2018 18:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516578139; bh=C8PDWi5DYIZ5KafHVKkVIGSt4Noi+s3orlN/uQgyGfo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=FKzANgVSXe8tu9fM1tYdbrNBj+eh65KO5VqUly9spewrkDS71u1N9i0ugqbO05WFGX/4oxMWsupOf/dISJ0dB2bgKZH4ApQMdyAq2ErkoqqV/8HH1I9PDAaYCJF8cCxrTpNx66+hW8deqzwc9qkuRzmluw+szbT9m6xGHx6DmH2SME+cTreyE0HxpXOh/iEZOaovgC+6yxYsoKI7hpmQiLcXXK7mMMKV9mZBIe8QjvoyTMW+yXq20tRKlGn0dEvN3M+mNUfleBtN53T/qwemcpqjsvUUzcW5OgesO8HizG49RiylgtuqT5vexEsdskd4XeZvQR+68cxVzr18TQ36BQ==
X-YMail-OSG: oA9Rxq0VM1kGarnQmebwTkQ1H74iei58x4KFvER38dv6MuRMKYhv1SamrFy9BSd
 QKwIdMZhRMMnwNS3Z7qH6KJ.zHmp31CGZoADN3C_GN09IZbj18MDpyrmU3erBN.KMSmP0dMgPx8a
 KuRZc_yrQ3BfQE752bda3kx5LSOJMy8gshKrqcJ7QKayC3X9ktP1kyw.pjarNi3t8DFFTYFRKxKa
 _AfvovXNEDfY_vDJMgtojB1VGzw9xkPstd5K2ASRCoodfkmBJQgpZRcr8nLhbBpauX00Mn1t3yJm
 PTMc3DGh2QrcawWkzKidlrHz_8TIG7..EyinubOljLDNMtaKHOKrj5wZ72PIbJ9P0tZTh4RibJY8
 UGA6E0Z3SDGDyfEdBgtK_.oXi6gvYG94lLh7Ba.TMOOMvqKvizUteTGywxkJUAfsVfDQ6IYdMPHt
 T5D8V2BjbV5y5.47ho45QOaXlx7YVCoDdpXTbA6VG7ek0O280Uoknym8djKqNCgTvHKGVzry47fb
 TUwJN4yce14BRY_RZ8m.uvO6enT3r5U0HndZ.5wXoLSlkjehCsA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Sun, 21 Jan 2018 23:42:19 +0000
Received: from smtp106.rhel.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([98.139.231.40])
          by smtp404.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID 658003e76b47aa0b456f7039861b9699;
          Sun, 21 Jan 2018 23:42:16 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v4 1/4] Add tar extract install options override in installation processing.
Date:   Sun, 21 Jan 2018 18:42:00 -0500
Message-Id: <20180121234203.13764-2-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180121234203.13764-1-randall.s.becker@rogers.com>
References: <20180121234203.13764-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

Introduced TAR_EXTRACT_OPTIONS as a configuration option to change
the options of tar processing during extract. The default value is "o"
which synthesizes xof, by default.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1a9b23b67..78ee431b7 100644
--- a/Makefile
+++ b/Makefile
@@ -429,6 +429,10 @@ all::
 # running the test scripts (e.g., bash has better support for "set -x"
 # tracing).
 #
+# Define TAR_EXTRACT_OPTIONS if you want to change the default behaviour
+# from xvf to something else during installation. The option only includes
+# "o" as xf are required.
+#
 # When cross-compiling, define HOST_CPU as the canonical name of the CPU on
 # which the built Git will run (for instance "x86_64").
 
@@ -452,6 +456,7 @@ LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
+TAR_EXTRACT_OPTIONS = o
 
 # Create as necessary, replace existing, make ranlib unneeded.
 ARFLAGS = rcs
@@ -2569,7 +2574,7 @@ install: all
 ifndef NO_GETTEXT
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
 	(cd po/build/locale && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -)
+	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) x$(TAR_EXTRACT_OPTIONS)f -)
 endif
 ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
-- 
2.16.0.31.gf1a482c

