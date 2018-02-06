Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B051B1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeBFAca (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:32:30 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39738 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbeBFAc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:32:26 -0500
Received: by mail-pg0-f67.google.com with SMTP id w17so186366pgv.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xLPS44AtgSb/yD5ui1XAGsmzeSjjZ+pYEagoDAc03zw=;
        b=ZbzVfGhLFIq+gn2cExvi8OyhTprFRNxC50UVTAiWKm96VsTtC/orznTtlXZbqVMoYJ
         y7+z+VyXMMamPJeXuWrA0y9ky7hifuwUW451IHbFPG+ch8Elo1ZsFtABs4qUl92oAe8Z
         ddXiRxHBl0sy9XHCATsqk8qpXfe5LTEf4bjzCUm7NV1nGDyQngX3VkeTE0CzohxKxqoN
         j6EZT/HHTM7R7SL3e2baCKoU7EjFqavzrCU4T3hYoAo5B9KikeQ0NOn9ulPDPg5QooQr
         qLq/x1gikB/2ScKmtw8ruRVjTkV20G5wnZLlVy87VBrDOgMjBdp2cH2+2tDacZjhRNkO
         1RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xLPS44AtgSb/yD5ui1XAGsmzeSjjZ+pYEagoDAc03zw=;
        b=lCQsI4nYzeudc3Z+3bECcTW+CLi0n3C2lcRCdhTe/cSPsZVAUtqa9O1RTjBXpcfbrx
         7XquCDmQZ43aCWx0yF9t3VreXXVRmy1QzZm5OQwxHcJzLdLbn4QU3qvCL6ZmsB7WzHFt
         Lv5e5t0PauDLyShbUvGZnbAejGYler6QytzOftn4WCMhINRtRv7K4hLlbCsU6n8IxnDV
         JWlZUwDBQPC1uSC0+sibzXMawk2VAHKtaoJC/XIuFd6h5+bau/5BNwDeXTm9YXklrzby
         OSLLGaVFWXGWVT+64BPxKcliBXV1Zrn5+sMarvjNBRqjqLj7h0mmmE4+mFK0ZduWo/hd
         JDSA==
X-Gm-Message-State: APf1xPCjzgtbsyjx5rlMuprszv552HwbB6pEw+Kfo6xnw6IVPZJ2nbdT
        Xn452Jirgw4u71J7nhmmn3q4dtgCPhw=
X-Google-Smtp-Source: AH8x226pWOlKjgfg40BO9ibT7VX120MJYqOnRpiSC7hmAtxKskrl+LIQVg8uhTUoTKz2x/5b5jUfcQ==
X-Received: by 10.98.11.201 with SMTP id 70mr592802pfl.16.1517877145908;
        Mon, 05 Feb 2018 16:32:25 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e26sm16578997pfi.76.2018.02.05.16.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:32:25 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 190/194] commit: allow in_merge_bases to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:45 -0800
Message-Id: <20180206001749.218943-92-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 4 ++--
 commit.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index a14933b208..cdee8d3917 100644
--- a/commit.c
+++ b/commit.c
@@ -1072,9 +1072,9 @@ int in_merge_bases_many(struct repository *r, struct commit *commit, int nr_refe
 /*
  * Is "commit" an ancestor of (i.e. reachable from) the "reference"?
  */
-int in_merge_bases_the_repository(struct commit *commit, struct commit *reference)
+int in_merge_bases(struct repository *r, struct commit *commit, struct commit *reference)
 {
-	return in_merge_bases_many(the_repository, commit, 1, &reference);
+	return in_merge_bases_many(r, commit, 1, &reference);
 }
 
 struct commit_list *reduce_heads(struct commit_list *heads)
diff --git a/commit.h b/commit.h
index 36412a5a9e..2281948738 100644
--- a/commit.h
+++ b/commit.h
@@ -232,8 +232,7 @@ extern void prune_shallow(int show_only);
 extern struct trace_key trace_shallow;
 
 int is_descendant_of(struct commit *, struct commit_list *);
-#define in_merge_bases(r, c1, c2) in_merge_bases_##r(c1, c2)
-int in_merge_bases_the_repository(struct commit *, struct commit *);
+int in_merge_bases(struct repository *r, struct commit *, struct commit *);
 int in_merge_bases_many(struct repository *r, struct commit *, int, struct commit **);
 
 extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
-- 
2.15.1.433.g936d1b9894.dirty

