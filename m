Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C35EC433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060B2233FD
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbhATQGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390295AbhATQFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:05:11 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF0C061786
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:04:29 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h19so16555602qtq.13
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Kv9CuiPayP7rCrV/TqNi89WQwYan5VBNgcegBcr2R4=;
        b=UW7+tgZdRMeMwQErSQ+Ur8zTR47yfczrkFlPpJVXvZkzI3ZYwTZOVLKEmrD77OE3CN
         TeoZdIIF/RTe2rEJKE3INtlzunIz/28sCmxPfxSsNjkfgf2+cb/gX3/QGpLNrKeQ64XP
         dsx9Cvs12DgVlqVVNkOX/OqeP4RjV4QS7Roi1PgNF9GnawHAuUljh8oG3Vl7hxqkEonK
         dNm5YYDZGRJxWazLe/tl0kfEnJucgB6hBmyKME/kGAja54WTQyvFzRKTmvjbyFALmQOD
         ouQN42Z0RPcQiOk4rE1W2NqQuyhVNui14MJ/54vXGBC8Fi06WeCJ+7uXc7didlDjllhf
         Fb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Kv9CuiPayP7rCrV/TqNi89WQwYan5VBNgcegBcr2R4=;
        b=TC5qprWQCM1ZkF9dPHpw/OBo5UpsKE4rDyudXWQF1mqkQXNvjxG/UF6CfNDCJaJo2a
         6PI61RV54ldXkr7gSarweyJypUVLW+kwrB3An0lFvXBgFRGv2EDnzSFG6eNfHETTNr9n
         Q3id88YVW8BlX7IFnpdGXzieR3zhpQlozhPoEnUlE+EKC1RHm2DggnDOiKV7KqvGDdkq
         6Kyq9/ada6F9abUIt5HUR3AI24cAyTqZoC57AIcJtuGgpq4ei8C5PDbcAgD5qWqwaXge
         quT2R3YubSHUvDjYDSW6kt3zH6oFt7VulTc+t0ZLy+2fJ2nuvmyHo4jG48a1/o/ppgOT
         bt1g==
X-Gm-Message-State: AOAM532M81rZo9PpyMComNmso9Qup14CxmrEPW2SFhpyNddrllrgEWL3
        ET6f0P7xchU4LNkh8ZUrgPb8CYgpqQ385w==
X-Google-Smtp-Source: ABdhPJzQNSnI7WOwXPd60FclNhSsj4FmtjxQTrhjqNflJyL5Kgd9+TPHgCBQP1xFTkMh9pt+z34iRw==
X-Received: by 2002:ac8:4557:: with SMTP id z23mr7826733qtn.191.1611158668505;
        Wed, 20 Jan 2021 08:04:28 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id b78sm1600793qkg.29.2021.01.20.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:04:27 -0800 (PST)
Date:   Wed, 20 Jan 2021 11:04:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@gitlab.com, peff@peff.net
Subject: [PATCH v2 2/3] ls-refs.c: initialize 'prefixes' before using it
Message-ID: <5fc081b2d554db305400ec52fac8683a3ed59597.1611158549.git.me@ttaylorr.com>
References: <cover.1611080326.git.me@ttaylorr.com>
 <cover.1611158549.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611158549.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Vosmaer <jacob@gitlab.com>

Correctly initialize the "prefixes" strvec using strvec_init() instead
of simply zeroing it via the earlier memset().

There's no way to trigger a crash, since the first 'ref-prefix' command
will initialize the strvec via the 'ALLOC_GROW' in 'strvec_push_nodup()'
(the alloc and nr variables are already zero'd, so the call to
ALLOC_GROW is valid).

If no "ref-prefix" command was given, then the call to
'ls-refs.c:ref_match()' will abort early after it reads the zero in
'prefixes->nr'. Likewise, strvec_clear() will only call free() on the
array, which is NULL, so we're safe there, too.

But, all of this is dangerous and requires more reasoning than it would
if we simply called 'strvec_init()', so do that.

Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ls-refs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ls-refs.c b/ls-refs.c
index a1e0b473e4..367597d447 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -90,6 +90,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
 	struct ls_refs_data data;
 
 	memset(&data, 0, sizeof(data));
+	strvec_init(&data.prefixes);
 
 	git_config(ls_refs_config, NULL);
 
-- 
2.30.0.138.g6d7191ea01

