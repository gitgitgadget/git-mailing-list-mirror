Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3078A1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeBMBX2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:28 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41265 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933198AbeBMBXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:25 -0500
Received: by mail-pl0-f67.google.com with SMTP id k8so5856806pli.8
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dTiil+LEee2lOyBxkxKP7sG9hzMIOD5/QY6qH0r1N7M=;
        b=dCJoPooD4uvzB3sRuy7hxUbBbWaaSCXGElhG/B3783BJKBwjNZ137xU7LooOBSe7ID
         1dOErh9caU/YM9GsHi+fHgjozXlrZtVWFvW8pvNpOZa36VYE/2DGsBp5rITFOwiuJhKg
         rLeyh+XRtsYWUt10/HyY0VyZFhG6E7QAjX9j0ajmBbihYc0M6qeXPO4kju+/J+jTRluX
         BaLzmAMEHavujoBQ4EAphKEcREqcqkLnDMfQdH5ypLjfTGrTZB4GO6F0JA1yoXC04Hzq
         ktdbfGxSxXlkl4U+I4FyNLLLveCKm+E2qWEsB72fO8etnLhyH5x5/Q0ZZIM5yP1zLq53
         ZX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dTiil+LEee2lOyBxkxKP7sG9hzMIOD5/QY6qH0r1N7M=;
        b=uSETIopiI8g55q71BIZSeDvZmU52/cqUmN0qTsF0tN4ajRTt+Utrz8DSMzxlerICm2
         7RHVbL/GyjfYHsLXVMt3iOucjjLQCEswwv+K/6LHR1B8m8esMntKEJw8N8RjXp6vo6fU
         /qBmrlO4G9ag5Boa/cC1Z9QX4g7NlBfGA+SwRJG+9z9GbWiPZZAmfYptRA+ceN18linw
         oREFfm69c4hInqzXitfahDMIHgi084cRAPWOXY/2WaqzWDtRx76EVX3qHKwLZlmrVMTJ
         5Y7IhQZf4A6pCwLIy244K5h6BfmwmZYk6s8HjKzSnzmssIVtS83EAjfKgj/V/aWXWQXx
         pSsA==
X-Gm-Message-State: APf1xPCSiqNgzhMcFK5o7bKU6CPqiFXGaJHeJy91Hhlbu9QQdpEe4jXS
        6QrC/WKWLczf+9yxmyJFpy0ONQ==
X-Google-Smtp-Source: AH8x227COyulLCjm7rDVvDSKwIlPAJ4aIpxVnorxK+Jb3mEznXWhO/QBli2Bc/5K/MUYlf9uM1N5lQ==
X-Received: by 2002:a17:902:8b8a:: with SMTP id ay10-v6mr12148805plb.156.1518485005084;
        Mon, 12 Feb 2018 17:23:25 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id o63sm31640925pfa.101.2018.02.12.17.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:24 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 22/26] sha1_file: allow stat_sha1_file to handle arbitrary repositories
Date:   Mon, 12 Feb 2018 17:22:37 -0800
Message-Id: <20180213012241.187007-23-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index fddada5756..21ddbff846 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -874,19 +874,18 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-#define stat_sha1_file(r, s, st, p) stat_sha1_file_##r(s, st, p)
-static int stat_sha1_file_the_repository(const unsigned char *sha1,
-					 struct stat *st, const char **path)
+static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
+			  struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 
-	*path = sha1_file_name(the_repository, sha1);
+	*path = sha1_file_name(r, sha1);
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb(the_repository);
+	prepare_alt_odb(r);
 	errno = ENOENT;
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
-- 
2.16.1.73.ga2c3e9663f.dirty

