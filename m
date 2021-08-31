Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE39C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C7E60F9E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbhHaUxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241270AbhHaUw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:52:56 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FC3C0613D9
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:01 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i13so715386ilm.4
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ID+XA7Pw++CvN1OMKw6Hl46Oz1Wxc2qICRPm34E5Ti0=;
        b=Hxv+ekBsIwws+DNBFVcKQh9PG5FR/XXzH+CHsXI5OkDUS0xXXj6or5XKFDflBjmxtk
         wZyr5j/YaN4PX4ZFhdIor2pj/N/ON2VzUJlSP9Kz80rbFMIF2xWTXL/71cBAty+0pwM4
         eCtXYGJhiKEKf5uremDVWLx4LqEoglTK1SjSaZZp24khkmkMA602m/sNh0NUdnnN5MGY
         B7JVrem7z38fv+DopmJlxHLPcEjW9KwKfqQu7ETrJQfMkapqb0B3urNc8ABB8ds3M3aT
         LbIyiC8W3rH88PF5jsDwDi0FJotmxfTtJQqEQIn1eb4RORKr3yB9ts5mX9jic8mkpjZD
         7Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ID+XA7Pw++CvN1OMKw6Hl46Oz1Wxc2qICRPm34E5Ti0=;
        b=CDPGu51a56DEen1FJCWCsku7gvwA844AaLPIgs+aOjHKcYtEnp6F19t6pyT5zmU5Va
         f3vYzcitXPzKOcS2IFXFNw/0rnUF+m56DkojIFrAhJG567f/koyNKpHzwi+3XqLH4N9x
         dT3IwGBc/0RltvBkbeQ9Y//kPurtah7RuT+1bxYyrcUXAfs/OvwSLO3SXP8aQuAbYiX3
         YTcWFeJ2PFe5ywLkXmo9gN5aXCeaSMtLe89s79TT0aDlpfiBaR4AO4Coj7DQnLtemZ17
         tiakWXP+f+L4IC1Gk4qAkAOgg1l6Jluvy9729DmESo8PPubsQaTCflaAb4dIfvGLZyS4
         Y+JA==
X-Gm-Message-State: AOAM532bb3wspJ1gLxCKMq2iruvxJW5+beqncDcvqJ2OUHFABhx1oEDj
        mKfdayACKr55qMDOWe8+/1/WMtiMONmdlxAZ
X-Google-Smtp-Source: ABdhPJyQEnBCkJEeaG4+e+vll/QphzI0gnIVTdDGTS4TcQMnohS5heWOUKRzsNKXSOs2LYijvRuBEA==
X-Received: by 2002:a92:4b01:: with SMTP id m1mr20083134ilg.50.1630443120430;
        Tue, 31 Aug 2021 13:52:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s18sm10683330ilp.83.2021.08.31.13.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:00 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:51:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 07/27] midx: clear auxiliary .rev after replacing the MIDX
Message-ID: <d30e6fe9a51be6ebf271b2871f6171ffcd8d7594.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a new multi-pack index, write_midx_internal() attempts to
clean up any auxiliary files (currently just the MIDX's `.rev` file, but
soon to include a `.bitmap`, too) corresponding to the MIDX it's
replacing.

This step should happen after the new MIDX is written into place, since
doing so beforehand means that the old MIDX could be read without its
corresponding .rev file.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 902e1a7a7d..0bcb403bae 100644
--- a/midx.c
+++ b/midx.c
@@ -1086,10 +1086,11 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	if (flags & MIDX_WRITE_REV_INDEX)
 		write_midx_reverse_index(midx_name, midx_hash, &ctx);
-	clear_midx_files_ext(object_dir, ".rev", midx_hash);
 
 	commit_lock_file(&lk);
 
+	clear_midx_files_ext(object_dir, ".rev", midx_hash);
+
 cleanup:
 	for (i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].p) {
-- 
2.33.0.96.g73915697e6

