Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F25C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJKAfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiJKAeo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:34:44 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E927E018
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:20 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d142so3719608iof.7
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BTaHe1tX3pxN1VFjyb7u7gNwNq3bEHUfJurqA711mho=;
        b=CyTf/1E/Oj1vHghX1dv9ngEaXvnHHyhT1qqUQl/8dIbiY4ZExgr4vzr0B2ngjeNIKH
         FwYvMtWe6itdPwJebRGfymtCvPJqnwUEpy2F4L7HR4NXQ+x5o0kgbJKkg5CQ4Vaw9asR
         tcyNYd9K/RpG11Bq+j77jE0uivzzh8q1U/Nd6EdqrmcY4hwrTnpEhvso7MWeh3i+NsgI
         /BWFCJH3N2l/fd3YfudnPCJHQB9Ji3PzYrbjwlU4pNo38ERK59dX3AZZ+rngT75TZuYQ
         jYSonKRlcRvJw/xhJGp92hUGbapvjpPRkbgNNdh+UQr1cfq7rr2pvHpy8Y7pKLr1euhj
         v0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTaHe1tX3pxN1VFjyb7u7gNwNq3bEHUfJurqA711mho=;
        b=nd+5zAKi7vH8uT1d/S/dgrwfQXJkyD4bnWWbdqyCmMYPwU1A7+JIPHmI3/jQRhWR/7
         IG0AbryUvfiV4GgduZSVw8t3asTTnNL9QDW9cbu6+VGD3wd8cmd4X10Nd11GaUQfTRHv
         cMUlconOs4t+i6bNPJtG6SdNuBISY3l45W2aoWVAzORlUNscpjVEejnsFNHEJVW8aL0W
         Jro4oqIHgV+1HTzuOLRo3qYwroJZO2VUUoUlCCNVo88jRTvOtIvu3dxM8ogbeHRw6qkV
         sdrO8MPB70AJk3bBV9ZB4iV+/1Il5Hgq094GFPdRwbmNV0uF3fsXGqI3wFXZQnJ1rc7/
         srNQ==
X-Gm-Message-State: ACrzQf0vqm56jdbSpVKSvDlL64nQCC1v1ZrLBNDXL56VZSkU7YYfNoMO
        T1tQqiMEDtqggplwmzLD68sAuksSeQiA1/0J
X-Google-Smtp-Source: AMsMyM4fkIFOCoOBhb3e3r+xH1fsnFRbf/Tjnk6BLanBDeG1fRnD6FZ4ODgJiTuUQQHQo7ZonBiY+g==
X-Received: by 2002:a05:6638:3286:b0:349:fd14:7af6 with SMTP id f6-20020a056638328600b00349fd147af6mr11273418jav.48.1665448459660;
        Mon, 10 Oct 2022 17:34:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q10-20020a056e02096a00b002f9f001de24sm4313455ilt.21.2022.10.10.17.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:34:19 -0700 (PDT)
Date:   Mon, 10 Oct 2022 20:34:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com
Subject: [PATCH 6/7] shortlog: implement `--group=committer` in terms of
 `--group=<format>`
Message-ID: <814ee4b8d8055269d9206847b0faf839816abf59.1665448437.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665448437.git.me@ttaylorr.com>
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
index aac8c7afa4..b46df179fe 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -225,7 +225,6 @@ static void insert_records_from_format(struct shortlog *log,
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
-	struct strbuf ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
 	struct strset dups = STRSET_INIT;
 	struct pretty_print_context ctx = {0};
@@ -245,22 +244,12 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
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
 	if (log->groups & SHORTLOG_GROUP_TRAILER) {
 		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
 	}
 	insert_records_from_format(log, &dups, commit, &ctx, oneline_str);
 
 	strset_clear(&dups);
-	strbuf_release(&ident);
 	strbuf_release(&oneline);
 }
 
@@ -371,6 +360,9 @@ void shortlog_init_group(struct shortlog *log)
 	if (log->groups & SHORTLOG_GROUP_AUTHOR)
 		string_list_append(&log->format,
 				   log->email ? "%aN <%aE>" : "%aN");
+	if (log->groups & SHORTLOG_GROUP_COMMITTER)
+		string_list_append(&log->format,
+				   log->email ? "%cN <%cE>" : "%cN");
 }
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
-- 
2.37.0.1.g1379af2e9d

