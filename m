Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833CD20370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdJEUc5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:32:57 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36393 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbdJEUcw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:32:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id l10so1951073wre.3
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzU/8vK7ouM6onDI8rEvXYKOlG7/4EV/sru5HnuZEjI=;
        b=JomcBnJYl0NI6Py74/Ic/yDamg95HuOum/HPBensdDvghNILr7LVVt0ru30ZnzZ8rN
         4cZ7E7oh7dNld8AY1IVKFM30nGTKad9+I6fFtUSYQsiaU4Vfc5UKaJ67Fk83+NE5JkAC
         5NbVlXI1Rp45XnSpQ4TLz09uCHSoHvKFi8asTFFukbwRVZUBTttiboXrecvjk6Z3Gu64
         2/WTNjXp5nX86LJcnZB21i4vf9tiDk9c93gg8W02jzn05I5X5ALhIcYQ8HDABJIs/SQV
         fk+v5e6oQI3Z+e3/pPXzNsDar8PFlx2WQRroI9UqS/ON2uyECAmU/AjRDajuUChGBfDx
         Bh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzU/8vK7ouM6onDI8rEvXYKOlG7/4EV/sru5HnuZEjI=;
        b=OYSKLM1GpcN1sR89mUyYpqEHfzFuA+H+gj684HGqOJiZVb83x+mRUnluytLpctMz00
         ua/XCjNFJz+cprkFeMWpiWxcy+aN8cNCAZsEVeAVWdtA6VHFHPIJtvQgwhP8j7bxrzzL
         iqCrvbDasc3ESvLS2gTq/ja7UA+gwlzwtV/amXAxlXkr/iCjsDMfovaxdbp8u6rom+zW
         QQBNTKvSeAQ0h8NlAYu3sZtKjpdpuJZgFZ6s8YHElwRtiPneDqE01GDoT1cDK+O1UXbf
         S6Vvxdvr/+6KzXBg+la2R8SJ5xl+1B6NhoVJNiscV/l318oEydWG69WgKplRJ2Bz2ozU
         cH5A==
X-Gm-Message-State: AMCzsaV6WSXxcvpvtXxrzzf0y4w2ZpwueXrRR0CZCVPUTDl8CnjeHxbT
        OcaomLGYZHBUERtqOrgMpjOlyqhw
X-Google-Smtp-Source: AOwi7QAdPQnM74iSJt6m2OSVd7jt3G0ZKta0HFNpIf69D1SQGODByYj+aG3FlsRwnQqi5do7P7O+qg==
X-Received: by 10.223.179.18 with SMTP id j18mr12299882wrd.262.1507235571513;
        Thu, 05 Oct 2017 13:32:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:32:50 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/12] apply: remove `newfd` from `struct apply_state`
Date:   Thu,  5 Oct 2017 22:32:10 +0200
Message-Id: <a2cedef325ccc0a2a0aaabd2d290457b05dfe8f0.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <cover.1507228170.git.martin.agren@gmail.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to a previous patch, we do not need to use `newfd` to signal
that we have a lockfile to clean up. We can just unconditionally call
`rollback_lock_file`. If we do not hold the lock, it will be a no-op.

Where we check `newfd` to decide whether we need to take the lock, we
can instead use `is_lock_file_locked()`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
v2: Identical.

 apply.c | 17 ++++++-----------
 apply.h |  3 +--
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/apply.c b/apply.c
index 5a6ca10a7..d676debd5 100644
--- a/apply.c
+++ b/apply.c
@@ -79,7 +79,6 @@ int init_apply_state(struct apply_state *state,
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
-	state->newfd = -1;
 	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_value = 1;
@@ -4705,13 +4704,13 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && state->newfd < 0) {
+	if (state->update_index && !is_lock_file_locked(&state->lock_file)) {
 		if (state->index_file)
-			state->newfd = hold_lock_file_for_update(&state->lock_file,
-								 state->index_file,
-								 LOCK_DIE_ON_ERROR);
+			hold_lock_file_for_update(&state->lock_file,
+						  state->index_file,
+						  LOCK_DIE_ON_ERROR);
 		else
-			state->newfd = hold_locked_index(&state->lock_file, LOCK_DIE_ON_ERROR);
+			hold_locked_index(&state->lock_file, LOCK_DIE_ON_ERROR);
 	}
 
 	if (state->check_index && read_apply_cache(state) < 0) {
@@ -4913,16 +4912,12 @@ int apply_all_patches(struct apply_state *state,
 			res = -128;
 			goto end;
 		}
-		state->newfd = -1;
 	}
 
 	res = !!errs;
 
 end:
-	if (state->newfd >= 0) {
-		rollback_lock_file(&state->lock_file);
-		state->newfd = -1;
-	}
+	rollback_lock_file(&state->lock_file);
 
 	if (state->apply_verbosity <= verbosity_silent) {
 		set_error_routine(state->saved_error_routine);
diff --git a/apply.h b/apply.h
index cf00cda17..dc4a01905 100644
--- a/apply.h
+++ b/apply.h
@@ -36,9 +36,8 @@ enum apply_verbosity {
 struct apply_state {
 	const char *prefix;
 
-	/* These are lock_file related */
+	/* Lock file */
 	struct lock_file lock_file;
-	int newfd;
 
 	/* These control what gets looked at and modified */
 	int apply; /* this is not a dry-run */
-- 
2.14.2.666.gea220ee40

