Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261D11F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeBFAYX (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:24:23 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43138 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeBFAYS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:24:18 -0500
Received: by mail-pl0-f68.google.com with SMTP id f4so120873plr.10
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wh4re9GAjkOk2hhfztiGtTExxyxjCjnXSu5uMEP3Kjw=;
        b=OEjiUm/SkgUcgnUD7+3xEUKoUo5W+vrrbdDVLgrBJln4VgHO22Lp7/gsCH4fmZqi63
         VLbGRAHITX6VGS+N17npvSfEnKCvZFMl1G9etiw57M6FQB2+4ffEhRdJ2F1F/yCJx/Ce
         I4/qhMPC46nwbXvvJriLhBAmceMLhHEgu2UzCpOyd8vy5KaSZaCpnGVCRsZthKFvSfc4
         dgvLHQ+Z0oauRyOJj5SiAuTgc8Y9WdNzcxDLghijmsqa27ownUS2dh2akwGDjhmtzkqZ
         rWD/cZbk2xsN9/7oudHKTfw+JzgxKuVNT6LBO+qEyiosl1Zu5tfE+Azr4QViemsYz/NE
         goDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wh4re9GAjkOk2hhfztiGtTExxyxjCjnXSu5uMEP3Kjw=;
        b=Awmjx2JB0mlIEoTjgHZOHbVNYMf3w12GIt50hvg2BRC170Y2a276Jm57jA+aWE/oum
         Dg5L4ehcEaycl4TXq+UvyUKjC08Bw1pVl+150ckTXoHXvJFfK8PlKZURrseHKX15NlaV
         QXZz0ktKYWPcDdyKqjbzFuxMfgha2C8hk1jhIvNSpS988wx18PwGx5NMP7o++6r+GgF5
         o/WUic4ejph1YR9DNt8y1d6UvSp9+EX82t3RGQ5PkJZFlLaVBvZbAbu5dQKlaCa+HlOI
         0Kcjs5nXZAVWHY7k6Zu8Gg6VytLEbKmJ+FZrGUr9oPhPRsFVgAkRxXnei5MwYwWo9EPR
         XiIQ==
X-Gm-Message-State: APf1xPBG73Kb/eJAbWwDSl70dAPgZ4kA7T3oinwPf2IY4QzS3rB/ZROK
        Qg7goCfhhIwGpiRi6baEkvpkaCUPPms=
X-Google-Smtp-Source: AH8x227qyfcheQxkj2uGqiiXhmtfCE1X/W/sj8TtD20G2bBl+b8UbtcQRItPLOyWtaRlk65Zi7dExA==
X-Received: by 2002:a17:902:a4:: with SMTP id a33-v6mr552879pla.257.1517876657195;
        Mon, 05 Feb 2018 16:24:17 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n66sm18251319pfn.111.2018.02.05.16.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:24:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 140/194] commit: convert commit_graft_pos() to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:55 -0800
Message-Id: <20180206001749.218943-42-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brandon Williams <bmwill@google.com>

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 435735ed2c..0d006ab1bb 100644
--- a/commit.c
+++ b/commit.c
@@ -105,11 +105,10 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 	return commit_graft_table[index]->oid.hash;
 }
 
-#define commit_graft_pos(r, s) commit_graft_pos_##r(s)
-static int commit_graft_pos_the_repository(const unsigned char *sha1)
+static int commit_graft_pos(struct repository *r, const unsigned char *sha1)
 {
-	return sha1_pos(sha1, the_repository->parsed_objects.grafts,
-			the_repository->parsed_objects.grafts_nr,
+	return sha1_pos(sha1, r->parsed_objects.grafts,
+			r->parsed_objects.grafts_nr,
 			commit_graft_sha1_access);
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

