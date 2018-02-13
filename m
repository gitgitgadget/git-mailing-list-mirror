Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18961F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933277AbeBMBXf (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:35 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44419 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933261AbeBMBXa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:30 -0500
Received: by mail-pg0-f67.google.com with SMTP id j9so8181863pgp.11
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P1Hve04FYrBMm1R7lg1WZVhcUmtSIXHBZt4fMcWDfH0=;
        b=WcSLtMvqHPVSCZyx67hF0acBFzwnpkleuo1FftP/PGbHlxLuQyLJ8rCLSbOWgyJmf2
         lyZiFUINtJMn9YlyeRt/yq6EOTTQMQl5mNwSq+265P9dy3s+yzzr2M2JSxs8wWXDGL9K
         E0LMIW9amKT8yxDKqlAZgU2jasYdhNG6qXeJf5P2ivUSZJKwgR9mh/nZRU4LQ53yqKAN
         UHzkejx4J8XrpnEdPlZAA2EKgS40nA+igLrTOSIX9AAokYm+lu+um4zNFntrW4N+L/dk
         bxt1yQQTbqw0Fp5qVG5J4lZfMHNQtrfQcRknMu/Bl8aMb8ZvqWhvCNU1EkZbKINL8U5e
         iupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P1Hve04FYrBMm1R7lg1WZVhcUmtSIXHBZt4fMcWDfH0=;
        b=nZylPxv8+EvW3fFexs/exxlH6ccbnndIqV+0USiOhAnPHJBCtpJYjcJ7ikUuUhCWeE
         v7vCiQ52vCdrN7FBCt/K/iWcka7iLiqh9Hqt/3yKQtsCqY3KmCErR8KsCHiotkM9F43P
         LJ7DE9kNZkeboC5NLPLvsXfkLq7pYFACacAWh65jG1pKdI5BbwGNtu2mcJ9mvBbTouHw
         WrPugtty7ngs36fTV/uoidNDXf7J4/+JJtLQrtd5K183F7cG4VUFQTgDKoL/tvE/qyBW
         9fwvuwiRgzdJRyI4Hvk5yChXmwnGwFLpRpaohcKE0K8494pZjwpj6IlF2Bi7RFA9w/EF
         zOzw==
X-Gm-Message-State: APf1xPBW76/nIcf7UsjvgdeIGb69iX3wZz5qMMnEUOsbQDc28ilUO/2S
        L3eQ42rEAef4cUSKLvF6uuXfYg==
X-Google-Smtp-Source: AH8x226fQSfWZWSW3FRHbqrnT/xl5DyIejJIP/7/2Rt8iIRHYC/oKKOB8TudYhX9DMoqBhsAz4IQkA==
X-Received: by 10.98.117.133 with SMTP id q127mr12304504pfc.225.1518485009836;
        Mon, 12 Feb 2018 17:23:29 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id y13sm33734120pfj.96.2018.02.12.17.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:29 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 25/26] sha1_file: allow map_sha1_file to handle arbitrary repositories
Date:   Mon, 12 Feb 2018 17:22:40 -0800
Message-Id: <20180213012241.187007-26-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 3 +--
 sha1_file.c    | 5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index b4756444bb..f164c4e5c9 100644
--- a/object-store.h
+++ b/object-store.h
@@ -68,8 +68,7 @@ struct packed_git {
  * is overwritten each time the function is called.
  */
 const char *sha1_file_name(struct repository *r, const unsigned char *sha1);
-#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
-void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
+extern void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
 void prepare_alt_odb(struct repository *r);
 
diff --git a/sha1_file.c b/sha1_file.c
index 86b0ca7089..6237d59a59 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -956,9 +956,10 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 	return map;
 }
 
-void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file(struct repository *r,
+		    const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(the_repository, NULL, sha1, size);
+	return map_sha1_file_1(r, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
-- 
2.16.1.73.ga2c3e9663f.dirty

