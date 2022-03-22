Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB134C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 17:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiCVRaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239718AbiCVRaO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 13:30:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9516E65EB
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:28:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u3so1308322wrg.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZZwdbmza6VzHoo8DhGH6ETA/M7qBT77r0dOdZfqRQ1g=;
        b=b/P1bS+5m8TrBPZ4jZt0AV44RE35UURbnfTye+svhLP4r9Vr43ie6V4xgS/xxN0fe2
         oZL9UqfvwWD+iccPsgcnTRDivQBJYMcH6tM5BBJlqynWpA4Wu4uLfRcN8D7K5kX1dhdD
         AJxfo4SNSNOtmHHTWANavHV1Es5ML/eQDDwnPcceOVxqtGFcB+hU9yqRGN5oDlxA2jwf
         OWHEDWYTMw/gQX+AiXB1kbO4a4LThwcbbC32GEYst2ddJ/78S+YT96K2xYghV1GN/Ao8
         RQqSdBLaaJFPjTdSHGSpZJeJ1X+GXSD8d9UREgMq4odCjBYHbZBEUKhYCkMbgTIBVt+B
         o9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZZwdbmza6VzHoo8DhGH6ETA/M7qBT77r0dOdZfqRQ1g=;
        b=im9BERUjw1+OlTthLeCg5uD6F9yUGCZQbm48ULkuoEBNYCzNEBsS+Yv7F80NRySBLJ
         JT5KAgzgzZ90RZe3WzogCVUbUJxuO4FAd4bKQuYkmrt/LJDMC0zQUzzCOV1x0S5w43bn
         CQ9OG0+rkvr040j36906Pa59jeQzuQVWkg0hL4zwiontN/O2LUihPvc2K0BVeflqWcfQ
         SUKn7WwUnd6UUf/+99YDBsC47D27eZJ1J78qW6wnV5lxpetyER291xUoPAcGDaIbjBsa
         QLKBBjspR3/jGywVouCYLjdgDWe3flPz6IxqagtbMlTnATbszqUTa1ZZPq/F4/0zNlqt
         /i4w==
X-Gm-Message-State: AOAM530+SYepmIKDjgBE4MD6vq8KoTC1iCXP7HYpgdzhVx2Mp8xfXCta
        2BriB0WTiS9rv7R9GTQ4dziaV9Qqre8=
X-Google-Smtp-Source: ABdhPJyN/rTPRbdk1sazD/OpT1k4oAj9F1ZeZxKdGcPMtgrFEuB6KQVW6z2m9DMTsULkcSB/NEiJUQ==
X-Received: by 2002:a05:6000:144e:b0:203:e36c:74b3 with SMTP id v14-20020a056000144e00b00203e36c74b3mr24104660wrx.565.1647970123970;
        Tue, 22 Mar 2022 10:28:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n124-20020a1ca482000000b0038c9cf6e296sm3259368wme.14.2022.03.22.10.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:28:43 -0700 (PDT)
Message-Id: <97de926904988b89b5663bd4c59c011a1723a8f5.1647970119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:28:37 +0000
Subject: [PATCH 3/5] pack-objects: parse --filter directly into revs.filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change moved the 'revs' variable into cmd_pack_objects()
and now we can remote the global filter_options in favor of revs.filter.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/pack-objects.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f29bef9d0b6..d39f668ad56 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -237,8 +237,6 @@ static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
 
-static struct list_objects_filter_options filter_options;
-
 static struct string_list uri_protocols = STRING_LIST_INIT_NODUP;
 
 enum missing_action {
@@ -3723,10 +3721,8 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 	int flags = 0;
 	int save_warning;
 
-	repo_init_revisions(the_repository, revs, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, revs, &s_r_opt);
-	list_objects_filter_copy(&revs->filter, &filter_options);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
@@ -3958,7 +3954,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			      &write_bitmap_index,
 			      N_("write a bitmap index if possible"),
 			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
-		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&revs.filter),
 		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
 		  option_parse_missing_action),
@@ -4080,7 +4076,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (filter_options.choice) {
+	if (revs.filter.choice) {
 		if (!pack_to_stdout)
 			die(_("cannot use --filter without --stdout"));
 		if (stdin_packs)
-- 
gitgitgadget

