Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9E21F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeBEX7g (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:59:36 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37442 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752353AbeBEX7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:59:35 -0500
Received: by mail-pl0-f65.google.com with SMTP id ay8so92246plb.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RoohsnlxWdI660D4voYjXS4lWeIF/vbLAOazqrWlA6M=;
        b=tWnkMi18Odx5S6mownWv0WMXWHopgKlSl5rNbxq9hk94oV2dyXY0vGTfJqLaciO69V
         x4Dr7s8t65Kkcchihxjj0dVc/LAQcw7mFI5hDvTj6Gv/br85IuYoIj0mk7YYTwL13nNn
         B48Lp/0MGAtvRx+9epAUbFG5+Hh2JZi2SvnLC4QeuMJB8nn+DpMdvfUUmjzuh8LG40X2
         iU3bIfL2PiFozWSoauwS5ZGGTNYkbO/c+MAj+/wCI062ByOSuuFkAjLVQ9HQU63a+SF4
         8GDp+ANBAp7Bqx5LB4ru7rrMGtyT7hQbKEL9Fziuezi559zFjH5AT093DcFTHs/vBhGx
         e45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RoohsnlxWdI660D4voYjXS4lWeIF/vbLAOazqrWlA6M=;
        b=HGq9+z1WhLs9p0ftQOMN/yQlOs23nLX5Wi4XLHCUmhYNdWph3DI3bJSAtkpxnNbVUM
         HqeDDcNm94PH4yNZYyrNI0AlfjVV8KBEUAujbzVNKpxnUGONaKTsgRuPpY9vb1ImLmXf
         h5N9JlceQnAGspfJ7I76W1Vjt+4Fpt8KJBQjngqgyCH1vJNxmWH4Dp92M4CcuVakBNB6
         5XJtbtvTJy6JlaOFsaLRpBUt0GB7qwBZ030j/M7NvHTs/WDNmyOLHU+MXQHVlgIhDQmA
         KYde6y5svAw4zN94JNcOyXi5NvCOisx/k6hGxwCf+jfz9ZmunNwwRSJdy8wZALcqsKG2
         +knw==
X-Gm-Message-State: APf1xPBvmS6LW8zueamuVXK/jlMAEKwYkEUFhfBn/Gve8E4hzrsoqX4l
        KjuKP+52fDGbmS+qyUVw4P07tCVhmfE=
X-Google-Smtp-Source: AH8x226H8J9cyeq9JHqM02QwepHiNj+Z2tKVRTLDUW3oPzevSM2N0izt7ASGfOVosmri6t8X29n+Fw==
X-Received: by 2002:a17:902:6c44:: with SMTP id h4-v6mr481542pln.373.1517875173964;
        Mon, 05 Feb 2018 15:59:33 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q2sm13048265pgf.10.2018.02.05.15.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:59:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 029/194] pack: allow prepare_packed_git_mru to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:50 -0800
Message-Id: <20180205235735.216710-9-sbeller@google.com>
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
 packfile.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index d1533ec948..fd7dfc816e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -864,14 +864,13 @@ static void rearrange_packed_git(struct repository *r)
 		set_next_packed_git, sort_pack);
 }
 
-#define prepare_packed_git_mru(r) prepare_packed_git_mru_##r()
-static void prepare_packed_git_mru_the_repository(void)
+static void prepare_packed_git_mru(struct repository *r)
 {
 	struct packed_git *p;
 
-	mru_clear(&the_repository->objects.packed_git_mru);
-	for (p = the_repository->objects.packed_git; p; p = p->next)
-		mru_append(&the_repository->objects.packed_git_mru, p);
+	mru_clear(&r->objects.packed_git_mru);
+	for (p = r->objects.packed_git; p; p = p->next)
+		mru_append(&r->objects.packed_git_mru, p);
 }
 
 void prepare_packed_git_the_repository(void)
-- 
2.15.1.433.g936d1b9894.dirty

