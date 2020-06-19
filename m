Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9502C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96D520776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Qd+OUti7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436566AbgFSR55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39508 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393724AbgFSR40 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2540260A69;
        Fri, 19 Jun 2020 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589379;
        bh=cEB7j441pJ7ZBQHDPn+LHn/tZPNuXvawa00Qmlr9GZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Qd+OUti7fdwDcDYJXuVf6MiuNv7GHz45MpwHC2kMlJ+K1reSLzVqyWWomJhi/Aa/t
         6PbyqB4IyhM+r9zkpMGXE/dI+WYmutG7MRUgbadvcchvIAMAjJ4u3hSA9QZ3Ipkcnj
         SJCezvGzd57FD4oFfIZOJTultTqMSqbASvenAbyvjbpp/1UDVTCJ8Hn1v2lCLjNcjH
         4yJMC/W3ZgGbttRA0iTwajyIF9jKqwWBocp7bHQWAgpf4psq6kTVnIDSoewMC/DbDU
         6XYpJwEjF79/wI1CaTXBG5hcCfehsn6Q77B8XgKs+iPf5CDHs1FmI7C+SGVgNK5ZqA
         qUDuflTemmULkNsqVh+0OV0rmd4KAbVENmxvwEHN/C8mfMeDUuhTNo02HsyZgtO9yD
         bTi+n1rq89GeLixa7dCmuccpMRlcmVTOWeEWwruYtpDrf+BMT20fOxeiL0+ilXZ1wi
         ITxqqFMQrzF4z+xnyQM3uPWV/rHgbipTVzB1FC3/pIUXmz7/2+r
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 12/44] connect: make parse_feature_value extern
Date:   Fri, 19 Jun 2020 17:55:29 +0000
Message-Id: <20200619175601.569856-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
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
index a52b038865..8f70a05699 100644
--- a/connect.c
+++ b/connect.c
@@ -18,7 +18,6 @@
 
 static char *server_capabilities_v1;
 static struct argv_array server_capabilities_v2 = ARGV_ARRAY_INIT;
-static const char *parse_feature_value(const char *, const char *, int *, int *);
 static const char *next_server_feature_value(const char *feature, int *len, int *offset);
 
 static int check_ref(const char *name, unsigned int flags)
@@ -483,7 +482,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	return list;
 }
 
-static const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset)
+const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset)
 {
 	int len;
 
diff --git a/connect.h b/connect.h
index c53976f7ec..c53586e929 100644
--- a/connect.h
+++ b/connect.h
@@ -19,6 +19,7 @@ struct packet_reader;
 enum protocol_version discover_version(struct packet_reader *reader);
 
 int server_supports_hash(const char *desired, int *feature_supported);
+const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset);
 int server_supports_v2(const char *c, int die_on_error);
 int server_feature_v2(const char *c, const char **v);
 int server_supports_feature(const char *c, const char *feature,
