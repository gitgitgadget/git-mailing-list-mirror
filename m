Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5BDC433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EEF2075F
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hyBXMI93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390443AbgEYT75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 15:59:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38718 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390395AbgEYT7t (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E781A609D3;
        Mon, 25 May 2020 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436788;
        bh=+VC8gXa5DUc8GKeavPNfMWykrG004iaSqUaxmId/s2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hyBXMI93ALcLY8UBwKDkK3u2rFdTfM4jQMwiM5HD9PpXjag0602fP69cgMboG9Wma
         TVZ6KUgf8ihrPNigoISPsDiHaLmkP3quYqviXc+AsAV4W22lLurZ0XU1J1iWGxOZqR
         BdyPj3y1hW28WGqNUJYLwC0te1i0kUod3f7ekvoyGmdDYCxRBof5msLd7yhTlsCWkS
         D2P3NJ0u8CpQuunMd0XmJE//1GR/e1pkIiCLLWxHKwmFUIyBfEE2wefgC9SG52taAX
         GM7DEhXydH85Aet5OcaXMgJMzDb/QNxct0ecElTAEPBEWn5/oVBauTKTKPECIq4Ue9
         pXUqk1HwIFQK5dUNr2Us0lcrrz9CBRlcOuzevqKwr1PAJN7LKBGr7/CbR9i8AhnmY7
         34ns2CZLWKQioaDQ1SMSNlX9NVVJM5Rftm3M3nMFhs0sTn5OQ4p490FB4MTLddC4KE
         riuqOWcAxosUsX8cWgrLPpUHkcQUfEKwz3/lHiVe+2YyOLSwDcy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 12/44] connect: make parse_feature_value extern
Date:   Mon, 25 May 2020 19:58:58 +0000
Message-Id: <20200525195930.309665-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're going to be using this function in other files, so no longer mark
this function static.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 3 +--
 connect.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index eaa13b41bb..397fad7e32 100644
--- a/connect.c
+++ b/connect.c
@@ -18,7 +18,6 @@
 
 static char *server_capabilities_v1;
 static struct argv_array server_capabilities_v2 = ARGV_ARRAY_INIT;
-static const char *parse_feature_value(const char *, const char *, int *, int *);
 static const char *next_server_feature_value(const char *feature, int *len, int *offset);
 
 static int check_ref(const char *name, unsigned int flags)
@@ -467,7 +466,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	return list;
 }
 
-static const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset)
+const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset)
 {
 	int len;
 
diff --git a/connect.h b/connect.h
index fc75d6a457..ace074dcb6 100644
--- a/connect.h
+++ b/connect.h
@@ -19,6 +19,7 @@ struct packet_reader;
 enum protocol_version discover_version(struct packet_reader *reader);
 
 int server_supports_hash(const char *desired, int *feature_supported);
+const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset);
 int server_supports_v2(const char *c, int die_on_error);
 int server_feature_v2(const char *c, const char **v);
 int server_supports_feature(const char *c, const char *feature,
