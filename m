Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A767A1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeBFA3g (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:29:36 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46318 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbeBFA3e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:29:34 -0500
Received: by mail-pl0-f66.google.com with SMTP id 36so124983ple.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ddhDdqMlt8JbJtOMGDYEYGbKhox4PSku8EeMi16HUg=;
        b=VRBuZipM2TFEK+z87rnkaHhF1BodCydldmRZHvHvk7nA1r5MtdYUFjQCgrupbUCLlH
         hBVpTE0cbMQcCGqAXSRR2TDKxAoXxW7QElRTyhbGD/cPIEoGbGa13wK1sSVNtEsmpWXe
         flCc6136saSKnzG3auYPXCHOaJCJpag39DhWGOTQuDaFRhrhrxwyk/j1DP9QFm45g1pz
         MzmBDk/fkdyxrsvglp8ZuE0P7tiEEYwhHAxP587U1idTGwU9UUdYsd/XT3OtKCX31+7K
         AZv2ehaV9f1Azz4Kp0y9nuZ2J9t/HqvpnGpvaEu5oOkPRHeil1U1mjqNwrB8SOwGP55N
         WB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ddhDdqMlt8JbJtOMGDYEYGbKhox4PSku8EeMi16HUg=;
        b=KLKMHcZoK4P9Vb1Jpyrb1sAO8b9XSYwOG+uK52HpmRE5w0qHwcc+MC2ePOumdgxH2h
         JdKYy0NT8m9izkI8VzZA1Ji8s7wfOK/SuBdCBASKt9DuLPq2Kkm12pKSK5AeTo1teeLy
         hooegxKsCjI66K8PurSnOVc32jawtDHn//Knu7PKEcROJVkRKvhcpaIAG0pcdFOL7hYc
         LkAioGvDGBJdlSRIq3fy6vYiAyzx0YJQq+uuAN6fsJWK8f9TglEi/NqjOaALnd3MD9rh
         /NdFEfBK7hkxTgwRos5wbgIcNHxSEQ4wXn7Ocj0jRILxHMT36zH6wkBqQh4nOEzlL+tM
         qMQw==
X-Gm-Message-State: APf1xPASpFrEt10f4naHownukB++husXGaBQlC8RGHiO5jDKC3VDT2n+
        LKV3dAXEe9pni/PeZjHMVF8nb9id5SM=
X-Google-Smtp-Source: AH8x226o/xjw8TCuRlhTRT0B5q6K7He6rHrpeVIki+icaDwt/ok87x68W0KNuLYY59j56bAfhFUSNA==
X-Received: by 2002:a17:902:8498:: with SMTP id c24-v6mr563853plo.450.1517876972626;
        Mon, 05 Feb 2018 16:29:32 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e67sm17803052pfd.23.2018.02.05.16.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:29:32 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 172/194] commit: allow get_merge_bases to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:27 -0800
Message-Id: <20180206001749.218943-74-sbeller@google.com>
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
index 8b1e35d2a1..33f5442dc1 100644
--- a/commit.c
+++ b/commit.c
@@ -1025,9 +1025,9 @@ struct commit_list *get_merge_bases_many_dirty(struct commit *one,
 	return get_merge_bases_many_0(the_repository, one, n, twos, 0);
 }
 
-struct commit_list *get_merge_bases_the_repository(struct commit *one, struct commit *two)
+struct commit_list *get_merge_bases(struct repository *r, struct commit *one, struct commit *two)
 {
-	return get_merge_bases_many_0(the_repository, one, 1, &two, 1);
+	return get_merge_bases_many_0(r, one, 1, &two, 1);
 }
 
 /*
diff --git a/commit.h b/commit.h
index e671ce68db..7fe6bb0b22 100644
--- a/commit.h
+++ b/commit.h
@@ -180,8 +180,7 @@ struct commit_graft *read_graft_line(struct strbuf *line);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
 
-#define get_merge_bases(r, r1, r2) get_merge_bases_##r(r1, r2)
-extern struct commit_list *get_merge_bases_the_repository(struct commit *rev1, struct commit *rev2);
+extern struct commit_list *get_merge_bases(struct repository *r, struct commit *rev1, struct commit *rev2);
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
-- 
2.15.1.433.g936d1b9894.dirty

