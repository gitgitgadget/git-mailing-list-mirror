Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8A31F461
	for <e@80x24.org>; Thu, 16 May 2019 21:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfEPVqY (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 17:46:24 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:37742 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfEPVqY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 17:46:24 -0400
Received: by mail-vs1-f74.google.com with SMTP id b26so967053vsl.4
        for <git@vger.kernel.org>; Thu, 16 May 2019 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=59vcfS5rPqZj2inGthWCqkWResCGyT4F4FPFLif4eNE=;
        b=gMycwN5AH8r/f/s2bOgn3OzjthQto9M5l63J+4HkT28fUt+4tuJqRztsFklzV2wo84
         Lszcs6ewrJMl1Gm4yc9GMc1ideTcpB4S+UY05qyeI5e0Del5XlBjGNuqkmCBBgqpGE95
         21G1GrHqwku/kTUjffkciZWPd/146qxNg7Vlw7w7DkV0JhIXC0SkEIFjmsjDPO4xPmZm
         sBdW1A6Jl4XV7g9bYQ8gfxwoiL2hkZ+ObvrI8AYKu1Zx7BpDvuIJ+ML1sBZyt1XOVAFv
         PxtrXjY76VaZACTYjSCVkTtvgPT2VBnOOVeiw77mR34VgJw6DXD5tLvxFA0tLo8QOJGu
         IgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=59vcfS5rPqZj2inGthWCqkWResCGyT4F4FPFLif4eNE=;
        b=CJLhfygVGBY+uWEg7x1uVTYavUPxRHNFltdpxGMh7xieSnaVC55odSoj9LRozKqJuR
         0AEoEyTY0BRzo5VSeamCnlgzmtjAX+ULYawLs/HsG6BqVfvpIglCtKFlqqGcG+DrcpBO
         EYQu/USxfkw64ZDNtZrSWbH3fL23SY0q+8cXpJdVgjaxZ+dmOgIUTy42zkyoP/ImXy4K
         slSehBeBJXk1vbJi1t1LkISz1QCGacU5TM9KLteao07qIyFZxsDX73Ya/fkjeeP68EmP
         OHPlQorYuga122uNTymDYBbBjYUAXefUNm7Lj6Jgea//nExBAP7ZyANo2pBjZIzBfxCk
         fMsQ==
X-Gm-Message-State: APjAAAU1yBsOVP/bPTwV2SaSXAXEQ+G0A3wT9Lfx68uNqu/8NyQ2SbQp
        Xg2F03bQAwzSttFP9Y1i54EbgaJy5/uEY0wtynQ=
X-Google-Smtp-Source: APXvYqyO4/Hj/VMeWF3gQTfO566ENZA24FzaTl3FRHEhMRRDYlyHodm/f0ENFNynJwqBvGWcSjiTHNwE1lfnMtB/7HU=
X-Received: by 2002:a1f:551:: with SMTP id 78mr603048vkf.45.1558043183172;
 Thu, 16 May 2019 14:46:23 -0700 (PDT)
Date:   Thu, 16 May 2019 14:44:44 -0700
In-Reply-To: <20190516020023.61161-1-emilyshaffer@google.com>
Message-Id: <20190516214444.191743-1-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190516020023.61161-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v2] grep: provide sane default to grep_source struct
From:   Emily Shaffer <emilyshaffer@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

grep_buffer creates a struct grep_source gs and calls grep_source()
with it. However, gs.name is null, which eventually produces a
segmentation fault in
grep_source()->grep_source_1()->show_line() when grep_opt.status_only is
not set.

This seems to be unreachable from existing commands but is reachable in
the event that someone rolls their own revision walk and neglects to set
rev_info->grep_filter->status_only. Conceivably, someone might want to
print all changed lines of all commits which match some regex.

To futureproof, give developers a heads-up if grep_source() is called
and a valid name field is expected but not given. This path should be
unreachable now, but in the future may become reachable if developers
want to add the ability to use grep_buffer() in prepared in-core data
and provide hints to the user about where the data came from.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
I've added the BUG() line to grep_source(). I considered adding it to
grep_source_1() but didn't see much difference. Looks like
grep_source_1() exists purely as a helper to grep_source() and is never
called by anybody else... but it's the function where the crash would
happen. So I'm not sure.

I also modified the wording for the BUG("") statement a little from
jrn's suggestion to hopefully make it more explicit, but I welcome
wordsmithing.

 grep.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 0d50598acd..6ceb880a8c 100644
--- a/grep.c
+++ b/grep.c
@@ -2021,6 +2021,9 @@ static int chk_hit_marker(struct grep_expr *x)
 
 int grep_source(struct grep_opt *opt, struct grep_source *gs)
 {
+	if (!opt->status_only && gs->name == NULL)
+		BUG("grep call which could print a name requires "
+		    "grep_source.name be non-NULL");
 	/*
 	 * we do not have to do the two-pass grep when we do not check
 	 * buffer-wide "all-match".
@@ -2045,7 +2048,11 @@ int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
 	struct grep_source gs;
 	int r;
 
-	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL, NULL);
+	/* TODO: In the future it may become desirable to pass in the name as
+	 * an argument to grep_buffer(). At that time, "(in core)" should be
+	 * replaced.
+	 */
+	grep_source_init(&gs, GREP_SOURCE_BUF, _("(in core)"), NULL, NULL);
 	gs.buf = buf;
 	gs.size = size;
 
-- 
2.21.0.1020.gf2820cf01a-goog

