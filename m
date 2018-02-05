Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3145C1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeBFAAG (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:00:06 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33568 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeBFAAE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:00:04 -0500
Received: by mail-pg0-f67.google.com with SMTP id u1so132260pgr.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uAl5w5qFMPBF7IEOeC05dfmWtr32fxkDp9Ihbm65q0Q=;
        b=BA9XW3W81cXioTTHGjMn/9Mocbhy3f3NG00f5iFo9Sx5LYt8UdTUto8y241wAHVrCZ
         ZmnswJzvXGSTYHmimv+EgLFDf5aaij7u3lhyaVMudhT+RKD5lMooW7h7m9sQg1kIRgw2
         bHfzXxNmybksxIVTn0CjM6ETBlMn3BUYy135IbUdFMWqQLNv6y+//YXlVpEn+s6+SRCQ
         MZb6dwtiE59vxhqaP45GkYp9+hoEU4wXAsobtf30Y3tgixyo8F5o9yH31xXHS7oaRABa
         PFEQKQf8O8iLPTMtr10qal2ijg5v2HPu1NcwWPz3C7seEdCfRLWV4YJ68P9rrrYzYWLR
         ttpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uAl5w5qFMPBF7IEOeC05dfmWtr32fxkDp9Ihbm65q0Q=;
        b=t5dVnAwSQcdC+VYgav6iuW6GSDIDuGUZqKQxwT6pP248iI363Ox2SfRt8tIvalQ4Qe
         3T7sDSBGaijQyscNkTIFRkJMY5RpBGQCIPZ32jN74PZx5p6Ums64fiCPt8CJfbjZ9pxl
         zHSdrutpT4l5kPKt+c2+OKBZ60VM8D/Cf0TQSGyU53TQqrFXll0hkFdwqtQfYGHbabzi
         B8tWbe36VUKNFCKFtqDBlGsnht6UpASfSWTeUiG7yRq8gNFhlxgJ1mfLmwD7KPQqWvms
         ECwObZRblzNEDo6RKRW9QTQbhyB/F4QhaIxXzQcGUVRr2YmKvMrz5YJ2ZTc/MvhJv/NH
         qL+g==
X-Gm-Message-State: APf1xPAudo7H+oH7nCj2SsQxPpEpG7wLOuCIvY+5oZJGyZv80uHinXZ+
        Nvuq/Xpf/wtJ1kr5+JLDAy2BS4Db/CI=
X-Google-Smtp-Source: AH8x226wimyyjrDM1gzk+E1qXFT07WeHlW/W5anAsX1/DOjWVWvcDaDO7MblMmstkzFy2o55nigIIA==
X-Received: by 10.99.113.67 with SMTP id b3mr413848pgn.134.1517875202948;
        Mon, 05 Feb 2018 16:00:02 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id h8sm22576347pfk.121.2018.02.05.16.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:00:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 032/194] pack: allow reprepare_packed_git to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:53 -0800
Message-Id: <20180205235735.216710-12-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 8 ++++----
 packfile.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7dc7e8e383..7aa69dd3c0 100644
--- a/packfile.c
+++ b/packfile.c
@@ -887,11 +887,11 @@ void prepare_packed_git(struct repository *r)
 	r->objects.packed_git_initialized = 1;
 }
 
-void reprepare_packed_git_the_repository(void)
+void reprepare_packed_git(struct repository *r)
 {
-	the_repository->objects.approximate_object_count_valid = 0;
-	the_repository->objects.packed_git_initialized = 0;
-	prepare_packed_git(the_repository);
+	r->objects.approximate_object_count_valid = 0;
+	r->objects.packed_git_initialized = 0;
+	prepare_packed_git(r);
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
diff --git a/packfile.h b/packfile.h
index 75be3cb877..b3138816e7 100644
--- a/packfile.h
+++ b/packfile.h
@@ -33,8 +33,7 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(struct repository *r);
-#define reprepare_packed_git(r) reprepare_packed_git_##r()
-extern void reprepare_packed_git_the_repository(void);
+extern void reprepare_packed_git(struct repository *r);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 /*
-- 
2.15.1.433.g936d1b9894.dirty

