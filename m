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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204F4C07E9C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03922613AA
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhGEMfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhGEMfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:09 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0970C061760
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:32 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t3so20599609oic.5
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HpdmJ6Nb6dvGNnEadDSOORYSjPZB6Unx6UEHCofzXiI=;
        b=n0cGZchn1zBnXJbxekBHhaLIfOOAsNZPxK72s3LuDWDkc2tekUmVxejKWWjEF1J/zq
         wRvYhZbQFrTBBveEXTBPQhOzc9oj5UqaQy1+cEfLOPJZtGwpQTKx92eIJ3SHByON2QA9
         DATiUAjA8NFn3wEQuY0y+8NANQeYmVjsTYdZkkpOOR5IrhC/6JBL0Q2zrBpYksilulRD
         PG2Z0Us5cWE85tB2tofL2/6nX/estOWOyAy1ji6a8yIDn4kPcyiRFtQgpMmwi4opLtsQ
         fmZXX1yY2ovBgIMC4fI08yMdBLqx3o71WxAqA+GimDCquBQrdiHXBrD6c64VNKA2HXrD
         wKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HpdmJ6Nb6dvGNnEadDSOORYSjPZB6Unx6UEHCofzXiI=;
        b=bwApNz5Kkb1lH1C0JG2DE3+N2WnHD0LN0DMH3rWmjv59/ld3c2FFJi9hMdA3P2i0x9
         ShlvLyzhHToFhbfTGCk9VngpWN0GXseszAFUMkGA3obQofXu+FgkWhissFpxtyD2MwEb
         4GxpXqzuxVODRMagkASeWFhFkPIax9QscLwo/ZMcwALvXZ+W/TvgEtGBbTKSddIwpTZB
         B+byX52J2/tKO4YqZCw2/aRVUwLDqEm6OMuz67nbufCJB00smASC2rGZYdNCDHx7XJ7B
         DwQj1FOGioESpzNasN65g0Ygvvxe9l/ZfXXf2EU+vriRZaltcSuHwCxnMlVybtjGXISp
         DTFA==
X-Gm-Message-State: AOAM530HlW5lCddBK+nMMXBYeATvZLGWj+nHxJ/jHONO6P3cBZZtMgHy
        /WAqckRqdLhdghKPgddYi+X0ztUvnjlXGQ==
X-Google-Smtp-Source: ABdhPJzoamCN6MVby6NydifI/K7cey5+Hi+kRD2zC6kJFNbhz6KZ21b3R+y2Ds4hLUvP2R13RmyTcw==
X-Received: by 2002:a05:6808:48:: with SMTP id v8mr9158807oic.69.1625488352073;
        Mon, 05 Jul 2021 05:32:32 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 59sm2547428otp.68.2021.07.05.05.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 12/35] commit: support for multiple MERGE_MODE
Date:   Mon,  5 Jul 2021 07:31:46 -0500
Message-Id: <20210705123209.1808663-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43..f9dd155566 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1742,7 +1742,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (!stat(git_path_merge_mode(the_repository), &statbuf)) {
 			if (strbuf_read_file(&sb, git_path_merge_mode(the_repository), 0) < 0)
 				die_errno(_("could not read MERGE_MODE"));
-			if (!strcmp(sb.buf, "no-ff"))
+			if (strstr(sb.buf, "no-ff"))
 				allow_fast_forward = 0;
 		}
 		if (allow_fast_forward)
-- 
2.32.0.36.g70aac2b1aa

