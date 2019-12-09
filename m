Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B5EC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7535207FD
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn0KZJJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfLILxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34853 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfLILxV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id c20so13119883wmb.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4mqg2+FA9ZvHSuvUO+QD6JNk/hSkJWff+fRlUvx2gXY=;
        b=mn0KZJJNHj/RT521PybHEowV39JdH6PM1y9tMpvA66rccXJmZrqZvdILxbwvM18PL7
         z8M869DuyD3GsqypcT9s8SuFzFipYES32yGzhcqaWNxsa7/++YXVkDaqguyx85NDR8/y
         vrxU4Mu/6pVajkviDk6KDAS3yRbCifwJXpwG4FZy+MLwnGQ4e9HibxPxLuk/RyDg77I/
         IvHcWFHw9zN9VAnEbeLkTblJLIS8ATThykcJERLWSNg/nUSUhwf3IuzcTFnOyOi79AUO
         k3OGapQcgWTmcv5rJEDM8GadoRbzLx8rLuy0Vksp6C1HM2ZExyvrr4JO8hQsMDZTP1Iv
         u0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mqg2+FA9ZvHSuvUO+QD6JNk/hSkJWff+fRlUvx2gXY=;
        b=JA5CGSnMuo6AJoX5K2Og9DUj0c34hwDv1k0CyfpIDUOeL3J40pGzAHmBkdUDkyjwiT
         +MFTJbtucbLcvQO96U+bL8V1hsF34DrxmmxVxfKWDEvqQCUNz2mEXYOMWGNrDOAU+Vz1
         9mzNVRHp0UFJcx2frPaS7PxyFYrFhUGot15Bbqod0YcvwkwrB59zeQmkiPtfiM/n2Pks
         sJBQ+pqTU72PBl54qi055I7g5hXuHocxh6JP6LU4UakDj5SyT2j/9ZgPqhAKbqvIxjN1
         JmCUtFWh6w1hhkKwNzfOKOmzwDK9YtnvIwU8P/DGFaAQ49snWTsX59GaMGFHjyEBWcUA
         KDLQ==
X-Gm-Message-State: APjAAAU20mAeGXCMc99vY2GYsH0H78DTDCOlpq1T2ok/C9GOiOsa124J
        inXsjlZK429t1ZPsO75jfdI=
X-Google-Smtp-Source: APXvYqzGkDvOF84m8qNViTOeqvHJF3eu6P2KsVFpfT6tvImwqKyoA7S7n8g70X5h2lu/O2KCSvBOKg==
X-Received: by 2002:a1c:1dc4:: with SMTP id d187mr25029704wmd.46.1575892399119;
        Mon, 09 Dec 2019 03:53:19 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:18 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 14/14] name-rev: cleanup name_ref()
Date:   Mon,  9 Dec 2019 12:52:58 +0100
Message-Id: <20191209115258.9281-15-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191209115258.9281-1-szeder.dev@gmail.com>
References: <20191112103821.30265-1-szeder.dev@gmail.com>
 <20191209115258.9281-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier patches in this series moved a couple of conditions from the
recursive name_rev() function into its caller name_ref(), for no other
reason than to make eliminating the recursion a bit easier to follow.

Since the previous patch name_rev() is not recursive anymore, so let's
move all those conditions back into name_rev().

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index a3b796eac4..cc488ee319 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -107,12 +107,26 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 
 static void name_rev(struct commit *start_commit,
 		const char *tip_name, timestamp_t taggerdate,
-		int from_tag)
+		int from_tag, int deref)
 {
 	struct prio_queue queue;
 	struct commit *commit;
 	struct commit **parents_to_queue = NULL;
 	size_t parents_to_queue_nr, parents_to_queue_alloc = 0;
+	char *to_free = NULL;
+
+	parse_commit(start_commit);
+	if (start_commit->date < cutoff)
+		return;
+
+	if (deref)
+		tip_name = to_free = xstrfmt("%s^0", tip_name);
+
+	if (!create_or_update_name(start_commit, tip_name, taggerdate, 0, 0,
+				   from_tag)) {
+		free(to_free);
+		return;
+	}
 
 	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO */
 	prio_queue_put(&queue, start_commit);
@@ -309,20 +323,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		if (taggerdate == TIME_MAX)
 			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		if (commit->date >= cutoff) {
-			const char *tip_name;
-			char *to_free = NULL;
-			if (deref)
-				tip_name = to_free = xstrfmt("%s^0", path);
-			else
-				tip_name = xstrdup(path);
-			if (create_or_update_name(commit, tip_name, taggerdate,
-						  0, 0, from_tag))
-				name_rev(commit, tip_name, taggerdate,
-					 from_tag);
-			else
-				free(to_free);
-		}
+		name_rev(commit, xstrdup(path), taggerdate, from_tag, deref);
 	}
 	return 0;
 }
-- 
2.24.0.801.g241c134b8d

