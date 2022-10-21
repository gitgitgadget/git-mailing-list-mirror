Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA3EC38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJUW0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJUW0I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:26:08 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5DE232E55
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:26:01 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n73so3463791iod.13
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XacoFaubAe+xFBWIvyw51mFWJwxSc1YnWe8ybySpMUc=;
        b=hiWEdEUNL/X5yVNq/pLNskkJjjeHOFsuhcmo2zOME0e9rq4+ZcaxAFucOMJNpPffci
         dQDmGFyQQ9GQhVXN9LHy5XCLshxnoxSrtYPw+XPcfZCUJLm/9pu3huUiD2r0jPBqbvze
         WXVm4MNLt3Kwf5Kb3xbJHf27Sr+Nw1+v+0DAY9p6/VCiQN4mCnobxN5nOM8QEOdhGyIn
         KWL100cHqEZfd//Hb4LEV5ogN2QikzR2rKMUrRiah95rZWQ25QUkaCOpHEb3Np+y7h3K
         ID7cgvcdjGAo65KDRbspQ36me/PPNQzDx/UVv8cEvTPzCi0Ok39RHXg07ZTdNquFaaBv
         aTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XacoFaubAe+xFBWIvyw51mFWJwxSc1YnWe8ybySpMUc=;
        b=RTRKtL+sjdzeX7pIcIK1k6ASMu0XDLpcwM3wF3ZjrvT4ezDmaPVqF/E/tapT33epFl
         PPEbbFxxaDKrCWeVMmo6xiQdtouAPvpNCkI2nUf7ugnbpzSc95Be6cJohix/K1yR7+6S
         K17lCxbymqlq9Ijp6a8Ko4txzUHX3egwFwe1EFgMVhOSoBNFxQQqkpRC2aFhjcDjOTYV
         7Xlth20NewLY+CvMPAwj7i0towGQENcwsbLitXVEFD5LYXiVp8eyW4JF9LeBEEJBtDXP
         o/VT2K+TYuqKfJEv1TL/AMopR0l2fhjF4/JYfH/zPyQf2Yl9St4pfECyHO9xK18+d4MC
         fXPg==
X-Gm-Message-State: ACrzQf0hN8TM8rP22VW9FwpHzG17inABR8Z3vVvEKZJy2T0U4l2Vh23K
        JxHbzXYu/0UPOtUrLVAKDNE6s6i9qGAlywXe
X-Google-Smtp-Source: AMsMyM5OjDyNaKHZbmTL08dyQwRz21v6C7wophQxoSmnD7mJ5oVPPEndR4tVoIJ3y1sMQx2SYikh0A==
X-Received: by 2002:a6b:3ec3:0:b0:6bb:d3ac:61d4 with SMTP id l186-20020a6b3ec3000000b006bbd3ac61d4mr14713209ioa.160.1666391158732;
        Fri, 21 Oct 2022 15:25:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a18-20020a027352000000b0036348f096acsm4696457jae.6.2022.10.21.15.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:25:58 -0700 (PDT)
Date:   Fri, 21 Oct 2022 18:25:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v3 7/7] shortlog: implement `--group=committer` in terms of
 `--group=<format>`
Message-ID: <6ce06a054eb0cf10f59ecd1526671a40c8908edb.1666391136.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666391136.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666391136.git.me@ttaylorr.com>
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
index 4b95820bca..27b057940d 100644
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
