Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A45E776DE
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 00:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbjJCAoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 20:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjJCAof (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 20:44:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2223FB0
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 17:44:32 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7741bffd123so31692885a.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 17:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696293871; x=1696898671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4YonXPrwG71hJ9T9Absavdo4j9+Skbni3fwV0Gysno=;
        b=viTOnEfaiZRrI3Rd/JXgUxTPpx00m7FMUxGgw1xRz4PuGAUp7ApEpQaKb3KxIWsRan
         gqD0m3mmE0WyGNGb4Qh+ovRtxPeanO/EsFSZ2hWqeTeQUyTs1qDBMmCthOBaQgFID6DW
         zP7JXqsBJXKi6cjn91kOuVHiPzCwOXbB0ojvOrUGwC5BiVj6hiKdnQLFqUMzxcw+NlkN
         ZZrqi0jm+Y95uukk9R94fPiyfEIKKWFGKL5Kttf1BLP24eom4g9rFAHK6wdgbZ2IdC8M
         sRiW1E5+GG627SQ+PAm1jfiPiMwWE+LgPKQK5BtoWvUSfqITLXexfJiIBj9xulOnggKT
         XhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293871; x=1696898671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4YonXPrwG71hJ9T9Absavdo4j9+Skbni3fwV0Gysno=;
        b=Vp81NkQeCdA/VGKb+Z85vqgM1/Sca1tqrahEqCtvNj06wSUY9kFKzUum2Ik0t1Ov69
         WLuKt4I9heO54mbFlEZfBKJH/oTMJ3kLJj10a1gDqNVUhnglKy/SvSKlYD+tyhpTu46f
         YlgOKob/hgzaXdNAPleSrUjV5iUDc5SjcdyZxxjxYCmJC+JVitk0m/K9oDHwlxMy3S61
         xLFfT/tTqIoGgk5hO3jacGCp1kY/+PsGxHDRmNDJWbT539rjO8NCSkF+UJfmhCtb992Y
         tGrIukAW4IKcaUAzeN7RogVDcvhzVTAUFMei/sLAg53opBqYrCrusjSPuX0G19nJQcCP
         793g==
X-Gm-Message-State: AOJu0Yw66u8YOtmFqV3y+jNYnGG/FMf/AuCRRBAlWm+PmwPBK3s+XSS2
        kKBgZif7WWMUq8mYb4m4fYhDXyupV6fpWv8dj+29PQ==
X-Google-Smtp-Source: AGHT+IE/A9R8xuICLx/fqGiGWOfacIdknVGjIHXgeuit1KbqoLZBvnbQBF4trrexRccrSl1rZnGVBg==
X-Received: by 2002:a05:620a:2847:b0:768:1572:e9af with SMTP id h7-20020a05620a284700b007681572e9afmr14481862qkp.8.1696293871118;
        Mon, 02 Oct 2023 17:44:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a16b500b00767721aebc0sm32547qkj.32.2023.10.02.17.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:44:30 -0700 (PDT)
Date:   Mon, 2 Oct 2023 20:44:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/3] builtin/repack.c: parse `--max-pack-size` with
 OPT_MAGNITUDE
Message-ID: <9ec999882d790aa770aba8c0916b9260661af9be.1696293862.git.me@ttaylorr.com>
References: <cover.1694123506.git.me@ttaylorr.com>
 <cover.1696293862.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696293862.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The repack builtin takes a `--max-pack-size` command-line argument which
it uses to feed into any of the pack-objects children that it may spawn
when generating a new pack.

This option is parsed with OPT_STRING, meaning that we'll accept
anything as input, punting on more fine-grained validation until we get
down into pack-objects.

This is fine, but it's wasteful to spend an entire sub-process just to
figure out that one of its option is bogus. Instead, parse the value of
`--max-pack-size` with OPT_MAGNITUDE in 'git repack', and then pass the
knonw-good result down to pack-objects.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 529e13120d..8a5bbb9cba 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -51,7 +51,7 @@ struct pack_objects_args {
 	const char *window_memory;
 	const char *depth;
 	const char *threads;
-	const char *max_pack_size;
+	unsigned long max_pack_size;
 	int no_reuse_delta;
 	int no_reuse_object;
 	int quiet;
@@ -242,7 +242,7 @@ static void prepare_pack_objects(struct child_process *cmd,
 	if (args->threads)
 		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
 	if (args->max_pack_size)
-		strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
+		strvec_pushf(&cmd->args, "--max-pack-size=%lu", args->max_pack_size);
 	if (args->no_reuse_delta)
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
@@ -946,7 +946,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum delta depth")),
 		OPT_STRING(0, "threads", &po_args.threads, N_("n"),
 				N_("limits the maximum number of threads")),
-		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
+		OPT_MAGNITUDE(0, "max-pack-size", &po_args.max_pack_size,
 				N_("maximum size of each packfile")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
-- 
2.42.0.310.g9604b54f73.dirty

