Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201EEC2D0FB
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB0623129
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VbsNlKMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbgEMAys (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38118 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731807AbgEMAyo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A981A60CFF;
        Wed, 13 May 2020 00:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331282;
        bh=W+hJvQuxy2ekMVK7JOUcC5uq+ZOoIQrZE58qJIsEcVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=VbsNlKMgoDNUQR94OO460ZWqAeVzULLL90kDSTkYtHraKxaMHipoHbtZeXtLtR4BY
         ZIEOsaFYDvCwarbGOJf97AGQDYgdkGiU3lu9nN9quXVY/kODhi+ixVxJCHdz9e6CiI
         kGxPWf3lg6AEMadIfEy137xT8n2rmOgllzuLMu7heGyuM33NtvdE4iEnpnEKu5PAdi
         ljb1QR+6fskbzEmRpO5nEfUkiChbAC+VEhjddXRydKO/CzvJxOTGJt42znMaJBZiMO
         XO+J5YqPGFKGJUiXkLFkYZgfw21IVGpHX3KlHq5x4g87tdJLcj4upGpQXCwfKiWcPm
         XcRwEl77jbAMtLg5wEr9um3aOon766o8Bm0Bs/j7PcJg9KEMxuDKkGG90vKNXgo+tZ
         k7KOFOv137FWyOFQZ93egnSlaewNLUXogLJ0S+Q2KZ9vq3yTSoDfTT0IbJaeRrHgwm
         lfVtgblTjpARfpsr/LFE5Z2o0Fg7Ohk1zQsZ6/mLFAamlFxuBEF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 12/44] connect: make parse_feature_value extern
Date:   Wed, 13 May 2020 00:53:52 +0000
Message-Id: <20200513005424.81369-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
index cb69aafe2c..511a069304 100644
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
index fc75d6a457..81935a0f2a 100644
--- a/connect.h
+++ b/connect.h
@@ -19,6 +19,7 @@ struct packet_reader;
 enum protocol_version discover_version(struct packet_reader *reader);
 
 int server_supports_hash(const char *desired, int *feature_supported);
+const char *parse_feature_value(const char *, const char *, int *, int *);
 int server_supports_v2(const char *c, int die_on_error);
 int server_feature_v2(const char *c, const char **v);
 int server_supports_feature(const char *c, const char *feature,
