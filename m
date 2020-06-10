Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAACEC433E1
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C807720760
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLs6T4/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgFJGcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgFJGcA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 02:32:00 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07805C03E96F
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 23:32:00 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m81so942452ioa.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 23:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLAkRSj+dy1kBdSQ1ANW//gviag+baogLOvlX0pXP4A=;
        b=jLs6T4/DU1TRlh298y6tR7XKokIOqNHH9vgaI2NaR9f2NmSVjPQJpuy3CMnVRPewgq
         OWJuKHqov8s0yNVEZ5fqxmNrqwc0HQ4cnlmUIvUo6C72fA2U7xlhIv4WIsqf3ptKBafj
         bOO0Jj0t+KPCCb/mt1aS04BqFSzyZAWGerxoaLydQtkBlX6C1hMJedeOhfIlgh3HhI18
         xWnRNxYeDeyWi29NfrZ8U6IVWXnLvurcLKi/gYnfeDqKZh6R6mFCytDxkJ1E/4PWd3rw
         eUy3uO4nt9nmroh/BE8iHsXkuHMumtIOqEu+tcXrIpZ3nI+TBza35EAtz6Ke2iAJB7mU
         AREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cLAkRSj+dy1kBdSQ1ANW//gviag+baogLOvlX0pXP4A=;
        b=AqIY25fkM7v+x6mGcKnWGaXkX6HT2VWQRqzW3zsMOt6M2R96ZO7bUJ/QLOHxK53TtG
         cO77YSSJiUc+YYAs0xNznO0J1IR03wCWIglKxBpWZWB0EwONNhnXyw5U4IasQyC32det
         g0o18gms7I6qs4oJZgOkgD7tZyTNTGeB1qCsCdBRb8GKcVS2xXPCoHew8meUybDhNX3t
         C5XX/WQmi4qip8qdgxOTRKx6g+x5SISLqLqKL71uOqsGQEsEI2/nb6klSDNCkLj7ZoNi
         BZKgadzhP+FOC4mrBYMZqxr7FgiNDLz+vLCC/dFNsX8TE9F5q41M/pG8IexmjWNVUlO8
         73uw==
X-Gm-Message-State: AOAM5319Hb0RGXOug/45OXrnXAy/1tYBRUd6BHdpfYt/kK0y2JAAlZvb
        +BEKmr5b1pFLSEc3kl9PNu3Ao6vGnBI=
X-Google-Smtp-Source: ABdhPJzAzbP6qzJNfN9XHDu+9RTOxsI1OBXKM6YCaDH7NlgjudXwHrPTLGB7uG1oo9/5O0Y3wge/NQ==
X-Received: by 2002:a05:6638:dd3:: with SMTP id m19mr1782939jaj.106.1591770718963;
        Tue, 09 Jun 2020 23:31:58 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id f22sm8497868iob.18.2020.06.09.23.31.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 23:31:58 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/7] worktree: make high-level pruning re-usable
Date:   Wed, 10 Jun 2020 02:30:45 -0400
Message-Id: <20200610063049.74666-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
In-Reply-To: <20200610063049.74666-1-sunshine@sunshineco.com>
References: <20200610063049.74666-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The low-level logic for removing a worktree is well encapsulated in
delete_git_dir(). However, high-level details related to pruning a
worktree -- such as dealing with verbosity and dry-run mode -- are not
encapsulated. Factor out this high-level logic into its own function so
it can be re-used as new worktree corruption detectors are added.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 35d38607e7..706ac68751 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -133,6 +133,14 @@ static int should_prune_worktree(const char *id, struct strbuf *reason)
 	return 0;
 }
 
+static void prune_worktree(const char *id, const char *reason)
+{
+	if (show_only || verbose)
+		printf_ln(_("Removing %s/%s: %s"), "worktrees", id, reason);
+	if (!show_only)
+		delete_git_dir(id);
+}
+
 static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
@@ -146,12 +154,7 @@ static void prune_worktrees(void)
 		strbuf_reset(&reason);
 		if (!should_prune_worktree(d->d_name, &reason))
 			continue;
-		if (show_only || verbose)
-			printf_ln(_("Removing %s/%s: %s"),
-				  "worktrees", d->d_name, reason.buf);
-		if (show_only)
-			continue;
-		delete_git_dir(d->d_name);
+		prune_worktree(d->d_name, reason.buf);
 	}
 	closedir(dir);
 	if (!show_only)
-- 
2.27.0.90.gabb59f83a2

