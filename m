Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38595C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D963021775
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw+Bk3SX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgI0N3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 09:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgI0N3W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 09:29:22 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA49AC0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:29:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w3so6149527ljo.5
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTGCWe4gyAUjyN4m8s5hUxSCis7QBP3d/aMCkskHZnY=;
        b=Mw+Bk3SXkahR7YEQ81gK+PFlVMRMLFPau2/MJcuykqdXmlbkSCvQgs3UU8K4cEbmI4
         XWihr/Rur9r9xkbpuBT2wo1xV7/0flQ/1spOOx3mlztGBXJfe7JqypKDzFc0wWydZEsA
         Vszqjl1KNpGDq6C/7pajAa5CteG6ClN5eQNO71ld6CW6jAdWWcATR1HBgnsrF4soG/TJ
         MC/jziIk8tVf7xe4IBUIuEEo5GL8eH+mM9Qb0at+rKX3a+R6z2wEWnGFnqj5gUZPqNo8
         b/izzm1SEQ36GHpN7CqLLW81rkzrPm4disHGnHKZUyTGpmmSme2e259LH3ZHmhKFiDB9
         fZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTGCWe4gyAUjyN4m8s5hUxSCis7QBP3d/aMCkskHZnY=;
        b=PCu6axGOjM/MU9lRlySSCn8R8ArnOYlgAsR/vkB1HGva/v/xSt9q8GEgOoyGsfuKer
         f/9F+nNHmMH1PoYKad2XOm7euw9IE3Jgt4KHq9/s9UOa0xbILzvcUdcxbd9tUqQEJa7G
         C39c6if2yvfqY3baOHw2PlQOs9R3+3S916pqwK5Pd/8iaB7AoFKhp2TY0Q57HbTpis8B
         HZvXfGZzxPn1DyU2RiPgLIWlFztmwu+tY/jSx00KC60PTLGp/xPkgV44dSgcoTN/QDX0
         LMMs1Y6QjGVqQLFUCvWqxqTtfb44dYDfaD4Xgk6hkn5AhPmmVXs+Mrc8IGv7dO+tsorv
         X2wA==
X-Gm-Message-State: AOAM533/HCgDdiWRZ3qkq5E8XAtblKqE/8x7C1/udmyyY02t9NECLLF8
        AsQ4x8isqo7D6944JHi0d0o6GwsJXAI=
X-Google-Smtp-Source: ABdhPJyUMVAIGIdNaX/qqg/QzPhNqR3zmkgATRzP3AJi1QQ4357CXI4UiY7TiM6uVGSfBgKXur3tfw==
X-Received: by 2002:a2e:8593:: with SMTP id b19mr3508179lji.290.1601213359922;
        Sun, 27 Sep 2020 06:29:19 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id b1sm2473845lfe.12.2020.09.27.06.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 06:29:19 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] worktree: rename copy-pasted variable
Date:   Sun, 27 Sep 2020 15:29:10 +0200
Message-Id: <20200927132910.20515-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <CAN0heSrFQFRPnXzp-UT6_jrwvVh+4EQMdOvkJaQCQxeg8GUG4g@mail.gmail.com>
References: <CAN0heSrFQFRPnXzp-UT6_jrwvVh+4EQMdOvkJaQCQxeg8GUG4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 12 Sep 2020 at 16:01, Martin Ågren <martin.agren@gmail.com> wrote:
>
> On Thu, 10 Sep 2020 at 22:29, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Martin Ågren <martin.agren@gmail.com> writes:
> >
> > > As the commit message of 04a3dfb8b5 ("worktree.c: check whether branch
> > > is bisected in another worktree", 2016-04-22) indicates, the function
> > > `is_worktree_being_bisected()` is based on the older function
> > > `is_worktree_being_rebased()`. This heritage can also be seen in the
> > > name of the variable where we store our return value: It was never
> > > adapted while copy-editing and remains as `found_rebase`.
> >
> > How bad is this copy and paste?  Is it a possibility to make a
> > single helper function and these existing two a thin wrapper around
> > the helper that passes customization between bisect and rebase?
>
> That's a good point. I'll look into it.

I did look into this, and here's what I came up with (this is on top of
v2 that I just sent out, since that's how I tried it out). If there
would be three or four such similar functions, I would feel a lot more
confident going with this approach, since it'd be sort of obvious that
they were all the same. But for "only" two it somehow feels a bit
brittle. If any of those two functions need to do something differently,
we might need to start shuffling logic between the helper and the
callers. Or we'll end up with just a single caller, the other having
broken away from the helper.

So in the end I didn't take the plunge for v2.

(BTW, the naming in this diff is clearly w-i-p grade...)

Martin

diff --git a/worktree.c b/worktree.c
index a75230a950..4009856b54 100644
--- a/worktree.c
+++ b/worktree.c
@@ -356,36 +356,40 @@ void update_worktree_location(struct worktree *wt, const char *path_)
 	strbuf_release(&path);
 }
 
+static int is_worktree_being_x(int (*check_fn)(const struct worktree *wt,
+					       struct wt_status_state *state),
+			       const struct worktree *wt,
+			       const char *target)
+{
+	struct wt_status_state state = { 0 };
+	int found;
+
+	found = check_fn(wt, &state) &&
+		state.branch &&
+		skip_prefix(target, "refs/heads/", &target) &&
+		!strcmp(state.branch, target);
+	wt_status_state_free_buffers(&state);
+	return found;
+}
+
+static int check_rebase_in_progress(const struct worktree *wt,
+				    struct wt_status_state *state)
+{
+	return wt_status_check_rebase(wt, state) &&
+	       (state->rebase_in_progress ||
+		state->rebase_interactive_in_progress);
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
-	struct wt_status_state state;
-	int found_rebase;
-
-	memset(&state, 0, sizeof(state));
-	found_rebase = wt_status_check_rebase(wt, &state) &&
-		       (state.rebase_in_progress ||
-			state.rebase_interactive_in_progress) &&
-		       state.branch &&
-		       skip_prefix(target, "refs/heads/", &target) &&
-		       !strcmp(state.branch, target);
-	wt_status_state_free_buffers(&state);
-	return found_rebase;
+	return is_worktree_being_x(check_rebase_in_progress, wt, target);
 }
 
 int is_worktree_being_bisected(const struct worktree *wt,
 			       const char *target)
 {
-	struct wt_status_state state;
-	int found_bisect;
-
-	memset(&state, 0, sizeof(state));
-	found_bisect = wt_status_check_bisect(wt, &state) &&
-		       state.branch &&
-		       skip_prefix(target, "refs/heads/", &target) &&
-		       !strcmp(state.branch, target);
-	wt_status_state_free_buffers(&state);
-	return found_bisect;
+	return is_worktree_being_x(wt_status_check_bisect, wt, target);
 }
 
 /*
-- 
2.28.0.277.g9b3c35fffd

