Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2FAC76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 09:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDJJI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 05:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjDJJIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 05:08:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49B530F9
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 02:08:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so2321747wms.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 02:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681117730;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2TsONl3zdCSFQsr+RZb7U0P17Ki5GCDNDuiY55mN/jo=;
        b=QXdtia1AlOfmpo3lys+OG9VWpT7RRC/3YwRx3zFxHgC1H67VcLpGJJqchJfUcZu5+U
         seEoXfVpvLnwrxXRkoT2wwmWeHoiJyD9FJttpxl075+rwUyzqpJOOkbg57FaV90Ztfiw
         p/gXucUFT4yUZxsS3YnjFrGCnztkz+g+l6ZnkqBgKMSwkH6zIS9vzuseSt41hoe9bbaG
         MSUHBrnwzUcwwO+6h5ReyoMv5dGA1C1uGzkv6WF2RtDbuifaAkk1CbrULfNFDUcZtfBK
         iCWmi4RPY1XKORomv2btg9jBRJbAQxHIQvAXLvzfWCtvAOd/2rnWy1Zbdt0l/7KR35wn
         UzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681117730;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TsONl3zdCSFQsr+RZb7U0P17Ki5GCDNDuiY55mN/jo=;
        b=EWVTW5hMfWtznPaWQBD6tm8HkAZ3jOB9Eb4G09wI/AsjilaNnlhxqQvxdZN2kC18Y1
         rHOhf/3KZcA1VvvQII5wNlW8ymbDiI1Gg3HiIwsBph54/+lMgBupvsxymsKAqzIhxL7P
         Rf1HCJFREnWRNBm0uc7BhiLSQgkTnTPJHxMCvJ+l53XoRLvyjGf92IFSVfubpyweHmcp
         16ISsoFoyydK2djo8CU1wNz6KTOHsMI7x679SNSnwZx+8PJpXjDqYOURVBOXJWSjNK00
         bAolV+kLI4EAwmz/wrJWeiiayET9UhWOj7x+/x2OrOWnb2KD5s+vu+khjZJ67gJVJkBn
         c2yA==
X-Gm-Message-State: AAQBX9dRsA7A0UYnRS/vV3Rw/to6vnN/9TTO7o9BV9KV4O8eiy4bSA+C
        EBAiWfGUaAH2i8hyTHVtCWYqynvG/J8=
X-Google-Smtp-Source: AKy350YhdhCJHQGyfj4608d8P2MNSRWjLv70MOJXXGqXB6Bg4F0PcHBVcLFQSODSgGWuI2B9OSR28A==
X-Received: by 2002:a05:600c:2313:b0:3f0:310c:158 with SMTP id 19-20020a05600c231300b003f0310c0158mr4405934wmo.6.1681117730142;
        Mon, 10 Apr 2023 02:08:50 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b003f034c76e85sm17232568wmg.38.2023.04.10.02.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 02:08:49 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 1/5] rebase: stop reading and writing unnecessary strategy state
Date:   Mon, 10 Apr 2023 10:08:27 +0100
Message-Id: <882b403423e5c2d90c3afc4eefb02bb499c4a02b.1681117706.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.672.gbd2d2ac924
In-Reply-To: <cover.1681117706.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1681117706.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The state files for "--strategy" and "--strategy-option" are written and
read twice, once by builtin/rebase.c and then by sequencer.c. This is an
artifact of the scripted rebase and the need to support "rebase
--preserve-merges". Now that "--preserve-merges" no-longer exists we
only need to read and write these files in sequencer.c. This enables us
to remove a call to free() in read_strategy_opts() that was added by
f1f4ebf432 (sequencer.c: fix "opts->strategy" leak in
read_strategy_opts(), 2022-11-08) as this commit fixes the root cause of
that leak.

There is further scope for removing duplication in the reading and
writing of state files between builtin/rebase.c and sequencer.c but that
is left for a follow up series.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 24 ------------------------
 sequencer.c      |  1 -
 2 files changed, 25 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b7b908b66..3bd215c771 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -483,24 +483,6 @@ static int read_basic_state(struct rebase_options *opts)
 		opts->gpg_sign_opt = xstrdup(buf.buf);
 	}
 
-	if (file_exists(state_dir_path("strategy", opts))) {
-		strbuf_reset(&buf);
-		if (!read_oneliner(&buf, state_dir_path("strategy", opts),
-				   READ_ONELINER_WARN_MISSING))
-			return -1;
-		free(opts->strategy);
-		opts->strategy = xstrdup(buf.buf);
-	}
-
-	if (file_exists(state_dir_path("strategy_opts", opts))) {
-		strbuf_reset(&buf);
-		if (!read_oneliner(&buf, state_dir_path("strategy_opts", opts),
-				   READ_ONELINER_WARN_MISSING))
-			return -1;
-		free(opts->strategy_opts);
-		opts->strategy_opts = xstrdup(buf.buf);
-	}
-
 	strbuf_release(&buf);
 
 	return 0;
@@ -518,12 +500,6 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 		write_file(state_dir_path("quiet", opts), "%s", "");
 	if (opts->flags & REBASE_VERBOSE)
 		write_file(state_dir_path("verbose", opts), "%s", "");
-	if (opts->strategy)
-		write_file(state_dir_path("strategy", opts), "%s",
-			   opts->strategy);
-	if (opts->strategy_opts)
-		write_file(state_dir_path("strategy_opts", opts), "%s",
-			   opts->strategy_opts);
 	if (opts->allow_rerere_autoupdate > 0)
 		write_file(state_dir_path("allow_rerere_autoupdate", opts),
 			   "-%s-rerere-autoupdate",
diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca2..c35a67e104 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2944,7 +2944,6 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 	strbuf_reset(buf);
 	if (!read_oneliner(buf, rebase_path_strategy(), 0))
 		return;
-	free(opts->strategy);
 	opts->strategy = strbuf_detach(buf, NULL);
 	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
 		return;
-- 
2.40.0.672.gbd2d2ac924

