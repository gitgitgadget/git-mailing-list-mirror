Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D991F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeBFAZA (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:25:00 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40153 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752353AbeBFAYo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:24:44 -0500
Received: by mail-pg0-f65.google.com with SMTP id g2so170199pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iv3e5ToX/mhPnkpw3A5+5pz6rTLnCfFpfvW39MFtdBg=;
        b=FUaFSaDjqgHblMHcCXrTi2L1mH8G1cHyWzo7tlT3OKYD2GZfDUM/uF+pmHsAnvJMaL
         dHnpLiqZitGdKAxSLsn1DYRGije/DNutyNXMgdQ2J/lVAOj/SQY5uadywpUBDl3Kaak1
         TVCYbMTB9FGERyjiHB/MMYUvz9L7nbkQ34ZmPjItp8+PfZM/0RAtRlbXnGhv1yGskVEE
         aAoQXCTuWUCfw4QjdakYZa+B/H6dwvqaj7wcLsJMViR5k/aZsY9LYV5v9x61gnxc/dIu
         +kAbJOY8AlrlC1JlUsYWfyk6WUiUar1XEllGzFXC3MbE8+C+/fU27X3aAwSfyw9SokaS
         zNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iv3e5ToX/mhPnkpw3A5+5pz6rTLnCfFpfvW39MFtdBg=;
        b=A3GWSS7Sk/5KS0F2F+WQJ6isN4CvDgFgDSasdLxgu/8KT46obrU6K1T6wTNMpxenuw
         TZqCXOsX1gnBjq8KvzdYItaLZ+sdWaJJdir2oFWw6/w5VEEkH0NbwnUTbFjJWMPSzpUG
         6FCJ815qQgQ6wKMoochGoFt+Jza/FgAMxzOjp7WfLMGSwzFINTBp+pwjgyXL/heB0Hf+
         YMI0CA46OdA3CrnRxLe+GYrWyIjV2yVxZS4iUmkohSHAkECtz6R8p+bGXQWWXYUzEnzz
         vuBUjffZ23LZK5KmPcpPf4NSRtzn6bd9mFNbK4h0imAnGE4ZpQGvS94xg1EQJ5rqjriJ
         0OwA==
X-Gm-Message-State: APf1xPDoce3cHVu9uyez7YT5yrrqkZM9ZUDBNxgVvmsmG2OGbK5XUxAC
        QYVSt95TK5D3eOd+NbsB5ju7AvBPR98=
X-Google-Smtp-Source: AH8x226hI7R5vyBMYdC3Ea8O4OpVPAANTmdN06jW7fb9G3qGiVgQGQ7u493YZY3tv33FEmuvX56rsQ==
X-Received: by 10.99.102.193 with SMTP id a184mr452357pgc.141.1517876683314;
        Mon, 05 Feb 2018 16:24:43 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v186sm17682191pfb.5.2018.02.05.16.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:24:42 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 141/194] commit: convert register_commit_graft to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:56 -0800
Message-Id: <20180206001749.218943-43-sbeller@google.com>
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
 commit.c | 29 +++++++++++++++--------------
 commit.h |  3 +--
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/commit.c b/commit.c
index 0d006ab1bb..43ed3298cc 100644
--- a/commit.c
+++ b/commit.c
@@ -112,30 +112,31 @@ static int commit_graft_pos(struct repository *r, const unsigned char *sha1)
 			commit_graft_sha1_access);
 }
 
-int register_commit_graft_the_repository(struct commit_graft *graft, int ignore_dups)
+int register_commit_graft(struct repository *r, struct commit_graft *graft,
+			  int ignore_dups)
 {
-	int pos = commit_graft_pos(the_repository, graft->oid.hash);
+	int pos = commit_graft_pos(r, graft->oid.hash);
 
 	if (0 <= pos) {
 		if (ignore_dups)
 			free(graft);
 		else {
-			free(the_repository->parsed_objects.grafts[pos]);
-			the_repository->parsed_objects.grafts[pos] = graft;
+			free(r->parsed_objects.grafts[pos]);
+			r->parsed_objects.grafts[pos] = graft;
 		}
 		return 1;
 	}
 	pos = -pos - 1;
-	ALLOC_GROW(the_repository->parsed_objects.grafts,
-		   the_repository->parsed_objects.grafts_nr + 1,
-		   the_repository->parsed_objects.grafts_alloc);
-	the_repository->parsed_objects.grafts_nr++;
-	if (pos < the_repository->parsed_objects.grafts_nr)
-		memmove(the_repository->parsed_objects.grafts + pos + 1,
-			the_repository->parsed_objects.grafts + pos,
-			(the_repository->parsed_objects.grafts_nr - pos - 1) *
-			sizeof(*the_repository->parsed_objects.grafts));
-	the_repository->parsed_objects.grafts[pos] = graft;
+	ALLOC_GROW(r->parsed_objects.grafts,
+		   r->parsed_objects.grafts_nr + 1,
+		   r->parsed_objects.grafts_alloc);
+	r->parsed_objects.grafts_nr++;
+	if (pos < r->parsed_objects.grafts_nr)
+		memmove(r->parsed_objects.grafts + pos + 1,
+			r->parsed_objects.grafts + pos,
+			(r->parsed_objects.grafts_nr - pos - 1) *
+			sizeof(*r->parsed_objects.grafts));
+	r->parsed_objects.grafts[pos] = graft;
 	return 0;
 }
 
diff --git a/commit.h b/commit.h
index 41a8947b33..870ad525fd 100644
--- a/commit.h
+++ b/commit.h
@@ -175,8 +175,7 @@ struct commit_graft {
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(struct strbuf *line);
-#define register_commit_graft(r, g, i) register_commit_graft_##r(g, i)
-int register_commit_graft_the_repository(struct commit_graft *, int);
+int register_commit_graft(struct repository *r, struct commit_graft *, int);
 #define lookup_commit_graft(r, o) lookup_commit_graft_##r(o)
 struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid);
 
-- 
2.15.1.433.g936d1b9894.dirty

