Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D471F406
	for <e@80x24.org>; Tue, 15 May 2018 23:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeEOXnQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:43:16 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:42061 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeEOXmy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:54 -0400
Received: by mail-pl0-f46.google.com with SMTP id u6-v6so958222pls.9
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AIhWTeimfg/UXdVGamZ51Gb4pzoFc7conKzULF4Vw6U=;
        b=fkj6PIiaLRMJHO8sYclHF9K4mE/OR4idboQE803PuT/dFhmsVA0ldxwQ552jhzajta
         eExeh0Ayunt/q5+gk0mnEuzfhZpzkTyja2121p5A6Dq27od7JZz/jUDJ4TlWPAXh7TyE
         +atjegmu+OxmsXGfeBFN31hSPD+Jijo37PfCZYcRNdNEVNel3KG4/m302gR+SPUd5vOc
         n8gByMWUIehYfXtCz7YY2FUEYjSix3ZKQmkvM6W7KzkpP6Qrm4+LPk9w/YIkpSaqt9tW
         g5x94YOlW0D/J2nUx2tOwFtWkeklz1WukIzHi0yXmT0E0FTjGiSS+4unjWa0+52vKR+U
         zkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AIhWTeimfg/UXdVGamZ51Gb4pzoFc7conKzULF4Vw6U=;
        b=VGaiJynU95U8KoCpkDlL00RQOL0bmSZthk6/khdDgDQuSb5gnfHBcYAEq9Q4jZiaS5
         +xIkxAAepcnbg1PLOwPJooLnVtRkr83PPmy4MbdKIQQKoVuJXUeNPxUBL6Xl+Z3/PMiq
         47ro7ZBb7Msp58VRgtKLDMloxsqsIc0FrL/AG7Igrue9T/VKsf+VqHOYXIZaEIsZ9ndF
         biLyArG646Ie5xrJZsFcUkaar20crIptsnb9Shs/u323KPRTDUcRJy16I3uA1Y4mLjHO
         5xwU1uFlSz+JEDJpSRozVTewoySvm3KB0kQbdrjggzdlZp7KCTfbeHTs4qcFONtgS1yQ
         2hHA==
X-Gm-Message-State: ALKqPwfaIhKvwxyPxghOCkyKUNgQUOzLYV6MlDzbY/FVlNrthIajRvZr
        G0IAauPLxYGqmLHmstejnpgSKJpKXL0=
X-Google-Smtp-Source: AB8JxZo1oEjmIgLaF7UoxDJGCE3wko7Ad1+EcIS+0jWHoejNr1/xyuVaglpZKDgqJM0NBLc0yI1+Aw==
X-Received: by 2002:a17:902:6181:: with SMTP id u1-v6mr16244098plj.272.1526427773513;
        Tue, 15 May 2018 16:42:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id z129-v6sm1325470pfb.108.2018.05.15.16.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/19] commit: convert commit_graft_pos() to handle arbitrary repositories
Date:   Tue, 15 May 2018 16:42:26 -0700
Message-Id: <20180515234233.143708-13-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
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
index 684eeaa2ccd..0ec3d22813a 100644
--- a/commit.c
+++ b/commit.c
@@ -104,11 +104,10 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 	return commit_graft_table[index]->oid.hash;
 }
 
-#define commit_graft_pos(r, s) commit_graft_pos_##r(s)
-static int commit_graft_pos_the_repository(const unsigned char *sha1)
+static int commit_graft_pos(struct repository *r, const unsigned char *sha1)
 {
-	return sha1_pos(sha1, the_repository->parsed_objects->grafts,
-			the_repository->parsed_objects->grafts_nr,
+	return sha1_pos(sha1, r->parsed_objects->grafts,
+			r->parsed_objects->grafts_nr,
 			commit_graft_sha1_access);
 }
 
-- 
2.17.0.582.gccdcbd54c44.dirty

