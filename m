Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C32C4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 05:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047D36069E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 05:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhIBFbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 01:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhIBFbi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 01:31:38 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0664C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 22:30:40 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id t4so837474qkb.9
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 22:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3FitgPdtsGLxJA6zNl+jJSF9Hb/EJ1IUObFf5u+/e8E=;
        b=AlGkkBBAJfw5BW2I3IHC7vPkXAvJDfGhw+NBSEs3H6w7+OPEL6MIYUu/p6uyaa/6xm
         cRJzv7wpDiBsRrg9RLY9ljF8IuR9L1m0d/bZ0Qo/v+qsolW0s5wx3H/Q719+epk8YtEJ
         01yop5AjXjVkjDqll5CniNLdN+z435flpLL7Ce23O0JfwCfXD5nr/PRIQCxnUu+spZuZ
         eQbFtZh/fFz5C4a9INSolIABlRejTtkfcx3MyLzUuR/UvbtRtmK94JrlS0tbgxZdKE+H
         tVhMW46GV/pc2D/wqwMmpGRKbXTsV/QaEgfSfhLedp7wFbXr2bVN/gfc6oR3ejzffU6X
         KFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3FitgPdtsGLxJA6zNl+jJSF9Hb/EJ1IUObFf5u+/e8E=;
        b=iNwW9Vw79rwQEWo6QlrP1BjZrq0M11xjBZ2P6T4PVJ5pk7nUiLrh6WN1rYWDEL90mj
         4YYkP3R8dlKFqO3H79HJQXCGYHvCxQCN0k6jepDQSklFsI39ht9SiKpKQA/0iivdKi2K
         sJevhDeFhCu1NIMW1GSh9zK1Bj07NhFv/f7AlFIzIRq/G7xz2BOAByduUQaWGR9ABZC2
         OAfYOmMcL8b68a2Kyyr3fOrpsoAuoYQtFSH89nhjKPbhVEVsvCRX9Nq2QUnYX5FGtdKt
         MVM51EZLw2qpoRF+PrA3Hj/9CGmgHwnaBUulOza+oQbvF4cy04+SqGkoydfoky+7I0c9
         kqlg==
X-Gm-Message-State: AOAM531V2ZXnKi84OE5+MM/cTuqY1JjAjDyeqUXFs+wFi2+1NdQ30cYe
        7PAAu97hNC0VbsdMc98M7P2a5sYwvpw=
X-Google-Smtp-Source: ABdhPJzBwCrXoVjcZmPD96YmVrwacof72hPwpefSOfnFrDGN57843/Tzg9q+vKYOcFxWk8InIQCoxQ==
X-Received: by 2002:a37:9947:: with SMTP id b68mr1614329qke.56.1630560639979;
        Wed, 01 Sep 2021 22:30:39 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w19sm669346qki.21.2021.09.01.22.30.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 22:30:39 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/3] fixup! refs: RFC: Reftable support for git-core
Date:   Wed,  1 Sep 2021 22:30:21 -0700
Message-Id: <20210902053023.44006-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210902053023.44006-1-carenas@gmail.com>
References: <20210902053023.44006-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

need to reorder the variables to hopefully make it easier to see why
they might not be used since assert will compile out itself with -DNDEBUG.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 refs/reftable-backend.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 61ee144e19..5d733b0496 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -127,10 +127,11 @@ static void clear_reftable_log_record(struct reftable_log_record *log)
 
 static void fill_reftable_log_record(struct reftable_log_record *log)
 {
-	const char *info = git_committer_info(0);
 	struct ident_split split = { NULL };
-	int result = split_ident_line(&split, info, strlen(info));
 	int sign = 1;
+	MAYBE_UNUSED const char *info = git_committer_info(0);
+	MAYBE_UNUSED int result = split_ident_line(&split, info, strlen(info));
+
 	assert(0 == result);
 
 	reftable_log_record_release(log);
-- 
2.33.0.481.g26d3bed244

