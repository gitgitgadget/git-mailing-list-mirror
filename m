Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5154FFA3743
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiJXUts (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbiJXUt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:49:27 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4382B9BA3
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:56:48 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id g13so5692262ile.0
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D//i2Mlz1KwVuZ4CUuIfv9yXE6tJCqoPCsZuhvzBAlo=;
        b=ag/AHCRTI1Zc557fsKu0Jrv/XH0nI5kn/rkOhtcFJMUrL6GFedP653iOTEwaz4qnnc
         P58HbGPZ8jDhPw3+qZIA7tn733yyu0ekSuz2XUpCX71ykDOhEB2+Y72DKubvwyd7FLqp
         AJyxWeqOcG+Io9G5LLL7fhbHlIDZHbVxOAiXm2oTS/ZPqWLPIzPMRrmwj4UKivOMHRiP
         hNxmx1KUXB9AjjtVkKb6r0tPKqLM/naLzEZGOrXTlWque5PF9gUCNQqv3lT4JdL8TJPA
         Y5tOFLeVJ1wuBcJ80rRIvxo0JOUdiOFo/v0Xoon/lhiGGA7Eucuk/Lr+79POn5yIM880
         OnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D//i2Mlz1KwVuZ4CUuIfv9yXE6tJCqoPCsZuhvzBAlo=;
        b=wtqDFExG1zBe0/2o6Z37OLDmOLnBj92bai+AWY+tlVovu2fhSRpjq/Xax6RdTzCdtK
         07W/J4kvSa1pqhOszXlc02txwHRla38TqD835jwahJZiPlM+/3h9kx05PiOWAPocStak
         25LgrY4agQCvuZ5a+iiCk0ZH/tZCMOhj/7S6U6vXoZz3CQtkSqt4deNDvNKerKKxrEN4
         Hpqljk2SH6OwWqP+RMqCZagM7PVlxe2LF2TuWzzIvQW8Y8faNJ18e9eJjcBbqjT+SpjW
         ErnSKlU1ymmOQjtyIfnVwkEQK1Rfd09HcvFUGoGbQTI1AQyPDRokIilpg54JnICYZxjI
         SWaA==
X-Gm-Message-State: ACrzQf0fuMa+Qz1qfFPbp1C3VaIF0vqVmrmEbw9HAli/3lH0FQht/aP8
        ZgkBVdjaLoZEomfBfUm1YVyNl3rU0hf7jtJo
X-Google-Smtp-Source: AMsMyM4Z+d4mQSJdsbyWNwJhOuwZCn5/iith/heLhuyiBLfqOLKDXfls7SWzazloxwtCq4/FuI9PaQ==
X-Received: by 2002:a05:6e02:1988:b0:2fc:907b:d1b4 with SMTP id g8-20020a056e02198800b002fc907bd1b4mr21406220ilf.155.1666637748838;
        Mon, 24 Oct 2022 11:55:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p10-20020a056638216a00b003635a42d653sm85517jak.134.2022.10.24.11.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:55:48 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:55:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 7/7] shortlog: implement `--group=committer` in terms of
 `--group=<format>`
Message-ID: <e4191ada3700a0ce6e45d3136491472cef9f4ae4.1666637725.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666637725.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666637725.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the same spirit as the previous commit, reimplement
`--group=committer` as a special case of `--group=<format>`, too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/shortlog.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index f6032c6328..27a87167e1 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -233,7 +233,6 @@ static void insert_records_from_format(struct shortlog *log,
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
-	struct strbuf ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
 	struct strset dups = STRSET_INIT;
 	struct pretty_print_context ctx = {0};
@@ -253,20 +252,10 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	}
 	oneline_str = oneline.len ? oneline.buf : "<none>";
 
-	if (log->groups & SHORTLOG_GROUP_COMMITTER) {
-		strbuf_reset(&ident);
-		format_commit_message(commit,
-				      log->email ? "%cN <%cE>" : "%cN",
-				      &ident, &ctx);
-		if (!HAS_MULTI_BITS(log->groups) ||
-		    strset_add(&dups, ident.buf))
-			insert_one_record(log, ident.buf, oneline_str);
-	}
 	insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
 	insert_records_from_format(log, &dups, commit, &ctx, oneline_str);
 
 	strset_clear(&dups);
-	strbuf_release(&ident);
 	strbuf_release(&oneline);
 }
 
@@ -377,6 +366,9 @@ void shortlog_finish_setup(struct shortlog *log)
 	if (log->groups & SHORTLOG_GROUP_AUTHOR)
 		string_list_append(&log->format,
 				   log->email ? "%aN <%aE>" : "%aN");
+	if (log->groups & SHORTLOG_GROUP_COMMITTER)
+		string_list_append(&log->format,
+				   log->email ? "%cN <%cE>" : "%cN");
 
 	string_list_sort(&log->trailers);
 }
-- 
2.38.0.16.g393fd4c6db
