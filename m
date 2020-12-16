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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3826C2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACE22342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbgLPSvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732202AbgLPSvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:09 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9249FC0617A7
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:28 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m12so51018618lfo.7
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Th2Dq8N66tSTdLaNVRHwhq9rBn4x4y6ED+6W55SSyDM=;
        b=KIQEBbvcpM7VK+0lS/tkN0YMktOjb/rH5e77higNsuBrgPmPm/M/c1/mbzK5Tj/Wdd
         EI+rJegrt2UDgftuVCUHn0JrOW2ZL2+aypfLqmXdmNio+1h1vvRlY+P1LHTfbW8BHGDm
         1GWxa/0oCzH07ozMOIGBfc5TZfne1T7rxY6mz6Qt121+sI8pgVZAjmtDX7armsRPK9dL
         zID4sKYseeeEX6mkVRNmTi3yoIzNvUjCg7BmQj9vzaucsRG/T7uu0Q0X35M5y3xNUN3R
         b8TQm4QBaQt+6DI0Zavc1xHC1JURsOS3kMVThMT4yCXqCftl6NVe6KK+4G1P8Q0zxDMj
         1owQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Th2Dq8N66tSTdLaNVRHwhq9rBn4x4y6ED+6W55SSyDM=;
        b=jjfnTeo2zqdV2letro1SX1I475hSE0MT414FKJTa9YvommsXoe2MOmeCsN5tM8PJSx
         BotfigsO4QU1p7fBeK01pIzL2mDCUOxgmxmPBlI0Z13ozGPooPMpiKW2t+p5qk1qrI16
         NYPKbi6UIZhROP6YcLxBA9bR7hgHHHaTu+rfBPEE7HbQ8FazZQHZ0rDLffxRnqpfkL7I
         t0IkiZfuQm+3qvJHf0IjRt3TlgxKAqmm8sjjph7eMo9CVs/DVt8pxyRyDvm5qaaS5miu
         hGp3BGR5QyFYZNwi9jw3+DvnQSkr6YxAK7iUxfwG/RPLozSKZaV5Uzw4gqrDi+j+uN1g
         S1Nw==
X-Gm-Message-State: AOAM530lI6k+Y2z7PESngI2kDZYldqZCBvwAnJu4JhVM7Fhq1dQkjiUA
        B8rRXdPWo2Sd2e2IKCDzVmI=
X-Google-Smtp-Source: ABdhPJwN2/ljXWj1U8S8cS1rF4r5JsHm6TIl8JjB0v1iUpqMJeUx8pGBJLWjrefIp9Eu3Yc64/t5QA==
X-Received: by 2002:a05:651c:1b2:: with SMTP id c18mr15433665ljn.385.1608144626249;
        Wed, 16 Dec 2020 10:50:26 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:25 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 03/33] revision: factor out initialization of diff-merge related settings
Date:   Wed, 16 Dec 2020 21:48:59 +0300
Message-Id: <20201216184929.3924-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move initialization code related to diffing merges into new
init_diff_merge_revs() function.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index e4c75d9278c4..da82663c8ce1 100644
--- a/revision.c
+++ b/revision.c
@@ -1805,6 +1805,8 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 	return 1;
 }
 
+static void init_diff_merge_revs(struct rev_info *revs);
+
 void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix)
@@ -1813,7 +1815,7 @@ void repo_init_revisions(struct repository *r,
 
 	revs->repo = r;
 	revs->abbrev = DEFAULT_ABBREV;
-	revs->ignore_merges = -1;
+	init_diff_merge_revs(revs);
 	revs->simplify_history = 1;
 	revs->pruning.repo = r;
 	revs->pruning.flags.recursive = 1;
@@ -2153,6 +2155,10 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
+static void init_diff_merge_revs(struct rev_info *revs) {
+	revs->ignore_merges = -1;
+}
+
 static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
 	int argcount = 1;
 	const char *optarg;
-- 
2.25.1

