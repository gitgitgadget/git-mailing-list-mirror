Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B52C4727E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8B02389F
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8BcAz8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgI0NQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgI0NQU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 09:16:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9037C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s205so6119811lja.7
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dXrASULAHGNYsC1y+ahucKK9zRdkJW7jlQCLWe6CIkI=;
        b=d8BcAz8Tv1d0TP7N3qEN8Q3ElF4vt5u8kfiaP+bB4THepYTTYmj9rWeU+15AV4E5Y4
         5h4cznwjoGhH69RFWYspWCnnhq0fjYfPlfRuzimZlMHma96LX2CTcNQViLabN1td1xKf
         9MqGl6plZhokNcLZ+toAWv2SPnNcgnOWIt1v5emg3Oi0CUShd5w1cwlpom2Cey8RIgpt
         gafYdqEB5+JEdTL/JDbWXO5dugrMLyto1hFMKrNDqGNq3FcwTTqsHmBwa4wRNpbya5LF
         //xp5pAB8EyisOc9BUO9Bb0IbNQeETBc26oSAqOttWiYfrUVuIjjgpjsXODCMGim2xfw
         pCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dXrASULAHGNYsC1y+ahucKK9zRdkJW7jlQCLWe6CIkI=;
        b=tGzn2sQ/5QTFA3ir3LpLWE7/IaqY/P0BeqXXzj2O90yFWG/YycGcv1I027Z9hRDFoh
         c3ThWmbYwFuYeruDfU2lo/DTKi7bbIwz6Mne+b9p94Q8vTr3x/mgYjOOIHb0vbffDz9H
         F1Bsmb9SNoQfvuf9wPadQ7smg3qfQUnBDlktSZ0zuA/kHd6t2vGWMYcxXJbf4P4X2pSR
         rA7Tz5AURQBff6MeMKfnp7/21+HWA0s220pEMPjPOeu5a6R0ZtE1pZzMAxLTPQA6IdJw
         6qivCleQBfS/f+Hc7lUNx0wx+DnJrtJ78qedu14xcp3wud0esxqUY3dct3ee2S4d7xbM
         gsRw==
X-Gm-Message-State: AOAM533bJFFupjpNQ4JE3YOOBVQp7JqiF119AMjiK79n7e98/UX116Pq
        Eou7ggmDV1/oSPdQANzD3GCSKAb5Rm4=
X-Google-Smtp-Source: ABdhPJxxEbnMmvk0MatZC4/7y13s1uvd2goQDGnUXSntOCj+c78niFiDayMVU+OOYZbs39+D/TyzQg==
X-Received: by 2002:a2e:7301:: with SMTP id o1mr3608180ljc.257.1601212578004;
        Sun, 27 Sep 2020 06:16:18 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o8sm2487616lfa.44.2020.09.27.06.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 06:16:17 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 7/7] worktree: use skip_prefix to parse target
Date:   Sun, 27 Sep 2020 15:15:47 +0200
Message-Id: <f8fbee62347f4b19cdf12612e5bfc82ae1cea453.1600281351.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1600281350.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com> <cover.1600281350.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of checking for "refs/heads/" using `starts_with()`, then
skipping past "refs/heads/" using `strlen()`, just use `skip_prefix()`.

In `is_worktree_being_rebased()`, we can adjust the indentation while
we're here and lose a pair of parentheses which isn't needed and which
might even make the reader wonder what they're missing and why that
grouping is there.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 worktree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/worktree.c b/worktree.c
index b5702aa4eb..a75230a950 100644
--- a/worktree.c
+++ b/worktree.c
@@ -364,11 +364,11 @@ int is_worktree_being_rebased(const struct worktree *wt,
 
 	memset(&state, 0, sizeof(state));
 	found_rebase = wt_status_check_rebase(wt, &state) &&
-		((state.rebase_in_progress ||
-		  state.rebase_interactive_in_progress) &&
-		 state.branch &&
-		 starts_with(target, "refs/heads/") &&
-		 !strcmp(state.branch, target + strlen("refs/heads/")));
+		       (state.rebase_in_progress ||
+			state.rebase_interactive_in_progress) &&
+		       state.branch &&
+		       skip_prefix(target, "refs/heads/", &target) &&
+		       !strcmp(state.branch, target);
 	wt_status_state_free_buffers(&state);
 	return found_rebase;
 }
@@ -382,8 +382,8 @@ int is_worktree_being_bisected(const struct worktree *wt,
 	memset(&state, 0, sizeof(state));
 	found_bisect = wt_status_check_bisect(wt, &state) &&
 		       state.branch &&
-		       starts_with(target, "refs/heads/") &&
-		       !strcmp(state.branch, target + strlen("refs/heads/"));
+		       skip_prefix(target, "refs/heads/", &target) &&
+		       !strcmp(state.branch, target);
 	wt_status_state_free_buffers(&state);
 	return found_bisect;
 }
-- 
2.28.0.277.g9b3c35fffd

