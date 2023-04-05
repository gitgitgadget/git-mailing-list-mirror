Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E613CC761A6
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 15:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbjDEPWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbjDEPWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 11:22:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5C4102
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 08:22:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso7310281wms.5
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 08:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680708134;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oo6Cx6waGn+ZXBMAchjGUr3k3N/zH50qbYYxB1xWhK4=;
        b=ZjX8h/bHxb5FoRpGHr340x4/uXT8gNcUaMaYxAPPEZpZNds5aK2pC5N5/CBKDRYP5L
         JxdXEJrnirA/42wRZrxBz9rKUaB/JVYLmEF3rEq6hWWWzzQLMOpfOtoLSft8LWuY0TGb
         2ZlM0U/SQCJZlDVzmaX1UjEqpA3a+n/VrKVCkUKwKT9swfaMV430Hf5eJLfdJINRPx5X
         0bdi7xLY4HZIWUOKGWyWJRkmLgssZ5RFnW12VF1APWoWtVPDrSVvceDjP9nUkm/SocMC
         ZK+wYqY0qj23zOVbrCOKKvRi1QQBYpFnHif9R0tjH/zsnKFdLIpV7OJ9E/rMIKh2scSd
         oTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680708134;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oo6Cx6waGn+ZXBMAchjGUr3k3N/zH50qbYYxB1xWhK4=;
        b=QKisxexPU5kQEHrH4vW0gQprgzMANvvQWc7P1y1n9FZMbIVCC7a93EEYNSm0fTr6Ij
         ZmEmpzNFSf1VyjLZXcHfoKssutmulu1CdlhQok3dyejTpSV8MaWv0Gjw2DjnxrUHhwV8
         WQHOepwN15Aonb6eFRq5W7GDrOKsW/rvr4eQVT8qYSTATf9iXq0MFxlmggGS0SRwxlp3
         n+RU5STUGkL84wF39uWBexIqquQ7aC1l6r0jHoOUKltaZkxr7dwVqv7hINX0lS7iCHvO
         McSas09bLcQwXyib0uq1XOm5y2i831Y5fSmbZfIebyar2Ppzmzasww8LYO4+KIFpe2tC
         rAQA==
X-Gm-Message-State: AAQBX9dCYpSlGu8nyEjkjoHWatvuoSEGuC6BT71fI3mr+6/L0z4AZ3EA
        bZ/dgOnYibUo1cR0AM7GUX4Ci7TGUuU=
X-Google-Smtp-Source: AKy350YYv6qrxmy1Dqf41xXyda8LdQWHc0w8hLWvIb5o2VCSlA+FuGl5By59tQtAqQPsIG143UeLBQ==
X-Received: by 2002:a05:600c:ad7:b0:3ed:301c:375c with SMTP id c23-20020a05600c0ad700b003ed301c375cmr5234144wmr.21.1680708134207;
        Wed, 05 Apr 2023 08:22:14 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003edc11c2ecbsm2515610wmj.4.2023.04.05.08.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:22:13 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/5] rebase: stop reading and writing unnecessary strategy state
Date:   Wed,  5 Apr 2023 16:21:44 +0100
Message-Id: <2353c753f5fe56b4ebc72e8c3acef788f31e6345.1680708043.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.670.g64ef305212.dirty
In-Reply-To: <cover.1680708043.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1680708043.git.phillip.wood@dunelm.org.uk>
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
2.40.0.670.g64ef305212.dirty

