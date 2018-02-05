Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F971F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBEXzu (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:55:50 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33039 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeBEXzj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:39 -0500
Received: by mail-pl0-f68.google.com with SMTP id t4so93175plo.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4SaMk+DHYRgGB0SyKYMF0OM9jdTmJCu0bEJT0f9GYwM=;
        b=lS+7fm1AOGgj/xCji7rm78O44ZF/rSbnI0cFTATUCAoXwY34JQlYsmmE+i2WYbbWOi
         wikdizPWlJzc6+KuxF5HEF5gYpq0NmYL8QFxqBfJqfQqoyKTMCYFfpCSWEtewaxMB4Kd
         QwdjA3GLN31taqLmYBequRQI9zoV/+QDjH/U8MpfDsNs9yIyZEENIrMl4g5uz6S8kHkk
         Rbj2K9l9cdXM0L5UfrzNgnALzosVUPNzwyfODHrec3ZI5leLFNboY0XIPoyIEY4c+ESS
         TnlVF/hL09hZ38ftDF3z0AQuVi/+ZXNKN3TErTH6aneDPaoER+u+eFOH73q11PN7CdG5
         +r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4SaMk+DHYRgGB0SyKYMF0OM9jdTmJCu0bEJT0f9GYwM=;
        b=il/3Vt70L1ButN2o0Dp6OHa06tr5gfW2yhoNVm4OEFa/fpMOdQba2AHlx+kleAx4iS
         mxOzmLH2XT5lNz2aPPxZQ/R13bsGabEylt/ziw6rX8+g8ypR9GFfcB9mb7OtMrH98zcZ
         HCpLAUw0Bgr/5zIy+0WrG8rMPOL67+abNXHY5APOnX7VUuR1f3bzAAF6sGso6Rc1Y+/H
         q2lN1+VTNI7UeK8oCvVRXX6SlYKSJgQMz5lO5YMe8z/4jN0KhIgf0fghzdA8T4ND2X6B
         qEai9bbN35uGSfJoE9zZk0mX7wSnUGbRV9nVwwOHcZhpRWUokERLs8QRPXFpasz3Bxs+
         ZawA==
X-Gm-Message-State: APf1xPCAv5E7MOaa6AfrkCwDQwA0uzvq02ls1atknBHTKMWtBhu7ri7P
        OF6Lm8ZvpigxbbuqeJrQftcB1yuiPFk=
X-Google-Smtp-Source: AH8x225D9FMPd1L0FVloKJWccyoY8bFtuvtnazXk+VGKb+4srlijWZHD2Qj3eF1nm62nJuANElDh5Q==
X-Received: by 2002:a17:902:1e5:: with SMTP id b92-v6mr515345plb.144.1517874938154;
        Mon, 05 Feb 2018 15:55:38 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v22sm19778179pfa.158.2018.02.05.15.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 004/194] pack: move prepare_packed_git_run_once to object store
Date:   Mon,  5 Feb 2018 15:51:58 -0800
Message-Id: <20180205235508.216277-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Each repository's object store can be initialized independently, so
they must not share a run_once variable.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 8 +++++++-
 packfile.c     | 7 +++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/object-store.h b/object-store.h
index e2a59a0611..14129fbba1 100644
--- a/object-store.h
+++ b/object-store.h
@@ -15,8 +15,14 @@ struct object_store {
 
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
+
+	/*
+	 * Whether packed_git has already been populated with this repository's
+	 * packs.
+	 */
+	unsigned packed_git_initialized : 1;
 };
-#define OBJECT_STORE_INIT { NULL, MRU_INIT, NULL, NULL }
+#define OBJECT_STORE_INIT { NULL, MRU_INIT, NULL, NULL, 0 }
 
 struct packed_git {
 	struct packed_git *next;
diff --git a/packfile.c b/packfile.c
index 11b0e6613c..177aa219f9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -873,12 +873,11 @@ static void prepare_packed_git_mru(void)
 		mru_append(&the_repository->objects.packed_git_mru, p);
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
@@ -886,13 +885,13 @@ void prepare_packed_git(void)
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
2.15.1.433.g936d1b9894.dirty

