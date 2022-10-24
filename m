Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FC9C38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 21:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJXVuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiJXVuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 17:50:23 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A98A2F090C
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:03:20 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id g13so5783502ile.0
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpsOH8MNNjaXe8PFoD/jp7TaZ7ac3hJ14pF51hYOfwY=;
        b=QF7vN0W8oYtDC1N4rCk189pB9J/1Td07nSZcjJbGPAifby1YsiBr7ux3r7wDSkU3RS
         1/BYwUzzVTEVolbuTci7d5Lmmr4QG7FaZSNLvFchylZ+jpX7VFihPOa7V5SSZYVjPENb
         rEFVAzVyY1LP8Zz0PTEhpWmonmgaWVpRroUAecaLfeNxPjdBNzRgIKCs3BzfPM9Y8ARs
         6MBgte8QSF8sIgXz5m1UFI8yq3ifZUpJVLAaOIXZeN7iDq1rbWZxY2jvseF5utL4iUt0
         7WtM1uUPGAhMZct56Kih0uAOcoRaUd7+a+AXTICqePxmq//jXkmlT24IucLaSgg2feT8
         C26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpsOH8MNNjaXe8PFoD/jp7TaZ7ac3hJ14pF51hYOfwY=;
        b=HitDNUV2JpPsip6B4Wp3Fe/8bB4VZ7aU872I5rgrYdDCy7ezxZN7QdHMmXubXr84zv
         +J++OYaKHbZmvfWufzRR1UmWVa5UC8GQOHk3QbpN4MXiG6hlhM/zHV5IAE2QoMnayoYm
         ekla3cfixOTS3WuySe4vTOuYO+IjtKGe7cERYMjIAjIlSCvcm2mIGy8/oJketrgri+yt
         jNHgB7l0SsUQOEUPhO8vmMKSRnY0f0T6Z2HL0ti9YzwXKbYQzuyitArAU9JdB639ezep
         eOERjdfkL4B+yRQxcPXx36/OsPgV+HfkBdlJ7WUIUG4fs+dhSLGBAG8Pck1rys+y+iJu
         gKyg==
X-Gm-Message-State: ACrzQf1zRKtBNqV6itGkXcGpN1eK4UaJrMZaUa14ju1yobO8Jadm3JLT
        QmbpSwfIjdmRIrZ/NdG1yeRp+zKO8k7ydqSd
X-Google-Smtp-Source: AMsMyM7eiI2uYWyPXSEpicvMU4oWtrLz/vabKsSJWrnziIoYiL+0QECrxhtXr5p0xulVo73yatqO1g==
X-Received: by 2002:a6b:671e:0:b0:6bb:f05a:fb11 with SMTP id b30-20020a6b671e000000b006bbf05afb11mr20427996ioc.74.1666637734636;
        Mon, 24 Oct 2022 11:55:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o13-20020a056e0214cd00b003001a04f9b9sm247613ilk.12.2022.10.24.11.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:55:34 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:55:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 2/7] shortlog: make trailer insertion a noop when appropriate
Message-ID: <2153c6c6649c54588c24db1ace647719ad0431f3.1666637725.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666637725.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666637725.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there are no trailers to insert, it is natural that
insert_records_from_trailers() should return without having done any
work.

But instead we guard this call unnecessarily by first checking whether
`log->groups` has the `SHORTLOG_GROUP_TRAILER` bit set.

Prepare to match a similar pattern in the future where a function which
inserts records of a certain type does no work when no specifiers
matching that type are given.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/shortlog.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 53c379a51d..18f0800c82 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -170,6 +170,9 @@ static void insert_records_from_trailers(struct shortlog *log,
 	const char *commit_buffer, *body;
 	struct strbuf ident = STRBUF_INIT;
 
+	if (!log->trailers.nr)
+		return;
+
 	/*
 	 * Using format_commit_message("%B") would be simpler here, but
 	 * this saves us copying the message.
@@ -240,9 +243,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		    strset_add(&dups, ident.buf))
 			insert_one_record(log, ident.buf, oneline_str);
 	}
-	if (log->groups & SHORTLOG_GROUP_TRAILER) {
-		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
-	}
+	insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
 
 	strset_clear(&dups);
 	strbuf_release(&ident);
-- 
2.38.0.16.g393fd4c6db

