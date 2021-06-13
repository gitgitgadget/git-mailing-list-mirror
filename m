Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B517CC48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 05:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C185611CE
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 05:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFMFCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 01:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhFMFCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 01:02:09 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91ECC061766
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 21:59:53 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so7480939otu.6
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 21:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQXe6buHltMr+p0yRZf8Iowfc7T/6kp9lrkEYVN+kJw=;
        b=TUwyqBIqbfew1LMd5iFQ/Z/4+ATrdpxKqDjxTYQhfXvDfReKuWcYIR5RLbWqN44Gau
         LsRXmjApET7hZ44hJDDmgW6qbrhk8L4a4+SfOZQvsUfU7MNRD++xGP9/bm3nFp3bmKi6
         tviqeruXs0PxBJ1xk4ze5YvQrJgjROibax7hs9usvVgoebfKaLpHvi68fyjQQikNWSaB
         ScGC/2mhNKpA7r8ryq0jskAxoLCg0VElrKfZ1HIlapWUpiITpRwZ06XQ1EK6RCUDNeOr
         tnmOcnCAO2VFOSSsUxtbFJLx6nZTcgnkWpIFw2GFchaHSU4R35FEtj3jL0PUl7uL07Tv
         Q+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQXe6buHltMr+p0yRZf8Iowfc7T/6kp9lrkEYVN+kJw=;
        b=bB3+dNWKEAaCvloSQ8frkM5bexvOj4u8/S1Hjl6rIXqBjlSEV8gJER8XBkHUB6LsWw
         P5+a1k3MCVNs6XRjLJaphjz3DTtIiN4M6NN2phbhMHsFW8AJ8zFdJTxsaJYIJ0WtaSRV
         LJPiIZxZajJC80qJqK106usUQPKsgLuvca2NshSS5lzZnic4jF+QnYO46sMryx9tFA8h
         GiM4f1UpW9Wv/ivFdgfJTHSHsfQmi6TBbTPaHjPTm7KErrA1jCOBkZlS2dIvm9p9o276
         dMOTiQeiDXVuFkxPZ2nkpeLK9FoDxRxmwUYhekfU7px8suZqWX5PeM4cuXCGAZkl8udS
         qcRQ==
X-Gm-Message-State: AOAM533z88Ptt2uELs4vMPxQeDjaO53OU2A45axNXxbYUQKl2ptTJnoi
        NZbxKyPWltMLUltzpfZhRA30gjOeN6CHKQ==
X-Google-Smtp-Source: ABdhPJxB7xk12rkRVPvuRG7Yz6uxr7aqvPp6N3BZYkmZWHYq5TKxQ7wa6qynSH0kqttDSrdTkzVOfA==
X-Received: by 2002:a05:6830:22ec:: with SMTP id t12mr9132520otc.243.1623560392953;
        Sat, 12 Jun 2021 21:59:52 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p5sm2129015oip.35.2021.06.12.21.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 21:59:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] pull: cleanup autostash check
Date:   Sat, 12 Jun 2021 23:59:47 -0500
Message-Id: <20210613045949.255090-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613045949.255090-1-felipe.contreras@gmail.com>
References: <20210613045949.255090-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently "git pull --rebase" takes a shortcut in the case a
fast-forward merge is possible; run_merge() is called with --ff-only.

However, "git merge" didn't have an --autostash option, so, when "git
pull --rebase --autostash" was called *and* the fast-forward merge
shortcut was taken, then the pull failed.

This was fixed in commit f15e7cf5cc (pull: ff --rebase --autostash
works in dirty repo, 2017-06-01) by simply skipping the fast-forward
merge shortcut.

Later on "git merge" learned the --autostash option [a03b55530a
(merge: teach --autostash option, 2020-04-07)], and so did "git pull"
[d9f15d37f1 (pull: pass --autostash to merge, 2020-04-07)].

Therefore it's not necessary to skip the fast-forward merge shortcut
anymore when called with --rebase --autostash.

Let's always take the fast-forward merge shortcut by essentially
reverting f15e7cf5cc.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e8927fc2ff..a22293b7db 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -947,7 +947,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
-	int autostash;
 	int rebase_unspecified = 0;
 	int can_ff;
 
@@ -982,8 +981,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	autostash = config_autostash;
 	if (opt_rebase) {
+		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
@@ -1065,13 +1064,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
-		if (!autostash) {
-			if (can_ff) {
-				/* we can fast-forward this without invoking rebase */
-				opt_ff = "--ff-only";
-				ran_ff = 1;
-				ret = run_merge();
-			}
+
+		if (can_ff) {
+			/* we can fast-forward this without invoking rebase */
+			opt_ff = "--ff-only";
+			ran_ff = 1;
+			ret = run_merge();
 		}
 		if (!ran_ff)
 			ret = run_rebase(&newbase, &upstream);
-- 
2.32.0

