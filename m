Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D911F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeBXAsQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:16 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34204 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeBXAsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:09 -0500
Received: by mail-pg0-f66.google.com with SMTP id m19so3989488pgn.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q2A17rdtpU+Jgq8RkGCQbhq6UpB4NXkEwWcbZ0m3AKs=;
        b=bAwipW9V9ixJctRzFQChKxyBaq0C394Q1+Bpd115vLUdc5yBw0mCIX4zk5B1ytgcTC
         XEp3VD8sSWQGqHAjnykIUQM8Hp4nCaItWB1R1bn3zQgcjI+82pyn63EpMAfc/d9HoLhe
         D5iYtpfzQCCg6Pa8AersGzSHoNjb2h01k3q1ph5GTiG6G+qtQ4X1GLpX3ay3Kpgff5u2
         48De4RYKXls+5qB6QFMvLV5X7AAZ/OMq101rW9wrc65hDljd8KZrWQKyIpZPuRY2qRf+
         74vZLTs+/buoG+qlF+6DbbSVZUg209QiszkHCeV4j/2PqaLJz2uKgSXcclnn4im2qjCM
         +I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q2A17rdtpU+Jgq8RkGCQbhq6UpB4NXkEwWcbZ0m3AKs=;
        b=dkNXfycDE5wcaGsXmu+UefYThsi7hyh16ZCuJP3fGmZx+jPrMa0PHWfYc6mQm47Lif
         cfzVX6wvJZ4VGPYbxjlzIoulxXjLBgTlZiZfzk6Zhz4hM2HiqOweysyxls+Jrnk5RXBL
         V4cnE6WLAxM8bJdE0cVk711X2z5j5u42qgEaAEzMmcKamvcgDg2AkgWbVttL8ACMYaLu
         J8Zl17YX6KnOvIlg27naSFEVHJWcmK3PN44MHeeTRpkbeB02fkbrW8cr7yeIuAmQcZwD
         49vj7lm4IrirC2oCtqK9wPGeJ37I1vGTaQeRDvCrt2wNKCeA1HLBng6y2akMu5E213YF
         qDAQ==
X-Gm-Message-State: APf1xPASWs1+Gmefpwx/qIsbnLSaFJyH5y6cPxGIUw9sePtTygsAhli8
        4yZKRn5+N9ouRpEMQBP9znEajrcr6xw=
X-Google-Smtp-Source: AH8x226Acirn8Ee69Dm/mN0BGkU9I01w/OPjmZIXIVCu0DmxMleLHB1VCL3qCfD8dNB+eInv7NWgfg==
X-Received: by 10.101.85.67 with SMTP id t3mr2803270pgr.310.1519433288739;
        Fri, 23 Feb 2018 16:48:08 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q76sm7472421pfj.149.2018.02.23.16.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 07/27] pack: move prepare_packed_git_run_once to object store
Date:   Fri, 23 Feb 2018 16:47:34 -0800
Message-Id: <20180224004754.129721-8-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each repository's object store can be initialized independently, so
they must not share a run_once variable.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 8 +++++++-
 packfile.c     | 7 +++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/object-store.h b/object-store.h
index 4f768465a14..bd6441e525f 100644
--- a/object-store.h
+++ b/object-store.h
@@ -89,9 +89,15 @@ struct raw_object_store {
 
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
+
+	/*
+	 * Whether packed_git has already been populated with this repository's
+	 * packs.
+	 */
+	unsigned packed_git_initialized : 1;
 };
 
-#define RAW_OBJECT_STORE_INIT(o) { NULL, NULL, LIST_HEAD_INIT(o.packed_git_mru), NULL, NULL }
+#define RAW_OBJECT_STORE_INIT(o) { NULL, NULL, LIST_HEAD_INIT(o.packed_git_mru), NULL, NULL, 0 }
 
 void raw_object_store_clear(struct raw_object_store *o);
 
diff --git a/packfile.c b/packfile.c
index 65d9a4f6c61..3ee349ab1bd 100644
--- a/packfile.c
+++ b/packfile.c
@@ -883,12 +883,11 @@ static void prepare_packed_git_mru(void)
 		list_add_tail(&p->mru, &the_repository->objects.packed_git_mru);
 }
 
-static int prepare_packed_git_run_once = 0;
 void prepare_packed_git(void)
 {
 	struct alternate_object_database *alt;
 
-	if (prepare_packed_git_run_once)
+	if (the_repository->objects.packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
@@ -896,13 +895,13 @@ void prepare_packed_git(void)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
-	prepare_packed_git_run_once = 1;
+	the_repository->objects.packed_git_initialized = 1;
 }
 
 void reprepare_packed_git(void)
 {
 	approximate_object_count_valid = 0;
-	prepare_packed_git_run_once = 0;
+	the_repository->objects.packed_git_initialized = 0;
 	prepare_packed_git();
 }
 
-- 
2.16.1.291.g4437f3f132-goog

