Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB921F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeBFAVx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:21:53 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32806 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBFAVv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:21:51 -0500
Received: by mail-pl0-f66.google.com with SMTP id t4so132927plo.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JNzJt1frRZFdxTxfkrLapE7FI8kSlSNPGiOtCxiBCRU=;
        b=luueOQ+D37qf0W0S09TnIu7qH9eRgvQQyAtmwTM6uQdAR79N5FRj0eAk0Y2ovRRgN0
         HtMOkD+rJEVc9RNTZ+UG1w9dAvfiUCkpWL3PkmX9pN1wUfQkvRjHx/eV4QJu6wHGltyn
         7ePdqv/B7SHV2NXh51qV84VyX5QKbR4lkAPsmO2yWBqrIS84/XnVQdljT7zrjMjAbTGO
         /LbKpBF4Qxg7v0c11oqDySBJj0/Oe2o8/xOoQEd44rsDYEEUY4Zx/KLx6UVUdRXNKH6o
         VqwJ04VGSjut4xP0a/oP54sVz2NZ3oRU0wVZwm6V4T+x5Ecx2MAM2OOHx6DDBo7rQwHN
         cdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JNzJt1frRZFdxTxfkrLapE7FI8kSlSNPGiOtCxiBCRU=;
        b=QhORGoqol0oyU6MrxcOwxB/VsXnHXWZ6o4p28k36izDIMuIGr76r3lYfAu1ZI5CyDJ
         1hstJgdjMABjhZeN5bnqhvVudcCFBvj5QTIEix9zUbKFH4WDz1TXpJjnan38cXhojKeC
         wpiioeRzK+NCYTtmupA4fZ5tmDuK2IDgxMF5U1kC21u/mkkbkXtgJPD2Gv1r8CZNcvCR
         hxveSXpEfh04upRhoJ5rHJnzCChTwpoPHEdCrxwLZigyE+4l+5NxQj11uCqEw7LuMwrO
         sjbhV5XhotbjQ50FDmYmcDiUmXeBp/AWW5Zfrw+LG5m6xaH1I3lqO78q5t1SUi3ywCyE
         +DvA==
X-Gm-Message-State: APf1xPC2QSbd5OBWGudbfiz1Gfsum+O9kOzI8X8pO2aRkEJl7z0snWwq
        5piAf7W2xKF+zhcZ3OOfH9ysghWjCTs=
X-Google-Smtp-Source: AH8x227Wiqipnwo3TOlUKURi8QPCHO+/tJh3eEZL7IABBq/RErZMLQlWViQMwHICCmqsXFavfP2+gA==
X-Received: by 2002:a17:902:6f08:: with SMTP id w8-v6mr537148plk.155.1517876510310;
        Mon, 05 Feb 2018 16:21:50 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r2sm6204459pgt.75.2018.02.05.16.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:21:49 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 124/194] streaming: allow open_istream_pack_non_delta to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:39 -0800
Message-Id: <20180206001749.218943-26-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 streaming.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/streaming.c b/streaming.c
index 94651ffbf0..21bd069315 100644
--- a/streaming.c
+++ b/streaming.c
@@ -440,9 +440,6 @@ static open_method_decl(pack_non_delta)
 	struct pack_window *window;
 	enum object_type in_pack_type;
 
-	if (r != the_repository)
-		BUG("r != the_repository");
-
 	st->u.in_pack.pack = oi->u.packed.pack;
 	st->u.in_pack.pos = oi->u.packed.offset;
 	window = NULL;
-- 
2.15.1.433.g936d1b9894.dirty

