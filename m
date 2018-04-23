Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 128381F424
	for <e@80x24.org>; Mon, 23 Apr 2018 19:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932390AbeDWTpa (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 15:45:30 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43564 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeDWTp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 15:45:29 -0400
Received: by mail-wr0-f195.google.com with SMTP id v15-v6so26328804wrm.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NI6yO1iJVoGVkXstJe4cTm7SyJ9BTIdlrOIbHNvk39Q=;
        b=XH7k1Tpp9Dsfn+WGAw6GA1ERAsXOtBJuucNQpu0UoJMb0mnSz6dv8xoAumRKxLaNbK
         oNfVwUNNQ2uF4HM0+xXjSJS9EivO3TcEAuKCWeYzU06m/SzC5oKAM0Sdc5O6Fv27p2I0
         TTDdtBONcMGumdNtlo9bbP98Zt+/vad5sSJhIT1bFCUWLtN3ti8nYP3KTOg2AkHtScEL
         lt5sZx/VET75aiF40fvF2PQHVn/sb2peENcrY0M9v8EKuvmZPVHbIbUcEmPhfEJFyWp4
         507KsaxnAEnXKKBNZ9M6NVOWwbkPGPo38fToQrkzs6XIEMzzxY9wPQPSRs+l86FJ3P7x
         uT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NI6yO1iJVoGVkXstJe4cTm7SyJ9BTIdlrOIbHNvk39Q=;
        b=oyHKl+sZfPfeHrAgSJCWVtGacig5EfN+Sb2V7+2bcWlWC/3+CUVCO+N7zh1tsIEiRd
         4bin4sC+tNI/T6M+6NVewr5pIQG3tsBuSmePBXNIMthZtYpGi3M7W/W8wzIVLNVDohV+
         FEA+UDARtsBmqfHJucx3EDdaE42mGwLcSAE1JMrsBL+q9Gcc1qJt8NWmH23ap7Jkvn0J
         39TUuUDxgXyWCPmWaPdKnHH4DHP3dz4t6bCHy1zs6oBpWjp1tKDLYYgDkAhvFCcu/oab
         4ZW4VYHKWLQ1QjTVolXrzo3GCa8mCGyzhNLWC1mvN7BorXarGfPxci5N2RikBFrAMTyb
         ROqw==
X-Gm-Message-State: ALQs6tBUZzo+ZlL5Y4j3F0Bcxd/R+nCB0DzGXTzmmNtkta3meOL/Gm9s
        B0S2u0KiIKyJljdKrcWK0qK7KK5T
X-Google-Smtp-Source: AIpwx49SrLMwwC4r5KnpDoJNVumqJV+non8786XnhNgMuwP5/VhMfrNpQfzDrNnJmlfXfGolS3qNcA==
X-Received: by 10.28.3.197 with SMTP id 188mr9883615wmd.43.1524512727692;
        Mon, 23 Apr 2018 12:45:27 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id y7sm8341859wmy.30.2018.04.23.12.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 12:45:26 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v8 3/4] worktree: factor out dwim_branch function
Date:   Mon, 23 Apr 2018 20:38:47 +0100
Message-Id: <20180423193848.5159-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.74.g7afd1c25cc.dirty
In-Reply-To: <20180423193848.5159-1-t.gummerer@gmail.com>
References: <20180415202917.4360-1-t.gummerer@gmail.com>
 <20180423193848.5159-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out a dwim_branch function, which takes care of the dwim'ery in
'git worktree add <path>'.  It's not too much code currently, but we're
adding a new kind of dwim in a subsequent patch, at which point it makes
more sense to have it as a separate function.

Factor it out now to reduce the patch noise in the next patch.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d348101216..bd4cf4583f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -387,6 +387,20 @@ static void print_preparing_worktree_line(int detach,
 	}
 }
 
+static const char *dwim_branch(const char *path, const char **new_branch)
+{
+	int n;
+	const char *s = worktree_basename(path, &n);
+	*new_branch = xstrndup(s, n);
+	if (guess_remote) {
+		struct object_id oid;
+		const char *remote =
+			unique_tracking_name(*new_branch, &oid);
+		return remote;
+	}
+	return NULL;
+}
+
 static int add(int ac, const char **av, const char *prefix)
 {
 	struct add_opts opts;
@@ -439,16 +453,9 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (ac < 2 && !new_branch && !opts.detach) {
-		int n;
-		const char *s = worktree_basename(path, &n);
-		new_branch = xstrndup(s, n);
-		if (guess_remote) {
-			struct object_id oid;
-			const char *remote =
-				unique_tracking_name(new_branch, &oid);
-			if (remote)
-				branch = remote;
-		}
+		const char *s = dwim_branch(path, &new_branch);
+		if (s)
+			branch = s;
 	}
 
 	if (ac == 2 && !new_branch && !opts.detach) {
-- 
2.16.1.74.g7afd1c25cc.dirty

